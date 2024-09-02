module cursor_graphic(
    input clk,
    input reset_p,
    input [3:0] i_bram_r,i_bram_g,i_bram_b,
    input mouse_left_click,
    input signed [10:0] pixel_addr_x, pixel_addr_y,
    input signed [10:0] cursor_addr_x, cursor_addr_y,
    output reg [3:0] o_vga_r, o_vga_g, o_vga_b);

    function [11:0]bit_to_12bit;
        input bit;
        begin
            bit_to_12bit = {12{bit}};
        end
        
    endfunction

    wire [1:0] lut_out;

    cursor_graphic_ROM(
                        .a({temp_y[3:0],temp_x[2:0]}), 
                        .clk(clk), 
                        .qspo(lut_out)
    );

    localparam LUT_MAX_ADDR_X = 6 ;
    localparam LUT_MAX_ADDR_Y = 10 ;



    reg signed [10:0] temp_x, temp_y; 


    always @(*) begin
        temp_x = pixel_addr_x - cursor_addr_x;
        temp_y = pixel_addr_y - cursor_addr_y;
    end

    // 00 blank 10 white 11 black
    reg pixel_bit_color;



    always @ (*) begin
        case (lut_out)
            10:  pixel_bit_color = 1;
            11:  pixel_bit_color = 0;
        endcase

        if ((temp_x >= LUT_MAX_ADDR_X) || (temp_x < 0) ) begin
             {o_vga_r, o_vga_g,  o_vga_b} =  {i_bram_r,i_bram_g,i_bram_b};
        end
        else begin
            case (lut_out)
                00:{o_vga_r, o_vga_g,  o_vga_b} =  {i_bram_r,i_bram_g,i_bram_b};
                10:{o_vga_r, o_vga_g,  o_vga_b}  = mouse_left_click ? bit_to_12bit(~pixel_bit_color) : bit_to_12bit(pixel_bit_color);
                11:{o_vga_r, o_vga_g,  o_vga_b}  = mouse_left_click ? bit_to_12bit(~pixel_bit_color) : bit_to_12bit(pixel_bit_color);
            endcase 
        end 

    end



endmodule