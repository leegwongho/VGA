`timescale 1ns / 1ps


module BRAM_test_generator (
    input clk, reset_p,
    input pixel_clock_pulse,
    input in_hsync, in_vsync,
    input in_display_on,
    output reg [9:0] out_addr_x,
    output reg [9:0] out_addr_y,
    output reg write_enable,
    output [3:0] vgaRed, vgaGreen, vgaBlue
);

    wire hsync_nedge, vsync_nedge;
    edge_detector_n hsync_edge_detector (.clk(clk), .reset_p(reset_p), .cp(in_hsync), .n_edge(hsync_nedge));
    edge_detector_n vsync_edge_detector (.clk(clk), .reset_p(reset_p), .cp(in_vsync), .n_edge(vsync_nedge));

    reg [3:0] counter_red, counter_green, counter_blue;
    integer counter;
    //integer pixel_counter;
    
    // address manipulator
    always @(negedge clk or posedge reset_p) begin
        if (reset_p) begin
            out_addr_x = 0;
            out_addr_y = 0;
            
        end
        else begin
            if (write_enable) begin
                out_addr_x = out_addr_x + 1;
                if (out_addr_x >= 320) begin
                    out_addr_x = 0;
                    out_addr_y = out_addr_y + 1;
                end
            end
            else begin
                out_addr_x = 0;
                out_addr_y = 0;
            end
        end
    end

    always @(negedge clk or posedge reset_p) begin
        if (reset_p) begin
            write_enable = 1;
        end
        else if (write_enable) begin
            if (out_addr_y >= 240) begin
                write_enable = 0;
            end
        end
        else if (vsync_nedge) begin
            write_enable = 1;
        end
    end

    always @(negedge clk or posedge reset_p) begin
        if (reset_p) begin
            counter_red = 0;
            counter_green = 0;
            counter_blue = 0;
            counter = 0;
        end
        else begin
            if (write_enable) begin
                /*
                if(out_addr_x <= 160)begin
                    counter_red = 4'b1111;
                    counter_green = 4'b0000;
                    counter_blue = 4'b0000;
                end
                else begin
                    counter_red = 4'b0000;
                    counter_green = 4'b0000;
                    counter_blue = 4'b0000;
                end
                */
                counter_red = counter >> 1;
                counter_green = counter << 1;
                counter_blue = counter >> 2;
                counter = counter + 1;
            end
        end
    end
    
    assign vgaRed = counter_red;
    assign vgaGreen = counter_green;
    assign vgaBlue = counter_blue;

endmodule