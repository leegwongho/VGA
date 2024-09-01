`timescale 1ns / 1ps

module TOP_image_and_mouse(
    input clk, reset_p,
    input data,
    input data_clk,
    input RsRx,
    output Hsync, Vsync,
    output [3:0] V2M_Red, V2M_Green, V2M_Blue,
    output [3:0] com,
    output [7:0] seg_7);
    
    parameter MAX_BRAM_ADDR_X = 320;
    parameter MAX_BRAM_ADDR_Y = 240;
    
    wire pixel_clock_pulse;
    pixel_clock_generator PCG (
        .clk(clk), .reset_p(reset_p),
        .pixel_clock_pulse(pixel_clock_pulse)
    );
    
    wire out_display_on;
    wire [3:0] B2V_Red, B2V_Green, B2V_Blue;
    wire [3:0] B2V_Red_withmouse, B2V_Green_withmouse, B2V_Blue_withmouse;
    wire [9:0] pixel_coord_x, pixel_coord_y;
    
    VGA_controller VC(
        .clk(clk), .reset_p(reset_p),
        .pixel_clock_pulse(pixel_clock_pulse),
        .in_vgaRed(B2V_Red_withmouse), .in_vgaGreen(B2V_Green_withmouse), .in_vgaBlue(B2V_Blue_withmouse),
        .Hsync(Hsync), .Vsync(Vsync), .out_display_on(out_display_on),
        .out_vgaRed(V2M_Red), .out_vgaGreen(V2M_Green), .out_vgaBlue(V2M_Blue),
        .count_h (pixel_coord_x),
        .count_v (pixel_coord_y)
    );
    
    
    wire [9:0] addr_x_scaler, addr_y_scaler;
    pixel_coord_converter PCC(
        .addr_x(pixel_coord_x), .addr_y(pixel_coord_y),
        .addr_x_scaler(addr_x_scaler), .addr_y_scaler(addr_y_scaler)
    );
    
    wire write_enable;
    wire [9:0] gen_addr_x, gen_addr_y;
    wire [3:0] gen_vgaRed, gen_vgaGreen, gen_vgaBlue;
    BRAM_320x240_controller BC(
        .clk(clk), .reset_p(reset_p),
        .write_enable(write_enable),
        .porta_addr_x(gen_addr_x), .portb_addr_x(addr_x_scaler),
        .porta_addr_y(gen_addr_y), .portb_addr_y(addr_y_scaler),
        .porta_vgaRed(gen_vgaRed), .porta_vgaGreen(gen_vgaGreen), .porta_vgaBlue(gen_vgaBlue),
    
        .portb_vgaRed(B2V_Red), .portb_vgaGreen(B2V_Green), .portb_vgaBlue(B2V_Blue)
    );
    
    UART_Rx_pixel_data_addr_and_rgb image_receiver(
        .clk (clk),
        .reset_p (reset_p),
        
        .uart_rx (RsRx),
        
        .write_enable (img_write_enable),
        
        .pixel_addr_x (gen_addr_x),
        .pixel_addr_y (gen_addr_y),
        
        .pixel_red(gen_vgaRed),
        .pixel_green (gen_vgaGreen),
        .pixel_blue (gen_vgaBlue)
    );
    
    // if sent image exceed BRAM size, do not write pixel info
    assign write_enable = ( (gen_addr_x < MAX_BRAM_ADDR_X) && (gen_addr_y < MAX_BRAM_ADDR_Y) ) ? img_write_enable : 0;
    
    /////////////////////////////////
    // Mouse pointer implementation
    /////////////////////////////////
    wire [9:0] value_x, value_y;
    mouse_controller_in_vga #(.MAX_ADDR_X (640), .MAX_ADDR_Y(480)) test_monitor(
                                    .clk(clk), .reset_p(reset_p),
                                    .data(data),
                                    .data_clk(data_clk),
                                    .mouse_left_click(mouse_left_click), .mouse_right_click(mouse_right_click),
                                    .value_x(value_x), .value_y(value_y));
    
    assign {B2V_Red_withmouse, B2V_Green_withmouse, B2V_Blue_withmouse}  = ( (pixel_coord_x == value_x ||
                                         pixel_coord_x == value_x + 1 ||
                                         pixel_coord_x == value_x + 2 ||
                                         pixel_coord_x == value_x + 3)
                                && (pixel_coord_y == value_y ||
                                        pixel_coord_y == value_y + 1 ||
                                        pixel_coord_y == value_y + 2 ||
                                        pixel_coord_y == value_y + 3)
                               ) 
                               ? {4'hf, 4'h0, 4'h0} : {B2V_Red, B2V_Green, B2V_Blue};

endmodule
