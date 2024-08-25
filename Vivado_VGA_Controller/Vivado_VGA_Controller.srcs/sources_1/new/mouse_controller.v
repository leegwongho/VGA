module mouse_controller(
    input clk, reset_p,
    input data,
    input data_clk,
    output mouse_left_click, mouse_right_click, 
    output mouse_right_left_cursor, mouse_up_down_cursor, 
    output [7:0] mouse_move_x, mouse_move_y);


    wire data_finish_flag;

    wire [10:0] signal_1, signal_2, signal_3;

    mouse_sipo ps2_mouse_(
                        .clk(clk), .reset_p(reset_p),
                        .data(data),
                        .data_clk(data_clk),
                        .data_finish_flag(data_finish_flag),
                        .signal_1(signal_1), .signal_2(signal_2), .signal_3(signal_3));


    mouse_data_origin_Word valid_data_div(
                                .clk(clk), .reset_p(reset_p),
                                .signal_1(signal_1), .signal_2(signal_2), .signal_3(signal_3),
                                .mouse_left_click(mouse_left_click), .mouse_right_click(mouse_right_click), 
                                .mouse_right_left_cursor(mouse_right_left_cursor), .mouse_up_down_cursor(mouse_up_down_cursor), 
                                .mouse_move_x(mouse_move_x), .mouse_move_y(mouse_move_y));

endmodule