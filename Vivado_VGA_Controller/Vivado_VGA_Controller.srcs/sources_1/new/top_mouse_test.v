module top_mouse_test(
    input clk, reset_p,
    input data,
    input data_clk,
    output [3:0] com,
    output [7:0] seg_7
);

    wire mouse_left_click, mouse_right_click, mouse_right_left_cursor, mouse_up_down_cursor;
    wire [7:0] mouse_move_x, mouse_move_y;

    mouse_usb_ps2 mouse_test(
                        .clk(clk), .reset_p(reset_p),
                        .data(data),
                        .data_clk(data_clk),
                        .mouse_left_click(mouse_left_click), .mouse_right_click(mouse_right_click), 
                        .mouse_right_left_cursor(mouse_right_left_cursor), .mouse_up_down_cursor(mouse_up_down_cursor), 
                        .mouse_move_x(mouse_move_x), .mouse_move_y(mouse_move_y));

    // reg [7:0] value_x, value_y;
    reg [15:0] value_x, value_y;

    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            value_x = 0;
            value_y = 0;
        end
        else begin
            if (mouse_left_click) begin
                value_x = value_x - 1;
            end

            if (mouse_right_click) begin
                value_y = value_y -1;
            end

            if (mouse_right_left_cursor) begin
                value_x = value_x + mouse_move_x[4];
            end
            else begin
                value_x = value_x - mouse_move_x[4];
            end

            if (mouse_up_down_cursor) begin
                value_y = value_y - mouse_move_y[4];
            end
            else begin
                value_y = value_y + mouse_move_y[4];                
            end
        
        end
    end

    // assign value = {value_y, value_x};

    fnd_4digit_cntr fnd( .clk(clk), .reset_p(reset_p), .com(com) , .value(value), .seg_7(seg_7));


endmodule