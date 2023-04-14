/************************************************************************
Avalon-MM Interface VGA Text mode display

Register Map:
0x000-0x0257 : VRAM, 80x30 (2400 byte, 600 word) raster order (first column then row)
0x258        : control register

VRAM Format:
X->
[ 31  30-24][ 23  22-16][ 15  14-8 ][ 7    6-0 ]
[IV3][CODE3][IV2][CODE2][IV1][CODE1][IV0][CODE0]

IVn = Draw inverse glyph
CODEn = Glyph code from IBM codepage 437

Control Register Format:
[[31-25][24-21][20-17][16-13][ 12-9][ 8-5 ][ 4-1 ][   0    ] 
[[RSVD ][FGD_R][FGD_G][FGD_B][BKG_R][BKG_G][BKG_B][RESERVED]

VSYNC signal = bit which flips on every Vsync (time for new frame), used to synchronize software
BKG_R/G/B = Background color, flipped with foreground when IVn bit is set
FGD_R/G/B = Foreground color, flipped with background when Inv bit is set

************************************************************************/
`define NUM_REGS 601 //80*30 characters / 4 characters per register
`define CTRL_REG 600 //index of control register

module vga_text_avl_interface (
	// Avalon Clock Input, note this clock is also used for VGA, so this must be 50Mhz
	// We can put a clock divider here in the future to make this IP more generalizable
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,					// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,			// Avalon-MM Byte Enable
	input  logic [11:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,		// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,		// Avalon-MM Read Data
	
	// Exported Conduit (mapped to VGA port - make sure you export in Platform Designer)
	output logic [3:0]  red, green, blue,	// VGA color channels (mapped to output pins in top-level)
	output logic hs, vs						// VGA HS/VS
);
//logic [31:0] register_output, palette_output, drawing_output;
////	ram x0(.address_a(AVL_ADDR), .address_b(char_addr), .byteena_a(AVL_BYTE_EN), .byteena_b(4'hF), .clock(CLK), .data_a(AVL_WRITEDATA), .data_b(0),
////		.rden_a(AVL_CS&&AVL_READ&&~AVL_ADDR[11]), .rden_b(1'b1), .wren_a(AVL_CS&&AVL_WRITE&&~AVL_ADDR[11]), .wren_b(1'b0), .q_a(register_output), .q_b(drawing_output));
//
//	ram2 x0(.address_a(AVL_ADDR), .address_b(char_addr), .byteena_a(AVL_BYTE_EN), .byteena_b(4'hF), .clock(CLK), .data_a(AVL_WRITEDATA), .data_b(0),
//		.rden_a(AVL_CS&&AVL_READ&&~AVL_ADDR[11]), .rden_b(1'b1), .wren_a(AVL_CS&&AVL_WRITE&&~AVL_ADDR[11]), .wren_b(1'b0), .q_a(register_output), .q_b(drawing_output));
////above is 7.2 logic
//
//logic [31:0] palette [8]; // palette registers

//char_addr = (DrawX/8 + DrawY/16 * 80)
//vramm = charaddr / 4
//16*[7:0] + DrawY % 16 = addr
//always_comb
//begin
//if((AVL_ADDR[11]&&AVL_READ&&AVL_CS) == 1'b1)
//begin
//AVL_READDATA <= palette[AVL_ADDR[2:0]];
//end
//else
//begin
//AVL_READDATA <= register_output;
//end
//end
//
//always_ff@ (posedge CLK)
//begin
//if((AVL_ADDR[11]&&AVL_WRITE&&AVL_CS) == 1'b1)
//begin
//palette[AVL_ADDR[2:0]] = AVL_WRITEDATA;
//end
//end

logic [9:0] X, Y;
logic [6:0] address;
logic [7:0] font_data;
logic pixel_clk, blank;

vga_controller vga_0 (.Clk(CLK), .Reset(RESET), .hs(hs), .vs(vs), .blank(blank), .pixel_clk(pixel_clk), .DrawX(X), .DrawY(Y));
//font_rom rom(.addr(addressinput), .data(font_data));
dogactualfinal_example example(.DrawX(X), .DrawY(Y),.vga_clk(CLK), .blank(blank),.red(red), .green(green), .blue(blue));
// Read and write from AVL interface to register block, note that READ waitstate = 1, so this should be in always_ff
//always_ff @(posedge CLK) 
//begin
//if ((AVL_WRITE==1'b1)&&(AVL_CS==1'b1))
//begin
//
//	if(AVL_BYTE_EN[0] == 1'b1)
//	begin
//		register_output[7:0] <= AVL_WRITEDATA[7:0];
//	end
//	
//	if(AVL_BYTE_EN[1] == 1'b1)
//	begin
//		register_output[15:8] <= AVL_WRITEDATA[15:8];
//	end
//	
//	if(AVL_BYTE_EN[2] == 1'b1)
//	begin
//		register_output[23:16] <= AVL_WRITEDATA[23:16];
//	end
//	
//	if(AVL_BYTE_EN[3] == 1'b1)
//	begin
//		register_output[31:24] <= AVL_WRITEDATA[31:24];
//	end
//
//end
//
//if((AVL_READ==1'b1)&&(AVL_CS==1'b1))
//begin
//	AVL_READDATA <= register_output[31:0];
//end
//
//end
//logic [10:0]char_addr;
//logic [2:0] palette_idx_fgd, palette_idx_bgd;
//logic [3:0] palette_red_fgd, palette_green_fgd, palette_blue_fgd, palette_red_bgd, palette_green_bgd, palette_blue_bgd;
////logic [9:0] vram;
//logic inverse_bit;
//logic [10:0] addressinput;
//assign addressinput = address*16 + Y[3:0];
//assign char_addr = (X[9:4] + Y[9:4]*40);
////divide by 2 to get register for sprite(7.2)
////handle drawing (may either be combinational or sequential - or both).
//always_comb
//begin
//inverse_bit = 0;
//address = 0;
//palette_idx_fgd = 0;
//palette_idx_bgd = 0;
//palette_red_fgd = 0;
//palette_blue_fgd = 0;
//palette_green_fgd = 0;
//palette_red_bgd = 0;
//palette_green_bgd = 0;
//palette_blue_bgd = 0;
//
////row major order to get pixel count, divide by four to get register index
//if((X[3]) == 1'b0) //dividing by 16 (7.2) to get 16 bit sprite block and then modding (by 2 for 7.2) to get exact block
//begin
//address = (drawing_output[14:8]); //16*register value + DrawY mod 16 to find row of data in font_rom
//inverse_bit = drawing_output[15];
//palette_idx_fgd = drawing_output[7:5]; //fgd [7:4] /2
//palette_idx_bgd = drawing_output[3:1]; //bgd	[3:0] /2
//if(drawing_output[4] == 1)
//begin
//palette_red_fgd = palette[palette_idx_fgd][24:21];
//palette_green_fgd = palette[palette_idx_fgd][20:17];
//palette_blue_fgd = palette[palette_idx_fgd][16:13];
//end
//else
//begin
//palette_red_fgd = palette[palette_idx_fgd][12:9];
//palette_green_fgd = palette[palette_idx_fgd][8:5];
//palette_blue_fgd = palette[palette_idx_fgd][4:1];
//end
//if(drawing_output[0] == 1)
//begin
//palette_red_bgd = palette[palette_idx_bgd][24:21];
//palette_green_bgd = palette[palette_idx_bgd][20:17];
//palette_blue_bgd = palette[palette_idx_bgd][16:13];
//end
//else
//begin
//palette_red_bgd = palette[palette_idx_bgd][12:9];
//palette_green_bgd = palette[palette_idx_bgd][8:5];
//palette_blue_bgd = palette[palette_idx_bgd][4:1];
//end
// 
////	if(drawing_output[7] == 1'b1)
////	begin
////	real_font_data = ~font_data;
////	end
////	else
////	begin
////	real_font_data = font_data;
////	end
//end
//
//else if((X[3]) == 1'b1) //dividing by 16 to get 16 bit sprite block and then modding to get exact block
//begin
//address = (drawing_output[30:24]); //16*register value + DrawY mod 16 to find row of data in font_rom
//inverse_bit = drawing_output[31];
//palette_idx_fgd = drawing_output[23:21]; //fgd
//palette_idx_bgd = drawing_output[19:17]; //bgd
//if(drawing_output[20] == 1)
//begin
//palette_red_fgd = palette[palette_idx_fgd][24:21];
//palette_green_fgd = palette[palette_idx_fgd][20:17];
//palette_blue_fgd = palette[palette_idx_fgd][16:13];
//end
//else
//begin
//palette_red_fgd = palette[palette_idx_fgd][12:9];
//palette_green_fgd = palette[palette_idx_fgd][8:5];
//palette_blue_fgd = palette[palette_idx_fgd][4:1];
//end
//if(drawing_output[16] == 1)
//begin
//palette_red_bgd = palette[palette_idx_bgd][24:21];
//palette_green_bgd = palette[palette_idx_bgd][20:17];
//palette_blue_bgd = palette[palette_idx_bgd][16:13];
//end
//else
//begin
//palette_red_bgd = palette[palette_idx_bgd][12:9];
//palette_green_bgd = palette[palette_idx_bgd][8:5];
//palette_blue_bgd = palette[palette_idx_bgd][4:1];
//end
////	if(drawing_output[15] == 1'b1)
////	begin
////	real_font_data = ~font_data;
////	end
////	else
////	begin
////	real_font_data = font_data;
////	end
//end
//
////else if((X[4:3]) == 2'b10) //dividing by 8 to get 8 bit sprite block and then modding to get exact block
////begin
////address = (drawing_output[22:16]); //16*register value + DrawY mod 16 to find row of data in font_rom
////inverse_bit = drawing_output[23];
//////	if(drawing_output[23] == 1'b1)
//////	begin
//////	real_font_data = ~font_data;
//////	end
//////	else
//////	begin
//////	real_font_data = font_data;
//////	end
////end
////
////else if((X[4:3]) == 2'b11) //dividing by 8 to get 8 bit sprite block and then modding to get exact block
////begin
////address = (drawing_output[30:24]); //16*register value + DrawY mod 16 to find row of data in font_rom
////inverse_bit = drawing_output[31];
//////	if(drawing_output[31] == 1'b1)
//////	begin
//////	real_font_data = ~font_data;
//////	end
//////	else
//////	begin
//////	real_font_data = font_data;
//////	end
////end
//
//end
//
//always_ff@(posedge pixel_clk)
//begin
//
//if(~blank)
//begin
//red <= 4'h0;
//green <= 4'h0;
//blue <= 4'h0; 
//end
//else if ( (inverse_bit)^(font_data[7-X[2:0]]) == 1'b1)
//begin
//red <= palette_red_fgd;
//green <= palette_green_fgd;
//blue <= palette_blue_fgd; 
//end
//else 
//begin
//red <= palette_red_bgd;
//green <= palette_green_bgd;
//blue <= palette_blue_bgd; 
//end
//
//
//end


endmodule
