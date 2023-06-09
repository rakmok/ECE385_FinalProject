module fullproject (
	input logic [9:0] DrawX, DrawY, input logic [7:0] keycode,
	input logic vga_clk, blank, frame_clk, KEY, Reset, turret_clk,
	output logic [3:0] red, green, blue, output logic flag_t_l_90_exist_m, flag_t_l_60_exist_m,flag_t_l_45_exist_m,flag_t_l_30_exist_m,flag_t_l_0_exist_m,
flag_t_l_330_exist_m,flag_t_l_315_exist_m,flag_t_l_300_exist_m,flag_t_l_270_exist_m
);

logic negedge_vga_clk;
assign negedge_vga_clk = ~vga_clk;
logic shoot_left;
logic shoot_right;
always_comb
begin
//shoot_left = 1'b1;
//if(flag_b_l_gameend)
//begin
if(keycode == 8'h2C)
begin
shoot_left = 1'b1;
end
else
begin
shoot_left = 1'b0;
end
//else
//begin
//shoot_left = 1'b1;
//end
//end
end

always_comb
begin
if(keycode == 8'h2A)
begin
shoot_right = 1'b1;
end
else
begin
shoot_right = 1'b0;
end
end
//assign shoot_left = ~(keycode & 8'h28);

logic flag_b_reset; //reset flag for bullet (starting)
logic flag_b_reset_r;
initial flag_b_reset_r = 1;
initial flag_b_reset = 1;
//initial b_l_motion_x = 10'h001;
//initial b180_motion_x = 10'h001;
//initial b_l_motion_y = 10'h001;
//initial b180_motion_y = 10'h001;

//spacebar = 2c
//enter = 28
//up = 52
//down = 51
//w = 1a
//s = 16
//tab = 2b
//backspace = 2a

logic flag_t_l_90_exist, flag_t_l_60_exist,flag_t_l_45_exist,flag_t_l_30_exist,flag_t_l_0_exist,
flag_t_l_330_exist,flag_t_l_315_exist,flag_t_l_300_exist,flag_t_l_270_exist;

logic flag_t_r_90_exist, flag_t_r_120_exist,flag_t_r_135_exist,flag_t_r_150_exist,flag_t_r_180_exist,
flag_t_r_210_exist,flag_t_r_225_exist,flag_t_r_240_exist,flag_t_r_270_exist;

assign flag_t_l_90_exist_m = flag_t_l_90_exist;
assign flag_t_l_60_exist_m = flag_t_l_60_exist;
assign flag_t_l_45_exist_m = flag_t_l_45_exist;
assign flag_t_l_30_exist_m = flag_t_l_30_exist;
assign flag_t_l_0_exist_m = flag_t_l_0_exist;
assign flag_t_l_330_exist_m = flag_t_l_330_exist;
assign flag_t_l_315_exist_m = flag_t_l_315_exist;
assign flag_t_l_300_exist_m = flag_t_l_300_exist;
assign flag_t_l_270_exist_m = flag_t_l_270_exist;
							  
always_ff@ (posedge shoot_left||flag_b_l_gameendp1||flag_b_r_gameendp2||flag_b_l_gameendp2||flag_b_r_gameendp1||bullet_collision)
begin
//if(flag_b_l_gameend == 1 || flag_b_r_gameend ==1)
//begin
//flag_b_reset<=flag_b_reset;
//end
//else
//begin
	flag_b_reset <= ~flag_b_reset;
//end
end

always_ff@ (posedge shoot_right||flag_b_l_gameendp1||flag_b_r_gameendp2||flag_b_l_gameendp2||flag_b_r_gameendp1||bullet_collision)
begin
//if(flag_b_l_gameend == 1 || flag_b_r_gameend == 1)
//begin
//flag_b_reset_r<=flag_b_reset_r;
//end
//else
//begin
	flag_b_reset_r <= ~flag_b_reset_r;
//end
end


logic [9:0] b_override_motion_x, b_override_motion_y, initial_b_l_pos_x, initial_b_l_pos_y;

logic [9:0] b_override_motion_x_r, b_override_motion_y_r, initial_b_r_pos_x, initial_b_r_pos_y;

ISDU ISDU ( .Reset(flag_b_reset), .*);
ISDU2 ISDU2 ( .Reset(flag_b_reset_r), .*);

logic [12:0] rom_address_dog, rom_address_peng; //character sprite rom addresses

logic [12:0] rom_address_t_l_0, rom_address_t_l_30, rom_address_t_l_45, rom_address_t_l_60, rom_address_t_l_90, rom_address_t_l_270, rom_address_t_l_300, rom_address_t_l_315, 
rom_address_t_l_330; //turret left sprites

logic [12:0] rom_address_t_r_90, rom_address_t_r_120, rom_address_t_r_135, rom_address_t_r_150, rom_address_t_r_180, rom_address_t_r_210, rom_address_t_r_225, rom_address_t_r_240, 
rom_address_t_r_270; //turret right sprites

logic [12:0] rom_address_b_l_0, rom_address_b_l_15, rom_address_b_l_30, rom_address_b_l_45, rom_address_b_l_60, rom_address_b_l_75, rom_address_b_l_90, rom_address_b_l_105, rom_address_b_l_120,
rom_address_b_l_135, rom_address_b_l_150, rom_address_b_l_165, rom_address_b_l_180, rom_address_b_l_195, rom_address_b_l_210, rom_address_b_l_225, rom_address_b_l_240, rom_address_b_l_255
, rom_address_b_l_270, rom_address_b_l_285, rom_address_b_l_300, rom_address_b_l_315, rom_address_b_l_330, rom_address_b_l_345; //bullet left rom addresses

logic [12:0] rom_address_b_r_0, rom_address_b_r_15, rom_address_b_r_30, rom_address_b_r_45, rom_address_b_r_60, rom_address_b_r_75, rom_address_b_r_90, rom_address_b_r_105, rom_address_b_r_120,
rom_address_b_r_135, rom_address_b_r_150, rom_address_b_r_165, rom_address_b_r_180, rom_address_b_r_195, rom_address_b_r_210, rom_address_b_r_225, rom_address_b_r_240, rom_address_b_r_255
, rom_address_b_r_270, rom_address_b_r_285, rom_address_b_r_300, rom_address_b_r_315, rom_address_b_r_330, rom_address_b_r_345; //bullet right rom addresses

logic [10:0] rom_address_def_315, rom_address_def_315_2, rom_address_def_315_3, rom_address_def_315_4, rom_address_def_315_5, rom_address_def_315_6, rom_address_def_45_1, rom_address_def_45_2;

logic [15:0] rom_address_gameoverp1, rom_address_gameoverp2;

logic [18:0] rom_address_s; //background sprites

logic [0:0] rom_q_gameoverp1, rom_q_gameoverp2;
logic [2:0] rom_q_d, rom_q_p, rom_q_t_l,  rom_q_s, rom_q_def_315, rom_q_def_315_2, rom_q_def_315_3, rom_q_def_315_4, rom_q_def_315_5, rom_q_def_315_6, rom_q_def_45_1, rom_q_def_45_2; //output addresses, rom

logic [2:0] rom_q_t_l_0, rom_q_t_l_30, rom_q_t_l_45, rom_q_t_l_60, rom_q_t_l_90, rom_q_t_l_330 , rom_q_t_l_315, rom_q_t_l_300, rom_q_t_l_270;

logic [2:0] rom_q_t_r_90, rom_q_t_r_120, rom_q_t_r_135, rom_q_t_r_150, rom_q_t_r_180, rom_q_t_r_210 , rom_q_t_r_225, rom_q_t_r_240, rom_q_t_r_270;

logic [2:0] rom_q_b_l_0, rom_q_b_l_15, rom_q_b_l_30, rom_q_b_l_45, rom_q_b_l_60, rom_q_b_l_75, rom_q_b_l_90, rom_q_b_l_105, rom_q_b_l_120, rom_q_b_l_135,
rom_q_b_l_150, rom_q_b_l_165, rom_q_b_l_180, rom_q_b_l_195, rom_q_b_l_210, rom_q_b_l_225, rom_q_b_l_240, rom_q_b_l_255, rom_q_b_l_270, rom_q_b_l_285,
rom_q_b_l_300, rom_q_b_l_315, rom_q_b_l_330, rom_q_b_l_345; //output addresses for left bullet


logic [2:0] rom_q_b_r_0, rom_q_b_r_15, rom_q_b_r_30, rom_q_b_r_45, rom_q_b_r_60, rom_q_b_r_75, rom_q_b_r_90, rom_q_b_r_105, rom_q_b_r_120, rom_q_b_r_135,
rom_q_b_r_150, rom_q_b_r_165, rom_q_b_r_180, rom_q_b_r_195, rom_q_b_r_210, rom_q_b_r_225, rom_q_b_r_240, rom_q_b_r_255, rom_q_b_r_270, rom_q_b_r_285,
rom_q_b_r_300, rom_q_b_r_315, rom_q_b_r_330, rom_q_b_r_345; //output addresses for right bullet

logic [9:0] b_l_motion_x, b_l_pos_x, b_l_pos_y, b_l_motion_y;//bullet left motions and positions
logic [9:0] b_r_motion_x, b_r_motion_y, b_r_pos_x, b_r_pos_y;//bullet right motions and positions
//
//initial b_l_pos_x = 90; //initials for start of game bullet position
//initial b_l_pos_y = 38;
//
//initial b_r_pos_x = 400; //initials for start of game bullet position
//initial b_r_pos_y = 300;

assign rom_address_s = (DrawX) + (DrawY*640); //rom address for background assignment

logic [3:0] palette_red_dog, palette_green_dog, palette_blue_dog; //palettes
logic [3:0] palette_red_peng, palette_green_peng, palette_blue_peng;
logic [9:0] temp_x, temp_y, temp2_x, temp2_y;

//palettes for left turret
logic [3:0] palette_red_t_l_0, palette_green_t_l_0, palette_blue_t_l_0;
logic [3:0] palette_red_t_l_30, palette_green_t_l_30, palette_blue_t_l_30;
logic [3:0] palette_red_t_l_45, palette_green_t_l_45, palette_blue_t_l_45;
logic [3:0] palette_red_t_l_60, palette_green_t_l_60, palette_blue_t_l_60;
logic [3:0] palette_red_t_l_90, palette_green_t_l_90, palette_blue_t_l_90;
logic [3:0] palette_red_t_l_330, palette_green_t_l_330, palette_blue_t_l_330;
logic [3:0] palette_red_t_l_315, palette_green_t_l_315, palette_blue_t_l_315;
logic [3:0] palette_red_t_l_300, palette_green_t_l_300, palette_blue_t_l_300;
logic [3:0] palette_red_t_l_270, palette_green_t_l_270, palette_blue_t_l_270;

logic [3:0] palette_red_s, palette_green_s, palette_blue_s;
logic [3:0] palette_red_def_315, palette_green_def_315, palette_blue_def_315;
logic [3:0] palette_red_def_315_2, palette_green_def_315_2, palette_blue_def_315_2;
logic [3:0] palette_red_def_315_3, palette_green_def_315_3, palette_blue_def_315_3;
logic [3:0] palette_red_def_315_4, palette_green_def_315_4, palette_blue_def_315_4;
logic [3:0] palette_red_def_315_5, palette_green_def_315_5, palette_blue_def_315_5;
logic [3:0] palette_red_def_315_6, palette_green_def_315_6, palette_blue_def_315_6;
logic [3:0] palette_red_def_45_1, palette_green_def_45_1, palette_blue_def_45_1;
logic [3:0] palette_red_def_45_2, palette_green_def_45_2, palette_blue_def_45_2;
logic [3:0] palette_red_gameoverp1, palette_green_gameoverp1, palette_blue_gameoverp1;
logic [3:0] palette_red_gameoverp2, palette_green_gameoverp2, palette_blue_gameoverp2;
//palettes for right turret

logic [3:0] palette_red_t_r_90, palette_green_t_r_90, palette_blue_t_r_90;
logic [3:0] palette_red_t_r_120, palette_green_t_r_120, palette_blue_t_r_120;
logic [3:0] palette_red_t_r_135, palette_green_t_r_135, palette_blue_t_r_135;
logic [3:0] palette_red_t_r_150, palette_green_t_r_150, palette_blue_t_r_150;
logic [3:0] palette_red_t_r_180, palette_green_t_r_180, palette_blue_t_r_180;
logic [3:0] palette_red_t_r_210, palette_green_t_r_210, palette_blue_t_r_210;
logic [3:0] palette_red_t_r_225, palette_green_t_r_225, palette_blue_t_r_225;
logic [3:0] palette_red_t_r_240, palette_green_t_r_240, palette_blue_t_r_240;
logic [3:0] palette_red_t_r_270, palette_green_t_r_270, palette_blue_t_r_270;

//palettes for projectiles
logic [3:0] palette_red_b_l_0, palette_green_b_l_0, palette_blue_b_l_0; //0
logic [3:0] palette_red_b_l_15, palette_green_b_l_15, palette_blue_b_l_15;
logic [3:0] palette_red_b_l_30, palette_green_b_l_30, palette_blue_b_l_30;
logic [3:0] palette_red_b_l_45, palette_green_b_l_45, palette_blue_b_l_45; 
logic [3:0] palette_red_b_l_60, palette_green_b_l_60, palette_blue_b_l_60;
logic [3:0] palette_red_b_l_75, palette_green_b_l_75, palette_blue_b_l_75;
logic [3:0] palette_red_b_l_90, palette_green_b_l_90, palette_blue_b_l_90; //90 
logic [3:0] palette_red_b_l_105, palette_green_b_l_105, palette_blue_b_l_105;
logic [3:0] palette_red_b_l_120, palette_green_b_l_120, palette_blue_b_l_120;
logic [3:0] palette_red_b_l_135, palette_green_b_l_135, palette_blue_b_l_135; 
logic [3:0] palette_red_b_l_150, palette_green_b_l_150, palette_blue_b_l_150;
logic [3:0] palette_red_b_l_165, palette_green_b_l_165, palette_blue_b_l_165;
logic [3:0] palette_red_b_l_180, palette_green_b_l_180, palette_blue_b_l_180; //180 
logic [3:0] palette_red_b_l_195, palette_green_b_l_195, palette_blue_b_l_195;
logic [3:0] palette_red_b_l_210, palette_green_b_l_210, palette_blue_b_l_210;
logic [3:0] palette_red_b_l_225, palette_green_b_l_225, palette_blue_b_l_225; 
logic [3:0] palette_red_b_l_240, palette_green_b_l_240, palette_blue_b_l_240;
logic [3:0] palette_red_b_l_255, palette_green_b_l_255, palette_blue_b_l_255; 
logic [3:0] palette_red_b_l_270, palette_green_b_l_270, palette_blue_b_l_270; //270
logic [3:0] palette_red_b_l_285, palette_green_b_l_285, palette_blue_b_l_285;
logic [3:0] palette_red_b_l_300, palette_green_b_l_300, palette_blue_b_l_300; 
logic [3:0] palette_red_b_l_315, palette_green_b_l_315, palette_blue_b_l_315;
logic [3:0] palette_red_b_l_330, palette_green_b_l_330, palette_blue_b_l_330;
logic [3:0] palette_red_b_l_345, palette_green_b_l_345, palette_blue_b_l_345;

//palettes for right side projectiles
logic [3:0] palette_red_b_r_0, palette_green_b_r_0, palette_blue_b_r_0; //0
logic [3:0] palette_red_b_r_15, palette_green_b_r_15, palette_blue_b_r_15;
logic [3:0] palette_red_b_r_30, palette_green_b_r_30, palette_blue_b_r_30;
logic [3:0] palette_red_b_r_45, palette_green_b_r_45, palette_blue_b_r_45; 
logic [3:0] palette_red_b_r_60, palette_green_b_r_60, palette_blue_b_r_60;
logic [3:0] palette_red_b_r_75, palette_green_b_r_75, palette_blue_b_r_75;
logic [3:0] palette_red_b_r_90, palette_green_b_r_90, palette_blue_b_r_90; //90 
logic [3:0] palette_red_b_r_105, palette_green_b_r_105, palette_blue_b_r_105;
logic [3:0] palette_red_b_r_120, palette_green_b_r_120, palette_blue_b_r_120;
logic [3:0] palette_red_b_r_135, palette_green_b_r_135, palette_blue_b_r_135; 
logic [3:0] palette_red_b_r_150, palette_green_b_r_150, palette_blue_b_r_150;
logic [3:0] palette_red_b_r_165, palette_green_b_r_165, palette_blue_b_r_165;
logic [3:0] palette_red_b_r_180, palette_green_b_r_180, palette_blue_b_r_180; //180 
logic [3:0] palette_red_b_r_195, palette_green_b_r_195, palette_blue_b_r_195;
logic [3:0] palette_red_b_r_210, palette_green_b_r_210, palette_blue_b_r_210;
logic [3:0] palette_red_b_r_225, palette_green_b_r_225, palette_blue_b_r_225; 
logic [3:0] palette_red_b_r_240, palette_green_b_r_240, palette_blue_b_r_240;
logic [3:0] palette_red_b_r_255, palette_green_b_r_255, palette_blue_b_r_255; 
logic [3:0] palette_red_b_r_270, palette_green_b_r_270, palette_blue_b_r_270; //270
logic [3:0] palette_red_b_r_285, palette_green_b_r_285, palette_blue_b_r_285;
logic [3:0] palette_red_b_r_300, palette_green_b_r_300, palette_blue_b_r_300; 
logic [3:0] palette_red_b_r_315, palette_green_b_r_315, palette_blue_b_r_315;
logic [3:0] palette_red_b_r_330, palette_green_b_r_330, palette_blue_b_r_330;
logic [3:0] palette_red_b_r_345, palette_green_b_r_345, palette_blue_b_r_345;  

logic [9:0] actlX, actlY, turretX_left, turretY_left, b_x_left, b_y_left, turret_x_right, turret_y_right;
logic [9:0] def_315_x, def_315_y, def_315_x_2, def_315_y_2, def_315_x_3, def_315_y_3, def_315_x_4, def_315_y_4;

logic [0:0]flag_t_l_0, flag_t_l_30, flag_t_l_45, flag_t_l_60, flag_t_l_90, flag_t_l_330, flag_t_l_315, flag_t_l_300, flag_t_l_270; //drawing flags for left turret

logic [0:0]flag_t_r_90, flag_t_r_120, flag_t_r_135, flag_t_r_150, flag_t_r_180, flag_t_r_210, flag_t_r_225, flag_t_r_240, flag_t_r_270; //drawing flags for right turret

logic [0:0]flag_p, flag_d, flag_def_315, flag_def_315_2, flag_def_315_3, flag_def_315_4, flag_def_315_5, flag_def_315_6, flag_def_45_1, flag_def_45_2, flag_gameoverp1, flag_gameoverp2; //drawing flags

logic [0:0]flag_b_l_90, flag_b_l_60,flag_b_l_45,flag_b_l_30,flag_b_l_0,
flag_b_l_330,flag_b_l_315,flag_b_l_300,flag_b_l_270, flag_b_l_240, flag_b_l_225, flag_b_l_210, flag_b_l_180, flag_b_l_150,
flag_b_l_135, flag_b_l_120; //drawing flags for left bullet

logic [0:0]flag_b_r_90, flag_b_r_60,flag_b_r_45,flag_b_r_30,flag_b_r_0,
flag_b_r_330,flag_b_r_315,flag_b_r_300,flag_b_r_270, flag_b_r_240, flag_b_r_225, flag_b_r_210, flag_b_r_180, flag_b_r_150,
flag_b_r_135, flag_b_r_120; //drawing flags for right bullet

logic [0:0]flag_b_l_90_exist, flag_b_l_60_exist,flag_b_l_45_exist,flag_b_l_30_exist,flag_b_l_0_exist,
flag_b_l_330_exist,flag_b_l_315_exist,flag_b_l_300_exist,flag_b_l_270_exist, flag_b_l_240_exist, flag_b_l_225_exist, flag_b_l_210_exist, flag_b_l_180_exist, flag_b_l_150_exist,
flag_b_l_135_exist, flag_b_l_120_exist; //exist flags for left bullet

logic [0:0]flag_b_r_90_exist, flag_b_r_60_exist,flag_b_r_45_exist,flag_b_r_30_exist,flag_b_r_0_exist,
flag_b_r_330_exist,flag_b_r_315_exist,flag_b_r_300_exist,flag_b_r_270_exist, flag_b_r_240_exist, flag_b_r_225_exist, flag_b_r_210_exist, flag_b_r_180_exist, flag_b_r_150_exist,
flag_b_r_135_exist, flag_b_r_120_exist; //exist flags for right bullet

assign def_315_x = DrawX-300;
assign def_315_y = DrawY-200;

assign def_315_x_2 = DrawX-300;
assign def_315_y_2 = DrawY-250;

assign def_315_x_3 = DrawX-80;
assign def_315_y_3 = DrawY-360;

assign def_315_x_4 = DrawX-550;
assign def_315_y_4 = DrawY-290;


logic [9:0] def_5_pos_x, def_5_pos_y, def_motion_x, def_motion_y, def_45_1_motion_x, def_45_1_motion_y;
logic [9:0] def_6_pos_x, def_6_pos_y, def_motion_x_6, def_motion_y_6;
logic [9:0] def_45_1_pos_x,def_45_1_pos_y,def_45_2_pos_x,def_45_2_pos_y;
initial def_motion_y = 10'h002;
initial def_motion_x = 10'h000;
initial def_5_pos_x = 180;
initial def_5_pos_y = 50;
initial def_motion_y_6 = 10'h3FE;
initial def_motion_x_6 = 10'h000;
initial def_6_pos_x = 480;
initial def_6_pos_y = 340;

initial def_45_1_motion_x = 10'h002;
initial def_45_1_motion_y = 10'h000;
initial def_45_1_pos_x = 300;
initial def_45_1_pos_y = 100;
assign def_45_2_pos_x = DrawX-300;
assign def_45_2_pos_y = DrawY-360;

//always_ff @(posedge vga_clk) //detecting color for deflector
//begin
//if(b_l_pos_x+25>590 && b_l_pos_y+10>50 &&b_l_pos_y+25<90 && b_l_pos_x+10<630) //check if point at end of missile is hitting the deflector
//begin
//def_detection_x <= b_l_pos_x-565;
//def_detection_y <= b_l_pos_y-40;
//end
//else
//begin
//def_detection_x <= 1;
//def_detection_y <= 0;
//end
//end

logic [9:0] b_x_right, b_y_right; 

assign turretX_left = DrawX - 40;
assign turretY_left = DrawY - 40;
assign actlX = DrawX - 590;
assign actlY = DrawY - 380;

assign b_x_left = DrawX - b_l_pos_x;
assign b_y_left = DrawY - b_l_pos_y;
logic [9:0] gameoverp1_x, gameoverp1_y, gameoverp2_x, gameoverp2_y;

assign gameoverp1_x = DrawX - 200;
assign gameoverp1_y = DrawY - 170;


assign gameoverp2_x = DrawX - 200;
assign gameoverp2_y = DrawY - 170;

assign b_x_right = DrawX - b_r_pos_x;
assign b_y_right = DrawY - b_r_pos_y;
// 
assign turret_x_right = DrawX - 550;
assign turret_y_right = DrawY - 420; //calculations of positions updating

//always_comb
//begin
//rom_address_detect = def_detection_x + def_detection_y*40;
//end

always_comb //dog drawing
begin
if(actlX<50 && actlY<100)
begin
rom_address_dog = actlX+actlY*50;
if(palette_red_dog !=4'hF && palette_green_dog !=4'h0 && palette_blue_dog != 4'hF)
begin
flag_d = 1;
end
else
begin
flag_d = 0;
end
end
else
begin
rom_address_dog = 0;
flag_d = 0;
end
end

always_comb //penguin drawing
begin
if(DrawX<50 && DrawY<100)
begin
rom_address_peng= DrawX+DrawY*50;
if(palette_red_peng != 4'hF && palette_green_peng !=4'h0 && palette_blue_peng != 4'hF)
begin
flag_p = 1;
end
else
begin
flag_p = 0;
end
end
else
begin
rom_address_peng = 0;
flag_p = 0;
end
end

always_comb //turret left 0 drawing
begin
if((turretX_left<45 && turretY_left<45&&flag_t_l_0_exist==1))
begin
rom_address_t_l_0 = turretX_left+turretY_left*45;
flag_t_l_0 = 1;
end
else
begin
rom_address_t_l_0 = 0;
flag_t_l_0 = 0;
end
end
//
always_comb //turret left 30 drawing
begin
if((turretX_left<45 && turretY_left<45&&flag_t_l_30_exist==1))
begin
rom_address_t_l_30 = turretX_left+turretY_left*45;
flag_t_l_30 = 1;
end
else
begin
rom_address_t_l_30 = 0;
flag_t_l_30 = 0;
end
end

always_comb //turret left 45 drawing
begin
if((turretX_left<45 && turretY_left<45&&flag_t_l_45_exist==1))
begin
rom_address_t_l_45 = turretX_left+turretY_left*45;
flag_t_l_45 = 1;
end
else
begin
rom_address_t_l_45 = 0;
flag_t_l_45 = 0;
end
end
//
always_comb //turret left 60 drawing
begin
if((turretX_left<45 && turretY_left<45&&flag_t_l_60_exist==1))
begin
rom_address_t_l_60 = turretX_left+turretY_left*45;
flag_t_l_60 = 1;
end
else
begin
rom_address_t_l_60 = 0;
flag_t_l_60 = 0;
end
end
//
always_comb //turret left 90 drawing
begin
if((turretX_left<45 && turretY_left<45&&flag_t_l_90_exist==1))
begin
rom_address_t_l_90 = turretX_left+turretY_left*45;
flag_t_l_90 = 1;
end
else
begin
rom_address_t_l_90 = 0;
flag_t_l_90 = 0;
end
end
//
always_comb //turret left 270 drawing
begin
if((turretX_left<45 && turretY_left<45&&flag_t_l_270_exist==1))
begin
rom_address_t_l_270 = turretX_left+turretY_left*45;
flag_t_l_270 = 1;
end
else
begin
rom_address_t_l_270 = 0;
flag_t_l_270 = 0;
end
end
//
always_comb //turret left 300 drawing
begin
if((turretX_left<45 && turretY_left<45&&flag_t_l_300_exist==1))
begin
rom_address_t_l_300 = turretX_left+turretY_left*45;
flag_t_l_300 = 1;
end
else
begin
rom_address_t_l_300 = 0;
flag_t_l_300 = 0;
end
end
//
always_comb //turret left 315 drawing
begin
if((turretX_left<45 && turretY_left<45&&flag_t_l_315_exist==1))
begin
rom_address_t_l_315 = turretX_left+turretY_left*45;
flag_t_l_315 = 1;
end
else
begin
rom_address_t_l_315 = 0;
flag_t_l_315 = 0;
end
end
//

always_comb
begin
if((turretX_left<45 && turretY_left<45&&flag_t_l_330_exist==1)) //turret left 330
begin
rom_address_t_l_330 = turretX_left+turretY_left*45;
flag_t_l_330 = 1;
end
else
begin
rom_address_t_l_330 = 0;
flag_t_l_330 = 0;
end
end

//TURRET RIGHT DRAWING STARTS
//
//
//
//
always_comb //turret right 90 drawing
begin
if((turret_x_right<45 && turret_y_right<45&&flag_t_r_90_exist==1))
begin
rom_address_t_r_90 = turret_x_right+turret_y_right*45;
flag_t_r_90 = 1;
end
else
begin
rom_address_t_r_90 = 0;
flag_t_r_90 = 0;
end
end
//
always_comb //turret right 120 drawing
begin
if((turret_x_right<45 && turret_y_right<45&&flag_t_r_120_exist==1))
begin
rom_address_t_r_120 = turret_x_right+turret_y_right*45;
flag_t_r_120 = 1;
end
else
begin
rom_address_t_r_120 = 0;
flag_t_r_120 = 0;
end
end

always_comb //turret right 135 drawing
begin
if((turret_x_right<45 && turret_y_right<45&&flag_t_r_135_exist==1))
begin
rom_address_t_r_135 = turret_x_right+turret_y_right*45;
flag_t_r_135 = 1;
end
else
begin
rom_address_t_r_135 = 0;
flag_t_r_135 = 0;
end
end
//
always_comb //turret right 150 drawing
begin
if((turret_x_right<45 && turret_y_right<45&&flag_t_r_150_exist==1))
begin
rom_address_t_r_150 = turret_x_right+turret_y_right*45;
flag_t_r_150 = 1;
end
else
begin
rom_address_t_r_150 = 0;
flag_t_r_150 = 0;
end
end
//
always_comb //turret right 180 drawing
begin
if((turret_x_right<45 && turret_y_right<45&&flag_t_r_180_exist ==1))
begin
rom_address_t_r_180 = turret_x_right+turret_y_right*45;
flag_t_r_180 = 1;
end
else
begin
rom_address_t_r_180 = 0;
flag_t_r_180 = 0;
end
end
//
always_comb //turret right 210 drawing
begin
if((turret_x_right<45 && turret_y_right<45&&flag_t_r_210_exist==1))
begin
rom_address_t_r_210 = turret_x_right+turret_y_right*45;
flag_t_r_210 = 1;
end
else
begin
rom_address_t_r_210 = 0;
flag_t_r_210 = 0;
end
end
//
always_comb //turret right 225 drawing
begin
if((turret_x_right<45 && turret_y_right<45&&flag_t_r_225_exist==1))
begin
rom_address_t_r_225 = turret_x_right+turret_y_right*45;
flag_t_r_225 = 1;
end
else
begin
rom_address_t_r_225 = 0;
flag_t_r_225 = 0;
end
end
//
always_comb //turret right 240 drawing
begin
if((turret_x_right<45 && turret_y_right<45&&flag_t_r_240_exist==1))
begin
rom_address_t_r_240 = turret_x_right+turret_y_right*45;
flag_t_r_240 = 1;
end
else
begin
rom_address_t_r_240 = 0;
flag_t_r_240 = 0;
end
end
//

always_comb //turret right 270
begin
if((turret_x_right<45 && turret_y_right<45&&flag_t_r_270_exist==1)) 
begin
rom_address_t_r_270 = turret_x_right+turret_y_right*45;
flag_t_r_270 = 1;
end
else
begin
rom_address_t_r_270 = 0;
flag_t_r_270 = 0;
end
end



//always_comb //turret right drawing
//begin
//if(turret_x_right<43 && turret_y_right<34)
//begin
//rom_address_t_r_180= turret_x_right+turret_y_right*43;
//flag_t_r_180 = 1;
//end
//else
//begin
//rom_address_t_r_180 = 0;
//flag_t_r_180 = 0;
//end
//end

always_comb //bullet left 0 drawing
begin
if(DrawX>b_l_pos_x && DrawY>b_l_pos_y && DrawX<b_l_pos_x+40 && DrawY<b_l_pos_y+40 && flag_b_l_0_exist==1)
begin
rom_address_b_l_0= b_x_left+b_y_left*40;
//if (palette_red_b_l_0 !=4'hF && palette_green_b_l_0 !=4'hF && palette_blue_b_l_0 != 4'hF)
//begin
flag_b_l_0 = 1;
//end
//else
//begin
//flag_b_l_0 = 0;
//end
end
else
begin
rom_address_b_l_0 = 0;
flag_b_l_0 = 0;
end
end


always_comb //bullet left 30 drawing
begin
if(DrawX>b_l_pos_x && DrawY>b_l_pos_y && DrawX<b_l_pos_x+40 && DrawY<b_l_pos_y+40 && flag_b_l_30_exist==1)
begin
rom_address_b_l_30= b_x_left+b_y_left*40;
//if(palette_red_b_l_30 !=4'hF && palette_green_b_l_30 !=4'hF && palette_blue_b_l_30 != 4'hF)
//begin
flag_b_l_30 = 1;
//end
//else
//begin
//flag_b_l_30 = 0;
//end
end
else
begin
rom_address_b_l_30 = 0;
flag_b_l_30 = 0;
end
end

always_comb //bullet left 45 drawing
begin
if(DrawX>b_l_pos_x && DrawY>b_l_pos_y && DrawX<b_l_pos_x+40 && DrawY<b_l_pos_y+40 && flag_b_l_45_exist==1)
begin
rom_address_b_l_45= b_x_left+b_y_left*40;
//if(palette_red_b_l_45 !=4'hF && palette_green_b_l_45 !=4'hF && palette_blue_b_l_45 != 4'hF)
//begin
flag_b_l_45 = 1;
//end
//else
//begin
//flag_b_l_45 = 0;
//end
end
else
begin
rom_address_b_l_45 = 0;
flag_b_l_45 = 0;
end
end


always_comb //bullet left 60 drawing
begin
if(DrawX>b_l_pos_x && DrawY>b_l_pos_y && DrawX<b_l_pos_x+40 && DrawY<b_l_pos_y+40 && flag_b_l_60_exist==1)
begin
rom_address_b_l_60= b_x_left+b_y_left*40;
//if(palette_red_b_l_60 !=4'hF && palette_green_b_l_60 !=4'hF && palette_blue_b_l_60 != 4'hF)
//begin
flag_b_l_60 = 1;
//end
//else
//begin
//flag_b_l_60 = 0;
//end
end
else
begin
rom_address_b_l_60 = 0;
flag_b_l_60 = 0;
end
end

always_comb //bullet left 90 drawing
begin
if(DrawX>b_l_pos_x && DrawY>b_l_pos_y && DrawX<b_l_pos_x+40 && DrawY<b_l_pos_y+40 && flag_b_l_90_exist==1)
begin
rom_address_b_l_90 = b_x_left + b_y_left*40;
//if (palette_red_b_l_90 !=4'hF && palette_green_b_l_90 !=4'hF && palette_blue_b_l_90 != 4'hF)
//begin
flag_b_l_90 = 1;
//end
//else
//begin
//flag_b_l_90 = 0;
//end
end
else
begin
rom_address_b_l_90 = 0;
flag_b_l_90 = 0;
end
end


always_comb //bullet left 120 drawing
begin
if(DrawX>b_l_pos_x && DrawY>b_l_pos_y && DrawX<b_l_pos_x+40 && DrawY<b_l_pos_y+40 && flag_b_l_120_exist==1)
begin
rom_address_b_l_120= b_x_left+b_y_left*40;
//if(palette_red_b_l_120 !=4'hF && palette_green_b_l_120 !=4'hF && palette_blue_b_l_120 != 4'hF)
//begin
flag_b_l_120 = 1;
//end
//else
//begin
//flag_b_l_120 = 0;
//end
end
else
begin
rom_address_b_l_120 = 0;
flag_b_l_120 = 0;
end
end

always_comb //bullet left 135 drawing
begin
if(DrawX>b_l_pos_x && DrawY>b_l_pos_y && DrawX<b_l_pos_x+40 && DrawY<b_l_pos_y+40 && flag_b_l_135_exist==1)
begin
rom_address_b_l_135= b_x_left+b_y_left*40;
//if(palette_red_b_l_135 !=4'hF && palette_green_b_l_135 !=4'hF && palette_blue_b_l_135 != 4'hF)
//begin
flag_b_l_135 = 1;
//end
//else
//begin
//flag_b_l_135 = 0;
//end
end
else
begin
rom_address_b_l_135 = 0;
flag_b_l_135 = 0;
end
end


always_comb //bullet left 150 drawing
begin
if(DrawX>b_l_pos_x && DrawY>b_l_pos_y && DrawX<b_l_pos_x+40 && DrawY<b_l_pos_y+40 && flag_b_l_150_exist==1)
begin
rom_address_b_l_150= b_x_left+b_y_left*40;
//if(palette_red_b_l_150 !=4'hF && palette_green_b_l_150 !=4'hF && palette_blue_b_l_150 != 4'hF)
//begin
flag_b_l_150 = 1;
//end
//else
//begin
//flag_b_l_150 = 0;
//end
end
else
begin
rom_address_b_l_150 = 0;
flag_b_l_150 = 0;
end
end

always_comb //bullet left 180 drawing
begin
if(DrawX>b_l_pos_x && DrawY>b_l_pos_y && DrawX<b_l_pos_x+40 && DrawY<b_l_pos_y+40 && flag_b_l_180_exist==1)
begin
rom_address_b_l_180= b_x_left+b_y_left*40;
//if(palette_red_b_l_180 !=4'hF && palette_green_b_l_180 !=4'hF && palette_blue_b_l_180 != 4'hF)
//begin
flag_b_l_180 = 1;
//end
//else
//begin
//flag_b_l_180 = 0;
//end
end
else
begin
rom_address_b_l_180 = 0;
flag_b_l_180 = 0;
end
end


always_comb //bullet left 210 drawing
begin
if(DrawX>b_l_pos_x && DrawY>b_l_pos_y && DrawX<b_l_pos_x+40 && DrawY<b_l_pos_y+40 && flag_b_l_210_exist==1)
begin
rom_address_b_l_210= b_x_left+b_y_left*40;
//if(palette_red_b_l_210 !=4'hF && palette_green_b_l_210 !=4'hF && palette_blue_b_l_210 != 4'hF)
//begin
flag_b_l_210 = 1;
//end
//else
//begin
//flag_b_l_210 = 0;
//end
end
else
begin
rom_address_b_l_210 = 0;
flag_b_l_210 = 0;
end
end

always_comb //bullet left 225 drawing
begin
if(DrawX>b_l_pos_x && DrawY>b_l_pos_y && DrawX<b_l_pos_x+40 && DrawY<b_l_pos_y+40 && flag_b_l_225_exist==1)
begin
rom_address_b_l_225= b_x_left+b_y_left*40;
//if(palette_red_b_l_225 !=4'hF && palette_green_b_l_225 !=4'hF && palette_blue_b_l_225 != 4'hF)
//begin
flag_b_l_225 = 1;
//end
//else
//begin
//flag_b_l_225 = 0;
//end
end
else
begin
rom_address_b_l_225 = 0;
flag_b_l_225 = 0;
end
end


always_comb //bullet left 240 drawing
begin
if(DrawX>b_l_pos_x && DrawY>b_l_pos_y && DrawX<b_l_pos_x+40 && DrawY<b_l_pos_y+40 && flag_b_l_240_exist==1)
begin
rom_address_b_l_240= b_x_left+b_y_left*40;
//if(palette_red_b_l_240 !=4'hF && palette_green_b_l_240 !=4'hF && palette_blue_b_l_240 != 4'hF)
//begin
flag_b_l_240 = 1;
//end
//else
//begin
//flag_b_l_240 = 0;
//end
end
else
begin
rom_address_b_l_240 = 0;
flag_b_l_240 = 0;
end
end

always_comb //bullet left 270 drawing
begin
if(DrawX>b_l_pos_x && DrawY>b_l_pos_y && DrawX<b_l_pos_x+40 && DrawY<b_l_pos_y+40 && flag_b_l_270_exist==1)
begin
rom_address_b_l_270= b_x_left+b_y_left*40;
//if(palette_red_b_l_270 !=4'hF && palette_green_b_l_270 !=4'hF && palette_blue_b_l_270 != 4'hF)
//begin
flag_b_l_270 = 1;
//end
//else
//begin
//flag_b_l_270 = 0;
//end
end
else
begin
rom_address_b_l_270 = 0;
flag_b_l_270 = 0;
end
end


always_comb //bullet left 300 drawing
begin
if(DrawX>b_l_pos_x && DrawY>b_l_pos_y && DrawX<b_l_pos_x+40 && DrawY<b_l_pos_y+40 && flag_b_l_300_exist==1)
begin
rom_address_b_l_300= b_x_left+b_y_left*40;
//if(palette_red_b_l_300 !=4'hF && palette_green_b_l_300 !=4'hF && palette_blue_b_l_300 != 4'hF)
//begin
flag_b_l_300 = 1;
//end
//else
//begin
//flag_b_l_300 = 0;
//end
end
else
begin
rom_address_b_l_300 = 0;
flag_b_l_300 = 0;
end
end


always_comb //bullet left 315 drawing
begin
if(DrawX>b_l_pos_x && DrawY>b_l_pos_y && DrawX<b_l_pos_x+40 && DrawY<b_l_pos_y+40 && flag_b_l_315_exist==1)
begin
rom_address_b_l_315= b_x_left+b_y_left*40;
//if(palette_red_b_l_315 !=4'hF && palette_green_b_l_315 !=4'hF && palette_blue_b_l_315 != 4'hF)
//begin
flag_b_l_315 = 1;
//end
//else
//begin
//flag_b_l_315 = 0;
//end
end
else
begin
rom_address_b_l_315 = 0;
flag_b_l_315 = 0;
end
end


always_comb //bullet left 330 drawing
begin
if(DrawX>b_l_pos_x && DrawY>b_l_pos_y && DrawX<b_l_pos_x+40 && DrawY<b_l_pos_y+40 && flag_b_l_330_exist==1)
begin
rom_address_b_l_330= b_x_left+b_y_left*40;
//if(palette_red_b_l_330 !=4'hF && palette_green_b_l_330 !=4'hF && palette_blue_b_l_330 != 4'hF)
//begin
flag_b_l_330 = 1;
//end
//else
//begin
//flag_b_l_330 = 0;
//end
end
else
begin
rom_address_b_l_330 = 0;
flag_b_l_330 = 0;
end
end
//BULLET DRAWING RIGHT START
//
//
//
//
always_comb //bullet right 0 drawing
begin
if(DrawX>b_r_pos_x && DrawY>b_r_pos_y && DrawX<b_r_pos_x+40 && DrawY<b_r_pos_y+40 && flag_b_r_0_exist==1)
begin
rom_address_b_r_0= b_x_right+b_y_right*40;
flag_b_r_0 = 1;
end
else
begin
rom_address_b_r_0 = 0;
flag_b_r_0 = 0;
end
end


always_comb //bullet right 30 drawing
begin
if(DrawX>b_r_pos_x && DrawY>b_r_pos_y && DrawX<b_r_pos_x+40 && DrawY<b_r_pos_y+40 && flag_b_r_30_exist==1)
begin
rom_address_b_r_30= b_x_right+b_y_right*40;
flag_b_r_30 = 1;
end
else
begin
rom_address_b_r_30 = 0;
flag_b_r_30 = 0;
end
end

always_comb //bullet right 45 drawing
begin
if(DrawX>b_r_pos_x && DrawY>b_r_pos_y && DrawX<b_r_pos_x+40 && DrawY<b_r_pos_y+40 && flag_b_r_45_exist==1)
begin
rom_address_b_r_45= b_x_right+b_y_right*40;
flag_b_r_45 = 1;
end
else
begin
rom_address_b_r_45 = 0;
flag_b_r_45 = 0;
end
end


always_comb //bullet right 60 drawing
begin
if(DrawX>b_r_pos_x && DrawY>b_r_pos_y && DrawX<b_r_pos_x+40 && DrawY<b_r_pos_y+40 && flag_b_r_60_exist==1)
begin
rom_address_b_r_60= b_x_right+b_y_right*40;
flag_b_r_60 = 1;
end
else
begin
rom_address_b_r_60 = 0;
flag_b_r_60 = 0;
end
end

always_comb //bullet right 90 drawing
begin
if(DrawX>b_r_pos_x && DrawY>b_r_pos_y && DrawX<b_r_pos_x+40 && DrawY<b_r_pos_y+40 && flag_b_r_90_exist==1)
begin
rom_address_b_r_90= b_x_right+b_y_right*40;
flag_b_r_90 = 1;
end
else
begin
rom_address_b_r_90 = 0;
flag_b_r_90 = 0;
end
end


always_comb //bullet right 120 drawing
begin
if(DrawX>b_r_pos_x && DrawY>b_r_pos_y && DrawX<b_r_pos_x+40 && DrawY<b_r_pos_y+40 && flag_b_r_120_exist==1)
begin
rom_address_b_r_120= b_x_right+b_y_right*40;
flag_b_r_120 = 1;
end
else
begin
rom_address_b_r_120 = 0;
flag_b_r_120 = 0;
end
end

always_comb //bullet right 135 drawing
begin
if(DrawX>b_r_pos_x && DrawY>b_r_pos_y && DrawX<b_r_pos_x+40 && DrawY<b_r_pos_y+40 && flag_b_r_135_exist==1)
begin
rom_address_b_r_135= b_x_right+b_y_right*40;
flag_b_r_135 = 1;
end
else
begin
rom_address_b_r_135 = 0;
flag_b_r_135 = 0;
end
end


always_comb //bullet right 150 drawing
begin
if(DrawX>b_r_pos_x && DrawY>b_r_pos_y && DrawX<b_r_pos_x+40 && DrawY<b_r_pos_y+40 && flag_b_r_150_exist==1)
begin
rom_address_b_r_150= b_x_right+b_y_right*40;
flag_b_r_150 = 1;
end
else
begin
rom_address_b_r_150 = 0;
flag_b_r_150 = 0;
end
end

always_comb //bullet right 180 drawing
begin
if(DrawX>b_r_pos_x && DrawY>b_r_pos_y && DrawX<b_r_pos_x+40 && DrawY<b_r_pos_y+40 && flag_b_r_180_exist ==1)
begin
rom_address_b_r_180= b_x_right+b_y_right*40;
flag_b_r_180 = 1;
end
else
begin
rom_address_b_r_180 = 0;
flag_b_r_180 = 0;
end
end


always_comb //bullet right 210 drawing
begin
if(DrawX>b_r_pos_x && DrawY>b_r_pos_y && DrawX<b_r_pos_x+40 && DrawY<b_r_pos_y+40 && flag_b_r_210_exist==1)
begin
rom_address_b_r_210= b_x_right+b_y_right*40;
flag_b_r_210 = 1;
end
else
begin
rom_address_b_r_210 = 0;
flag_b_r_210 = 0;
end
end

always_comb //bullet right 225 drawing
begin
if(DrawX>b_r_pos_x && DrawY>b_r_pos_y && DrawX<b_r_pos_x+40 && DrawY<b_r_pos_y+40 && flag_b_r_225_exist==1)
begin
rom_address_b_r_225= b_x_right+b_y_right*40;
flag_b_r_225 = 1;
end
else
begin
rom_address_b_r_225 = 0;
flag_b_r_225 = 0;
end
end


always_comb //bullet right 240 drawing
begin
if(DrawX>b_r_pos_x && DrawY>b_r_pos_y && DrawX<b_r_pos_x+40 && DrawY<b_r_pos_y+40 && flag_b_r_240_exist==1)
begin
rom_address_b_r_240= b_x_right+b_y_right*40;
flag_b_r_240 = 1;
end
else
begin
rom_address_b_r_240 = 0;
flag_b_r_240 = 0;
end
end

always_comb //bullet right 270 drawing
begin
if(DrawX>b_r_pos_x && DrawY>b_r_pos_y && DrawX<b_r_pos_x+40 && DrawY<b_r_pos_y+40 && flag_b_r_270_exist==1)
begin
rom_address_b_r_270= b_x_right+b_y_right*40;
flag_b_r_270 = 1;
end
else
begin
rom_address_b_r_270 = 0;
flag_b_r_270 = 0;
end
end


always_comb //bullet right 300 drawing
begin
if(DrawX>b_r_pos_x && DrawY>b_r_pos_y && DrawX<b_r_pos_x+40 && DrawY<b_r_pos_y+40 && flag_b_r_300_exist==1)
begin
rom_address_b_r_300= b_x_right+b_y_right*40;
flag_b_r_300 = 1;
end
else
begin
rom_address_b_r_300 = 0;
flag_b_r_300 = 0;
end
end


always_comb //bullet right 315 drawing
begin
if(DrawX>b_r_pos_x && DrawY>b_r_pos_y && DrawX<b_r_pos_x+40 && DrawY<b_r_pos_y+40 && flag_b_r_315_exist==1)
begin
rom_address_b_r_315= b_x_right+b_y_right*40;
flag_b_r_315 = 1;
end
else
begin
rom_address_b_r_315 = 0;
flag_b_r_315 = 0;
end
end


always_comb //bullet right 330 drawing
begin
if(DrawX>b_r_pos_x && DrawY>b_r_pos_y && DrawX<b_r_pos_x+40 && DrawY<b_r_pos_y+40 && flag_b_r_330_exist==1)
begin
rom_address_b_r_330= b_x_right+b_y_right*40;
flag_b_r_330 = 1;
end
else
begin
rom_address_b_r_330 = 0;
flag_b_r_330 = 0;
end
end



always_comb //deflector right drawing
begin
if(def_315_x<40 && def_315_y<40)
begin
rom_address_def_315= def_315_x+def_315_y*40;
if(palette_red_def_315 !=4'hF && palette_green_def_315 !=4'hF && palette_blue_def_315 != 4'hF)
begin
flag_def_315 = 1;
end
else
begin
flag_def_315 = 0;
end
end
else
begin
rom_address_def_315 = 0;
flag_def_315 = 0;
end
end

always_comb //deflector 2 drawing
begin
if(def_315_x_2<40 && def_315_y_2<40)
begin
rom_address_def_315_2= def_315_x_2+def_315_y_2*40;
if(palette_red_def_315_2 !=4'hF && palette_green_def_315_2 !=4'hF && palette_blue_def_315_2 != 4'hF)
begin
flag_def_315_2 = 1;
end
else
begin
flag_def_315_2 = 0;
end
end
else
begin
rom_address_def_315_2 = 0;
flag_def_315_2 = 0;
end
end

always_comb //deflector 3 drawing
begin
if(def_315_x_3<40 && def_315_y_3<40)
begin
rom_address_def_315_3= def_315_x_3+def_315_y_3*40;
if(palette_red_def_315_3 !=4'hF && palette_green_def_315_3 !=4'hF && palette_blue_def_315_3 != 4'hF)
begin
flag_def_315_3 = 1;
end
else
begin
flag_def_315_3 = 0;
end
end
else
begin
rom_address_def_315_3 = 0;
flag_def_315_3 = 0;
end
end

always_comb //deflector 4 drawing
begin
if(def_315_x_4<40 && def_315_y_4<40)
begin
rom_address_def_315_4 = def_315_x_4+def_315_y_4*40;
if(palette_red_def_315_4 !=4'hF && palette_green_def_315_4 !=4'hF && palette_blue_def_315_4 != 4'hF)
begin
flag_def_315_4 = 1;
end
else
begin
flag_def_315_4 = 0;
end
end
else
begin
rom_address_def_315_4 = 0;
flag_def_315_4 = 0;
end
end


always_comb //deflector 5 drawing
begin
if(DrawX>def_5_pos_x && DrawY>def_5_pos_y && DrawX<def_5_pos_x+40 && DrawY<def_5_pos_y+40)
begin
rom_address_def_315_5 = (DrawX-def_5_pos_x)+((DrawY-def_5_pos_y)*40);
if(palette_red_def_315_5 !=4'hF && palette_green_def_315_5 !=4'hF && palette_blue_def_315_5 != 4'hF)
begin
flag_def_315_5 = 1;
end
else
begin
flag_def_315_5 = 0;
end
end
else
begin
rom_address_def_315_5 = 0;
flag_def_315_5 = 0;
end
end

always_ff @ (negedge frame_clk)
begin
if(def_5_pos_y <=5)
begin
def_motion_y = 10'h002; 
end
else if(def_5_pos_y+40>=480)
begin
def_motion_y = 10'h3FE;
end
		def_5_pos_x <= def_5_pos_x + def_motion_x;
		def_5_pos_y <= def_5_pos_y + def_motion_y;
end

always_comb //deflector 45_1 drawing
begin
if(DrawX>def_45_1_pos_x && DrawY>def_45_1_pos_y && DrawX<def_45_1_pos_x+40 && DrawY<def_45_1_pos_y+40)
begin
rom_address_def_45_1 = (DrawX-def_45_1_pos_x)+((DrawY-def_45_1_pos_y)*40);
if(palette_red_def_45_1 ==4'hF && palette_green_def_45_1 ==4'hF && palette_blue_def_45_1 == 4'hF)
begin
flag_def_45_1 = 0;
end
else
begin
flag_def_45_1 = 1;
end
end
else
begin
rom_address_def_45_1 = 0;
flag_def_45_1 = 0;
end
end


always_comb //deflector 45_2 drawing
begin
if(def_45_2_pos_x<40 && def_45_2_pos_y<40)
begin
rom_address_def_45_2 = ((def_45_2_pos_x)+(def_45_2_pos_y)*40);
if(palette_red_def_45_2 ==4'hF && palette_green_def_45_2 ==4'hF && palette_blue_def_45_2== 4'hF)
begin
flag_def_45_2 = 0;
end
else
begin
flag_def_45_2 = 1;
end
end
else
begin
rom_address_def_45_2 = 0;
flag_def_45_2 = 0;
end
end

//always_comb //deflector right drawing
//begin
//if(def_315_x<40 && def_315_y<40)
//begin
//rom_address_def_315= def_315_x+def_315_y*40;
//if(palette_red_def_315 !=4'hF && palette_green_def_315 !=4'hF && palette_blue_def_315 != 4'hF)
//begin
//flag_def_315 = 1;
//end
//else
//begin
//flag_def_315 = 0;
//end
//end
//else
//begin
//rom_address_def_315 = 0;
//flag_def_315 = 0;
//end
//end

always_ff @ (negedge frame_clk)
begin
if(def_45_1_pos_x <=5)
begin
def_45_1_motion_x = 10'h002; 
end
else if(def_45_1_pos_x+40>=640)
begin
def_45_1_motion_x= 10'h3FE;
end
		def_45_1_pos_x <= def_45_1_pos_x + def_45_1_motion_x;
		def_45_1_pos_y <= def_45_1_pos_y + def_45_1_motion_y;
end



always_comb //deflector 6 drawing
begin
if(DrawX>def_6_pos_x && DrawY>def_6_pos_y && DrawX<def_6_pos_x+40 && DrawY<def_6_pos_y+40)
begin
rom_address_def_315_6 = (DrawX-def_6_pos_x)+((DrawY-def_6_pos_y)*40);
if(palette_red_def_315_6 !=4'hF && palette_green_def_315_6 !=4'hF && palette_blue_def_315_6 != 4'hF)
begin
flag_def_315_6 = 1;
end
else
begin
flag_def_315_6 = 0;
end
end
else
begin
rom_address_def_315_6 = 0;
flag_def_315_6 = 0;
end
end



always_ff @ (negedge frame_clk)
begin
if(def_6_pos_y <=5)
begin
def_motion_y_6 = 10'h002; 
end
else if(def_6_pos_y+40>=480)
begin
def_motion_y_6 = 10'h3FE;
end
		def_6_pos_x <= def_6_pos_x + def_motion_x_6;
		def_6_pos_y <= def_6_pos_y + def_motion_y_6;
end



always_comb //gameend drawing
begin
if(DrawX>200 && DrawY>170 && DrawX<200+240 && DrawY<170+140 && (flag_b_l_gameendp1 == 1 || flag_b_r_gameendp1 == 1))
begin
rom_address_gameoverp1 = (gameoverp1_x)+(gameoverp1_y*240);
flag_gameoverp1 = 1;
end
else
begin
rom_address_gameoverp1 = 0;
flag_gameoverp1 = 0;
end
end


always_comb //gameend drawing
begin
if(DrawX>200 && DrawY>170 && DrawX<200+240 && DrawY<170+140 && (flag_b_l_gameendp2 == 1 || flag_b_r_gameendp2 == 1))
begin
rom_address_gameoverp2 = (gameoverp2_x)+(gameoverp2_y*240);
flag_gameoverp2 = 1;
end
else
begin
rom_address_gameoverp2 = 0;
flag_gameoverp2 = 0;
end
end
//INITIAL MOTIONS FOR BULLET LEFT
//
//
//
//
//
//
always_comb
begin
flag_b_l_0_exist = 0; //initial motions
flag_b_l_30_exist = 0;
flag_b_l_45_exist = 0;
flag_b_l_60_exist = 0;
flag_b_l_90_exist = 0;
flag_b_l_120_exist = 0;
flag_b_l_135_exist = 0;
flag_b_l_150_exist = 0;
flag_b_l_180_exist = 0;
flag_b_l_210_exist = 0;
flag_b_l_225_exist = 0;
flag_b_l_240_exist = 0;
flag_b_l_270_exist = 0;
flag_b_l_300_exist = 0;
flag_b_l_315_exist = 0;
flag_b_l_330_exist = 0;

	if(b_l_motion_x == 2&& b_l_motion_y ==0)
	begin
		flag_b_l_0_exist = 1;
	end
	
	else if(b_l_motion_x ==0 && b_l_motion_y ==2)
	begin
		flag_b_l_270_exist = 1;
	end
	
	else if(b_l_motion_x ==1 && b_l_motion_y ==1)
	begin
		flag_b_l_315_exist = 1;
	end
	
	else if(b_l_motion_x ==10'h3FE && b_l_motion_y ==0)
	begin
		flag_b_l_180_exist = 1;
	end
	
	else if(b_l_motion_x ==0 && b_l_motion_y ==10'h3FE)
	begin
		flag_b_l_90_exist = 1;
	end
	
	else if(b_l_motion_x ==10'h3FF && b_l_motion_y ==10'h3FF)
	begin
		flag_b_l_135_exist = 1;
	end
	
	else if(b_l_motion_x ==1 && b_l_motion_y ==10'h3FF)
	begin
		flag_b_l_45_exist = 1;
	end
	
	else if(b_l_motion_x ==10'h3FF && b_l_motion_y ==1)
	begin
		flag_b_l_225_exist = 1;
	end
	
	else if(b_l_motion_x ==2 && b_l_motion_y ==10'h3FF)
	begin
		flag_b_l_30_exist = 1;
	end
	
	else if(b_l_motion_x ==1 && b_l_motion_y ==10'h3FE)
	begin
		flag_b_l_60_exist = 1;
	end
	else if(b_l_motion_x ==2 && b_l_motion_y ==1)
	begin
		flag_b_l_330_exist = 1;
	end
	
	else if(b_l_motion_x ==1 && b_l_motion_y ==2)
	begin
		flag_b_l_300_exist = 1;
	end
	
	else if(b_l_motion_x ==10'h3FF && b_l_motion_y ==10'h3FE)
	begin
		flag_b_l_120_exist = 1;
	end
	
	else if(b_l_motion_x ==10'h3FE && b_l_motion_y ==10'h3FF)
	begin
		flag_b_l_150_exist = 1;
	end
	
	else if(b_l_motion_x ==10'h3FE && b_l_motion_y ==1)
	begin
		flag_b_l_210_exist = 1;
	end
	
	else if(b_l_motion_x ==10'h3FF && b_l_motion_y ==2)
	begin
		flag_b_l_240_exist = 1;
	end
	
end


//INITIAL MOTIONS FOR BULLET RIGHT
//
//
//
//
//
//
always_comb
begin
flag_b_r_0_exist = 0; //initial motions
flag_b_r_30_exist = 0;
flag_b_r_45_exist = 0;
flag_b_r_60_exist = 0;
flag_b_r_90_exist = 0;
flag_b_r_120_exist = 0;
flag_b_r_135_exist = 0;
flag_b_r_150_exist = 0;
flag_b_r_180_exist = 0;
flag_b_r_210_exist = 0;
flag_b_r_225_exist = 0;
flag_b_r_240_exist = 0;
flag_b_r_270_exist = 0;
flag_b_r_300_exist = 0;
flag_b_r_315_exist = 0;
flag_b_r_330_exist = 0;

	if(b_r_motion_x == 2&& b_r_motion_y ==0)
	begin
		flag_b_r_0_exist = 1;
	end
	
	else if(b_r_motion_x ==0 && b_r_motion_y ==2)
	begin
		flag_b_r_270_exist = 1;
	end
	
	else if(b_r_motion_x ==1 && b_r_motion_y ==1)
	begin
		flag_b_r_315_exist = 1;
	end
	
	else if(b_r_motion_x ==10'h3FE && b_r_motion_y ==0)
	begin
		flag_b_r_180_exist = 1;
	end
	
	else if(b_r_motion_x ==0 && b_r_motion_y ==10'h3FE)
	begin
		flag_b_r_90_exist = 1;
	end
	
	else if(b_r_motion_x ==10'h3FF && b_r_motion_y ==10'h3FF)
	begin
		flag_b_r_135_exist = 1;
	end
	
	else if(b_r_motion_x ==1 && b_r_motion_y ==10'h3FF)
	begin
		flag_b_r_45_exist = 1;
	end
	
	else if(b_r_motion_x ==10'h3FF && b_r_motion_y ==1)
	begin
		flag_b_r_225_exist = 1;
	end
	
	else if(b_r_motion_x ==2 && b_r_motion_y ==10'h3FF)
	begin
		flag_b_r_30_exist = 1;
	end
	
	else if(b_r_motion_x ==1 && b_r_motion_y ==10'h3FE)
	begin
		flag_b_r_60_exist = 1;
	end
	else if(b_r_motion_x ==2 && b_r_motion_y ==1)
	begin
		flag_b_r_330_exist = 1;
	end
	
	else if(b_r_motion_x ==1 && b_r_motion_y ==2)
	begin
		flag_b_r_300_exist = 1;
	end
	
	else if(b_r_motion_x ==10'h3FF && b_r_motion_y ==10'h3FE)
	begin
		flag_b_r_120_exist = 1;
	end
	
	else if(b_r_motion_x ==10'h3FE && b_r_motion_y ==10'h3FF)
	begin
		flag_b_r_150_exist = 1;
	end
	
	else if(b_r_motion_x ==10'h3FE && b_r_motion_y ==1)
	begin
		flag_b_r_210_exist = 1;
	end
	
	else if(b_r_motion_x ==10'h3FF && b_r_motion_y ==2)
	begin
		flag_b_r_240_exist = 1;
	end
	
end
//BOUNCING AND MOTIONS FOR BULLET LEFT
//
//
//
//
//
//
logic [0:0]flag_b_l_90_conflict, flag_b_l_60_conflict,flag_b_l_45_conflict,flag_b_l_30_conflict,flag_b_l_0_conflict,
flag_b_l_330_conflict,flag_b_l_315_conflict,flag_b_l_300_conflict,flag_b_l_270_conflict, flag_b_l_240_conflict, flag_b_l_225_conflict, flag_b_l_210_conflict, flag_b_l_180_conflict, flag_b_l_150_conflict,
flag_b_l_135_conflict, flag_b_l_120_conflict; //conflict flags for left bullet

always_ff@(posedge vga_clk)
begin

if(DrawX == b_l_pos_x+31 && DrawY == b_l_pos_y+19&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_l_0)
begin
flag_b_l_0_conflict <= 1;
end
else if (DrawX == b_l_pos_x+28 && DrawY ==b_l_pos_y+14&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_l_30)
begin
flag_b_l_30_conflict <= 1;
end
else if (DrawX == b_l_pos_x+26 && DrawY == b_l_pos_y+13&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_l_45)
begin
flag_b_l_45_conflict <= 1;
end
else if (DrawX == b_l_pos_x+25 && DrawY == b_l_pos_y+10&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_l_60)
begin
flag_b_l_60_conflict <= 1;
end
else if (DrawX == b_l_pos_x+20 && DrawY == b_l_pos_y+7&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_l_90)
begin
flag_b_l_90_conflict <= 1;
end
else if (DrawX == b_l_pos_x+15 && DrawY == b_l_pos_y+10&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_l_120)
begin
flag_b_l_120_conflict <= 1;
end
else if (DrawX == b_l_pos_x+10 && DrawY ==b_l_pos_y+10&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_l_135)
begin
flag_b_l_135_conflict <= 1;
end
else if (DrawX == b_l_pos_x+10 && DrawY == b_l_pos_y+15&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_l_150)
begin
flag_b_l_150_conflict <= 1;
end
else if (DrawX == b_l_pos_x+5 && DrawY == b_l_pos_y+20&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_l_180)
begin
flag_b_l_180_conflict <= 1;
end
else if (DrawX == b_l_pos_x+10 && DrawY == b_l_pos_y+25&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_l_210)
begin
flag_b_l_210_conflict <= 1;
end
else if (DrawX == b_l_pos_x+13 && DrawY == b_l_pos_y+26&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_l_225)
begin
flag_b_l_225_conflict <= 1;
end
else if (DrawX == b_l_pos_x+15 && DrawY == b_l_pos_y+28&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_l_240)
begin
flag_b_l_240_conflict <= 1;
end
else if (DrawX == b_l_pos_x+20 && DrawY == b_l_pos_y+31&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_l_270)
begin
flag_b_l_270_conflict <= 1;
end
else if (DrawX == b_l_pos_x+25 && DrawY ==b_l_pos_y+28&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_l_300)
begin
flag_b_l_300_conflict <= 1;
end
else if (DrawX == b_l_pos_x+27 && DrawY == b_l_pos_y+27&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_l_315)
begin
flag_b_l_315_conflict <= 1;
end
else if (DrawX == b_l_pos_x+28 && DrawY ==b_l_pos_y+25&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_l_330)
begin
flag_b_l_330_conflict <= 1;
end
else
begin
flag_b_l_90_conflict <= 0;
flag_b_l_60_conflict <=0; 
flag_b_l_45_conflict <= 0; 
flag_b_l_30_conflict<= 0;
flag_b_l_0_conflict<= 0;
flag_b_l_330_conflict<= 0;
flag_b_l_315_conflict<= 0;
flag_b_l_300_conflict<= 0;
flag_b_l_270_conflict<= 0;
flag_b_l_240_conflict<= 0; 
flag_b_l_225_conflict<= 0;
flag_b_l_210_conflict<= 0; 
flag_b_l_180_conflict<= 0;
flag_b_l_150_conflict<= 0;
flag_b_l_135_conflict<= 0; 
flag_b_l_120_conflict<= 0;
end
end

logic [0:0]flag_b_l_90_conflict_45, flag_b_l_60_conflict_45,flag_b_l_45_conflict_45,flag_b_l_30_conflict_45,flag_b_l_0_conflict_45,
flag_b_l_330_conflict_45,flag_b_l_315_conflict_45,flag_b_l_300_conflict_45,flag_b_l_270_conflict_45, flag_b_l_240_conflict_45, flag_b_l_225_conflict_45, flag_b_l_210_conflict_45, flag_b_l_180_conflict_45, flag_b_l_150_conflict_45,
flag_b_l_135_conflict_45, flag_b_l_120_conflict_45; //conflict flags for left bullet
//45 DEGREE REFLECTOR LOGIC FOR LEFT BULLET
always_ff@(posedge vga_clk)
begin

if(DrawX == b_l_pos_x+31 && DrawY == b_l_pos_y+19&&(flag_def_45_1||flag_def_45_2) && flag_b_l_0)
begin
flag_b_l_0_conflict_45 <= 1;
end
else if (DrawX == b_l_pos_x+28 && DrawY ==b_l_pos_y+14&&(flag_def_45_1||flag_def_45_2) && flag_b_l_30)
begin
flag_b_l_30_conflict_45 <= 1;
end
else if (DrawX == b_l_pos_x+26 && DrawY == b_l_pos_y+13&&(flag_def_45_1||flag_def_45_2) && flag_b_l_45)
begin
flag_b_l_45_conflict_45 <= 1;
end
else if (DrawX == b_l_pos_x+25 && DrawY == b_l_pos_y+10&&(flag_def_45_1||flag_def_45_2) && flag_b_l_60)
begin
flag_b_l_60_conflict_45 <= 1;
end
else if (DrawX == b_l_pos_x+20 && DrawY == b_l_pos_y+7&&(flag_def_45_1||flag_def_45_2) && flag_b_l_90)
begin
flag_b_l_90_conflict_45 <= 1;
end
else if (DrawX == b_l_pos_x+15 && DrawY == b_l_pos_y+10&&(flag_def_45_1||flag_def_45_2) && flag_b_l_120)
begin
flag_b_l_120_conflict_45 <= 1;
end
else if (DrawX == b_l_pos_x+10 && DrawY ==b_l_pos_y+10&&(flag_def_45_1||flag_def_45_2) && flag_b_l_135)
begin
flag_b_l_135_conflict_45 <= 1;
end
else if (DrawX == b_l_pos_x+10 && DrawY == b_l_pos_y+15&&(flag_def_45_1||flag_def_45_2) && flag_b_l_150)
begin
flag_b_l_150_conflict_45 <= 1;
end
else if (DrawX == b_l_pos_x+5 && DrawY == b_l_pos_y+20&&(flag_def_45_1||flag_def_45_2) && flag_b_l_180)
begin
flag_b_l_180_conflict_45 <= 1;
end
else if (DrawX == b_l_pos_x+10 && DrawY == b_l_pos_y+25&&(flag_def_45_1||flag_def_45_2) && flag_b_l_210)
begin
flag_b_l_210_conflict_45 <= 1;
end
else if (DrawX == b_l_pos_x+13 && DrawY == b_l_pos_y+26&&(flag_def_45_1||flag_def_45_2) && flag_b_l_225)
begin
flag_b_l_225_conflict_45 <= 1;
end
else if (DrawX == b_l_pos_x+15 && DrawY == b_l_pos_y+28&&(flag_def_45_1||flag_def_45_2) && flag_b_l_240)
begin
flag_b_l_240_conflict_45 <= 1;
end
else if (DrawX == b_l_pos_x+20 && DrawY == b_l_pos_y+31&&(flag_def_45_1||flag_def_45_2) && flag_b_l_270)
begin
flag_b_l_270_conflict_45 <= 1;
end
else if (DrawX == b_l_pos_x+25 && DrawY ==b_l_pos_y+28&&(flag_def_45_1||flag_def_45_2) && flag_b_l_300)
begin
flag_b_l_300_conflict_45 <= 1;
end
else if (DrawX == b_l_pos_x+27 && DrawY == b_l_pos_y+27&&(flag_def_45_1||flag_def_45_2) && flag_b_l_315)
begin
flag_b_l_315_conflict_45 <= 1;
end
else if (DrawX == b_l_pos_x+28 && DrawY ==b_l_pos_y+25&&(flag_def_45_1||flag_def_45_2) && flag_b_l_330)
begin
flag_b_l_330_conflict_45 <= 1;
end
else
begin
flag_b_l_90_conflict_45 <= 0;
flag_b_l_60_conflict_45 <=0; 
flag_b_l_45_conflict_45 <= 0; 
flag_b_l_30_conflict_45<= 0;
flag_b_l_0_conflict_45<= 0;
flag_b_l_330_conflict_45<= 0;
flag_b_l_315_conflict_45<= 0;
flag_b_l_300_conflict_45<= 0;
flag_b_l_270_conflict_45<= 0;
flag_b_l_240_conflict_45<= 0; 
flag_b_l_225_conflict_45<= 0;
flag_b_l_210_conflict_45<= 0; 
flag_b_l_180_conflict_45<= 0;
flag_b_l_150_conflict_45<= 0;
flag_b_l_135_conflict_45<= 0; 
flag_b_l_120_conflict_45<= 0;
end
end
//GAMEEND LOGIC
//
//
//
//
logic [0:0] flag_b_l_gameendp1, flag_b_r_gameendp1, flag_b_l_gameendp2, flag_b_r_gameendp2;
initial flag_b_l_gameendp1 = 0;
initial flag_b_r_gameendp1 = 0;//gameend flags for left bullet
///GAMEEND COLLISION DETECTION FOR DOG
always_ff @(posedge vga_clk)
begin
//flag_b_l_gameend <= 0;
//flag_b_l_gameend <= 0;
if(DrawX == b_l_pos_x+31 && DrawY == b_l_pos_y+19&& flag_d&& flag_b_l_0)
begin
flag_b_l_gameendp1 <= 1;
end
else if (DrawX == b_l_pos_x+28 && DrawY ==b_l_pos_y+14&&flag_d&& flag_b_l_30)
begin
flag_b_l_gameendp1 <= 1;
end
else if (DrawX == b_l_pos_x+26 && DrawY == b_l_pos_y+13&&flag_d&& flag_b_l_45)
begin
flag_b_l_gameendp1 <= 1;
end
else if (DrawX == b_l_pos_x+25 && DrawY == b_l_pos_y+10&&flag_d&& flag_b_l_60)
begin
flag_b_l_gameendp1 <= 1;
end
else if (DrawX == b_l_pos_x+20 && DrawY == b_l_pos_y+7&&flag_d&& flag_b_l_90)
begin
flag_b_l_gameendp1 <= 1;
end
else if (DrawX == b_l_pos_x+15 && DrawY == b_l_pos_y+10&&flag_d&& flag_b_l_120)
begin
flag_b_l_gameendp1 <= 1;
end
else if (DrawX == b_l_pos_x+10 && DrawY ==b_l_pos_y+10&&flag_d&& flag_b_l_135)
begin
flag_b_l_gameendp1 <= 1;
end
else if (DrawX == b_l_pos_x+10 && DrawY == b_l_pos_y+15&&flag_d&& flag_b_l_150)
begin
flag_b_l_gameendp1 <=1;
end
else if (DrawX == b_l_pos_x+5 && DrawY == b_l_pos_y+20&&flag_d&& flag_b_l_180)
begin
flag_b_l_gameendp1 <= 1;
end
else if (DrawX == b_l_pos_x+10 && DrawY == b_l_pos_y+25&&flag_d&& flag_b_l_210)
begin
flag_b_l_gameendp1 <= 1;
end
else if (DrawX == b_l_pos_x+13 && DrawY == b_l_pos_y+26&&flag_d&& flag_b_l_225)
begin
flag_b_l_gameendp1 <= 1;
end
else if (DrawX == b_l_pos_x+15 && DrawY == b_l_pos_y+28&&flag_d&& flag_b_l_240)
begin
flag_b_l_gameendp1 <= 1;
end
else if (DrawX == b_l_pos_x+20 && DrawY == b_l_pos_y+31&&flag_d&& flag_b_l_270)
begin
flag_b_l_gameendp1 <= 1;
end
else if (DrawX == b_l_pos_x+25 && DrawY ==b_l_pos_y+28&&flag_d&& flag_b_l_300)
begin
flag_b_l_gameendp1 <= 1;
end
else if (DrawX == b_l_pos_x+27 && DrawY == b_l_pos_y+27&&flag_d&& flag_b_l_315)
begin
flag_b_l_gameendp1 <= 1;
end
else if (DrawX == b_l_pos_x+28 && DrawY ==b_l_pos_y+25&&flag_d&& flag_b_l_330)
begin
flag_b_l_gameendp1 <= 1;
end
else if(keycode == 8'h2B)
begin
flag_b_l_gameendp1 <= 0;
end

if(DrawX == b_r_pos_x+31 && DrawY == b_r_pos_y+19&& flag_d&& flag_b_r_0)
begin
flag_b_r_gameendp1 <= 1;
end
else if (DrawX == b_r_pos_x+28 && DrawY ==b_r_pos_y+14&&flag_d&& flag_b_r_30)
begin
flag_b_r_gameendp1 <= 1;
end
else if (DrawX == b_r_pos_x+26 && DrawY == b_r_pos_y+13&&flag_d&& flag_b_r_45)
begin
flag_b_r_gameendp1 <= 1;
end
else if (DrawX == b_r_pos_x+25 && DrawY == b_r_pos_y+10&&flag_d&& flag_b_r_60)
begin
flag_b_r_gameendp1 <= 1;
end
else if (DrawX == b_r_pos_x+20 && DrawY == b_r_pos_y+7&&flag_d&& flag_b_r_90)
begin
flag_b_r_gameendp1 <= 1;
end
else if (DrawX == b_r_pos_x+15 && DrawY == b_r_pos_y+10&&flag_d&& flag_b_r_120)
begin
flag_b_r_gameendp1 <= 1;
end
else if (DrawX == b_r_pos_x+10 && DrawY ==b_r_pos_y+10&&flag_d&& flag_b_r_135)
begin
flag_b_r_gameendp1 <= 1;
end
else if (DrawX == b_r_pos_x+10 && DrawY == b_r_pos_y+15&&flag_d&& flag_b_r_150)
begin
flag_b_r_gameendp1 <=1;
end
else if (DrawX == b_r_pos_x+5 && DrawY == b_r_pos_y+20&&flag_d&& flag_b_r_180)
begin
flag_b_r_gameendp1 <= 1;
end
else if (DrawX == b_r_pos_x+10 && DrawY == b_r_pos_y+25&&flag_d&& flag_b_r_210)
begin
flag_b_r_gameendp1 <= 1;
end
else if (DrawX == b_r_pos_x+13 && DrawY == b_r_pos_y+26&&flag_d&& flag_b_r_225)
begin
flag_b_r_gameendp1 <= 1;
end
else if (DrawX == b_r_pos_x+15 && DrawY == b_r_pos_y+28&&flag_d&& flag_b_r_240)
begin
flag_b_r_gameendp1 <= 1;
end
else if (DrawX == b_r_pos_x+20 && DrawY == b_r_pos_y+31&&flag_d&& flag_b_r_270)
begin
flag_b_r_gameendp1 <= 1;
end
else if (DrawX == b_r_pos_x+25 && DrawY ==b_r_pos_y+28&&flag_d&& flag_b_r_300)
begin
flag_b_r_gameendp1 <= 1;
end
else if (DrawX == b_r_pos_x+27 && DrawY == b_r_pos_y+27&&flag_d&& flag_b_r_315)
begin
flag_b_r_gameendp1 <= 1;
end
else if (DrawX == b_r_pos_x+28 && DrawY ==b_r_pos_y+25&&flag_d&& flag_b_r_330)
begin
flag_b_r_gameendp1 <= 1;
end
else if(keycode == 8'h2B)
begin
flag_b_r_gameendp1 <= 0;
end

//START OF COLLISION DETECTION WITH PENGUIN
if(DrawX == b_l_pos_x+31 && DrawY == b_l_pos_y+19&& flag_p&& flag_b_l_0)
begin
flag_b_l_gameendp2 <= 1;
end
else if (DrawX == b_l_pos_x+28 && DrawY ==b_l_pos_y+14&&flag_p&& flag_b_l_30)
begin
flag_b_l_gameendp2 <= 1;
end
else if (DrawX == b_l_pos_x+26 && DrawY == b_l_pos_y+13&&flag_p&& flag_b_l_45)
begin
flag_b_l_gameendp2 <= 1;
end
else if (DrawX == b_l_pos_x+25 && DrawY == b_l_pos_y+10&&flag_p&& flag_b_l_60)
begin
flag_b_l_gameendp2 <= 1;
end
else if (DrawX == b_l_pos_x+20 && DrawY == b_l_pos_y+7&&flag_p&& flag_b_l_90)
begin
flag_b_l_gameendp2 <= 1;
end
else if (DrawX == b_l_pos_x+15 && DrawY == b_l_pos_y+10&&flag_p&& flag_b_l_120)
begin
flag_b_l_gameendp2 <= 1;
end
else if (DrawX == b_l_pos_x+10 && DrawY ==b_l_pos_y+10&&flag_p&& flag_b_l_135)
begin
flag_b_l_gameendp2 <= 1;
end
else if (DrawX == b_l_pos_x+10 && DrawY == b_l_pos_y+15&&flag_p&& flag_b_l_150)
begin
flag_b_l_gameendp2 <=1;
end
else if (DrawX == b_l_pos_x+5 && DrawY == b_l_pos_y+20&&flag_p&& flag_b_l_180)
begin
flag_b_l_gameendp2 <= 1;
end
else if (DrawX == b_l_pos_x+10 && DrawY == b_l_pos_y+25&&flag_p&& flag_b_l_210)
begin
flag_b_l_gameendp2 <= 1;
end
else if (DrawX == b_l_pos_x+13 && DrawY == b_l_pos_y+26&&flag_p&& flag_b_l_225)
begin
flag_b_l_gameendp2 <= 1;
end
else if (DrawX == b_l_pos_x+15 && DrawY == b_l_pos_y+28&&flag_p&& flag_b_l_240)
begin
flag_b_l_gameendp2 <= 1;
end
else if (DrawX == b_l_pos_x+20 && DrawY == b_l_pos_y+31&&flag_p&& flag_b_l_270)
begin
flag_b_l_gameendp2 <= 1;
end
else if (DrawX == b_l_pos_x+25 && DrawY ==b_l_pos_y+28&&flag_p&& flag_b_l_300)
begin
flag_b_l_gameendp2 <= 1;
end
else if (DrawX == b_l_pos_x+27 && DrawY == b_l_pos_y+27&&flag_p&& flag_b_l_315)
begin
flag_b_l_gameendp2 <= 1;
end
else if (DrawX == b_l_pos_x+28 && DrawY ==b_l_pos_y+25&&flag_p&& flag_b_l_330)
begin
flag_b_l_gameendp2 <= 1;
end
else if(keycode == 8'h2B)
begin
flag_b_l_gameendp2 <= 0;
end

if(DrawX == b_r_pos_x+31 && DrawY == b_r_pos_y+19&& flag_p&& flag_b_r_0)
begin
flag_b_r_gameendp2 <= 1;
end
else if (DrawX == b_r_pos_x+28 && DrawY ==b_r_pos_y+14&&flag_p&& flag_b_r_30)
begin
flag_b_r_gameendp2 <= 1;
end
else if (DrawX == b_r_pos_x+26 && DrawY == b_r_pos_y+13&&flag_p&& flag_b_r_45)
begin
flag_b_r_gameendp2 <= 1;
end
else if (DrawX == b_r_pos_x+25 && DrawY == b_r_pos_y+10&&flag_p&& flag_b_r_60)
begin
flag_b_r_gameendp2 <= 1;
end
else if (DrawX == b_r_pos_x+20 && DrawY == b_r_pos_y+7&&flag_p&& flag_b_r_90)
begin
flag_b_r_gameendp2 <= 1;
end
else if (DrawX == b_r_pos_x+15 && DrawY == b_r_pos_y+10&&flag_p&& flag_b_r_120)
begin
flag_b_r_gameendp2 <= 1;
end
else if (DrawX == b_r_pos_x+10 && DrawY ==b_r_pos_y+10&&flag_p&& flag_b_r_135)
begin
flag_b_r_gameendp2 <= 1;
end
else if (DrawX == b_r_pos_x+10 && DrawY == b_r_pos_y+15&&flag_p&& flag_b_r_150)
begin
flag_b_r_gameendp2 <=1;
end
else if (DrawX == b_r_pos_x+5 && DrawY == b_r_pos_y+20&&flag_p&& flag_b_r_180)
begin
flag_b_r_gameendp2 <= 1;
end
else if (DrawX == b_r_pos_x+10 && DrawY == b_r_pos_y+25&&flag_p&& flag_b_r_210)
begin
flag_b_r_gameendp2 <= 1;
end
else if (DrawX == b_r_pos_x+13 && DrawY == b_r_pos_y+26&&flag_p&& flag_b_r_225)
begin
flag_b_r_gameendp2 <= 1;
end
else if (DrawX == b_r_pos_x+15 && DrawY == b_r_pos_y+28&&flag_p&& flag_b_r_240)
begin
flag_b_r_gameendp2 <= 1;
end
else if (DrawX == b_r_pos_x+20 && DrawY == b_r_pos_y+31&&flag_p&& flag_b_r_270)
begin
flag_b_r_gameendp2 <= 1;
end
else if (DrawX == b_r_pos_x+25 && DrawY ==b_r_pos_y+28&&flag_p&& flag_b_r_300)
begin
flag_b_r_gameendp2 <= 1;
end
else if (DrawX == b_r_pos_x+27 && DrawY == b_r_pos_y+27&&flag_p&& flag_b_r_315)
begin
flag_b_r_gameendp2 <= 1;
end
else if (DrawX == b_r_pos_x+28 && DrawY ==b_r_pos_y+25&&flag_p&& flag_b_r_330)
begin
flag_b_r_gameendp2 <= 1;
end
else if(keycode == 8'h2B)
begin
flag_b_r_gameendp2 <= 0;
end
end

logic [0:0] bullet_collision;

//always_comb
//begin
//
//if(((flag_b_l_0&&flag_b_l_0_exist)||(flag_b_l_30&&flag_b_l_30_exist)||(flag_b_l_45&&flag_b_l_45_exist)||
//(flag_b_l_60&&flag_b_l_60_exist)||(flag_b_l_90&&flag_b_l_90_exist)||(flag_b_l_120&&flag_b_l_120_exist)||(flag_b_l_135&&flag_b_l_135_exist)||
//(flag_b_l_150&&flag_b_l_150_exist)||(flag_b_l_180&&flag_b_l_180_exist)||(flag_b_l_210&&flag_b_l_210_exist)||(flag_b_l_225&&flag_b_l_225_exist)
//||(flag_b_l_240&&flag_b_l_240_exist)||(flag_b_l_270&&flag_b_l_270_exist)||(flag_b_l_300&&flag_b_l_300_exist)||(flag_b_l_330&&flag_b_l_330_exist)||(flag_b_l_315&&flag_b_l_315_exist)) 
//&& ((flag_b_r_0&&flag_b_r_0_exist)||(flag_b_r_30&&flag_b_r_30_exist)||(flag_b_r_45&&flag_b_r_45_exist)||
//(flag_b_r_60&&flag_b_r_60_exist)||(flag_b_r_90&&flag_b_r_90_exist)||(flag_b_r_120&&flag_b_r_120_exist)||(flag_b_r_135&&flag_b_r_135_exist)||
//(flag_b_r_150&&flag_b_r_150_exist)||(flag_b_r_180&&flag_b_r_180_exist)||(flag_b_r_210&&flag_b_r_210_exist)||(flag_b_r_225&&flag_b_r_225_exist)
//||(flag_b_r_240&&flag_b_r_240_exist)||(flag_b_r_270&&flag_b_r_270_exist)||(flag_b_r_300&&flag_b_r_300_exist)||(flag_b_r_330&&flag_b_r_330_exist)||(flag_b_r_315&&flag_b_r_315_exist))) 
//begin
//bullet_collision =1;
//end
//else
//begin
//bullet_collision =0;
//end
//end

//CONFLICTS FOR BULLET RIGHT
logic [0:0]flag_b_r_90_conflict, flag_b_r_60_conflict,flag_b_r_45_conflict,flag_b_r_30_conflict,flag_b_r_0_conflict,
flag_b_r_330_conflict,flag_b_r_315_conflict,flag_b_r_300_conflict,flag_b_r_270_conflict, flag_b_r_240_conflict, flag_b_r_225_conflict, flag_b_r_210_conflict, flag_b_r_180_conflict, flag_b_r_150_conflict,
flag_b_r_135_conflict, flag_b_r_120_conflict; //drawing flags for left bullet

always_ff@(posedge vga_clk)
begin

if(DrawX == b_r_pos_x+31 && DrawY == b_r_pos_y+19&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_r_0)
begin
flag_b_r_0_conflict <= 1;
end
else if (DrawX == b_r_pos_x+28 && DrawY ==b_r_pos_y+14&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_r_30)
begin
flag_b_r_30_conflict <= 1;
end
else if (DrawX == b_r_pos_x+26 && DrawY == b_r_pos_y+13&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_r_45)
begin
flag_b_r_45_conflict <= 1;
end
else if (DrawX == b_r_pos_x+25 && DrawY == b_r_pos_y+10&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_r_60)
begin
flag_b_r_60_conflict <= 1;
end
else if (DrawX == b_r_pos_x+20 && DrawY == b_r_pos_y+7&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_r_90)
begin
flag_b_r_90_conflict <= 1;
end
else if (DrawX == b_r_pos_x+15 && DrawY == b_r_pos_y+10&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_r_120)
begin
flag_b_r_120_conflict <= 1;
end
else if (DrawX == b_r_pos_x+10 && DrawY ==b_r_pos_y+10&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_r_135)
begin
flag_b_r_135_conflict <= 1;
end
else if (DrawX == b_r_pos_x+10 && DrawY == b_r_pos_y+15&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_r_150)
begin
flag_b_r_150_conflict <= 1;
end
else if (DrawX == b_r_pos_x+5 && DrawY == b_r_pos_y+20&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_r_180)
begin
flag_b_r_180_conflict <= 1;
end
else if (DrawX == b_r_pos_x+10 && DrawY == b_r_pos_y+25&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_r_210)
begin
flag_b_r_210_conflict <= 1;
end
else if (DrawX == b_r_pos_x+13 && DrawY == b_r_pos_y+26&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_r_225)
begin
flag_b_r_225_conflict <= 1;
end
else if (DrawX == b_r_pos_x+15 && DrawY == b_r_pos_y+28&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_r_240)
begin
flag_b_r_240_conflict <= 1;
end
else if (DrawX == b_r_pos_x+20 && DrawY == b_r_pos_y+31&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_r_270)
begin
flag_b_r_270_conflict <= 1;
end
else if (DrawX == b_r_pos_x+25 && DrawY ==b_r_pos_y+28&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_r_300)
begin
flag_b_r_300_conflict <= 1;
end
else if (DrawX == b_r_pos_x+27 && DrawY == b_r_pos_y+27&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_r_315)
begin
flag_b_r_315_conflict <= 1;
end
else if (DrawX == b_r_pos_x+28 && DrawY ==b_r_pos_y+25&&(flag_def_315||flag_def_315_2||flag_def_315_3||flag_def_315_4||flag_def_315_5||flag_def_315_6) && flag_b_r_330)
begin
flag_b_r_330_conflict <= 1;
end
else
begin
flag_b_r_90_conflict <= 0;
flag_b_r_60_conflict <=0; 
flag_b_r_45_conflict <= 0; 
flag_b_r_30_conflict<= 0;
flag_b_r_0_conflict<= 0;
flag_b_r_330_conflict<= 0;
flag_b_r_315_conflict<= 0;
flag_b_r_300_conflict<= 0;
flag_b_r_270_conflict<= 0;
flag_b_r_240_conflict<= 0; 
flag_b_r_225_conflict<= 0;
flag_b_r_210_conflict<= 0; 
flag_b_r_180_conflict<= 0;
flag_b_r_150_conflict<= 0;
flag_b_r_135_conflict<= 0; 
flag_b_r_120_conflict<= 0;
end
end

logic [0:0]flag_b_r_90_conflict_45, flag_b_r_60_conflict_45,flag_b_r_45_conflict_45,flag_b_r_30_conflict_45,flag_b_r_0_conflict_45,
flag_b_r_330_conflict_45,flag_b_r_315_conflict_45,flag_b_r_300_conflict_45,flag_b_r_270_conflict_45, flag_b_r_240_conflict_45, flag_b_r_225_conflict_45, flag_b_r_210_conflict_45, flag_b_r_180_conflict_45, flag_b_r_150_conflict_45,
flag_b_r_135_conflict_45, flag_b_r_120_conflict_45; 
always_ff@(posedge vga_clk)
begin

if(DrawX == b_r_pos_x+31 && DrawY == b_r_pos_y+19&&(flag_def_45_1||flag_def_45_2) && flag_b_r_0)
begin
flag_b_r_0_conflict_45 <= 1;
end
else if (DrawX == b_r_pos_x+28 && DrawY ==b_r_pos_y+14&&(flag_def_45_1||flag_def_45_2) && flag_b_r_30)
begin
flag_b_r_30_conflict_45 <= 1;
end
else if (DrawX == b_r_pos_x+26 && DrawY == b_r_pos_y+13&&(flag_def_45_1||flag_def_45_2) && flag_b_r_45)
begin
flag_b_r_45_conflict_45 <= 1;
end
else if (DrawX == b_r_pos_x+25 && DrawY == b_r_pos_y+10&&(flag_def_45_1||flag_def_45_2) && flag_b_r_60)
begin
flag_b_r_60_conflict_45 <= 1;
end
else if (DrawX == b_r_pos_x+20 && DrawY == b_r_pos_y+7&&(flag_def_45_1||flag_def_45_2) && flag_b_r_90)
begin
flag_b_r_90_conflict_45 <= 1;
end
else if (DrawX == b_r_pos_x+15 && DrawY == b_r_pos_y+10&&(flag_def_45_1||flag_def_45_2) && flag_b_r_120)
begin
flag_b_r_120_conflict_45 <= 1;
end
else if (DrawX == b_r_pos_x+10 && DrawY ==b_r_pos_y+10&&(flag_def_45_1||flag_def_45_2) && flag_b_r_135)
begin
flag_b_r_135_conflict_45 <= 1;
end
else if (DrawX == b_r_pos_x+10 && DrawY == b_r_pos_y+15&&(flag_def_45_1||flag_def_45_2) && flag_b_r_150)
begin
flag_b_r_150_conflict_45 <= 1;
end
else if (DrawX == b_r_pos_x+5 && DrawY == b_r_pos_y+20&&(flag_def_45_1||flag_def_45_2) && flag_b_r_180)
begin
flag_b_r_180_conflict_45 <= 1;
end
else if (DrawX == b_r_pos_x+10 && DrawY == b_r_pos_y+25&&(flag_def_45_1||flag_def_45_2) && flag_b_r_210)
begin
flag_b_r_210_conflict_45 <= 1;
end
else if (DrawX == b_r_pos_x+13 && DrawY == b_r_pos_y+26&&(flag_def_45_1||flag_def_45_2) && flag_b_r_225)
begin
flag_b_r_225_conflict_45 <= 1;
end
else if (DrawX == b_r_pos_x+15 && DrawY == b_r_pos_y+28&&(flag_def_45_1||flag_def_45_2) && flag_b_r_240)
begin
flag_b_r_240_conflict_45 <= 1;
end
else if (DrawX == b_r_pos_x+20 && DrawY == b_r_pos_y+31&&(flag_def_45_1||flag_def_45_2) && flag_b_r_270)
begin
flag_b_r_270_conflict_45 <= 1;
end
else if (DrawX == b_r_pos_x+25 && DrawY ==b_r_pos_y+28&&(flag_def_45_1||flag_def_45_2) && flag_b_r_300)
begin
flag_b_r_300_conflict_45 <= 1;
end
else if (DrawX == b_r_pos_x+27 && DrawY == b_r_pos_y+27&&(flag_def_45_1||flag_def_45_2) && flag_b_r_315)
begin
flag_b_r_315_conflict_45 <= 1;
end
else if (DrawX == b_r_pos_x+28 && DrawY ==b_r_pos_y+25&&(flag_def_45_1||flag_def_45_2) && flag_b_r_330)
begin
flag_b_r_330_conflict_45 <= 1;
end
else
begin
flag_b_r_90_conflict_45 <= 0;
flag_b_r_60_conflict_45 <=0; 
flag_b_r_45_conflict_45 <= 0; 
flag_b_r_30_conflict_45<= 0;
flag_b_r_0_conflict_45<= 0;
flag_b_r_330_conflict_45<= 0;
flag_b_r_315_conflict_45<= 0;
flag_b_r_300_conflict_45<= 0;
flag_b_r_270_conflict_45<= 0;
flag_b_r_240_conflict_45<= 0; 
flag_b_r_225_conflict_45<= 0;
flag_b_r_210_conflict_45<= 0; 
flag_b_r_180_conflict_45<= 0;
flag_b_r_150_conflict_45<= 0;
flag_b_r_135_conflict_45<= 0; 
flag_b_r_120_conflict_45<= 0;
end
end
//MOTIONS AND BOUNCING FOR BULLET LEFT


always_ff @(posedge (vga_clk))
begin

	if(flag_b_reset==1'b1)
	begin
		b_l_motion_x <= b_override_motion_x;
		b_l_motion_y <= b_override_motion_y;
	end

	else
	begin
		if(b_l_pos_x+30>640&&(b_l_motion_x<10'h004))
		begin
		b_l_motion_x <= (~(b_l_motion_x)+10'h001);
		b_l_motion_y <= b_l_motion_y;
		end	

		else if(b_l_pos_x<=5&&(b_l_motion_x>10'h004))
		begin
		b_l_motion_x <= (~(b_l_motion_x)+10'h001);
		b_l_motion_y <= b_l_motion_y;
		end

		else if(flag_b_l_90_conflict|| flag_b_l_60_conflict||flag_b_l_45_conflict||flag_b_l_30_conflict||flag_b_l_0_conflict
||flag_b_l_330_conflict||flag_b_l_315_conflict||flag_b_l_300_conflict||
flag_b_l_270_conflict||flag_b_l_240_conflict|| flag_b_l_225_conflict||flag_b_l_210_conflict|| 
flag_b_l_180_conflict||flag_b_l_150_conflict
||flag_b_l_135_conflict|| flag_b_l_120_conflict)
		begin
		b_l_motion_x <= b_l_motion_y;
		b_l_motion_y <= b_l_motion_x;
		end
		else if(flag_b_l_90_conflict_45|| flag_b_l_60_conflict_45||flag_b_l_45_conflict_45||flag_b_l_30_conflict_45||flag_b_l_0_conflict_45
||flag_b_l_330_conflict_45||flag_b_l_315_conflict_45||flag_b_l_300_conflict_45||
flag_b_l_270_conflict_45||flag_b_l_240_conflict_45|| flag_b_l_225_conflict_45||flag_b_l_210_conflict_45|| 
flag_b_l_180_conflict_45||flag_b_l_150_conflict_45
||flag_b_l_135_conflict_45|| flag_b_l_120_conflict_45)
		begin
		b_l_motion_x <= ~b_l_motion_y+1;
		b_l_motion_y <= ~b_l_motion_x+1;		
		end
		else if(b_l_pos_y <= 5&&(b_l_motion_y>10'h003))
		begin
		b_l_motion_x <= b_l_motion_x;
		b_l_motion_y <= ~b_l_motion_y+1;
		end

		else if(b_l_pos_y+30>=480&&(b_l_motion_y<10'h004))
		begin
		b_l_motion_x <= b_l_motion_x;
		b_l_motion_y <= ~b_l_motion_y+1;
		end
	end		


end

always_ff @ (posedge frame_clk)
begin
	if(flag_b_reset == 1'b1)
	begin
		b_l_pos_x <= initial_b_l_pos_x;
		b_l_pos_y <= initial_b_l_pos_y;
	end
	
	else
	begin
		b_l_pos_x <= b_l_pos_x + b_l_motion_x;
		b_l_pos_y <= b_l_pos_y + b_l_motion_y;
	end
end

//BOUNCING AND MOTIONS FOR BULLET RIGHT
//
//
//
//
//
//
always_ff @(posedge (vga_clk))
begin

	if(flag_b_reset_r==1'b1)
	begin
		b_r_motion_x <= b_override_motion_x_r;
		b_r_motion_y <= b_override_motion_y_r;
	end

	else
	begin
		if(b_r_pos_x+40>640&&(b_r_motion_x<10'h004))
		begin
		b_r_motion_x <= (~(b_r_motion_x)+10'h001);
		b_r_motion_y <= b_r_motion_y;
		end	

		else if(b_r_pos_x<=5&&(b_r_motion_x>10'h004))
		begin
		b_r_motion_x <= (~(b_r_motion_x)+10'h001);
		b_r_motion_y <= b_r_motion_y;
		end

		else if(flag_b_r_90_conflict|| flag_b_r_60_conflict||flag_b_r_45_conflict||flag_b_r_30_conflict||flag_b_r_0_conflict
||flag_b_r_330_conflict||flag_b_r_315_conflict||flag_b_r_300_conflict||
flag_b_r_270_conflict||flag_b_r_240_conflict|| flag_b_r_225_conflict||flag_b_r_210_conflict|| 
flag_b_r_180_conflict||flag_b_r_150_conflict
||flag_b_r_135_conflict|| flag_b_r_120_conflict)
		begin
		b_r_motion_x <= b_r_motion_y;
		b_r_motion_y <= b_r_motion_x;
		end
		else if(flag_b_r_90_conflict_45|| flag_b_r_60_conflict_45||flag_b_r_45_conflict_45||flag_b_r_30_conflict_45||flag_b_r_0_conflict_45
||flag_b_r_330_conflict_45||flag_b_r_315_conflict_45||flag_b_r_300_conflict_45||
flag_b_r_270_conflict_45||flag_b_r_240_conflict_45|| flag_b_r_225_conflict_45||flag_b_r_210_conflict_45|| 
flag_b_r_180_conflict_45||flag_b_r_150_conflict_45
||flag_b_r_135_conflict_45|| flag_b_r_120_conflict_45)
		begin
		b_r_motion_x <= ~b_r_motion_y+1;
		b_r_motion_y <= ~b_r_motion_x+1;		
		end
		else if(b_r_pos_y <= 5&&(b_r_motion_y>10'h003))
		begin
		b_r_motion_x <= b_r_motion_x;
		b_r_motion_y <= ~b_r_motion_y+1;
		end

		else if(b_r_pos_y+40>=480&&(b_r_motion_y<10'h004))
		begin
		b_r_motion_x <= b_r_motion_x;
		b_r_motion_y <= ~b_r_motion_y+1;
		end
	end		


end

always_ff @ (negedge frame_clk)
begin
	if(flag_b_reset_r == 1'b1)
	begin
		b_r_pos_x <= initial_b_r_pos_x;
		b_r_pos_y <= initial_b_r_pos_y;
	end
	
	else
	begin
		b_r_pos_x <= b_r_pos_x + b_r_motion_x;
		b_r_pos_y <= b_r_pos_y + b_r_motion_y;
	end
end



always_ff @ (posedge vga_clk) begin
	if(~blank)
	begin
		red <= 4'h0;
		green <= 4'h0;
		blue <= 4'h0;
	end
	else if(flag_gameoverp1) 
	begin
		red <= palette_red_gameoverp1;
		green <= palette_green_gameoverp1;
		blue <= palette_blue_gameoverp1;
	end
	else if(flag_gameoverp2) 
	begin
		red <= palette_red_gameoverp2;
		green <= palette_green_gameoverp2;
		blue <= palette_blue_gameoverp2;
	end
	else if(flag_def_315) 
	begin
		red <= palette_red_def_315;
		green <= palette_green_def_315;
		blue <= palette_blue_def_315;
	end
	else if(flag_def_315_2) 
	begin
		red <= palette_red_def_315_2;
		green <= palette_green_def_315_2;
		blue <= palette_blue_def_315_2;
	end
	else if(flag_def_315_3) 
	begin
		red <= palette_red_def_315_3;
		green <= palette_green_def_315_3;
		blue <= palette_blue_def_315_3;
	end
	else if(flag_def_315_4) 
	begin
		red <= palette_red_def_315_4;
		green <= palette_green_def_315_4;
		blue <= palette_blue_def_315_4;
	end
	else if(flag_def_315_5) 
	begin
		red <= palette_red_def_315_5;
		green <= palette_green_def_315_5;
		blue <= palette_blue_def_315_5;
	end	
	else if(flag_def_315_6) 
	begin
		red <= palette_red_def_315_6;
		green <= palette_green_def_315_6;
		blue <= palette_blue_def_315_6;
	end
	else if(flag_def_45_1) 
	begin
		red <= palette_red_def_45_1;
		green <= palette_green_def_45_1;
		blue <= palette_blue_def_45_1;	
	end
	else if(flag_def_45_2) 
	begin
		red <= palette_red_def_45_2;
		green <= palette_green_def_45_2;
		blue <= palette_blue_def_45_2;
	end
	else if(flag_b_l_0&& ~flag_b_reset&& (palette_red_b_l_0 !=4'hF && palette_green_b_l_0 !=4'hF && palette_blue_b_l_0 != 4'hF)) 
	begin
		red <= palette_red_b_l_0;
		green <= palette_green_b_l_0;
		blue <= palette_blue_b_l_0;
	end
	else if(flag_b_l_30&& ~flag_b_reset&& (palette_red_b_l_30 !=4'hF && palette_green_b_l_30 !=4'hF && palette_blue_b_l_30 != 4'hF)) 
	begin
		red <= palette_red_b_l_30;
		green <= palette_green_b_l_30;
		blue <= palette_blue_b_l_30;
	end
	else if(flag_b_l_45&& ~flag_b_reset && (palette_red_b_l_45 !=4'hF && palette_green_b_l_45 !=4'hF && palette_blue_b_l_45 != 4'hF)) 
	begin
		red <= palette_red_b_l_45;
		green <= palette_green_b_l_45;
		blue <= palette_blue_b_l_45;
	end
	else if(flag_b_l_60&&(palette_red_b_l_60 !=4'hF && palette_green_b_l_60 !=4'hF && palette_blue_b_l_60 != 4'hF)&& ~flag_b_reset) 
	begin
		red <= palette_red_b_l_60;
		green <= palette_green_b_l_60;
		blue <= palette_blue_b_l_60;
	end
	else if(flag_b_l_90&& ~flag_b_reset&& (palette_red_b_l_90 !=4'hF && palette_green_b_l_90 !=4'hF && palette_blue_b_l_90 != 4'hF)) 
	begin
		red <= palette_red_b_l_90;
		green <= palette_green_b_l_90;
		blue <= palette_blue_b_l_90;
	end
	else if(flag_b_l_120&&(palette_red_b_l_120 !=4'hF && palette_green_b_l_120 !=4'hF && palette_blue_b_l_120 != 4'hF)&& ~flag_b_reset) 
	begin
		red <= palette_red_b_l_120;
		green <= palette_green_b_l_120;
		blue <= palette_blue_b_l_120;
	end
	else if(flag_b_l_135&&(palette_red_b_l_135 !=4'hF && palette_green_b_l_135 !=4'hF && palette_blue_b_l_135 != 4'hF)&& ~flag_b_reset) 
	begin
		red <= palette_red_b_l_135;
		green <= palette_green_b_l_135;
		blue <= palette_blue_b_l_135;
	end
	else if(flag_b_l_150&&(palette_red_b_l_150 !=4'hF && palette_green_b_l_150 !=4'hF && palette_blue_b_l_150 != 4'hF)&& ~flag_b_reset) 
	begin
		red <= palette_red_b_l_150;
		green <= palette_green_b_l_150;
		blue <= palette_blue_b_l_150;
	end
	else if(flag_b_l_180&&(palette_red_b_l_180 !=4'hF && palette_green_b_l_180 !=4'hF && palette_blue_b_l_180 != 4'hF)&& ~flag_b_reset) 
	begin
		red <= palette_red_b_l_180;
		green <= palette_green_b_l_180;
		blue <= palette_blue_b_l_180;
	end
	else if(flag_b_l_210&&(palette_red_b_l_210 !=4'hF && palette_green_b_l_210 !=4'hF && palette_blue_b_l_210 != 4'hF)&& ~flag_b_reset) 
	begin
		red <= palette_red_b_l_210;
		green <= palette_green_b_l_210;
		blue <= palette_blue_b_l_210;
	end
		else if(flag_b_l_225&&(palette_red_b_l_225 !=4'hF && palette_green_b_l_225 !=4'hF && palette_blue_b_l_225 != 4'hF)&& ~flag_b_reset) 
	begin
		red <= palette_red_b_l_225;
		green <= palette_green_b_l_225;
		blue <= palette_blue_b_l_225;
	end
	else if(flag_b_l_240&&(palette_red_b_l_240 !=4'hF && palette_green_b_l_240 !=4'hF && palette_blue_b_l_240 != 4'hF)&& ~flag_b_reset) 
	begin
		red <= palette_red_b_l_240;
		green <= palette_green_b_l_240;
		blue <= palette_blue_b_l_240;
	end
	else if(flag_b_l_270&&(palette_red_b_l_270 !=4'hF && palette_green_b_l_270 !=4'hF && palette_blue_b_l_270 != 4'hF)&& ~flag_b_reset) 
	begin
		red <= palette_red_b_l_270;
		green <= palette_green_b_l_270;
		blue <= palette_blue_b_l_270;
	end
	else if(flag_b_l_300&&(palette_red_b_l_300 !=4'hF && palette_green_b_l_300 !=4'hF && palette_blue_b_l_300 != 4'hF)&& ~flag_b_reset) 
	begin
		red <= palette_red_b_l_300;
		green <= palette_green_b_l_300;
		blue <= palette_blue_b_l_300;
	end
	else if(flag_b_l_315&&(palette_red_b_l_315 !=4'hF && palette_green_b_l_315 !=4'hF && palette_blue_b_l_315 != 4'hF)&& ~flag_b_reset) 
	begin
		red <= palette_red_b_l_315;
		green <= palette_green_b_l_315;
		blue <= palette_blue_b_l_315;
	end
	else if(flag_b_l_330&&(palette_red_b_l_330 !=4'hF && palette_green_b_l_330 !=4'hF && palette_blue_b_l_330 != 4'hF)&& ~flag_b_reset) 
	begin
		red <= palette_red_b_l_330;
		green <= palette_green_b_l_330;
		blue <= palette_blue_b_l_330;
	end
	else if(flag_b_r_0&&(palette_red_b_r_0 !=4'hF && palette_green_b_r_0 !=4'hF && palette_blue_b_r_0 != 4'hF)&& ~flag_b_reset_r) //start of drawing right bullet sprites
	begin
		red <= palette_red_b_r_0;
		green <= palette_green_b_r_0;
		blue <= palette_blue_b_r_0;
	end
	else if(flag_b_r_30&&(palette_red_b_r_30 !=4'hF && palette_green_b_r_30 !=4'hF && palette_blue_b_r_30 != 4'hF)&& ~flag_b_reset_r) 
	begin
		red <= palette_red_b_r_30;
		green <= palette_green_b_r_30;
		blue <= palette_blue_b_r_30;
	end
	else if(flag_b_r_45&&(palette_red_b_r_45 !=4'hF && palette_green_b_r_45 !=4'hF && palette_blue_b_r_45 != 4'hF)&& ~flag_b_reset_r) 
	begin
		red <= palette_red_b_r_45;
		green <= palette_green_b_r_45;
		blue <= palette_blue_b_r_45;
	end
	else if(flag_b_r_60&&(palette_red_b_r_60 !=4'hF && palette_green_b_r_60 !=4'hF && palette_blue_b_r_60 != 4'hF)&& ~flag_b_reset_r) 
	begin
		red <= palette_red_b_r_60;
		green <= palette_green_b_r_60;
		blue <= palette_blue_b_r_60;
	end
	else if(flag_b_r_90&&(palette_red_b_r_90 !=4'hF && palette_green_b_r_90 !=4'hF && palette_blue_b_r_90 != 4'hF)&& ~flag_b_reset_r) 
	begin
		red <= palette_red_b_r_90;
		green <= palette_green_b_r_90;
		blue <= palette_blue_b_r_90;
	end
	else if(flag_b_r_120&&(palette_red_b_r_120 !=4'hF && palette_green_b_r_120 !=4'hF && palette_blue_b_r_120 != 4'hF)&& ~flag_b_reset_r) 
	begin
		red <= palette_red_b_r_120;
		green <= palette_green_b_r_120;
		blue <= palette_blue_b_r_120;
	end
	else if(flag_b_r_135&&(palette_red_b_r_135 !=4'hF && palette_green_b_r_135 !=4'hF && palette_blue_b_r_135 != 4'hF)&& ~flag_b_reset_r) 
	begin
		red <= palette_red_b_r_135;
		green <= palette_green_b_r_135;
		blue <= palette_blue_b_r_135;
	end
	else if(flag_b_r_150&&(palette_red_b_r_150 !=4'hF && palette_green_b_r_150 !=4'hF && palette_blue_b_r_150 != 4'hF)&& ~flag_b_reset_r) 
	begin
		red <= palette_red_b_r_150;
		green <= palette_green_b_r_150;
		blue <= palette_blue_b_r_150;
	end
	else if(flag_b_r_180&&(palette_red_b_r_180 !=4'hF && palette_green_b_r_180 !=4'hF && palette_blue_b_r_180 != 4'hF)&& ~flag_b_reset_r) 
	begin
		red <= palette_red_b_r_180;
		green <= palette_green_b_r_180;
		blue <= palette_blue_b_r_180;
	end
	else if(flag_b_r_210&&(palette_red_b_r_210 !=4'hF && palette_green_b_r_210 !=4'hF && palette_blue_b_r_210 != 4'hF)&& ~flag_b_reset_r) 
	begin
		red <= palette_red_b_r_210;
		green <= palette_green_b_r_210;
		blue <= palette_blue_b_r_210;
	end
		else if(flag_b_r_225&&(palette_red_b_r_225 !=4'hF && palette_green_b_r_225 !=4'hF && palette_blue_b_r_225 != 4'hF)&& ~flag_b_reset_r) 
	begin
		red <= palette_red_b_r_225;
		green <= palette_green_b_r_225;
		blue <= palette_blue_b_r_225;
	end
	else if(flag_b_r_240&&(palette_red_b_r_240 !=4'hF && palette_green_b_r_240 !=4'hF && palette_blue_b_r_240 != 4'hF)&& ~flag_b_reset_r) 
	begin
		red <= palette_red_b_r_240;
		green <= palette_green_b_r_240;
		blue <= palette_blue_b_r_240;
	end
	else if(flag_b_r_270&&(palette_red_b_r_270 !=4'hF && palette_green_b_r_270 !=4'hF && palette_blue_b_r_270 != 4'hF)&& ~flag_b_reset_r) 
	begin
		red <= palette_red_b_r_270;
		green <= palette_green_b_r_270;
		blue <= palette_blue_b_r_270;
	end
	else if(flag_b_r_300&&(palette_red_b_r_300 !=4'hF && palette_green_b_r_300 !=4'hF && palette_blue_b_r_300 != 4'hF)&& ~flag_b_reset_r) 
	begin
		red <= palette_red_b_r_300;
		green <= palette_green_b_r_300;
		blue <= palette_blue_b_r_300;
	end
	else if(flag_b_r_315&&(palette_red_b_r_315 !=4'hF && palette_green_b_r_315 !=4'hF && palette_blue_b_r_315 != 4'hF)&& ~flag_b_reset_r) 
	begin
		red <= palette_red_b_r_315;
		green <= palette_green_b_r_315;
		blue <= palette_blue_b_r_315;
	end
	else if(flag_b_r_330&&(palette_red_b_r_330 !=4'hF && palette_green_b_r_330 !=4'hF && palette_blue_b_r_330 != 4'hF)&& ~flag_b_reset_r) 
	begin
		red <= palette_red_b_r_330;
		green <= palette_green_b_r_330;
		blue <= palette_blue_b_r_330;
	end	
	
	else if (flag_d) 
	begin
	if(palette_red_dog == 4'hC && palette_green_dog == 4'h2 && palette_blue_dog == 4'hA)
	begin
	end
	else
	begin
		red <= palette_red_dog;
		green <= palette_green_dog;
		blue <= palette_blue_dog;
	end
	end
	else if (flag_p)
	begin
	if(palette_red_peng == 4'hD && palette_green_peng == 4'h3 && palette_blue_peng == 4'hC)
	begin
	end
	else
	begin
		red <= palette_red_peng;
		green <= palette_green_peng;
		blue <= palette_blue_peng;
	end
	end
	else if (flag_t_l_0&&(palette_red_t_l_0 !=4'hF && palette_green_t_l_0 !=4'h0 && palette_blue_t_l_0 != 4'hF))
	begin
		red <= palette_red_t_l_0;
		green <= palette_green_t_l_0;
		blue <= palette_blue_t_l_0;
	end
	else if (flag_t_l_30&&(palette_red_t_l_30 !=4'hF && palette_green_t_l_30 !=4'h0 && palette_blue_t_l_30 != 4'hF))
	begin
		red <= palette_red_t_l_30;
		green <= palette_green_t_l_30;
		blue <= palette_blue_t_l_30;
	end
	else if (flag_t_l_45&&(palette_red_t_l_45 !=4'hF && palette_green_t_l_45 !=4'h0 && palette_blue_t_l_45 != 4'hF))
	begin
		red <= palette_red_t_l_45;
		green <= palette_green_t_l_45;
		blue <= palette_blue_t_l_45;
	end
	else if (flag_t_l_60&&(palette_red_t_l_60 !=4'hF && palette_green_t_l_60 !=4'h0 && palette_blue_t_l_60 != 4'hF))
	begin
		red <= palette_red_t_l_60;
		green <= palette_green_t_l_60;
		blue <= palette_blue_t_l_60;
	end
	else if (flag_t_l_90&&(palette_red_t_l_90 !=4'hF && palette_green_t_l_90 !=4'h0 && palette_blue_t_l_90 != 4'hF))
	begin
		red <= palette_red_t_l_90;
		green <= palette_green_t_l_90;
		blue <= palette_blue_t_l_90;
	end
	else if (flag_t_l_270&&(palette_red_t_l_270 !=4'hF && palette_green_t_l_270 !=4'h0 && palette_blue_t_l_270 != 4'hF))
	begin
		red <= palette_red_t_l_270;
		green <= palette_green_t_l_270;
		blue <= palette_blue_t_l_270;
	end
	else if (flag_t_l_300&&(palette_red_t_l_300 !=4'hF && palette_green_t_l_300 !=4'h0 && palette_blue_t_l_300 != 4'hF))
	begin
		red <= palette_red_t_l_300;
		green <= palette_green_t_l_300;
		blue <= palette_blue_t_l_300;
	end
	else if (flag_t_l_315&&(palette_red_t_l_315 !=4'hF && palette_green_t_l_315 !=4'h0 && palette_blue_t_l_315 != 4'hF))
	begin
		red <= palette_red_t_l_315;
		green <= palette_green_t_l_315;
		blue <= palette_blue_t_l_315;
	end
	else if (flag_t_l_330&&(palette_red_t_l_330 !=4'hF && palette_green_t_l_330 !=4'h0 && palette_blue_t_l_330 != 4'hF))
	begin
		red <= palette_red_t_l_330;
		green <= palette_green_t_l_330;
		blue <= palette_blue_t_l_330;
	end
	
	
	
	else if(flag_t_r_180&&(palette_red_t_r_180 !=4'hF && palette_green_t_r_180 !=4'h0 && palette_blue_t_r_180 != 4'hF))
	begin
		red <= palette_red_t_r_180;
		green <= palette_green_t_r_180;
		blue <= palette_blue_t_r_180;
	end
	else if (flag_t_r_120&&(palette_red_t_r_120 !=4'hF && palette_green_t_r_120 !=4'h0 && palette_blue_t_r_120 != 4'hF))
	begin
		red <= palette_red_t_r_120;
		green <= palette_green_t_r_120;
		blue <= palette_blue_t_r_120;
	end
	else if (flag_t_r_135&&(palette_red_t_r_135 !=4'hF && palette_green_t_r_135 !=4'h0 && palette_blue_t_r_135 != 4'hF))
	begin
		red <= palette_red_t_r_135;
		green <= palette_green_t_r_135;
		blue <= palette_blue_t_r_135;
	end
	else if (flag_t_r_150&&(palette_red_t_r_150 !=4'hF && palette_green_t_r_150 !=4'h0 && palette_blue_t_r_150 != 4'hF))
	begin
		red <= palette_red_t_r_150;
		green <= palette_green_t_r_150;
		blue <= palette_blue_t_r_150;
	end
	else if (flag_t_r_90&&(palette_red_t_r_90 !=4'hF && palette_green_t_r_90 !=4'h0 && palette_blue_t_r_90 != 4'hF))
	begin
		red <= palette_red_t_r_90;
		green <= palette_green_t_r_90;
		blue <= palette_blue_t_r_90;
	end
	else if (flag_t_r_270&&(palette_red_t_r_270 !=4'hF && palette_green_t_r_270 !=4'h0 && palette_blue_t_r_270 != 4'hF))
	begin
		red <= palette_red_t_r_270;
		green <= palette_green_t_r_270;
		blue <= palette_blue_t_r_270;
	end
	else if (flag_t_r_210&&(palette_red_t_r_210 !=4'hF && palette_green_t_r_210 !=4'h0 && palette_blue_t_r_210 != 4'hF))
	begin
		red <= palette_red_t_r_210;
		green <= palette_green_t_r_210;
		blue <= palette_blue_t_r_210;
	end
	else if (flag_t_r_225&&(palette_red_t_r_225 !=4'hF && palette_green_t_r_225 !=4'h0 && palette_blue_t_r_225 != 4'hF))
	begin
		red <= palette_red_t_r_225;
		green <= palette_green_t_r_225;
		blue <= palette_blue_t_r_225;
	end
	else if (flag_t_r_240&&(palette_red_t_r_240 !=4'hF && palette_green_t_r_240 !=4'h0 && palette_blue_t_r_240 != 4'hF))
	begin
		red <= palette_red_t_r_240;
		green <= palette_green_t_r_240;
		blue <= palette_blue_t_r_240;
	end
	else
	begin
		red <= (palette_red_s);
		green <= (palette_green_s);
		blue <= palette_blue_s;
	end
end


//roms and palettes for various sprites
turret_0_rom turret_0_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_t_l_0),
	.q       (rom_q_t_l)
);

turret_0_palette turret_0_palette (
	.index (rom_q_t_l),
	.red   (palette_red_t_l_0),
	.green (palette_green_t_l_0),
	.blue  (palette_blue_t_l_0)
);
dogactualfinal_rom dogactualfinal_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_dog),
	.q       (rom_q_d)
);

dogactualfinal_palette dogactualfinal_palette (
	.index (rom_q_d),
	.red   (palette_red_dog),
	.green (palette_green_dog),
	.blue  (palette_blue_dog)
);

penguin_final_rom penguin_final_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_peng),
	.q       (rom_q_p)
);

penguin_final_palette penguin_final_palette (
	.index (rom_q_p),
	.red   (palette_red_peng),
	.green (palette_green_peng),
	.blue  (palette_blue_peng)
);

//turret_180_rom turret_180_rom (
//	.clock   (negedge_vga_clk),
//	.address (rom_address_t_r_180),
//	.q       (rom_q_t_r_180)
//);
//
//turret_180_palette turret_180_palette (
//	.index (rom_q_t_r_180),
//	.red   (palette_red_t_r_180),
//	.green (palette_green_t_r_180),
//	.blue  (palette_blue_t_r_180)
//);


deflector_rom deflector_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_def_315),
	.q       (rom_q_def_315)
);

deflector_palette deflector_palette (
	.index (rom_q_def_315),
	.red   (palette_red_def_315),
	.green (palette_green_def_315),
	.blue  (palette_blue_def_315)
);

deflector_rom deflector_rom_2 (
	.clock   (negedge_vga_clk),
	.address (rom_address_def_315_2),
	.q       (rom_q_def_315_2)
);

deflector_palette deflector_palette_2 (
	.index (rom_q_def_315_2),
	.red   (palette_red_def_315_2),
	.green (palette_green_def_315_2),
	.blue  (palette_blue_def_315_2)
);

deflector_rom deflector_rom_3 (
	.clock   (negedge_vga_clk),
	.address (rom_address_def_315_3),
	.q       (rom_q_def_315_3)
);

deflector_palette deflector_palette_3 (
	.index (rom_q_def_315_3),
	.red   (palette_red_def_315_3),
	.green (palette_green_def_315_3),
	.blue  (palette_blue_def_315_3)
);

deflector_rom deflector_rom_4 (
	.clock   (negedge_vga_clk),
	.address (rom_address_def_315_4),
	.q       (rom_q_def_315_4)
);

deflector_palette deflector_palette_4 (
	.index (rom_q_def_315_4),
	.red   (palette_red_def_315_4),
	.green (palette_green_def_315_4),
	.blue  (palette_blue_def_315_4)
);

deflector_rom deflector_rom_5 (
	.clock   (negedge_vga_clk),
	.address (rom_address_def_315_5),
	.q       (rom_q_def_315_5)
);

deflector_palette deflector_palette_5 (
	.index (rom_q_def_315_5),
	.red   (palette_red_def_315_5),
	.green (palette_green_def_315_5),
	.blue  (palette_blue_def_315_5)
);
deflector_rom deflector_rom_6 (
	.clock   (negedge_vga_clk),
	.address (rom_address_def_315_6),
	.q       (rom_q_def_315_6)
);

deflector_palette deflector_palette_6 (
	.index (rom_q_def_315_6),
	.red   (palette_red_def_315_6),
	.green (palette_green_def_315_6),
	.blue  (palette_blue_def_315_6)
);
//deflector_120_rom deflector_120_rom (
//	.clock   (vga_clk),
//	.address (rom_address_def_315),
//	.q       (rom_q_def_315),
//	.address2(rom_address_detect),
//	.q2(rom_q_detect)
//);
//
//deflector_120_palette deflector_120_palette (
//	.index (rom_q_def_315),
//	.index2 (rom_q_detect),
//	.red   (palette_red_def_315),
//	.green (palette_green_def_315),
//	.blue  (palette_blue_def_315),
//	.red2(palette_red_detect),
//	.green2(palette_green_detect),
//	.blue2(palette_blue_detect)
//);


starrynight_rom starrynight_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_s),
	.q       (rom_q_s)
);

starrynight_palette starrynight_palette (
	.index (rom_q_s),
	.red   (palette_red_s),
	.green (palette_green_s),
	.blue  (palette_blue_s)
);


projectile_0_rom projectile_0_rom ( //0
	.clock   (negedge_vga_clk),
	.address (rom_address_b_l_0),
	.q       (rom_q_b_l_0)
);

projectile_0_palette projectile_0_palette (
	.index (rom_q_b_l_0),
	.red   (palette_red_b_l_0),
	.green (palette_green_b_l_0),
	.blue  (palette_blue_b_l_0)
);

projectile_30jpg_rom projectile_30jpg_rom ( //30
	.clock   (negedge_vga_clk),
	.address (rom_address_b_l_30),
	.q       (rom_q_b_l_30)
);

projectile_30jpg_palette projectile_30jpg_palette ( 
	.index (rom_q_b_l_30),
	.red   (palette_red_b_l_30),
	.green (palette_green_b_l_30),
	.blue  (palette_blue_b_l_30)
);

projectile_45_rom projectile_45_rom ( //45
	.clock   (negedge_vga_clk),
	.address (rom_address_b_l_45),
	.q       (rom_q_b_l_45)
);

projectile_45_palette projectile_45_palette (
	.index (rom_q_b_l_45),
	.red   (palette_red_b_l_45),
	.green (palette_green_b_l_45),
	.blue  (palette_blue_b_l_45)
);
 
projectile_60_rom projectile_60_rom ( //60
	.clock   (negedge_vga_clk),
	.address (rom_address_b_l_60),
	.q       (rom_q_b_l_60)
);

projectile_60_palette projectile_60_palette (
	.index (rom_q_b_l_60),
	.red   (palette_red_b_l_60),
	.green (palette_green_b_l_60),
	.blue  (palette_blue_b_l_60)
);


projectile_90_rom projectile_90_rom ( //90
	.clock   (negedge_vga_clk),
	.address (rom_address_b_l_90),
	.q       (rom_q_b_l_90)
);

projectile_90_palette projectile_90_palette ( 
	.index (rom_q_b_l_90),
	.red   (palette_red_b_l_90),
	.green (palette_green_b_l_90),
	.blue  (palette_blue_b_l_90)
);


projectile_120_rom projectile_120_rom ( //120
	.clock   (negedge_vga_clk),
	.address (rom_address_b_l_120),
	.q       (rom_q_b_l_120)
);

projectile_120_palette projectile_120_palette (
	.index (rom_q_b_l_120),
	.red   (palette_red_b_l_120),
	.green (palette_green_b_l_120),
	.blue  (palette_blue_b_l_120)
);


projectile_135_rom projectile_135_rom ( //135
	.clock   (negedge_vga_clk),
	.address (rom_address_b_l_135),
	.q       (rom_q_b_l_135)
);

projectile_135_palette projectile_135_palette (
	.index (rom_q_b_l_135),
	.red   (palette_red_b_l_135),
	.green (palette_green_b_l_135),
	.blue  (palette_blue_b_l_135)
);

projectile_150_rom projectile_150_rom ( //150
	.clock   (negedge_vga_clk),
	.address (rom_address_b_l_150),
	.q       (rom_q_b_l_150)
);

projectile_150_palette projectile_150_palette (
	.index (rom_q_b_l_150),
	.red   (palette_red_b_l_150),
	.green (palette_green_b_l_150),
	.blue  (palette_blue_b_l_150)
);

projectile_180_rom projectile_180_rom ( //180
	.clock   (negedge_vga_clk),
	.address (rom_address_b_l_180),
	.q       (rom_q_b_l_180)
);

projectile_180_palette projectile_180_palette (
	.index (rom_q_b_l_180),
	.red   (palette_red_b_l_180),
	.green (palette_green_b_l_180),
	.blue  (palette_blue_b_l_180)
);

projectile_210_rom projectile_210_rom ( //210
	.clock   (negedge_vga_clk),
	.address (rom_address_b_l_210),
	.q       (rom_q_b_l_210)
);

projectile_210_palette projectile_210_palette (
	.index (rom_q_b_l_210),
	.red   (palette_red_b_l_210),
	.green (palette_green_b_l_210),
	.blue  (palette_blue_b_l_210)
);


projectile_225_rom projectile_225_rom ( //225
	.clock   (negedge_vga_clk),
	.address (rom_address_b_l_225),
	.q       (rom_q_b_l_225)
);

projectile_225_palette projectile_225_palette (
	.index (rom_q_b_l_225),
	.red   (palette_red_b_l_225),
	.green (palette_green_b_l_225),
	.blue  (palette_blue_b_l_225)
);


projectile_240_rom projectile_240_rom ( //240
	.clock   (negedge_vga_clk),
	.address (rom_address_b_l_240),
	.q       (rom_q_b_l_240)
);

projectile_240_palette projectile_240_palette (
	.index (rom_q_b_l_240),
	.red   (palette_red_b_l_240),
	.green (palette_green_b_l_240),
	.blue  (palette_blue_b_l_240)
);


projectile_270_rom projectile_270_rom ( //270
	.clock   (negedge_vga_clk),
	.address (rom_address_b_l_270),
	.q       (rom_q_b_l_270)
);

projectile_270_palette projectile_270_palette (
	.index (rom_q_b_l_270),
	.red   (palette_red_b_l_270),
	.green (palette_green_b_l_270),
	.blue  (palette_blue_b_l_270)
);

projectile_300_rom projectile_300_rom ( //300
	.clock   (negedge_vga_clk),
	.address (rom_address_b_l_300),
	.q       (rom_q_b_l_300)
);

projectile_300_palette projectile_300_palette (
	.index (rom_q_b_l_300),
	.red   (palette_red_b_l_300),
	.green (palette_green_b_l_300),
	.blue  (palette_blue_b_l_300)
);

projectile_315_rom projectile_315_rom ( //315
	.clock   (negedge_vga_clk),
	.address (rom_address_b_l_315),
	.q       (rom_q_b_l_315)
);

projectile_315_palette projectile_315_palette (
	.index (rom_q_b_l_315),
	.red   (palette_red_b_l_315),
	.green (palette_green_b_l_315),
	.blue  (palette_blue_b_l_315)
);
 
projectile_330_rom projectile_330_rom ( //330
	.clock   (negedge_vga_clk),
	.address (rom_address_b_l_330),
	.q       (rom_q_b_l_330)
);

projectile_330_palette projectile_330_palette (
	.index (rom_q_b_l_330),
	.red   (palette_red_b_l_330),
	.green (palette_green_b_l_330),
	.blue  (palette_blue_b_l_330)
);
//RIGHT SIDE BULLETS START 
//
//
//
//
//
//
projectile_0_rom projectile_0_rom_r ( //0
	.clock   (negedge_vga_clk),
	.address (rom_address_b_r_0),
	.q       (rom_q_b_r_0)
);

projectile_0_palette projectile_0_palette_r (
	.index (rom_q_b_r_0),
	.red   (palette_red_b_r_0),
	.green (palette_green_b_r_0),
	.blue  (palette_blue_b_r_0)
);

projectile_30jpg_rom projectile_30jpg_rom_r ( //30
	.clock   (negedge_vga_clk),
	.address (rom_address_b_r_30),
	.q       (rom_q_b_r_30)
);

projectile_30jpg_palette projectile_30jpg_palette_r ( 
	.index (rom_q_b_r_30),
	.red   (palette_red_b_r_30),
	.green (palette_green_b_r_30),
	.blue  (palette_blue_b_r_30)
);

projectile_45_rom projectile_45_rom_r ( //45
	.clock   (negedge_vga_clk),
	.address (rom_address_b_r_45),
	.q       (rom_q_b_r_45)
);

projectile_45_palette projectile_45_palette_r (
	.index (rom_q_b_r_45),
	.red   (palette_red_b_r_45),
	.green (palette_green_b_r_45),
	.blue  (palette_blue_b_r_45)
);
 
projectile_60_rom projectile_60_rom_r ( //60
	.clock   (negedge_vga_clk),
	.address (rom_address_b_r_60),
	.q       (rom_q_b_r_60)
);

projectile_60_palette projectile_60_palette_r (
	.index (rom_q_b_r_60),
	.red   (palette_red_b_r_60),
	.green (palette_green_b_r_60),
	.blue  (palette_blue_b_r_60)
);


projectile_90_rom projectile_90_rom_r ( //90
	.clock   (negedge_vga_clk),
	.address (rom_address_b_r_90),
	.q       (rom_q_b_r_90)
);

projectile_90_palette projectile_90_palette_r ( 
	.index (rom_q_b_r_90),
	.red   (palette_red_b_r_90),
	.green (palette_green_b_r_90),
	.blue  (palette_blue_b_r_90)
);


projectile_120_rom projectile_120_rom_r ( //120
	.clock   (negedge_vga_clk),
	.address (rom_address_b_r_120),
	.q       (rom_q_b_r_120)
);

projectile_120_palette projectile_120_palette_r (
	.index (rom_q_b_r_120),
	.red   (palette_red_b_r_120),
	.green (palette_green_b_r_120),
	.blue  (palette_blue_b_r_120)
);


projectile_135_rom projectile_135_rom_r ( //135
	.clock   (negedge_vga_clk),
	.address (rom_address_b_r_135),
	.q       (rom_q_b_r_135)
);

projectile_135_palette projectile_135_palette_r (
	.index (rom_q_b_r_135),
	.red   (palette_red_b_r_135),
	.green (palette_green_b_r_135),
	.blue  (palette_blue_b_r_135)
);

projectile_150_rom projectile_150_rom_r ( //150
	.clock   (negedge_vga_clk),
	.address (rom_address_b_r_150),
	.q       (rom_q_b_r_150)
);

projectile_150_palette projectile_150_palette_r (
	.index (rom_q_b_r_150),
	.red   (palette_red_b_r_150),
	.green (palette_green_b_r_150),
	.blue  (palette_blue_b_r_150)
);

projectile_180_rom projectile_180_rom_r ( //180
	.clock   (negedge_vga_clk),
	.address (rom_address_b_r_180),
	.q       (rom_q_b_r_180)
);

projectile_180_palette projectile_180_palette_r (
	.index (rom_q_b_r_180),
	.red   (palette_red_b_r_180),
	.green (palette_green_b_r_180),
	.blue  (palette_blue_b_r_180)
);

projectile_210_rom projectile_210_rom_r ( //210
	.clock   (negedge_vga_clk),
	.address (rom_address_b_r_210),
	.q       (rom_q_b_r_210)
);

projectile_210_palette projectile_210_palette_r (
	.index (rom_q_b_r_210),
	.red   (palette_red_b_r_210),
	.green (palette_green_b_r_210),
	.blue  (palette_blue_b_r_210)
);


projectile_225_rom projectile_225_rom_r ( //225
	.clock   (negedge_vga_clk),
	.address (rom_address_b_r_225),
	.q       (rom_q_b_r_225)
);

projectile_225_palette projectile_225_palette_r (
	.index (rom_q_b_r_225),
	.red   (palette_red_b_r_225),
	.green (palette_green_b_r_225),
	.blue  (palette_blue_b_r_225)
);


projectile_240_rom projectile_240_rom_r ( //240
	.clock   (negedge_vga_clk),
	.address (rom_address_b_r_240),
	.q       (rom_q_b_r_240)
);

projectile_240_palette projectile_240_palette_r (
	.index (rom_q_b_r_240),
	.red   (palette_red_b_r_240),
	.green (palette_green_b_r_240),
	.blue  (palette_blue_b_r_240)
);


projectile_270_rom projectile_270_rom_r ( //270
	.clock   (negedge_vga_clk),
	.address (rom_address_b_r_270),
	.q       (rom_q_b_r_270)
);

projectile_270_palette projectile_270_palette_r (
	.index (rom_q_b_r_270),
	.red   (palette_red_b_r_270),
	.green (palette_green_b_r_270),
	.blue  (palette_blue_b_r_270)
);

projectile_300_rom projectile_300_rom_r ( //300
	.clock   (negedge_vga_clk),
	.address (rom_address_b_r_300),
	.q       (rom_q_b_r_300)
);

projectile_300_palette projectile_300_palette_r (
	.index (rom_q_b_r_300),
	.red   (palette_red_b_r_300),
	.green (palette_green_b_r_300),
	.blue  (palette_blue_b_r_300)
);

projectile_315_rom projectile_315_rom_r ( //315
	.clock   (negedge_vga_clk),
	.address (rom_address_b_r_315),
	.q       (rom_q_b_r_315)
);

projectile_315_palette projectile_315_palette_r (
	.index (rom_q_b_r_315),
	.red   (palette_red_b_r_315),
	.green (palette_green_b_r_315),
	.blue  (palette_blue_b_r_315)
);
 
projectile_330_rom projectile_330_rom_r ( //330
	.clock   (negedge_vga_clk),
	.address (rom_address_b_r_330),
	.q       (rom_q_b_r_330)
);

projectile_330_palette projectile_330_palette_r (
	.index (rom_q_b_r_330),
	.red   (palette_red_b_r_330),
	.green (palette_green_b_r_330),
	.blue  (palette_blue_b_r_330)
);
// TURRET LEFT DRAWING START
//
//
//
//
turret_30_rom turret_30_rom ( //TURRET 30
	.clock   (negedge_vga_clk),
	.address (rom_address_t_l_30),
	.q       (rom_q_t_l_30)
);

turret_30_palette turret_30_palette (
	.index (rom_q_t_l_30),
	.red   (palette_red_t_l_30),
	.green (palette_green_t_l_30),
	.blue  (palette_blue_t_l_30)
);

turret_45_rom turret_45_rom ( //TURRET 45
	.clock   (negedge_vga_clk),
	.address (rom_address_t_l_45),
	.q       (rom_q_t_l_45)
);

turret_45_palette turret_45_palette (
	.index (rom_q_t_l_45),
	.red   (palette_red_t_l_45),
	.green (palette_green_t_l_45),
	.blue  (palette_blue_t_l_45)
);


turret_60_rom turret_60_rom ( //TURRET 60
	.clock   (negedge_vga_clk),
	.address (rom_address_t_l_60),
	.q       (rom_q_t_l_60)
);

turret_60_palette turret_60_palette (
	.index (rom_q_t_l_60),
	.red   (palette_red_t_l_60),
	.green (palette_green_t_l_60),
	.blue  (palette_blue_t_l_60)
);

turret_90_rom turret_90_rom ( //TURRET 90
	.clock   (negedge_vga_clk),
	.address (rom_address_t_l_90),
	.q       (rom_q_t_l_90)
);

turret_90_palette turret_90_palette (
	.index (rom_q_t_l_90),
	.red   (palette_red_t_l_90),
	.green (palette_green_t_l_90),
	.blue  (palette_blue_t_l_90)
);
turret_330_rom turret_330_rom ( //TURRET 330
	.clock   (negedge_vga_clk),
	.address (rom_address_t_l_330),
	.q       (rom_q_t_l_330)
);

turret_330_palette turret_330_palette ( 
	.index (rom_q_t_l_330),
	.red   (palette_red_t_l_330),
	.green (palette_green_t_l_330),
	.blue  (palette_blue_t_l_330)
);


turret_315_rom turret_315_rom ( //TURRET 315
	.clock   (negedge_vga_clk),
	.address (rom_address_t_l_315),
	.q       (rom_q_t_l_315)
);

turret_315_palette turret_315_palette (
	.index (rom_q_t_l_315),
	.red   (palette_red_t_l_315),
	.green (palette_green_t_l_315),
	.blue  (palette_blue_t_l_315)
);

turret_300_rom turret_300_rom ( //TURRET 300
	.clock   (negedge_vga_clk),
	.address (rom_address_t_l_300),
	.q       (rom_q_t_l_300)
);

turret_300_palette turret_300_palette (
	.index (rom_q_t_l_300),
	.red   (palette_red_t_l_300),
	.green (palette_green_t_l_300),
	.blue  (palette_blue_t_l_300)
);


turret_270_rom turret_270_rom ( //TURRET 270
	.clock   (negedge_vga_clk),
	.address (rom_address_t_l_270),
	.q       (rom_q_t_l_270)
);

turret_270_palette turret_270_palette (
	.index (rom_q_t_l_270),
	.red   (palette_red_t_l_270),
	.green (palette_green_t_l_270),
	.blue  (palette_blue_t_l_270)
);
//TURRET RIGHT DRAWING START
//
//
//
turret_90_r_rom turret_90_r_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_t_r_90),
	.q       (rom_q_t_r_90)
);

turret_90_r_palette turret_90_r_palette (
	.index (rom_q_t_r_90),
	.red   (palette_red_t_r_90),
	.green (palette_green_t_r_90),
	.blue  (palette_blue_t_r_90)
);
turret_120_r_rom turret_120_r_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_t_r_120),
	.q       (rom_q_t_r_120)
);

turret_120_r_palette turret_120_r_palette (
	.index (rom_q_t_r_120),
	.red   (palette_red_t_r_120),
	.green (palette_green_t_r_120),
	.blue  (palette_blue_t_r_120)
);
turret_135_r_rom turret_135_r_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_t_r_135),
	.q       (rom_q_t_r_135)
);

turret_135_r_palette turret_135_r_palette (
	.index (rom_q_t_r_135),
	.red   (palette_red_t_r_135),
	.green (palette_green_t_r_135),
	.blue  (palette_blue_t_r_135)
);


turret_150_r_rom turret_150_r_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_t_r_150),
	.q       (rom_q_t_r_150)
);

turret_150_r_palette turret_150_r_palette (
	.index (rom_q_t_r_150),
	.red   (palette_red_t_r_150),
	.green (palette_green_t_r_150),
	.blue  (palette_blue_t_r_150)
);

turret_180_r_rom turret_180_r_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_t_r_180),
	.q       (rom_q_t_r_180)
);

turret_180_r_palette turret_180_r_palette (
	.index (rom_q_t_r_180),
	.red   (palette_red_t_r_180),
	.green (palette_green_t_r_180),
	.blue  (palette_blue_t_r_180)
);

turret_210_r_rom turret_210_r_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_t_r_210),
	.q       (rom_q_t_r_210)
);

turret_210_r_palette turret_210_r_palette (
	.index (rom_q_t_r_210),
	.red   (palette_red_t_r_210),
	.green (palette_green_t_r_210),
	.blue  (palette_blue_t_r_210)
);

turret_225_r_rom turret_225_r_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_t_r_225),
	.q       (rom_q_t_r_225)
);

turret_225_r_palette turret_225_r_palette (
	.index (rom_q_t_r_225),
	.red   (palette_red_t_r_225),
	.green (palette_green_t_r_225),
	.blue  (palette_blue_t_r_225)
);

turret_240_r_rom turret_240_r_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_t_r_240),
	.q       (rom_q_t_r_240)
);

turret_240_r_palette turret_240_r_palette (
	.index (rom_q_t_r_240),
	.red   (palette_red_t_r_240),
	.green (palette_green_t_r_240),
	.blue  (palette_blue_t_r_240)
);

turret_270_r_rom turret_270_r_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_t_r_270),
	.q       (rom_q_t_r_270)
);

turret_270_r_palette turret_270_r_palette (
	.index (rom_q_t_r_270),
	.red   (palette_red_t_r_270),
	.green (palette_green_t_r_270),
	.blue  (palette_blue_t_r_270)
);

//gameoverscreen_rom gameoverscreen_rom (
//	.clock   (negedge_vga_clk),
//	.address (rom_address_gameover),
//	.q       (rom_q_gameover)
//);
//
//gameoverscreen_palette gameoverscreen_palette (
//	.index (rom_q_gameover),
//	.red   (palette_red_gameover),
//	.green (palette_green_gameover),
//	.blue  (palette_blue_gameover)
//);
gameoverplayer1win_rom gameoverplayer1win_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_gameoverp1),
	.q       (rom_q_gameoverp1)
);

gameoverplayer1win_palette gameoverplayer1win_palette (
	.index (rom_q_gameoverp1),
	.red   (palette_red_gameoverp1),
	.green (palette_green_gameoverp1),
	.blue  (palette_blue_gameoverp1)
);
gameoverplayer2win_rom gameoverplayer2win_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_gameoverp2),
	.q       (rom_q_gameoverp2)
);

gameoverplayer2win_palette gameoverplayer2win_palette (
	.index (rom_q_gameoverp2),
	.red   (palette_red_gameoverp2),
	.green (palette_green_gameoverp2),
	.blue  (palette_blue_gameoverp2)
);
absorber_rom absorber_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_def_45_1),
	.q       (rom_q_def_45_1)
);

absorber_palette absorber_palette (
	.index (rom_q_def_45_1),
	.red   (palette_red_def_45_1),
	.green (palette_green_def_45_1),
	.blue  (palette_blue_def_45_1)
);
absorber_rom absorber_rom2 (
	.clock   (negedge_vga_clk),
	.address (rom_address_def_45_2),
	.q       (rom_q_def_45_2)
);

absorber_palette absorber_palette2 (
	.index (rom_q_def_45_2),
	.red   (palette_red_def_45_2),
	.green (palette_green_def_45_2),
	.blue  (palette_blue_def_45_2)
);
endmodule
