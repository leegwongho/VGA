`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/26 17:46:23
// Design Name: 
// Module Name: cursor_graphic
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cursor_graphic(
    input clk, reset_p,
    input [4:0] current_graphic_state,
    input [8:0] cursor_addr_x, cursor_addr_y,
    output reg write_enable,
    output reg rgb_addr_x, rgb_addr_y,
    output reg rgb_red, rgb_green, rgb_blue
    );
    
    parameter GRAPHIC_DEMO_IDLE  = 5'b00001;
    parameter GRAPHIC_DEMO_RED   = 5'b00010;
    parameter GRAPHIC_DEMO_GREEN = 5'b00100;
    parameter GRAPHIC_DEMO_BLUE  = 5'b01000;
    parameter GRAPHIC_DEMO_WHITE = 5'b10000;
    
    parameter ST_DISABLED = 3'b001;
    parameter ST_REFILLBG = 3'b010;
    parameter ST_DRAWCURSOR = 3'b100;
    
    reg [2:0] draw_state, draw_next_state; // 0: disabled, 1: refill background, 2: draw cursor
    reg cursor_LUT [0:14][0:9];
    
    // refill previous cursor graphic with background color
    
    // draw cursor graphic
    always @(negedge clk or posedge reset_p) begin
        if (reset_p) begin
            rgb_red = 0; rgb_green = 0; rgb_blue = 0;
        end
        
        else begin
            case (draw_state)
                ST_DISABLED: begin
                    write_enable = 0;
                end
                ST_REFILLBG: begin
                    case (current_graphic_state)
                         GRAPHIC_DEMO_IDLE: begin
                            if (cursor_addr_x < 160 && cursor_addr_y < 120) begin
                                rgb_red = 4'hf; rgb_green = 4'h0; rgb_blue = 4'h0;
                            end
                            else if (cursor_addr_x >= 160 && cursor_addr_y < 120) begin
                                rgb_red = 4'h0; rgb_green = 4'h0; rgb_blue = 4'hf;
                            end
                            else if (cursor_addr_x <= 160 && cursor_addr_y >= 120) begin
                                rgb_red = 4'h0; rgb_green = 4'hf; rgb_blue = 4'h0;
                            end
                            else begin
                                rgb_red = 4'hf; rgb_green = 4'hf; rgb_blue = 4'hf;
                            end
                         end
                         GRAPHIC_DEMO_RED: begin rgb_red = 4'hf; rgb_green = 4'h0; rgb_blue = 4'h0; end
                         GRAPHIC_DEMO_GREEN: begin rgb_red = 4'h0; rgb_green = 4'hf; rgb_blue = 4'h0; end
                         GRAPHIC_DEMO_BLUE: begin rgb_red = 4'h0; rgb_green = 4'h0; rgb_blue = 4'hf; end
                         GRAPHIC_DEMO_WHITE: begin rgb_red = 4'hf; rgb_green = 4'hf; rgb_blue = 4'hf; end
                    endcase
                    rgb_addr_x = cursor_addr_x; rgb_addr_y = cursor_addr_y;
                    write_enable = 1;
                    draw_next_state = ST_DRAWCURSOR;
                end
                ST_DRAWCURSOR: begin
                    rgb_red = 0; rgb_green = 0; rgb_blue = 0;
                    rgb_addr_x = cursor_addr_x; rgb_addr_y = cursor_addr_y;
                    write_enable = 1;
                    draw_next_state = ST_DISABLED;
                end
            endcase
        end
    end
endmodule
