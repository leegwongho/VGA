`timescale 1ns / 1ps

// Port A always input, Port B always output
module BRAM_320x240_controller(
    input clk, reset_p,
    input write_enable,
    input [8:0] porta_addr_x, portb_addr_x,
    input [7:0] porta_addr_y, portb_addr_y,
    input [3:0] porta_vgaRed, porta_vgaGreen, porta_vgaBlue,
    output [3:0] portb_vgaRed, portb_vgaGreen, portb_vgaBlue
);
    // some unused memory spaces, but this will eliminate usage of multiplication
    wire [16:0] porta_addr_1d = {porta_addr_y, porta_addr_x};
    wire [16:0] portb_addr_1d = {portb_addr_y, portb_addr_x};

    BRAM_4bit_512x240 BRAM_red (
        .clka       (clk),
        .wea        (write_enable),
        .addra      (porta_addr_1d),
        .dina       (porta_vgaRed),
        
        .clkb       (clk),
        .addrb      (portb_addr_1d),
        .doutb      (portb_vgaRed)
    );
    
    BRAM_4bit_512x240 BRAM_green (
        .clka       (clk),
        .wea        (write_enable),
        .addra      (porta_addr_1d),
        .dina       (porta_vgaGreen),
        
        .clkb       (clk),
        .addrb      (portb_addr_1d),
        .doutb      (portb_vgaGreen)
    );
    
    BRAM_4bit_512x240 BRAM_blue (
        .clka       (clk),
        .wea        (write_enable),
        .addra      (porta_addr_1d),
        .dina       (porta_vgaBlue),
        
        .clkb       (clk),
        .addrb      (portb_addr_1d),
        .doutb      (portb_vgaBlue)
    );

endmodule
