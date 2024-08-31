`timescale 1ns / 1ns

module tb_BRAM ();

    reg clka, clkb, write_enable;
    reg [16:0] porta_addr_1d, portb_addr_1d;
    reg [3:0] porta_vgaRed;
    wire [3:0] portb_vgaRed;

    BRAM_4bit_512x240 BRAM_red (
    .clka       (clka),
    .wea        (write_enable),
    .addra      (porta_addr_1d),
    .dina       (porta_vgaRed),
    
    .clkb       (clkb),
    .addrb      (portb_addr_1d),
    .doutb      (portb_vgaRed)
    );

    // clock generation
    initial begin
        clka = 0;
        forever #5 clka = ~clka;
    end
    
    initial begin
        clkb = 0;
        forever #15 clkb = ~clkb;
    end
    
    // input init
    initial begin
        write_enable = 0;
        porta_addr_1d = 0;
        portb_addr_1d = 0;
        porta_vgaRed = 0;
    end
    
    integer i;
    initial begin
    
        write_enable = 1;
        for (i=0; i<320; i=i+1) begin
            if (i <160) porta_vgaRed = 4'hf;
            else porta_vgaRed = 4'h3;
            porta_addr_1d = i;
            #10;
        end
        #10 write_enable = 0;
        
        for (i=0; i<320; i=i+1) begin
            #30 portb_addr_1d = i;
        end
        
        #100 $stop;
    end
    
endmodule

module tb_TOP_mouse_control_module ();

    reg clka, reset_p;
    wire Hsync, Vsync;
    wire data, data_clk;
    wire [3:0] V2M_Red, V2M_Green, V2M_Blue;
    wire [3:0] com;
    wire [7:0] seg_7;
    
    TOP_mouse_control DUT (
        clka, reset_p,
        data,
        data_clk,
        Hsync,Vsync,
        V2M_Red, V2M_Green, V2M_Blue,
        com,
        seg_7
     );
    
    initial begin
        clka = 0;
        forever #5 clka = ~clka;
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

module tb_TOP_module ();

    reg clka, reset_p;
    wire Hsync, Vsync;
    wire [3:0] vgaRed, vgaGreen, vgaBlue;

    TOP_module DUT (
        clka, reset_p,
        Hsync, Vsync,
        vgaRed, vgaGreen, vgaBlue
    );
    
    initial begin
        clka = 0;
        forever #5 clka = ~clka;
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

    reg clka, reset_p;
    wire Hsync, Vsync;
    wire [3:0] vgaRed, vgaGreen, vgaBlue;

    TOP_VGA_BRAM_test DUT (
        clka, reset_p,
        Hsync, Vsync,
        vgaRed, vgaGreen, vgaBlue
    );

    initial begin
        clka = 0;
        forever #5 clka = ~clka;
    end
    
    initial begin
        reset_p=0;
        reset_p=1;
        #10 reset_p=0;
        @(posedge Vsync) $stop;
    end

endmodule


module tb_pixel_coord_tracker ();

    reg clka, reset_p;
    wire Hsync, Vsync, display_on;
    wire pixel_clock_pulse;
    wire [9:0] cur_pixel_coord_x, cur_pixel_coord_y;


    pixel_coordinate_tracker pixel_coord_tracker_module (
        .clka (clka),
        .reset_p (reset_p),
        
        .Hsync          (Hsync),
        .Vsync          (Vsync),
        .pixel_clock_pusle  (pixel_clock_pulse),
        .in_display_on  (display_on),
        
        .pixel_coord_x  (cur_pixel_coord_x),
        .pixel_coord_y  (cur_pixel_coord_y)
    );

    VGA_controller vga_cntr_module(
        .clka (clka),
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
        .clka (clka),
        .reset_p (reset_p),
        
        .pixel_clock_pulse (pixel_clock_pulse)
    );
    
    initial begin
        clka = 0;
        forever #5 clka = ~clka;
    end
    
    initial begin
        reset_p=0;
        reset_p=1;
        #10 reset_p=0;
        @(posedge Vsync) $stop;
    end

endmodule