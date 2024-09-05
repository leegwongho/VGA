// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Thu Sep  5 18:57:13 2024
// Host        : DESKTOP-TPO10A8 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/lany_workspace/Git/vga_con/Vivado_VGA_Controller/Vivado_VGA_Controller.srcs/sources_1/ip/cursor_graphic_ROM/cursor_graphic_ROM_stub.v
// Design      : cursor_graphic_ROM
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2019.2" *)
module cursor_graphic_ROM(a, clk, qspo)
/* synthesis syn_black_box black_box_pad_pin="a[6:0],clk,qspo[1:0]" */;
  input [6:0]a;
  input clk;
  output [1:0]qspo;
endmodule
