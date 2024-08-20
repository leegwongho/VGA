`timescale 1ns / 1ps

module TOP_VGA_BRAM_test (
    input clk, reset_p,
    output Hsync, Vsync,
    output [3:0] vgaRed, vgaGreen, vgaBlue
);

    wire [3:0] inter_vgaRed, inter_vgaGreen, inter_vgaBlue;
    wire [3:0] gen_vgaRed, gen_vgaGreen, gen_vgaBlue;
    wire [9:0] addr_x, addr_y;
    wire write_enable;
    wire display_on;
    wire [9:0] cur_pixel_coord_x, cur_pixel_coord_y;

    pixel_clock_generator pixel_clock_gen_module (
        .clk (clk),
        .reset_p (reset_p),
        
        .pixel_clock_pulse (pixel_clock_pulse)
    );

    
    pixel_coordinate_tracker pixel_coord_tracker_module (
        .clk (clk),
        .reset_p (reset_p),
        
        .Hsync          (Hsync),
        .Vsync          (Vsync),
        .pixel_clock_pusle  (pixel_clock_pulse),
        .in_display_on  (display_on),
        
        .pixel_coord_x  (cur_pixel_coord_x),
        .pixel_coord_y  (cur_pixel_coord_y)
    );

    VGA_controller vga_cntr_module(
        .clk (clk),
        .reset_p (reset_p),
        .pixel_clock_pulse (pixel_clock_pulse),
        
        .in_vgaRed (inter_vgaRed),
        .in_vgaGreen (inter_vgaGreen),
         .in_vgaBlue (inter_vgaBlue),
         
        .Hsync (Hsync),
        .Vsync (Vsync),
        .out_display_on (display_on),
        
        .out_vgaRed (vgaRed),
        .out_vgaGreen (vgaGreen),
        .out_vgaBlue (vgaBlue)
    );

    BRAM_320x240_controller BRAM_cntr_module(
        .clk (clk),
        .reset_p (reset_p),
        
       .write_enable (write_enable),
       
       .in_vgaRed (gen_vgaRed),
       .in_vgaGreen (gen_vgaGreen),
       .in_vgaBlue (gen_vgaBlue),
       
       .in_addr_x (addr_x),
       .in_addr_y (addr_y),
       
       .out_addr_x (cur_pixel_coord_x),
       .out_addr_y (cur_pixel_coord_y),
       
       .out_vgaRed (inter_vgaRed),
       .out_vgaGreen (inter_vgaGreen),
       .out_vgaBlue (inter_vgaBlue)
    );
    
    BRAM_test_generator BRAM_test_gen_module (
        .clk (clk),
        .reset_p (reset_p),
        .pixel_clock_pulse (pixel_clock_pulse),
        .in_hsync (Hsync),
        .in_vsync (Vsync),
        .in_display_on (display_on),
        
        .out_addr_x (cur_pixel_coord_x),
        .out_addr_y (cur_pixel_coord_y),
        .write_enable (write_enable),
        
        .vgaRed (gen_vgaRed),
        .vgaGreen (gen_vgaGreen),
        .vgaBlue (gen_vgaBlue)
    );
    
endmodule

module BRAM_test_generator (
    input clk, reset_p,
    input pixel_clock_pulse,
    input in_hsync, in_vsync,
    input in_display_on,
    output reg [8:0] out_addr_x,
    output reg [7:0] out_addr_y,
    output reg write_enable,
    output [3:0] vgaRed, vgaGreen, vgaBlue
);

    wire hsync_nedge, vsync_nedge;
    edge_detector_n hsync_edge_detector (.clk(clk), .reset_p(reset_p), .cp(in_hsync), .n_edge(hsync_nedge));
    edge_detector_n vsync_edge_detector (.clk(clk), .reset_p(reset_p), .cp(in_vsync), .n_edge(vsync_nedge));

    reg [3:0] counter_red, counter_green, counter_blue;
    integer pixel_counter;
    
    // address manipulator
    always @(negedge clk or posedge reset_p) begin
        if (reset_p) begin
            out_addr_x = 0;
            out_addr_y = 0;
        end
        else begin
            if (pixel_clock_pulse && in_display_on) begin
                out_addr_x = out_addr_x + 1;
                if (out_addr_x >= 9'd320) out_addr_x = 0;
            end
            else if (hsync_nedge) begin
                out_addr_x = 0;
                out_addr_y = out_addr_y + 1;
                if (out_addr_y >= 8'd240) out_addr_y = 0;   // If plain 240 was put instead of 8'd240, it is considered signed, thus becomes -16.
            end
            else if (vsync_nedge) begin
                out_addr_x = 0;
                out_addr_y = 0;
            end
        end
    end
    
    // write enable (initially 1, changed to 0 after writing BRAM)
    always @(negedge clk or posedge reset_p) begin
        if (reset_p) begin
            write_enable = 1;
        end
        else begin
            if (vsync_nedge) begin
                write_enable = 0;
            end
        end
    end
        
    always @(negedge clk or posedge reset_p) begin
        if (reset_p) begin
            pixel_counter = 0;
            counter_red = 0;
            counter_green = 0;
            counter_blue = 0;
        end
        else if (pixel_clock_pulse && in_display_on) begin
            if (write_enable) begin
                counter_red = pixel_counter [8:4];
                counter_green = pixel_counter [12:9];
                counter_blue = pixel_counter [16:13];
            end
        end
    end
    
    assign vgaRed = counter_red;
    assign vgaGreen = counter_green;
    assign vgaBlue = counter_blue;

endmodule

