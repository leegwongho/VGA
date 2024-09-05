// Took reference from https://m.blog.naver.com/nortul/221968205374
// and https://ds.opdenbrouw.nl/micprg/pdf/serial-win.pdf
/*
 * Sends input string to UART 
 *
 * Two command-line arguments:
 * First argument: COM port name (ex: COM4)
 * Second arument: string to send (ex: "Hello World")
 * Example usage: test_uart.exe COM4 "Hello World"
 */
#include <Windows.h>
#include <stdio.h>

void print_error_msg();

int main (int argc, char* argv[])
{
    // attempt to open COM
    HANDLE COM_handler;
    COM_handler = CreateFile (
        argv[1],
        GENERIC_READ | GENERIC_WRITE,
        0,
        0,
        OPEN_EXISTING,
        FILE_ATTRIBUTE_NORMAL,
        0
    );
    if (COM_handler == INVALID_HANDLE_VALUE)
    {
        print_error_msg ();
        return 1;
    }

    // Set COM parameters
    DCB COM_dcb = {0};
    COM_dcb.DCBlength = sizeof(COM_dcb);
    if (!GetCommState(COM_handler, &COM_dcb))   // Get current DCB from COM handler
    {
        print_error_msg ();
        return 1;
    }
    COM_dcb.BaudRate = CBR_9600;
    COM_dcb.ByteSize = 8;
    COM_dcb.StopBits = ONESTOPBIT;
    COM_dcb.Parity = NOPARITY;
    if (!SetCommState(COM_handler, &COM_dcb))   // Apply modified DCB to COM handler
    {
        print_error_msg ();
        return 1;
    }

    // Set COM timeout
    COMMTIMEOUTS COM_timeout = {0};
    COM_timeout.ReadIntervalTimeout = 50;
    COM_timeout.ReadTotalTimeoutConstant = 50;
    COM_timeout.ReadTotalTimeoutMultiplier = 10;
    COM_timeout.WriteTotalTimeoutConstant = 50;
    COM_timeout.WriteTotalTimeoutMultiplier = 10;
    if (!SetCommTimeouts(COM_handler, &COM_timeout))
    {
        print_error_msg ();
        return 1;
    }

    // COM write operation
    unsigned char COM_buffer = *argv[2];
    long unsigned int actual_tx_byte;
    if ( !WriteFile(COM_handler, &COM_buffer, 1, &actual_tx_byte, NULL) )
    {
        print_error_msg ();
        return 1;
    }
    printf("%d %d", sizeof(COM_buffer), actual_tx_byte);

    // Close COM handler
    CloseHandle(COM_handler);
    return 0;
}

void print_error_msg ()
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