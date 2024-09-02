// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Mon Sep  2 14:00:44 2024
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
  output [0:0]qspo;

  wire [6:0]a;
  wire clk;
  wire [0:0]qspo;
  wire [0:0]NLW_U0_dpo_UNCONNECTED;
  wire [0:0]NLW_U0_qdpo_UNCONNECTED;
  wire [0:0]NLW_U0_spo_UNCONNECTED;

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
  (* c_width = "1" *) 
  (* is_du_within_envelope = "true" *) 
  cursor_graphic_ROM_dist_mem_gen_v8_0_13 U0
       (.a(a),
        .clk(clk),
        .d(1'b0),
        .dpo(NLW_U0_dpo_UNCONNECTED[0]),
        .dpra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .i_ce(1'b1),
        .qdpo(NLW_U0_qdpo_UNCONNECTED[0]),
        .qdpo_ce(1'b1),
        .qdpo_clk(1'b0),
        .qdpo_rst(1'b0),
        .qdpo_srst(1'b0),
        .qspo(qspo),
        .qspo_ce(1'b1),
        .qspo_rst(1'b0),
        .qspo_srst(1'b0),
        .spo(NLW_U0_spo_UNCONNECTED[0]),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 4192)
`pragma protect data_block
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
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
