`timescale 1ns / 1ps


module VGA_controller(
    input clk, reset_p,
    input pixel_clock_pulse,
    input [3:0] in_vgaRed, in_vgaGreen, in_vgaBlue,
    output  Hsync, Vsync, out_display_on,
    output reg [3:0] out_vgaRed, out_vgaGreen, out_vgaBlue
    );

    wire H_display_on, V_display_on;
    wire h_sync_nedge;

    edge_detector_n edge_usec (.clk(clk), .reset_p(reset_p), .cp(Hsync), .n_edge(h_sync_nedge));
              
    h_sync_generator h_sync_module(
                            .clk(clk), .reset_p(reset_p),
                            .p_clk_cp(pixel_clock_pulse),
                            .Hsync(Hsync), .H_display_on(H_display_on));

    v_sync_generator v_sync_module(
                            .clk(clk), .reset_p(reset_p),
                            .h_sync_cp(h_sync_nedge),
                            .Vsync(Vsync), .V_display_on(V_display_on));

    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            out_vgaRed  = 0; 
            out_vgaGreen = 0;
            out_vgaBlue = 0;            
        end
        else begin
            if(pixel_clock_pulse && out_display_on) begin
                out_vgaRed  = in_vgaRed; 
                out_vgaGreen = in_vgaGreen;
                out_vgaBlue = in_vgaBlue;
            end
            else begin
                out_vgaRed  = 0; 
                out_vgaGreen = 0;
                out_vgaBlue = 0;                 
            end
        end    
    end

    assign out_display_on = H_display_on && V_display_on;
    
endmodule


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
