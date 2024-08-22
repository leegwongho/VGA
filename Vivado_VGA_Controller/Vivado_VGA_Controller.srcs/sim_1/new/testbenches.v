`timescale 1ns / 1ns

module tb_TOP_module ();

    reg clk, reset_p;
    wire Hsync, Vsync;
    wire [3:0] vgaRed, vgaGreen, vgaBlue;

    TOP_module DUT (
        clk, reset_p,
        Hsync, Vsync,
        vgaRed, vgaGreen, vgaBlue
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        reset_p=0;
        reset_p=1;
        #10 reset_p=0;
        repeat (100) begin
            @(posedge Vsync) $stop;
        end
    end
    
endmodule


module tb_TOP_VGA_BRAM_test ();

    reg clk, reset_p;
    wire Hsync, Vsync;
    wire [3:0] vgaRed, vgaGreen, vgaBlue;

    TOP_VGA_BRAM_test DUT (
        clk, reset_p,
        Hsync, Vsync,
        vgaRed, vgaGreen, vgaBlue
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        reset_p=0;
        reset_p=1;
        #10 reset_p=0;
        @(posedge Vsync) $stop;
    end

endmodule


module tb_pixel_coord_tracker ();

    reg clk, reset_p;
    wire Hsync, Vsync, display_on;
    wire pixel_clock_pulse;
    wire [9:0] cur_pixel_coord_x, cur_pixel_coord_y;


    pixel_coordinate_tracker pixel_coord_tracker_module (
        .clk (clk),
        .reset_p (reset_p),
        
        .Hsync          (Hsync),
        .Vsync          (Vsync),
        .pixel_clock_pusle  (pixel_clock_pulse),
        .in_display_on  (display_on),
        
        .pixel_coord_x  (cur_pixel_coord_x),
        .pixel_coord_y  (cur_pixel_coord_y)
    );

    VGA_controller vga_cntr_module(
        .clk (clk),
        .reset_p (reset_p),
        .pixel_clock_pulse (pixel_clock_pulse),
        
        .in_vgaRed (),
        .in_vgaGreen (),
        .in_vgaBlue (),
         
        .Hsync (Hsync),
        .Vsync (Vsync),
        .out_display_on (display_on),
        
        .out_vgaRed (),
        .out_vgaGreen (),
        .out_vgaBlue ()
    );

    pixel_clock_generator pixel_clock_gen_module (
        .clk (clk),
        .reset_p (reset_p),
        
        .pixel_clock_pulse (pixel_clock_pulse)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        reset_p=0;
        reset_p=1;
        #10 reset_p=0;
        @(posedge Vsync) $stop;
    end

endmodule

module tb_bram_ADC();

    reg clk, reset_p;
    wire Hsync, Vsync;
    wire [3:0] V2M_Red, V2M_Green, V2M_Blue;

    TOP_BRAM_ADC_module DUT(.clk(clk), .reset_p(reset_p), .Hsync(Hsync), .Vsync(Vsync),
                            .V2M_Red(V2M_Red), .V2M_Green(V2M_Green), .V2M_Blue(V2M_Blue));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        reset_p=0;
        reset_p=1;
        #10 reset_p=0;
        @(posedge Vsync) $stop;
    end


endmodule