`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/19 15:16:13
// Design Name: 
// Module Name: VGA_controller
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

module TOP_VGA_BRAM_test (
    input clk, reset_p,
    input [11:0] sw,
    output  Hsync, Vsync,
    output [3:0] vgaRed, vgaGreen, vgaBlue
);

    wire [3:0] inter_vgaRed, inter_vgaGreen, inter_vgaBlue;
    wire [3:0] gen_vgaRed, gen_vgaGreen, gen_vgaBlue;
    wire [18:0] address;
    wire write_enable;

    VGA_Controller vga_cntr_module(
        .clk (clk),
        .reset_p (reset_p),
        
        .in_vgaRed (inter_vgaRed),
        .in_vgaGreen (inter_vgaGreen),
         .in_vgaBlue (inter_vgaBlue),
         
        .Hsync (Hsync),
        .Vsync (Vsync),
        .out_vgaRed (vgaRed),
        .out_vgaGreen (vgaGreen),
        .out_vgaBlue (vgaBlue)
    );

    BRAM_controller BRAM_cntr_module(
        .clk (clk),
        .reset_p (reset_p),
        
       .enable (1),
       .write_enable (write_enable),
       
       .in_vgaRed (gen_vgaRed),
       .in_vgaGreen (gen_vgaGreen),
       .in_vgaBlue (gen_vgaBlue),
       
       .address (address),
       
       .out_vgaRed (inter_vgaRed),
       .out_vgaGreen (inter_vgaGreen),
       .out_vgaBlue (inter_vgaBlue)
    );
    
    BRAM_test_generator (
        .clk (clk),
        .reset_p (reset_p),
        .address (address),
        .write_enable (write_enable),
        .vgaRed (gen_vgaRed),
        .vgaGreen (gen_vgaGreen),
        .vgaBlue (gen_vgaBlue)
    );
    
endmodule

module VGA_Controller(
    input clk, reset_p,
    input [3:0] in_vgaRed, in_vgaGreen, in_vgaBlue,
    output  Hsync, Vsync,
    output reg [3:0] out_vgaRed, out_vgaGreen, out_vgaBlue
    );

    wire w_25mhz;

    wire H_display_on, V_display_on;
    
    wire h_sync_nedge;

    clock_div_4 mh_25(
                .clk(clk), .reset_p(reset_p),
                .clk_div_100(w_25mhz),
                .cp_div_100());

    edge_detector_n  edge_usec (.clk(clk), .reset_p(reset_p), .cp(Hsync), .n_edge(h_sync_nedge));
              

    h_sync h_sync_module(
                            .clk(clk), .reset_p(reset_p),
                            .p_clk_cp(w_25mhz),
                            .Hsync(Hsync), .H_display_on(H_display_on));


    v_sync v_sync_module(
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
            if(H_display_on && V_display_on) begin
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


endmodule


module BRAM_controller(
    input clk, reset_p,
    input enable, write_enable,
    input [3:0] in_vgaRed, in_vgaGreen, in_vgaBlue,
    input [18:0] address,
    output [3:0] out_vgaRed, out_vgaGreen, out_vgaBlue
);

    video_BRAM VRAM_red (
        .clka       (clk),
        .ena        (enable),
        .wea        (write_enable),
        .addra      (address),
        .dina       (in_vgaRed),
        .douta      (out_vgaRed)
    );
    
    video_BRAM VRAM_green (
        .clka       (clk),
        .ena        (enable),
        .wea        (write_enable),
        .addra      (address),
        .dina       (in_vgaGreen),
        .douta      (out_vgaGreen)
    );
    
    video_BRAM VRAM_blue (
        .clka       (clk),
        .ena        (enable),
        .wea        (write_enable),
        .addra      (address),
        .dina       (in_vgaBlue),
        .douta      (out_vgaBlue)
    );

endmodule

module BRAM_test_generator (
    input clk, reset_p,
    output [18:0] address,
    output reg write_enable,
    output [3:0] vgaRed, vgaGreen, vgaBlue
);

    reg init_flag;
    reg [3:0] counter_red, counter_green, counter_blue;
    integer pixel_counter;
    
    always @(negedge clk or posedge reset_p) begin
        if (reset_p) begin
            init_flag = 1;
            pixel_counter = 0;
            counter_red = 0;
            counter_green = 0;
            counter_blue = 0;
            write_enable = 0;
        end
        else begin
            if (init_flag) begin
                write_enable = 1;
                counter_red = pixel_counter [8:4];
                counter_green = pixel_counter [12:9];
                counter_blue = pixel_counter [16:13];
            end

            // counter
            pixel_counter = pixel_counter + 1;
            if (pixel_counter >= 76800) begin
                init_flag = 0;
                write_enable = 0;
                pixel_counter = 0;
            end
        end
    end
    
    assign address = pixel_counter [18:0];
    assign vgaRed = counter_red;
    assign vgaGreen = counter_green;
    assign vgaBlue = counter_blue;

endmodule