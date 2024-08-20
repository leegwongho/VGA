`timescale 1ns / 1ps


module pixel_clock_generator (
    input clk, reset_p,
    output pixel_clock_pulse);

    parameter SYSCLK_FREQ = 100_000_000;
    parameter TARGET_FREQ =  25_000_000;
    localparam DIVIDER_VALUE = SYSCLK_FREQ / TARGET_FREQ;

    reg [6:0] count_sysclk;
    always @ (negedge clk, posedge reset_p) begin
        if (reset_p) count_sysclk = 0;
        else begin
            if (count_sysclk >= (DIVIDER_VALUE - 1) ) begin 
                count_sysclk = 0;
                end
            else begin
                count_sysclk = count_sysclk +1;
            end
        end
    end
    
    assign cp_div_100 = (count_sysclk < (DIVIDER_VALUE / 2) ) ? 0 : 1;
    
    edge_detector_n  edge_usec (.clk(clk), .reset_p(reset_p), .cp(cp_div_100), .n_edge(pixel_clock_pulse));
                
endmodule