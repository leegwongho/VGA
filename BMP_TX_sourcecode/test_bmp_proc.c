/*
 * Flip BMP file upside down
 * Background: BMP file records pixel information from bottom to top, 
 * while VGA draws pixels top to bottom. BMP needs to be flipped to be
 * used with VGA.
 */
#include <stdint.h>
#include <stdio.h>

#define RESOLUTION_WIDTH 640
#define RESOLUTION_HEIGHT 480

int main()
{
    // Open BMP file
    FILE *input_bmp_ptr;                                    // declare file handler
    input_bmp_ptr = fopen("sample_2x2_24bit.bmp", "rb");    // open file and attach to the file handler


    // ------------------------------------------------------------------------
    // File Format Check ------------------------------------------------------
    // ------------------------------------------------------------------------

    // Check if the file is BMP by checking "BM" characters
    char buffer[2];                                             // store first two characters
    fseek(input_bmp_ptr, 0, SEEK_SET);
    fread( (void *) &buffer, 1, 2, input_bmp_ptr);
    if ( (buffer[0] != 'B') || (buffer[1] != 'M') )
    {
        fprintf(stderr, "ERROR: File is not BMP file\r\n");
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
        fprintf(stderr, "ERROR: BMP image is not %d x %d resolution\r\n", RESOLUTION_WIDTH, RESOLUTION_HEIGHT);
        return 1;
    }

    // Check if the image is 24bit BMP
    uint16_t image_bitdepth;                        // store image bit depth
    fseek(input_bmp_ptr, 0x1C, SEEK_SET);           // 0x1C: image bit depth
    fread( (void *) &image_bitdepth, 2, 1, input_bmp_ptr);     
    if (image_bitdepth != 24)
    {
        fprintf(stderr, "ERROR: BMP image is not of 24bit color depth\r\n");
        return 1;
    }

    // Check if the image compression type is RGB
    uint32_t image_colorCompType;                       // store image color compression type
    fseek(input_bmp_ptr, 0x1E, SEEK_SET);               // 0x1E: image color compression type
    fread( (void *) &image_colorCompType, 4, 1, input_bmp_ptr);     
    if (image_colorCompType != 0)
    {
        fprintf(stderr, "ERROR: BMP image compression type is not RGB\r\n");
        return 1;
    }

    // Save payload (pixel information) starting position offset
    uint32_t offset_payload;                        // store image color compression type
    fseek(input_bmp_ptr, 0x0A, SEEK_SET);           // 0x1C: image bit depth
    fread( (void *) &offset_payload, 4, 1, input_bmp_ptr);    

    // ------------------------------------------------------------------------
    // Image Processing -------------------------------------------------------
    // ------------------------------------------------------------------------

    // FOR DEBUG: output reordered pixel info in 4-bit per color
    FILE *output_bmp_ptr;                                    // declare file handler
    output_bmp_ptr = fopen("reordered.bmp", "wb");    // open file and attach to the file handler

    uint8_t byte_buffer;
    fseek(input_bmp_ptr, 0, SEEK_SET);
    for (int i=0; i<offset_payload; i++)
    {
        fread( (void *) &byte_buffer, 1, 1, input_bmp_ptr);
        fwrite( (void *) &byte_buffer, 1, 1, output_bmp_ptr);
    }

    uint8_t RGB_buffer[3];
    for (int y=0; y<RESOLUTION_HEIGHT; y++)
    {
        fseek(input_bmp_ptr, (offset_payload + (RESOLUTION_WIDTH * (RESOLUTION_HEIGHT - y - 1) * 3)), SEEK_SET);
        for (int x=0; x<RESOLUTION_WIDTH; x++)
        {
            fread( (void *) RGB_buffer, 1, 3, input_bmp_ptr);
            fwrite( (void *) RGB_buffer, 1, 3, output_bmp_ptr);
        }
    }

}