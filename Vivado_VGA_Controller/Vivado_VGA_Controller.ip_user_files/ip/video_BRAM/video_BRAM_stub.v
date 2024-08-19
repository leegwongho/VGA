// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Mon Aug 19 16:30:55 2024
// Host        : DESKTOP-TPO10A8 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/lany_workspace/Git/vga_con/Vivado_VGA_Controller/Vivado_VGA_Controller.srcs/sources_1/ip/video_BRAM/video_BRAM_stub.v
// Design      : video_BRAM
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2019.2" *)
module video_BRAM(clka, ena, wea, addra, dina, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[16:0],dina[3:0],douta[3:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [16:0]addra;
  input [3:0]dina;
  output [3:0]douta;
endmodule
