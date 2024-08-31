`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/31 17:22:12
// Design Name: 
// Module Name: TBset_uart
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_uart_rx_byte();
    
    reg clk, reset;
    reg RsRx;
    wire [7:0] byte_out;
    wire busy;
    
    UART_rx_byte DUT(
        clk, reset,
        RsRx,
        byte_out,
        busy
    );
    
    // system clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // reset signal generation
    initial begin
        reset = 0;
        reset = 1;
        #10 reset =0;
    end
    
    // module input initialization
    initial begin
        RsRx = 1;
    end
    
    // test bench main routine
    reg [7:0] sample_string [0:10] = "Hello World";
    integer byte_index, bit_index;
    initial begin
        #1000;
        for (byte_index=0; byte_index<11; byte_index=byte_index+1) begin
            RsRx = 0; #104167;  // Start bit 
            
            for (bit_index=0; bit_index<8; bit_index=bit_index+1) begin
                RsRx = sample_string[byte_index][bit_index];
                #104167;
            end
            RsRx = 1; #104167;  // Stop bit
        end
        #10000 $stop;
    end
    
endmodule
