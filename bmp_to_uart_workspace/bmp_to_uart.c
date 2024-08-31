#include <stdint.h>
#include <stdio.h>
#include <Windows.h>

#define RESOLUTION_WIDTH 640
#define RESOLUTION_HEIGHT 480

HANDLE COM_handler;
DCB COM_dcb = {0};
COMMTIMEOUTS COM_timeout = {0};

FILE *input_bmp_ptr;


void uart_print_error_msg ();
int uart_init ();
int check_bmp_format ();

/*
 * Fisrt argument: COM port name
 * Second argument: bmp image location
 * Payload information:
 *      4 bytes of UART TX per pixel:
 *          pixel_x[7:0]
 *          {pixel_y[5:0], pixel_x[9:8]}
 *          {vgaBlue[3:0], pixel_y[9:6]}
 *          {vgaRed[3:0], vgaGreen[3:0]}
 */
int main (int argc, char* argv[])
{
    // initializations
    uart_init(argv[1]); // init uart
    input_bmp_ptr = fopen(argv[2], "rb");    // open bmp file
    if (check_bmp_format())
    {
        return 1;
    }

    /////////////////////////////
    // Build payload and send
    ////////////////////////////

    // Save payload (pixel information) starting position offset
    uint32_t offset_payload;                        // store image color compression type
    fseek(input_bmp_ptr, 0x0A, SEEK_SET);           // 0x1C: image bit depth
    fread( (void *) &offset_payload, 4, 1, input_bmp_ptr); 

    uint8_t send_buffer[4];
    uint8_t RGB_buffer[3];
    for (uint16_t pixel_y=0; pixel_y<RESOLUTION_HEIGHT; pixel_y++)
    {
        fseek(input_bmp_ptr, (offset_payload + (RESOLUTION_WIDTH * (RESOLUTION_HEIGHT - pixel_y - 1) * 3)), SEEK_SET);
        for (uint16_t pixel_x=0; pixel_x<RESOLUTION_WIDTH; pixel_x++)
        {
            // read rgb value (1 byte per color, in Blue Green Red order) 
            fread( (void *) RGB_buffer, 1, 3, input_bmp_ptr);

            // get only top 4 bits
            RGB_buffer[0] = RGB_buffer[0] >> 4;
            RGB_buffer[1] = RGB_buffer[1] >> 4;
            RGB_buffer[2] = RGB_buffer[2] >> 4;

            // build payload
            send_buffer[0] = (uint8_t) pixel_x;
            send_buffer[1] = (uint8_t) (pixel_y << 2) | (pixel_x >> 8);
            send_buffer[2] = (uint8_t) (RGB_buffer[0] << 4) | (pixel_y >> 6);
            send_buffer[3] = (uint8_t) (RGB_buffer[2] << 4) | (RGB_buffer[1]);
            
            long unsigned int actual_tx_byte;
            if ( !WriteFile(COM_handler, send_buffer, 4, &actual_tx_byte, NULL) )
            {
                return 1;
            }
            if (actual_tx_byte != 4)
            {
                printf("Wrong number of bytes sent\r\n");
            }
        }
    }

    // Close COM handler
    CloseHandle(COM_handler);
    return 0;
}

int uart_init (char* COM_name)
{
    // attempt to open COM
    COM_handler = CreateFile (
        COM_name,
        GENERIC_READ | GENERIC_WRITE,
        0,
        0,
        OPEN_EXISTING,
        FILE_ATTRIBUTE_NORMAL,
        0
    );
    if (COM_handler == INVALID_HANDLE_VALUE)
    {
        uart_print_error_msg ();
        return 1;
    }

    // Set COM parameters
    COM_dcb.DCBlength = sizeof(COM_dcb);
    if (!GetCommState(COM_handler, &COM_dcb))   // Get current DCB from COM handler
    {
        uart_print_error_msg ();
        return 1;
    }
    COM_dcb.BaudRate = CBR_9600;
    COM_dcb.ByteSize = 8;
    COM_dcb.StopBits = ONESTOPBIT;
    COM_dcb.Parity = NOPARITY;
    if (!SetCommState(COM_handler, &COM_dcb))   // Apply modified DCB to COM handler
    {
        uart_print_error_msg ();
        return 1;
    }

    // Set COM timeout
    COM_timeout.ReadIntervalTimeout = 50;
    COM_timeout.ReadTotalTimeoutConstant = 50;
    COM_timeout.ReadTotalTimeoutMultiplier = 10;
    COM_timeout.WriteTotalTimeoutConstant = 50;
    COM_timeout.WriteTotalTimeoutMultiplier = 10;
    if (!SetCommTimeouts(COM_handler, &COM_timeout))
    {
        uart_print_error_msg ();
        return 1;
    }

    return 0;
}

void uart_print_error_msg ()
{
    char error_msg[1024];
    FormatMessage (
        FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
        NULL,
        GetLastError(),
        MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
        error_msg,
        1024,
        NULL
    );
    puts(error_msg);
}

int check_bmp_format ()
{
    // Check if the file is BMP by checking "BM" characters
    char buffer[2];                                             // store first two characters
    fseek(input_bmp_ptr, 0, SEEK_SET);
    fread( (void *) &buffer, 1, 2, input_bmp_ptr);
    if ( (buffer[0] != 'B') || (buffer[1] != 'M') )
    {
        printf("ERROR: File is not BMP file\r\n");
        return 1;
    }
    else    // if there is no error, reset buffer
    {
        buffer[0] = 0;
        buffer[1] = 0;
    }

    // Check if the image is 640 x 480 resolution
    uint32_t image_width;                       // store image width pixel num
    uint32_t image_height;                      // store image height pixel num
    fseek(input_bmp_ptr, 0x12, SEEK_SET);       // set file pointer to position offset 0x12
    fread( (void *) &image_width, 4, 1, input_bmp_ptr);    // 0x12: image width
    fread( (void *) &image_height, 4, 1, input_bmp_ptr);   // 0x16: image height
    if ( (image_width != RESOLUTION_WIDTH) || (image_height != RESOLUTION_HEIGHT) )
    {
        printf("ERROR: BMP image is not %d x %d resolution\r\n", RESOLUTION_WIDTH, RESOLUTION_HEIGHT);
        return 1;
    }

    // Check if the image is 24bit BMP
    uint16_t image_bitdepth;                        // store image bit depth
    fseek(input_bmp_ptr, 0x1C, SEEK_SET);           // 0x1C: image bit depth
    fread( (void *) &image_bitdepth, 2, 1, input_bmp_ptr);     
    if (image_bitdepth != 24)
    {
        printf("ERROR: BMP image is not of 24bit color depth\r\n");
        return 1;
    }

    // Check if the image compression type is RGB
    uint32_t image_colorCompType;                       // store image color compression type
    fseek(input_bmp_ptr, 0x1E, SEEK_SET);               // 0x1E: image color compression type
    fread( (void *) &image_colorCompType, 4, 1, input_bmp_ptr);     
    if (image_colorCompType != 0)
    {
        printf("ERROR: BMP image compression type is not RGB\r\n");
        return 1;
    }

    // Save payload (pixel information) starting position offset
    uint32_t offset_payload;                        // store image color compression type
    fseek(input_bmp_ptr, 0x0A, SEEK_SET);           // 0x1C: image bit depth
    fread( (void *) &offset_payload, 4, 1, input_bmp_ptr);    

    return 0;
}