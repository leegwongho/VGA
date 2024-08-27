`timescale 1ns / 1ps

module color_fsm(
    input clk, reset_p,
    input signed [7:0] offset_x, offset_y,
    input [8:0] cursor_addr_x, cursor_addr_y,
    output reg o_write_enable,
    output reg [9:0] addr_x, addr_y,
    output reg [3:0] vgaRed, vgaGreen, vgaBlue
    );
    
    wire cursor_write_enable;
    wire [8:0] cursor_rgb_addr_x, cursor_rgb_addr_y;
    wire [3:0] cursor_rgb_red, cursor_rgb_green, cursor_rgb_blue;
    
    cursor_graphic cursor_module (
        .clk (clk),
        .reset_p (reset_p),
        .current_graphic_state (state),
        .cursor_addr_x (cursor_addr_x), 
        .cursor_addr_y (cursor_addr_y),
        
        .write_enable (cursor_write_enable),
        .rgb_addr_x (cursor_rgb_addr_x),
        .rgb_addr_y (cursor_rgb_addr_y),
        .rgb_red (cursor_rgb_red),
        .rgb_green (cursor_rgb_green),
        .rgb_blue (cursor_rgb_blue)
    );
    
    reg [3:0] value_x, value_y;
    reg [19:0] time_counter;
    reg generate_frame;
    reg internal_write_enable;
    
/*
    // change value per 10ms
    always @(negedge clk or posedge reset_p) begin
        if (reset_p) begin
            time_counter = 0;
            value_x = 0;
            value_y = 0;
        end
        else begin
            time_counter = time_counter + 1;
            if (time_counter >= 'd1_000_000) begin
                time_counter = 0;
                
                value_x = value_x + 1;
                if (value_x >= 320) begin
                    value_x = 0;
                    value_y = value_y + 1;
                    if (value_y >= 240) begin
                        value_y = 0;
                    end
                end
            end
        end
        
    end
*/

    // Every 10ms, sweep frame by address;
    always @(negedge clk or posedge reset_p) begin
        if (reset_p) begin
            generate_frame = 0;
            addr_x = 0;
            addr_y = 0;
        end
        else if (1) begin
            if (time_counter == 0) begin
                generate_frame = 1;
            end
            else if (generate_frame) begin
                addr_x = addr_x + 1;
                if (addr_x >= 320) begin
                    addr_x = 0;
                    addr_y = addr_y + 1;
                    if (addr_y >= 240) begin
                        addr_y = 0;
                        generate_frame = 0;
                    end
                end
            end
        end
    end
    
    parameter IDLE  = 6'b000001;
    parameter RED   = 6'b000010;
    parameter GREEN = 6'b000100;
    parameter BLUE  = 6'b001000;
    parameter WHITE = 6'b010000;
    parameter CURSOR = 6'b010000;    

    reg [5:0] state, next_state;
    reg [3:0] red, green, blue;

    always @(negedge clk or posedge reset_p) begin
        if (reset_p) state = IDLE;
        else if(!time_counter) state = next_state;
    end

    // next state circuit
    always @(negedge clk or posedge reset_p) begin
        if (reset_p) begin
            next_state = IDLE;
            vgaRed = 0;
            vgaGreen = 0;
            vgaBlue = 0;
        end
        else begin
            case (state)
                IDLE: begin
                    o_write_enable = 1;
                    if(addr_x < 160 && addr_y < 120)begin
                        vgaRed = 4'b1111;
                        vgaGreen = 4'b0000;
                        vgaBlue = 4'b0000;
                    end
                    else if (addr_x >= 160 && addr_y < 120) begin
                        vgaRed = 4'b0000;
                        vgaGreen = 4'b1111;
                        vgaBlue = 4'b0000;
                    end
                    else if (addr_x < 160 && addr_y >= 120) begin
                        vgaRed = 4'b0000;
                        vgaGreen = 4'b0000;
                        vgaBlue = 4'b1111;
                    end
                    else begin
                        vgaRed = 4'b1111;
                        vgaGreen = 4'b1111;
                        vgaBlue = 4'b1111;
                    end
                    addr_x = addr_x + 1;
                    if (addr_x >= 320) begin
                        addr_x = 0;
                        addr_y = addr_y + 1;
                        if (addr_y >= 240) begin
                            addr_y = 0;
                            next_state = CURSOR;
                        end
                    end
                end

                RED: begin

                    vgaRed = 4'b1111;
                    vgaGreen = 4'b0000;
                    vgaBlue = 4'b0000;

                    next_state = GREEN;
                end

                GREEN: begin

                    vgaRed = 4'b0000;
                    vgaGreen = 4'b1111;
                    vgaBlue = 4'b0000;

                    next_state = BLUE;
                end

                BLUE: begin

                    vgaRed = 4'b0000;
                    vgaGreen = 4'b0000;
                    vgaBlue = 4'b1111;

                    next_state = WHITE;
                end

                WHITE: begin

                    vgaRed = 4'b1111;
                    vgaGreen = 4'b1111;
                    vgaBlue = 4'b1111;

                    next_state = IDLE;
                end
                
                CURSOR: begin
                    o_write_enable = cursor_write_enable;
                    addr_x = cursor_rgb_addr_x; addr_y = cursor_rgb_addr_y;
                    vgaRed = cursor_rgb_red; vgaGreen = cursor_rgb_green; vgaBlue = cursor_rgb_blue;
                end

                default: next_state = IDLE;
            endcase
        end
    end

endmodule
