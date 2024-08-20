`timescale 1ns / 1ps


module BRAM_320x240_controller(
    input clk, reset_p,
    input write_enable,
    input [8:0] in_addr_x, out_addr_x,
    input [7:0] in_addr_y, out_addr_y,
    input [3:0] in_vgaRed, in_vgaGreen, in_vgaBlue,
    output [3:0] out_vgaRed, out_vgaGreen, out_vgaBlue
);
    // some unused memory spaces, but this will eliminate usage of multiplication
    wire [16:0] in_addr_1d = {in_addr_y, in_addr_x};
    wire [16:0] out_addr_1d = {out_addr_y, out_addr_x};

    BRAM_4bit_512x240 BRAM_red (
        .clka       (clk),
        .wea        (write_enable),
        .addra      (in_addr_1d),
        .dina       (in_vgaRed),
        
        .clkb       (clk),
        .addrb      (out_addr_1d),
        .doutb      (out_vgaRed)
    );
    
    BRAM_4bit_512x240 BRAM_green (
        .clka       (clk),
        .wea        (write_enable),
        .addra      (in_addr_1d),
        .dina       (in_vgaGreen),
        
        .clkb       (clk),
        .addrb      (out_addr_1d),
        .doutb      (out_vgaGreen)
    );
    
    BRAM_4bit_512x240 BRAM_blue (
        .clka       (clk),
        .wea        (write_enable),
        .addra      (in_addr_1d),
        .dina       (in_vgaBlue),
        
        .clkb       (clk),
        .addrb      (out_addr_1d),
        .doutb      (out_vgaBlue)
    );

endmodule
