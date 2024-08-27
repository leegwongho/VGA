`timescale 1ns / 1ps

module color_fsm(
    input clk, reset_p,
    input signed [7:0] offset_x, offset_y,
    output write_enable,
    output reg [9:0] addr_x, addr_y,
    output reg [3:0] vgaRed, vgaGreen, vgaBlue
    );
    
    reg [3:0] value_x, value_y;
    reg [19:0] time_counter;
    reg generate_frame;
    
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
    
    // Every 10ms, sweep frame by address
    assign write_enable = generate_frame;
    always @(negedge clk or posedge reset_p) begin
        if (reset_p) begin
            generate_frame = 0;
            addr_x = 0;
            addr_y = 0;
        end
        else begin
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
    
    parameter IDLE  = 5'b00001;
    parameter RED   = 5'b00010;
    parameter GREEN = 5'b00100;
    parameter BLUE  = 5'b01000;
    parameter WHITE = 5'b10000;

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
                    next_state = RED;
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

                default: next_state = IDLE;
            endcase
        end
    end

endmodule
