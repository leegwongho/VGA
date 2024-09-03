
module mouse_sipo(
    input clk, reset_p,
    inout data,
    input data_clk,
    output reg data_in_busy_flag,
    output [10:0] signal_1, signal_2, signal_3, signal_4);

    reg [43:0] sipo;
    reg [43:0] buffer;
    reg [5:0] count;
    reg mouse_data;

    wire data_clk_nedge;
    wire data_in;

    reg init_state, data_out;
    assign data = (init_state) ? data_out : data_in;
    edge_detector_n right_click_edge ( .clk(clk), .reset_p(reset_p), .cp(data_clk), .n_edge(data_clk_nedge));

    
    assign signal_1 =  sipo[43:33];
    assign signal_2 =  sipo[32:22];
    assign signal_3 =  sipo[21:11];
    assign signal_4 =  sipo[10:0];

    // mouse write (init only) 8'hf4
    reg [3:0] send_bit_counter;
    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            init_state = 1;
            send_bit_counter = 0;
        end
        else begin
            if (init_state) begin
                 if (data_clk_nedge) begin
                    case (send_bit_counter)
                        0: begin
                            data_out = 1'b0; // start bit
                            send_bit_counter = send_bit_counter + 1;
                        end
                        1: begin
                            data_out = 1'b1;
                            send_bit_counter = send_bit_counter + 1;
                        end
                        2: begin
                            data_out = 1'b1; 
                            send_bit_counter = send_bit_counter + 1;
                        end
                        3: begin
                            data_out = 1'b1;
                            send_bit_counter = send_bit_counter + 1;
                        end
                        4: begin
                            data_out = 1'b1;
                            send_bit_counter = send_bit_counter + 1;
                        end
                        5: begin
                            data_out = 1'b0;
                            send_bit_counter = send_bit_counter + 1;
                        end            
                        6: begin
                            data_out = 1'b1;
                            send_bit_counter = send_bit_counter + 1;
                        end
                        7: begin
                            data_out = 1'b0;
                            send_bit_counter = send_bit_counter + 1;
                        end
                        8: begin
                            data_out = 1'b0;
                            send_bit_counter = send_bit_counter + 1;
                        end
                        9: begin
                            data_out = 1'b0; 
                            send_bit_counter = send_bit_counter + 1;
                        end
                        10: begin
                            data_out = 1'b1; // stop bit
                            init_state = 0;
                        end
                    endcase
                 end
            end
        end
    end

    // mouse read
    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            sipo <= 0;
            buffer <= 0;
            mouse_data <= 0;
            count <= 0;
        end
        else if (!init_state) begin
            mouse_data <= data_in;
            if (data_clk_nedge) begin
                buffer <= {buffer[42:0], mouse_data};
                count <= count + 1;
                data_in_busy_flag <= 1;
            end

            if (count >= 6'd44) begin
                sipo <= buffer;
                buffer <= 0;
                count <= 0;
                data_in_busy_flag <= 0;
            end
        end
    end

    // wire [15:0] value; 
    // assign value = count;
//    fnd_4digit_cntr test( .clk(clk), .reset_p(reset_p), .com(com), .value(value), .seg_7(seg_7) );



endmodule





