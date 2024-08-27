
module BRAM_mouse_test (
    input clk, reset_p,
    input pixel_clock_pulse,
    input in_hsync, in_vsync,
    input in_display_on,
    input data,
    input data_clk,
    output reg [9:0] out_addr_x,
    output reg [9:0] out_addr_y,
    output reg write_enable,
    output [3:0] vgaRed, vgaGreen, vgaBlue,
    output [3:0] com,
    output [7:0] seg_7);

    parameter pixel_cursor = 2'd2;
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


    wire write_enable_pedge;
    edge_detector_n write_enable_edge(.clk(clk), .reset_p(reset_p), .cp(write_enable), .p_edge(write_enable_pedge));
    
    wire mouse_left_click, mouse_right_click, mouse_right_left_cursor, mouse_up_down_cursor;

    wire [8:0] value_x, value_y;

    mouse_controller_in_vga test_monitor(
                                            .clk(clk), .reset_p(reset_p),
                                            .data(data),
                                            .data_clk(data_clk),
                                            .mouse_left_click(mouse_left_click), .mouse_right_click(mouse_right_click),
                                            .com(com),
                                            .seg_7(seg_7),
                                            .value_x(value_x), .value_y(value_y));

    reg cursor_flag;

    reg [2:0] count_cursor;

    always @(negedge clk, posedge reset_p) begin
        if (reset_p) begin
            cursor_flag = 0;
            count_cursor = 0;
        end
        else begin
            if (write_enable) begin
                if (out_addr_x == value_x && out_addr_y == value_y) begin 
                    cursor_flag = 1;
                end
                else begin
                    count_cursor = count_cursor +1;
                end

                if (count_cursor >= 3) begin
                    cursor_flag = 0;
                    count_cursor = 0;
                end

                if (out_addr_x == value_x && out_addr_y == (value_y - 1)) begin 
                    cursor_flag = 1;
                end
                else begin
                    count_cursor = count_cursor +1;
                end

/*
                if (out_addr_y == adc_y) begin
                    counter_red = 4'b0000;
                    counter_green = 4'b0000;
                    counter_blue = 4'b0000;
                end
                else begin
                    counter_red = 4'b1111;
                    counter_green = 4'b1111;
                    counter_blue = 4'b1111;
                end
                */
            end
        end
    end


    always @(negedge clk, posedge reset_p) begin
        if(reset_p) begin
            counter_red = 0;
            counter_green = 0;
            counter_blue = 0;
        end
        else begin
            if (cursor_flag) begin
                counter_red = 4'b0000;
                counter_green = 4'b0000;
                counter_blue = 4'b0000;
            end
            else begin
                counter_red = 4'b1111;
                counter_green = 4'b1111;
                counter_blue = 4'b1111;
            end
        end
    end

    assign vgaRed = counter_red;
    assign vgaGreen = counter_green;
    assign vgaBlue = counter_blue;

endmodule
