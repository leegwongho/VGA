// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
<<<<<<< Updated upstream
// Date        : Mon Sep  2 09:05:10 2024
// Host        : leegwongho running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/github/vga_con_verilog/Vivado_VGA_Controller/Vivado_VGA_Controller.srcs/sources_1/ip/BRAM_4bit_512x240/BRAM_4bit_512x240_stub.v
=======
// Date        : Mon Sep  2 14:25:28 2024
// Host        : leegwongho running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/github/vga_con_verilog/Vivado_VGA_Controller/Vivado_VGA_Controller.gen/sources_1/ip/BRAM_4bit_512x240/BRAM_4bit_512x240_stub.v
>>>>>>> Stashed changes
// Design      : BRAM_4bit_512x240
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *)
module BRAM_4bit_512x240(clka, wea, addra, dina, clkb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[16:0],dina[3:0],clkb,addrb[16:0],doutb[3:0]" */;
  input clka;
  input [0:0]wea;
  input [16:0]addra;
  input [3:0]dina;
  input clkb;
  input [16:0]addrb;
  output [3:0]doutb;
endmodule
