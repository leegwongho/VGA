// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Mon Sep  2 18:43:03 2024
// Host        : leegwongho running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/github/vga_con_verilog/Vivado_VGA_Controller/Vivado_VGA_Controller.srcs/sources_1/ip/cursor_graphic_ROM/cursor_graphic_ROM_sim_netlist.v
// Design      : cursor_graphic_ROM
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "cursor_graphic_ROM,dist_mem_gen_v8_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module cursor_graphic_ROM
   (a,
    clk,
    qspo);
  input [6:0]a;
  input clk;
  output [1:0]qspo;

  wire [6:0]a;
  wire clk;
  wire [1:0]qspo;
  wire [1:0]NLW_U0_dpo_UNCONNECTED;
  wire [1:0]NLW_U0_qdpo_UNCONNECTED;
  wire [1:0]NLW_U0_spo_UNCONNECTED;

  (* C_FAMILY = "artix7" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_DPO = "0" *) 
  (* C_HAS_DPRA = "0" *) 
  (* C_HAS_I_CE = "0" *) 
  (* C_HAS_QDPO = "0" *) 
  (* C_HAS_QDPO_CE = "0" *) 
  (* C_HAS_QDPO_CLK = "0" *) 
  (* C_HAS_QDPO_RST = "0" *) 
  (* C_HAS_QDPO_SRST = "0" *) 
  (* C_HAS_WE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_PIPELINE_STAGES = "0" *) 
  (* C_QCE_JOINED = "0" *) 
  (* C_QUALIFY_WE = "0" *) 
  (* C_REG_DPRA_INPUT = "0" *) 
  (* c_addr_width = "7" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "80" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_clk = "1" *) 
  (* c_has_qspo = "1" *) 
  (* c_has_qspo_ce = "0" *) 
  (* c_has_qspo_rst = "0" *) 
  (* c_has_qspo_srst = "0" *) 
  (* c_has_spo = "0" *) 
  (* c_mem_init_file = "cursor_graphic_ROM.mif" *) 
  (* c_parser_type = "1" *) 
  (* c_read_mif = "1" *) 
  (* c_reg_a_d_inputs = "1" *) 
  (* c_sync_enable = "1" *) 
  (* c_width = "2" *) 
  (* is_du_within_envelope = "true" *) 
  cursor_graphic_ROM_dist_mem_gen_v8_0_13 U0
       (.a(a),
        .clk(clk),
        .d({1'b0,1'b0}),
        .dpo(NLW_U0_dpo_UNCONNECTED[1:0]),
        .dpra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .i_ce(1'b1),
        .qdpo(NLW_U0_qdpo_UNCONNECTED[1:0]),
        .qdpo_ce(1'b1),
        .qdpo_clk(1'b0),
        .qdpo_rst(1'b0),
        .qdpo_srst(1'b0),
        .qspo(qspo),
        .qspo_ce(1'b1),
        .qspo_rst(1'b0),
        .qspo_srst(1'b0),
        .spo(NLW_U0_spo_UNCONNECTED[1:0]),
        .we(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
M9ERyrMNmk2Jjyg6ZCGYQpTqx5C+74+ICn/vAQ5KoRuxJNbql8tHJjFcOe3FAJX14Nokq4wtfvZP
2sPXAs/eYYzjjbnt4nx8oZRRPy0XyDpvba/qxyqBSxjChIoPMDwpXnxi+chZJU5N1zCNt9FZPAep
nLCjMCkQTlKbP3cUJIY=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FBAg02qOh8M8uZkNvwWHoY3ELncwvHjjgL2y2qLN7xuxxaPQj3LdyD/IETTPdSjNCB/rhpJxbT1y
U5fbF28Hkp+bzDuxeTWPX251wMhiEmdm4jhyMl2z+GRf2Z6VJ4bVM5bieaJvsbjuyQ9Az6TDmueI
14citDEbyRCyJD9EiVckdS2mZcTl37oVFebKnIeJGmNjOc2XrcM84JVJIG5iv3ryS2hAG9/84hEr
u3DYC+xS2w5swJXVSf0zV+w8xZulS3PTPLELIM8O+SEFdHetZKnrgG1aJ7V5xu0RniGAsyVwVbgu
M1jPqNLyU+9kyETKfG9jcGEIM2I2gUfmOvRs+g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
TYvdYOtu2OcY/hp0LCFlgwGgJeLJ5MSBDPjuyI3760LiXtklDVs7CUFlvRRXMgAzbHlMXbiHp/Xl
cvmN035ayt8D8gPWRXxnbQf3kRlW6EIFwFMZ1inL9b5f47gsuvCP6MaKiTg0W7+/ZeHbM4jHXvRe
b8HXvQvK5kVwtayEwt0=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
GkcGg32vdV7ZS9x4Uw9v3hZEcxD5hMmQXUqa6shDPbzqUGIxrKpTOb9W4Sgi8rq+qw7QpAZp2JW/
MkYAH1WikFlf+XWG57y55EFV7oRoKQDh2Yz0sZEwVhwTGwSAqfnjrmPITofdG5eiey1ySGprEKsT
mqWAV+ZN7TkQkKup0Ukf1O+8giYKT/7UibTRqG/CT9dgU/4atPgYh2QjNMVrsAH/uzDxh7stQMYe
nkjZBkpLWOq7mxEXTKVtYAD/8G5qCJELRcvCuUKYz4Une1wDj+L/vwRK3IAdWKQ+/5mvj0q5XEm7
IKu5HYvalbySwRWzaB00uobXZorNhfwSv45jHg==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
JnT3Bfv/DUBx2mIm4+jpmHjzhKoX4mNpcc/lgscv3iYrJw8Uble396hMwPsVZ+kkAsmYtegNCiTG
Z7kqnoNeWHv+Grdizsq0QM9S2KJ5EoZhjelE+3Cii/ztNHf7Y3c0nBPnioUQ5YmWk7vgoQl3SJ3d
vwD3G0c+fGJBRpi14hTJOB2wtu4EeWcJ1f+01LjKINeucLlwacjnN0tElyRgCNKfsRDAQiMqwKqg
XCleeNY0cyLXGI30pXMpnbLizYlNKgVD6DSeNaby0dhW4phR0a+9xteo8l8eRVzTO+VSOcYSy8rU
6Uj2y0Up19vcq91C+/YeHlh24VwNI2TJeUEDwQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
AWr8D+IaT/X0jMJSrwmWnhWOjt0+8oyULINYaH7QGBLgqKCVtf8rqo68R3/TZ8gTkN73fZOx0QCU
3WEp7Ga1gUsqEgy+2zGlncYhOzx62FJm4Pm7S6LbE1qdg3/9Pp55JLaf1ouYlZccQJ+yawj0HgL4
zR0T347Zg2aIFxQZ28icCuJbxAZsZgAT30scXsTMMvXlQQ9NI21OjirKgHRn3dldIjpkL+BrVBkQ
Q7MMiTBhpCn/c+WXk4H9BPc3vMrVoh6r5oo+e1858Hk7osyxNI9zuACaGwdAatsW756kQBMsQoUj
TmJksSfucjrHVSuLFffpztOARH3LXrhZcCZdoQ==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
fPVwMHnHe1L8weZTnbBxjlAabwZZnO4DZSHaO7tHGHAw6U+w+7Rc3BwfQXtiTyGXP15rvoLhvVpo
i1Tzs4zrV1X8vlWrxhS6XA2VO4RFkpCjmnHpvdgnW9mpk7w90QOEZIWZQST/o15t0wDT/kv4J36r
Ho59mVFCGQQSSYx0209u6sG2rNpJ5HtWMM+tDEDHUArucrBmPOoZSq0VSQsTHtjJQxr3U5fv9l6q
aEBWkjnLJ6zqLkt12B3q7V3iFORPpz6XNMqA6wzArzWirzgTCw3CduiSAgbNgoGmV4eNrVb2DfOT
5V4ni19GigMG1fHCD9dNPWGiRCWpY6iiN6iE1w==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
NkQB16Pku9sdGFuAkY+DjFhWzKYvb26AsK/VO1//MS5ztnK+V9d/0K8nVee9kGDNC4zorSd1NjRc
Jkj/JJm1k/9QiQQwOSB/94zKWUyVH2Rvw3UOuaTu9pWRQsIdmPNwXBKCOF5L17HHGaNqYzvHF7YY
REIp6VR4HcyLq2beYXn09Mq0f84obUr7+CMgh8i1SaLa/ydMPS9xsm1i0NFB3qcEC0dDq6xklwsX
s198UBI5mBJTEUKi38eytWXzQPFTmqdlD3Qn4CgstxSdoLrFHchISqt+L62U4xU6aVyYXmVaeebF
I1F3MAXQZwZwGETW7RW9t/+3pJtkjPfPtdnqu/Sg+zP+vLjSV/NcONctKnTj86/z+TTehoSH8ccr
BsjV0PhAtR3+RTr3VGkKJoUNeE8yFQIHlES8UamuSNMh5XrbmcbFx22MZ9gLOa350ytm1N124jNF
V860l5gGbt/8NcGf8I3EVPrYblJ5ZLGsZkVg1cKBMUys1yMm6Ci2Mruc

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
JDELzo7luYHcwIl8sAAMR3hvm1tr+ZaD3VKTvYj1uwYFwuIPCkUfjVi8OMAgp3Hh/R1wDZSeoY7T
xpO0sKF9MsovKwwArnByLL8zZflfJIe5AmC+jE5a8qUxydp4liMdOypRTLu6U6EUYUwSj6VOR0Uj
deCoQCr/gVZ2GdNKF5sKZsGXZSvx1Wag70BiGs69qhgUvVVlpbqpNRSB0DR/2IuSKCHhkucLXiTk
zVS7zC7GiyNYE6l/Yu5Ov25Cl+lY5cMZkqKvIFm90UiTBNYk4No5ofXnH/E0rNcbydv0BvWDmgKt
NXVratbi0ztKLb27z2lw5ZZzXCihB41kx4VjqA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 5088)
`pragma protect data_block
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
Uixn4nHBrLY71BEUB1Bv
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
