module mouse_controller_v2(
    input clk, reset_p,
    input data,
    output data_clk,
    // output [31:0] mouse_data,
    output [3:0] com,
    output [7:0] seg_7);

    reg [5:0] mouse_bit; 

    wire mouse_data_nedge, mouse_clk_nedge;

    reg [15:0] value;
    mouse_clock_generator mouse_clk (.clk(clk), .reset_p(reset_p), .pixel_clock_pulse(data_clk));
    edge_detector_n mouse_data_edge  (.clk(clk), .reset_p(reset_p), .cp(data), .n_edge(mouse_data_nedge));
    edge_detector_n mouse_clk_edge  (.clk(clk), .reset_p(reset_p), .cp(data_clk), .n_edge(mouse_clk_nedge));



    always @ (negedge clk, posedge reset_p) begin
        if (reset_p) begin
            mouse_bit = 0;
        end
        else begin
            if (mouse_data_nedge) begin
                mouse_bit = mouse_bit +1;
                if ( mouse_bit >= 5'd31) begin
                    mouse_bit = 0;
                end
            end
        end
    end

    reg mouse_left_click, mouse_right_click, mouse_right_left_cursor, mouse_up_down_cursor, mouse_move_x, mouse_move_y; 


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
            if (mouse_bit == 5'd1) begin
                if (data == 1) begin
                    mouse_left_click = 1;
                end
            end
            else begin
                mouse_left_click = 0;
            end

            if (mouse_bit == 2) begin
                if (data == 1) begin
                    mouse_right_click = 1;
                end
            end
            else begin
                mouse_right_click = 0;
            end

            if (mouse_bit == 5) begin
                if (data == 1) begin
                    mouse_right_left_cursor = 1;
                end
            end
            else begin
                mouse_right_left_cursor = 0;
            end
            

            if (mouse_bit == 6) begin
                if (data == 1) begin
                    mouse_up_down_cursor = 1;
                end
            end
            else begin
                mouse_up_down_cursor = 0;
            end

            if (mouse_bit == 17) begin
                if (data == 1) begin
                    mouse_move_x = 1;
                end
            end
            else begin
                mouse_move_x = 0;
            end

            if (mouse_bit == 27) begin
                if (data == 1) begin
                    mouse_move_y = 1;
                end
            end
            else begin
                mouse_move_y = 0;
            end

            
        end
    end

    wire mouse_left_click_nedge, mouse_right_click_nedge;
    edge_detector_n left_click_edge ( .clk(clk), .reset_p(reset_p), .cp(mouse_left_click), .n_edge(mouse_left_click_nedge));
    edge_detector_n right_click_edge ( .clk(clk), .reset_p(reset_p), .cp(mouse_left_click), .n_edge(mouse_right_click_nedge));

    


    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
           value = 0;
        end
        else begin
            if (mouse_left_click_nedge) begin
                value = value+1;
            end

            // if (mouse_right_click_nedge) begin
            //     value = value-1;
            // end


        end
    end




    fnd_4digit_cntr fnd( .clk(clk), .reset_p(reset_p), .com(com) , .value(value), .seg_7(seg_7));


endmodule



module mouse_controller_v1(  // 버그 수정 해야함
    input clk, reset_p,
    input data,
    // input data_clk,
    // output [31:0] mouse_data,
    output [3:0] com,
    output [7:0] seg_7);

    reg [5:0] mouse_bit; 

    wire mouse_data_nedge;

    reg [15:0] value;
    
    mouse_clock_generator mouse_clk (clk, reset_p, pixel_clock_pulse);
    edge_detector_n mouse_clk_edge ( .clk(clk), .reset_p(reset_p), .cp(data), .n_edge(mouse_data_nedge));

    always @ (negedge clk, posedge reset_p) begin
        if (reset_p) begin
            mouse_bit = 0;
        end
        else begin
            if (mouse_data_nedge) begin
                mouse_bit = mouse_bit +1;
                if ( mouse_bit >= 5'd31) begin
                    mouse_bit = 0;
                end
            end
        end
    end

    reg mouse_left_click, mouse_right_click, mouse_right_left_cursor, mouse_up_down_cursor, mouse_move_x, mouse_move_y; 


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
            if (mouse_bit == 5'd1) begin
                if (data == 1) begin
                    mouse_left_click = 1;
                end
            end

            if (mouse_bit == 2) begin
                if (data == 1) begin
                    mouse_right_click = 1;
                end
            end

            if (mouse_bit == 5) begin
                if (data == 1) begin
                    mouse_right_left_cursor = 1;
                end
            end

            if (mouse_bit == 6) begin
                if (data == 1) begin
                    mouse_up_down_cursor = 1;
                end
            end

            if (mouse_bit == 17) begin
                if (data == 1) begin
                    mouse_move_x = 1;
                end
            end

            if (mouse_bit == 27) begin
                if (data == 1) begin
                    mouse_move_y = 1;
                end
            end

            if (mouse_bit == 30) begin
                mouse_left_click = 0;
                mouse_right_click = 0;
                mouse_right_left_cursor = 0;
                mouse_up_down_cursor = 0;
                mouse_move_x = 0;
                mouse_move_y = 0;
            end
        end
    end

    wire mouse_left_click_pedge;
    edge_detector_n left_click_edge ( .clk(clk), .reset_p(reset_p), .cp(mouse_left_click), .p_edge(mouse_left_click_pedge));

    


    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
           
        end
        else begin
            if (mouse_left_click_pedge) begin
                value = value+1;
            end
        end
    end




    fnd_4digit_cntr fnd( .clk(clk), .reset_p(reset_p), .com(com) , .value(value), .seg_7(seg_7));


endmodule



module mouse_controller(
    input clk, reset_p,
    input data,
    input data_clk,
    // output [31:0] mouse_data,
    output [3:0] com,
    output [7:0] seg_7);

    parameter IDLE          = 0001;
    parameter MOUSE_STATUS  = 0010;
    parameter X_DIRECTION   = 0100;
    parameter Y_DIRECTION   = 1000;

    reg state, state_next;

    reg [5:0] mouse_bit; 

    wire mouse_clk_nedge, mouse_data_pedge, mouse_data_nedge;

    wire [31:0] mouse_data;
    edge_detector_n mouse_clk_edge ( .clk(clk), .reset_p(reset_p), .cp(data_clk), .n_edge(mouse_clk_nedge));
    edge_detector_n mouse_data_edge ( .clk(clk), .reset_p(reset_p), .cp(data), .p_edge(mouse_data_pedge), .n_edge(mouse_data_nedge));

    reg sipo_in_data, reg_en, rd_en;

    shift_register_sipo_n_32 sipo(  .clk(clk), .reset_p(reset_p),
                                    .d(sipo_in_data), .rd_en(rd_en), .reg_en(reg_en),
                                    .q(mouse_data));

    always @ (negedge clk, posedge reset_p) begin
        if (reset_p) begin
            mouse_bit = 0;
        end
        else if (mouse_clk_nedge) begin
            mouse_bit = mouse_bit +1;
            if ( mouse_bit >= 5'd31) begin
                mouse_bit = 0;
            end
        end
    end


    always @ (posedge clk, posedge reset_p) begin
        if (reset_p) begin
            state = IDLE;
        end
        else begin
            state = state_next;
        end
    end

    reg [7:0] mouse_status_byte, x_byte, y_byte;

    reg [4:0] count;

    always @ (negedge clk, posedge reset_p) begin
        if (reset_p) begin
            state_next = IDLE;
            sipo_in_data = 0;
            reg_en = 0;
        end
        else begin
            case (state)
                IDLE : begin
                    if (mouse_clk_nedge) begin
                        if (data == 0) begin
                            state_next = MOUSE_STATUS;
                            count = 0;
                            rd_en = 1;
                        end
                    end
                end
                MOUSE_STATUS : begin
                    if (mouse_clk_nedge) begin
                        reg_en = 1;
                        sipo_in_data = data;
                        count = count + 1;
                    end
                    else begin
                        reg_en = 0;
                    end

                    if (count >= 5'd10) begin
                        state_next = X_DIRECTION;
                    end 
                end 
                X_DIRECTION : begin
                    if (mouse_clk_nedge) begin
                        reg_en = 1;
                        sipo_in_data = data;
                        count = count + 1;
                    end
                    else begin
                        reg_en = 0;
                    end

                    if (count >= 5'd21) begin
                        state_next = Y_DIRECTION;
                    end 
                end
                Y_DIRECTION : begin
                    if (mouse_clk_nedge) begin
                        reg_en = 1;
                        sipo_in_data = data;
                        count = count + 1;
                    end
                    else begin
                        reg_en = 0;
                    end

                    if (count >= 5'd31) begin
                        state_next = IDLE;
                        rd_en = 0;
                    end 
                end
                default: ;
            endcase
        end
    end


    fnd_4digit_cntr fnd( .clk(clk), .reset_p(reset_p), .com(com) , .value({8'b0,mouse_data[31:24]}), .seg_7(seg_7));


endmodule





module fnd_4digit_cntr( clk, reset_p, com , value, seg_7 );
input clk, reset_p ;
input [15:0] value;
output [3:0] com;
output [7:0] seg_7;

reg [3:0] hex_value;

    ring_counter_bcd com_0 (.clk(clk), .reset_p(reset_p), . q(com));    
    
    decoder_7seg_behavioral  seg0(  .hex_value(hex_value),  .seg_7(seg_7));    

    always @ (posedge clk) begin                        
               case(com)
                        4'b1110: hex_value = value[3:0];
                        4'b1101: hex_value = value[7:4];
                        4'b1011: hex_value = value[11:8];
                        4'b0111: hex_value = value[15:12];
               endcase
    end


endmodule


 module   ring_counter_bcd (clk, reset_p,  q);
input clk, reset_p;
output  reg [3:0] q;

    reg [16:0] clk_div;
    always @(posedge clk) clk_div = clk_div +1;                        
   wire  clk_div_16_p;
   
    edge_detector_n de_clk (.clk(clk), .reset_p(reset_p), .cp(clk_div[16]), .p_edge(clk_div_16_p));

always @(posedge clk , posedge reset_p)begin                        
    if(reset_p) q = 4'b1110;                                                          
    else if (clk_div_16_p)  
               if (q == 4'b0111) q = 4'b1110;
               else q = {q[2:0], 1'b1};
    end 
    
endmodule

module decoder_7seg_behavioral(                 
    input [3:0] hex_value,                      
    output reg [7:0] seg_7);                    

    always @(hex_value) begin                   
        case(hex_value)                         
                              
            4'b0000 : seg_7 = 8'b0000_0011;     
            4'b0001 : seg_7 = 8'b1001_1111;     
            4'b0010 : seg_7 = 8'b0010_0101;     
            4'b0011 : seg_7 = 8'b0000_1101;     
            4'b0100 : seg_7 = 8'b1001_1001;     
            4'b0101 : seg_7 = 8'b0100_1001;     
            4'b0110 : seg_7 = 8'b0100_0001;     
            4'b0111 : seg_7 = 8'b0001_1111;     
            4'b1000 : seg_7 = 8'b0000_0001;     
            4'b1001 : seg_7 = 8'b0001_1001;     
            4'b1010 : seg_7 = 8'b0001_0001;     
            4'b1011 : seg_7 = 8'b1100_0001;     
            4'b1100 : seg_7 = 8'b0110_0011;     
            4'b1101 : seg_7 = 8'b1000_0101;     
            4'b1110 : seg_7 = 8'b0110_0001;     
            4'b1111 : seg_7 = 8'b0111_0001;     
        endcase                                
    end                                        

endmodule 


module edge_detector_p (clk, reset_p, cp, p_edge, n_edge);
input clk, reset_p, cp;
output   p_edge, n_edge;

 reg ff_cur, ff_old;       


    always @ (posedge clk, posedge reset_p) begin
            if(reset_p) begin
                ff_cur <= 0;
                ff_old <= 0;
            end
            else begin
                ff_cur <= cp;                   
                ff_old <= ff_cur;
            end

    end

    assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1: 0;
    
     assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1: 0;


endmodule