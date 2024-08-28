module mouse_data_origin_Word(
    input clk, reset_p,
    input [10:0] signal_1, signal_2, signal_3, signal_4,
    output reg mouse_left_click, mouse_right_click, 
    output reg mouse_right_left_cursor, mouse_up_down_cursor, 
    output reg [7:0] mouse_move_x, mouse_move_y);



    always @ (negedge clk, posedge reset_p) begin
        if (reset_p) begin
            mouse_left_click = 0;
            mouse_right_click = 0;
            mouse_right_left_cursor = 0;
            mouse_up_down_cursor = 0;
            mouse_move_x = 0;
            mouse_move_y = 0;
        end
        else begin
            mouse_left_click        = signal_1[9];
            mouse_right_click       = signal_1[8];
            mouse_right_left_cursor = signal_1[5];
            mouse_up_down_cursor    = signal_1[4];
            mouse_move_x            = signal_2[9:2];
            mouse_move_y            = signal_3[9:2];
        end
    end


    // assign mouse_left_click             = signal_1[9];
    // assign mouse_right_click            = signal_1[8];
    // assign mouse_right_left_cursor      = signal_1[5];
    // assign mouse_up_down_cursor         = signal_1[4];
    // assign mouse_move_x                 = signal_2[9:2];
    // assign mouse_move_y                 = signal_3[9:2];

endmodule