-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
<<<<<<< Updated upstream:Vivado_VGA_Controller/Vivado_VGA_Controller.srcs/sources_1/ip/BRAM_4bit_512x240/BRAM_4bit_512x240_stub.vhdl
-- Date        : Mon Sep  2 09:05:10 2024
-- Host        : leegwongho running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/github/vga_con_verilog/Vivado_VGA_Controller/Vivado_VGA_Controller.srcs/sources_1/ip/BRAM_4bit_512x240/BRAM_4bit_512x240_stub.vhdl
=======
-- Date        : Mon Sep  2 14:25:28 2024
-- Host        : leegwongho running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/github/vga_con_verilog/Vivado_VGA_Controller/Vivado_VGA_Controller.gen/sources_1/ip/BRAM_4bit_512x240/BRAM_4bit_512x240_stub.vhdl
>>>>>>> Stashed changes:Vivado_VGA_Controller/Vivado_VGA_Controller.gen/sources_1/ip/BRAM_4bit_512x240/BRAM_4bit_512x240_stub.vhdl
-- Design      : BRAM_4bit_512x240
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BRAM_4bit_512x240 is
  Port ( 
    clka : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 16 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 3 downto 0 );
    clkb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 16 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );

end BRAM_4bit_512x240;

architecture stub of BRAM_4bit_512x240 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,wea[0:0],addra[16:0],dina[3:0],clkb,addrb[16:0],doutb[3:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_5,Vivado 2022.2";
begin
end;
