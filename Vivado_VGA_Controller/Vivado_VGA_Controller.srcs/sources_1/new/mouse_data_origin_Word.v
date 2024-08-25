module mouse_data_origin_Word(
    input clk, reset_p,
    input [10:0] signal_1, signal_2, signal_3, signal_4,
    output mouse_left_click, mouse_right_click, 
    output mouse_right_left_cursor, mouse_up_down_cursor, 
    output [7:0] mouse_move_x, mouse_move_y);

    assign mouse_left_click = signal_1[9];
    assign mouse_right_click = signal_1[8];
    assign mouse_right_left_cursor = signal_1[5];
    assign mouse_up_down_cursor = signal_1[4];

    assign mouse_move_x = signal_2[9:2];
    assign mouse_move_y = signal_3[9:2];

endmodule