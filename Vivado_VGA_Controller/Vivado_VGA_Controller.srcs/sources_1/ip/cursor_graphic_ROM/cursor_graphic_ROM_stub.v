// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Mon Sep  2 14:00:44 2024
// Host        : leegwongho running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/github/vga_con_verilog/Vivado_VGA_Controller/Vivado_VGA_Controller.srcs/sources_1/ip/cursor_graphic_ROM/cursor_graphic_ROM_stub.v
// Design      : cursor_graphic_ROM
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2022.2" *)
module cursor_graphic_ROM(a, clk, qspo)
/* synthesis syn_black_box black_box_pad_pin="a[6:0],clk,qspo[0:0]" */;
  input [6:0]a;
  input clk;
  output [0:0]qspo;
endmodule
