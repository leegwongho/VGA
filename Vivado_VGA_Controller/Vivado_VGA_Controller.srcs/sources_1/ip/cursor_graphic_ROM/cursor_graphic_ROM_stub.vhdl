-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Mon Sep  2 19:42:07 2024
-- Host        : DESKTOP-TPO10A8 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               D:/lany_workspace/Git/vga_con/Vivado_VGA_Controller/Vivado_VGA_Controller.srcs/sources_1/ip/cursor_graphic_ROM/cursor_graphic_ROM_stub.vhdl
-- Design      : cursor_graphic_ROM
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cursor_graphic_ROM is
  Port ( 
    a : in STD_LOGIC_VECTOR ( 6 downto 0 );
    clk : in STD_LOGIC;
    qspo : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );

end cursor_graphic_ROM;

architecture stub of cursor_graphic_ROM is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a[6:0],clk,qspo[1:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dist_mem_gen_v8_0_13,Vivado 2019.2";
begin
end;
