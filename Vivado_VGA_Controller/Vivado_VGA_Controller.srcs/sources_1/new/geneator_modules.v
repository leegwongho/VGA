`timescale 1ns / 1ps


module pixel_clock_generator (
    input clk, reset_p,
    output pixel_clock_pulse
);

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


module edge_detector_n (clk, reset_p, cp, p_edge, n_edge);
    input clk, reset_p, cp;
    output   p_edge, n_edge;

    reg ff_cur, ff_old;       

    always @ (negedge clk, posedge reset_p) begin
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


module h_sync_generator(
    input clk, reset_p,
    input p_clk_cp,
    output reg Hsync, H_display_on);

    reg [9:0] count;

    parameter H_ACTIVE = 10'd640;
    parameter H_FRONT_PORCH = 10'd656;
    parameter H_SYNC = 10'd752;
    parameter H_BACK_PORCH = 10'd800;



    always @ (posedge clk, posedge reset_p) begin
        if(reset_p) begin
            count = 0;
            Hsync = 1;
            H_display_on = 0;
        end
        else if (p_clk_cp) begin
            if (count >= H_BACK_PORCH) begin
                count = 0;
            end
            else begin
                count = count +1;
            end

            if (count <= H_ACTIVE) begin
                Hsync = 1;
                H_display_on = 1;
            end
            else if (count <= H_FRONT_PORCH) begin
                Hsync = 1;
                H_display_on = 0;
            end
            else if (count <= H_SYNC) begin
                Hsync = 0;
                H_display_on = 0;
            end
            else if (count <= H_BACK_PORCH) begin
                Hsync = 1;
                H_display_on = 0;
            end            

        end
    end


endmodule


module v_sync_generator(
    input clk, reset_p,
    input h_sync_cp,
    output reg Vsync, V_display_on);

    reg [9:0] count;

    parameter V_ACTIVE = 10'd480;
    parameter V_FRONT_PORCH = 10'd491;
    parameter V_SYNC = 10'd493;
    parameter V_BACK_PORCH = 10'd524;

    always @ (posedge clk, posedge reset_p) begin
        if(reset_p) begin
            count = 0;
            Vsync = 1;
            V_display_on = 0;
        end
        else if(h_sync_cp) begin
            if(count >= V_BACK_PORCH) begin
                count = 0;
            end
            else begin
                count = count +1;
            end
                       
            if (count <= V_ACTIVE) begin
                Vsync = 1;
                V_display_on = 1;
            end
            else if (count <= V_FRONT_PORCH) begin
                Vsync = 1;
                V_display_on = 0;
            end
            else if (count <= V_SYNC) begin
                Vsync = 0;
                V_display_on = 0;
            end
            else if (count <= V_BACK_PORCH) begin
                Vsync = 1;
                V_display_on = 0;
            end            

        end
    end

endmodule


// Tracks current pixel coordinates on monitor
module pixel_coordinate_tracker (
    input clk, reset_p,
    input Hsync, Vsync, pixel_clock_pusle, in_display_on,
    output reg [9:0] pixel_coord_x, pixel_coord_y
);

    wire Hsync_nedeg, Vsync_nedeg;
    edge_detector_n Hsync_edge_module (.clk(clk), .reset_p(reset_p), .cp(Hsync), .n_edge(Hsync_nedeg));
    edge_detector_n Vsync_edge_module (.clk(clk), .reset_p(reset_p), .cp(Vsync), .n_edge(Vsync_nedge));

    always @(negedge clk or reset_p) begin
        if (reset_p) begin
            pixel_coord_x = 0;
            pixel_coord_y = 0;
        end
        else begin
            if (Vsync_nedeg) begin
                pixel_coord_x = 0;
                pixel_coord_y = 0;
            end
            else if (Hsync_nedeg) begin
                pixel_coord_x = 0;
                pixel_coord_y = pixel_coord_y + 1;
            end
            else if (pixel_clock_pusle && in_display_on) begin
                pixel_coord_x = pixel_coord_x + 1;
            end
        end
    end

endmodule