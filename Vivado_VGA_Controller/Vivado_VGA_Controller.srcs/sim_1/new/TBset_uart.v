`timescale 1ns / 1ps

module tb_cursor_graphic ();
    
    reg clk, reset_p, mouse_left_click;
    reg [3:0] i_bram_r,i_bram_g,i_bram_b;
    reg [9:0] pixel_addr_x, pixel_addr_y, cursor_addr_x, cursor_addr_y;
    wire [3:0] o_vga_r, o_vga_g, o_vga_b;
    cursor_graphic DUT(
        clk,
        reset_p,
        i_bram_r,i_bram_g,i_bram_b,
        mouse_left_click,
        pixel_addr_x, pixel_addr_y,
        cursor_addr_x, cursor_addr_y,
        o_vga_r, o_vga_g, o_vga_b);
        
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        reset_p = 0;
        reset_p = 1;
        #10 reset_p = 0;
    end
    
    initial begin
        mouse_left_click = 0;
        i_bram_r = 1; i_bram_g = 2; i_bram_b = 3;
        pixel_addr_x = 10'd131;
        cursor_addr_x = 10'd130;
        pixel_addr_y = 10'd102;
        cursor_addr_y = 10'd100;
        #100 $stop;
    end
        
endmodule


module tb_uart_rx_pixel_data();
    
    reg clk, reset_p;
    reg uart_rx;
    wire [9:0] pixel_addr_x, pixel_addr_y;
    wire [3:0] pixel_red, pixel_green, pixel_blue;
    wire write_enable;
    
    UART_Rx_pixel_data_addr_and_rgb DUT(
        clk, reset_p,
        uart_rx,
        write_enable,
        pixel_addr_x, pixel_addr_y,
        pixel_red, pixel_green, pixel_blue
    );
    
    // system clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // reset_p signal generation
    initial begin
        reset_p = 0;
        reset_p = 1;
        #10 reset_p =0;
    end
    
    // module input initialization
    initial begin
        uart_rx = 1;
    end
    
    // Payload build
    reg [9:0] payload_addr_x, payload_addr_y;
    reg [3:0] payload_pixel_red, payload_pixel_green, payload_pixel_blue;
    wire [7:0] payload [0:3];
    assign payload[0] = payload_addr_x[7:0];
    assign payload[1] = {payload_addr_y[5:0], payload_addr_x[9:8]};
    assign payload[2] = {payload_pixel_blue[3:0], payload_addr_y[9:6]};
    assign payload[3] = {payload_pixel_red[3:0], payload_pixel_green[3:0]};
    
    
    initial begin
        payload_addr_x = 10'h0f3;
        payload_addr_y = 10'h01d;
        payload_pixel_red = 4'h3;
        payload_pixel_green = 4'h9;
        payload_pixel_blue = 4'he;
    end
    
    
    // test bench main routine
    integer byte_index, bit_index;
    initial begin
        #1000;
        for (byte_index=0; byte_index<4; byte_index=byte_index+1) begin
            uart_rx = 0; #104167;  // Start bit 
            
            for (bit_index=0; bit_index<8; bit_index=bit_index+1) begin
                uart_rx = payload[byte_index][bit_index];
                #104167;
            end
            uart_rx = 1; #104167;  // Stop bit
        end
        #10000 $stop;
    end
    
endmodule

/*
 // For building byte_receiving UART RX module TB
    // test bench main routine
 reg [7:0] sample_string [0:10] = "Hello World";
 integer byte_index, bit_index;
 initial begin
     #1000;
     for (byte_index=0; byte_index<11; byte_index=byte_index+1) begin
         uart_rx = 0; #104167;  // Start bit 
         
         for (bit_index=0; bit_index<8; bit_index=bit_index+1) begin
             uart_rx = sample_string[byte_index][bit_index];
             #104167;
         end
         uart_rx = 1; #104167;  // Stop bit
     end
     #10000 $stop;
 end
*/
