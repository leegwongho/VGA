module cursor_graphic(
    input clk,
    input reset_p,
    input [3:0] i_bram_r,i_bram_g,i_bram_b,
    input mouse_left_click,
    input signed [10:0] pixel_addr_x, pixel_addr_y,
    input signed [10:0] cursor_addr_x, cursor_addr_y,
    output[3:0] o_vga_r, o_vga_g, o_vga_b);

    function [11:0]bit_to_12bit;
        input bit;
        begin
            bit_to_12bit = {bit,bit,bit,bit,bit,bit,bit,bit,bit,bit,bit,bit};
        end
        
    endfunction

    wire lut_out;

    cursor_graphic_ROM(
                        .a({temp_y[3:0],temp_x[2:0]}), 
                        .clk(clk), 
                        .qspo(lut_out)
    );

    localparam LUT_MAX_ADDR_X = 6 ;
    localparam LUT_MAX_ADDR_Y = 10 ;



    wire signed [10:0] temp_x, temp_y; 

    assign temp_x = pixel_addr_x - cursor_addr_x;
    assign temp_y = pixel_addr_y - cursor_addr_y;

    assign {o_vga_r, o_vga_g,  o_vga_b} =  (temp_x >= LUT_MAX_ADDR_X) && (temp_x < 0) ? {i_bram_r,i_bram_g,i_bram_b}:
                                            (mouse_left_click ?  ~bit_to_12bit(lut_out) : bit_to_12bit(lut_out))  ; 
                                       
    // 1 w, 0 b







endmodule