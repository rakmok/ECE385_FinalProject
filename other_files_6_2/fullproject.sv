module dogactualfinal_example (
	input logic [9:0] DrawX, DrawY, input logic [7:0] keycode,
	input logic vga_clk, blank, frame_clk, KEY, Reset, turret_clk,
	output logic [3:0] red, green, blue
);


logic flag_b_reset; //reset flag for bullet (starting)

initial flag_b_reset = 1;
initial b_l_motion_x = 1;
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
logic [3:0] turret_l;

initial turret_l = 4'b0100;


always_ff @(posedge frame_clk)
begin
if(keycode == 8'h1A && (turret_l) > (4'h0))
begin
turret_l <= turret_l - (4'b0001);
end
if(keycode == 8'h16 && turret_l < (4'h8))
begin
turret_l <= turret_l + (4'b0001);
end
end


always_comb
begin

flag_t_l_0_exist = 0;
flag_t_l_30_exist = 0;
flag_t_l_45_exist = 0;
flag_t_l_60_exist = 0;
flag_t_l_90_exist = 0;
flag_t_l_270_exist = 0;
flag_t_l_300_exist = 0;
flag_t_l_315_exist = 0;
flag_t_l_330_exist = 0;
case (turret_l)
					4'b0000: begin //90

flag_t_l_90_exist = 1;
							  end
					        
					4'b0001 : begin //60

flag_t_l_60_exist = 1;
							  end
	  
					4'b0010 : begin //45

flag_t_l_45_exist = 1;
							 end
							  
					4'b0011 : begin //30

flag_t_l_30_exist = 1;
							 end	
							 
					4'b0100 : begin //0
					
flag_t_l_0_exist = 1;
							  end
					        
					4'b0101 : begin //330

flag_t_l_330_exist = 1;
							  end
	  
					4'b0110 : begin //315

flag_t_l_315_exist = 1;
							 end
							  
					4'b0111 : begin //300

flag_t_l_300_exist = 1;
							 end
					4'b1000 : begin //270

flag_t_l_270_exist = 1;
							  end
							  
							  endcase
end
							  
always_ff@ (negedge KEY)
begin
flag_b_reset <= 0;
end

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

logic [12:0] rom_address_detect;

logic [10:0] rom_address_def_315;

logic [18:0] rom_address_s; //background sprites

logic [2:0] rom_q_d, rom_q_p, rom_q_t_l, rom_q_b_l_0, rom_q_t_l_45, rom_q_t_l_180, rom_q_b_l_45, rom_q_b_l_180, rom_q_s, rom_def_315, rom_q_detect; //addresses, rom

logic [9:0] b_l_motion_x, b_l_pos_x, b_l_pos_y, b_l_motion_y;//bullet motions
logic [9:0] b180_motion_x, b180_pos_x, b180_pos_y, b180_motion_y;

initial b_l_pos_x = 90; //initials for start of game bullet position
initial b_l_pos_y = 52;
initial def_detection_x = 0;
initial def_detection_y = 0;

assign rom_address_s = (DrawX) + (DrawY*640); //rom address for background assignment

logic [3:0] palette_red_dog, palette_green_dog, palette_blue_dog; //palettes
logic [3:0] palette_red_peng, palette_green_peng, palette_blue_peng;
logic [3:0] palette_red_t_l_0, palette_green_t_l_0, palette_blue_t_l_0;
logic [3:0] palette_red_t_l_45, palette_green_t_l_45, palette_blue_t_l_45;
logic [3:0] palette_red_t_l_180, palette_green_t_l_180, palette_blue_t_l_180;
logic [3:0] palette_red_b_l_0, palette_green_b_l_0, palette_blue_b_l_0;
logic [3:0] palette_red_b_l_45, palette_green_b_l_45, palette_blue_b_l_45;
logic [3:0] palette_red_b_l_180, palette_green_b_l_180, palette_blue_b_l_180; 
logic [3:0] palette_red_s, palette_green_s, palette_blue_s;
logic [3:0] palette_red_def_315, palette_green_def_315, palette_blue_def_315;
logic [3:0] palette_red_detect, palette_green_detect, palette_blue_detect;

logic [9:0] actlX, actlY, turretX_left, turretY_left, b_x_left, b_y_left, turret_x_right, turret_y_right;
logic [9:0] b180_x_left, b180_y_left; //positions
logic [9:0] def_315_x, def_315_y;
logic [9:0] def_detection_x, def_detection_y;

logic flag_t_l_45;

logic flag_p, flag_d, flag_t_l_0, flag_b_l_0, flag_t_l_180, flag_b_l_180, flag_def_315; //drawing flags

logic flag_b_exist, flag_b180_exist; //exist flags

assign def_315_x = DrawX-590;
assign def_315_y = DrawY-50;


always_ff @(posedge frame_clk)
begin
if(b_l_pos_x + 40 < 590)
begin
def_detection_x = 1;
def_detection_y = 0;
end
else
begin
def_detection_x = b_l_pos_x-590;
def_detection_y = b_l_pos_y-52;
end
end

assign turretX_left = DrawX - 50;
assign turretY_left = DrawY - 50;
assign actlX = DrawX - 590;
assign actlY = DrawY - 380;

assign b_x_left = DrawX - b_l_pos_x;
assign b_y_left = DrawY - b_l_pos_y;

assign b180_x_left = DrawX - b180_pos_x;
assign b180_y_left = DrawY - b180_pos_y;
 
assign turret_x_right = DrawX - 550;
assign turret_y_right = DrawY - 420; //calculations of positions updating

always_comb
begin
rom_address_detect = def_detection_x + def_detection_y*40;
end

always_comb //dog drawing
begin
if(actlX<50 && actlY<100)
begin
rom_address_dog = actlX+actlY*50;
flag_d = 1;
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
flag_p = 1;
end
else
begin
rom_address_peng = 0;
flag_p = 0;
end
end

always_comb //turret left 0 drawing
begin
if((turretX_left<43 && turretY_left<34&&flag_t_l_0_exist==1))
begin
rom_address_t_l_0 = turretX_left+turretY_left*43;
flag_t_l_0 = 1;
end
else
begin
rom_address_t_l_0 = 0;
flag_t_l_0 = 0;
end
end

always_comb //turret left 45 drawing
begin
if((turretX_left<43 && turretY_left<34&&flag_t_l_45_exist==1))
begin
rom_address_t_l_45 = turretX_left+turretY_left*43;
flag_t_l_45 = 1;
end
else
begin
rom_address_t_l_45 = 0;
flag_t_l_45 = 0;
end
end


always_comb //turret right drawing
begin
if(turret_x_right<43 && turret_y_right<34)
begin
rom_address_t_r_180= turret_x_right+turret_y_right*43;
flag_t_l_180 = 1;
end
else
begin
rom_address_t_r_180 = 0;
flag_t_l_180 = 0;
end
end

always_comb //bullet left 0 drawing
begin
if(DrawX>b_l_pos_x && DrawY>b_l_pos_y && DrawX<b_l_pos_x+40 && DrawY<b_l_pos_y+10 && flag_b_exist==1)
begin
rom_address_b_l_0= b_x_left+b_y_left*40;
flag_b_l_0 = 1;
end
else
begin
rom_address_b_l_0 = 0;
flag_b_l_0 = 0;
end
end


always_comb //bullet left 180 drawing
begin
if(DrawX>b180_pos_x && DrawY>b180_pos_y && DrawX<b180_pos_x+40 && DrawY<b180_pos_y+10 && flag_b180_exist==1)
begin
rom_address_b_l_180= b180_x_left+b180_y_left*40;
flag_b_l_180 = 1;
end
else
begin
rom_address_b_l_180 = 0;
flag_b_l_180 = 0;
end
end

always_comb //deflector right drawing
begin
if(def_315_x<40 && def_315_y<40)
begin
rom_address_def_315= def_315_x+def_315_y*40;
flag_def_315 = 1;
end
else
begin
rom_address_def_315 = 0;
flag_def_315 = 0;
end
end

always_ff @(posedge (frame_clk)&~flag_b_reset)
begin

if(b_l_pos_x+40>=639)
begin
b180_motion_x <= 10'h3FF;
b_l_motion_x <= 10'h3FF;

b180_pos_x <= b_l_pos_x;
b180_pos_y <= b_l_pos_y;

flag_b_exist <= 0;
flag_b180_exist <= 1;
end

else if(b180_pos_x==10)
begin
b_l_motion_x <= 10'h001;
b180_motion_x <= 10'h001;

b_l_pos_x <= b180_pos_x;
b_l_pos_y <= b180_pos_y;

flag_b_exist <= 1;
flag_b180_exist <= 0;
end
else if(palette_red_detect == 4'h9 && palette_green_detect == 4'h9 && palette_blue_detect == 4'hE)
begin
b180_motion_x <= 10'h3FF;
b_l_motion_x <= 10'h3FF;

b180_pos_x <= b_l_pos_x;
b180_pos_y <= b_l_pos_y;

flag_b_exist <= 0;
flag_b180_exist <= 1;
end
else
begin

flag_b_exist <= flag_b_exist;
flag_b180_exist<= flag_b180_exist;

b_l_motion_x <= b_l_motion_x;
b180_motion_x <= b180_motion_x;

end

b_l_pos_x <= b_l_pos_x + b_l_motion_x;
b180_pos_x<=b180_pos_x + b180_motion_x;
end




always_ff @ (posedge vga_clk) begin
	if(~blank)
	begin
		red <= 4'h0;
		green <= 4'h0;
		blue <= 4'h0;
	end
	else if(flag_def_315&&(palette_red_def_315 !=4'hF && palette_green_def_315 !=4'hF && palette_blue_def_315 != 4'hF)) 
	begin
		red <= palette_red_def_315;
		green <= palette_green_def_315;
		blue <= palette_blue_def_315;
	end
	else if(flag_b_l_0&&(palette_red_b_l_0 !=4'hF && palette_green_b_l_0 !=4'hF && palette_blue_b_l_0 != 4'hF)) 
	begin
		red <= palette_red_b_l_0;
		green <= palette_green_b_l_0;
		blue <= palette_blue_b_l_0;
	end
	else if(flag_b_l_180&&(palette_red_b_l_180 !=4'hF && palette_green_b_l_180 !=4'hF && palette_blue_b_l_180 != 4'hF)) 
	begin
		red <= palette_red_b_l_180;
		green <= palette_green_b_l_180;
		blue <= palette_blue_b_l_180;
	end

	else if (flag_d&&(palette_red_dog !=4'hF && palette_green_dog !=4'h0 && palette_blue_dog != 4'hF)) 
	begin
		red <= palette_red_dog;
		green <= palette_green_dog;
		blue <= palette_blue_dog;
	end
	else if (flag_p&&(palette_red_peng != 4'hF && palette_green_peng !=4'h0 && palette_blue_peng != 4'hF))
	begin
		red <= palette_red_peng;
		green <= palette_green_peng;
		blue <= palette_blue_peng;
	end
	else if (flag_t_l_0&&(palette_red_t_l_0 !=4'hF && palette_green_t_l_0 !=4'h0 && palette_blue_t_l_0 != 4'hF))
	begin
		red <= palette_red_t_l_0;
		green <= palette_green_t_l_0;
		blue <= palette_blue_t_l_0;
	end
	else if (flag_t_l_45&&(palette_red_t_l_45 !=4'hF && palette_green_t_l_45 !=4'h0 && palette_blue_t_l_45 != 4'hF))
	begin
		red <= palette_red_t_l_45;
		green <= palette_green_t_l_45;
		blue <= palette_blue_t_l_45;
	end
	else if(flag_t_l_180&&(palette_red_t_l_180 !=4'hF && palette_green_t_l_180 !=4'h0 && palette_blue_t_l_180 != 4'hF))
	begin
		red <= palette_red_t_l_180;
		green <= palette_green_t_l_180;
		blue <= palette_blue_t_l_180;
	end
	else
	begin
		red <= (palette_red_s);
		green <= (palette_green_s);
		blue <= palette_blue_s;
	end
end

turret_rom turret_rom (
	.clock   (vga_clk),
	.address (rom_address_t_l_0),
	.q       (rom_q_t_l)
);

turret_palette turret_palette (
	.index (rom_q_t_l),
	.red   (palette_red_t_l_0),
	.green (palette_green_t_l_0),
	.blue  (palette_blue_t_l_0)
);
dogactualfinal_rom dogactualfinal_rom (
	.clock   (vga_clk),
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
	.clock   (vga_clk),
	.address (rom_address_peng),
	.q       (rom_q_p)
);

penguin_final_palette penguin_final_palette (
	.index (rom_q_p),
	.red   (palette_red_peng),
	.green (palette_green_peng),
	.blue  (palette_blue_peng)
);
rocketforfinal_rom rocketforfinal_rom (
	.clock   (vga_clk),
	.address (rom_address_b_l_0),
	.q       (rom_q_b_l_0)
);

rocketforfinal_palette rocketforfinal_palette (
	.index (rom_q_b_l_0),
	.red   (palette_red_b_l_0),
	.green (palette_green_b_l_0),
	.blue  (palette_blue_b_l_0)
);

turret_180_rom turret_180_rom (
	.clock   (vga_clk),
	.address (rom_address_t_r_180),
	.q       (rom_q_t_l_180)
);

turret_180_palette turret_180_palette (
	.index (rom_q_t_l_180),
	.red   (palette_red_t_l_180),
	.green (palette_green_t_l_180),
	.blue  (palette_blue_t_l_180)
);
projectile_180_rom projectile_180_rom (
	.clock   (vga_clk),
	.address (rom_address_b_l_180),
	.q       (rom_q_b_l_180)
);

projectile_180_palette projectile_180_palette (
	.index (rom_q_b_l_180),
	.red   (palette_red_b_l_180),
	.green (palette_green_b_l_180),
	.blue  (palette_blue_b_l_180)
);

starrynight_rom starrynight_rom (
	.clock   (vga_clk),
	.address (rom_address_s),
	.q       (rom_q_s)
);

starrynight_palette starrynight_palette (
	.index (rom_q_s),
	.red   (palette_red_s),
	.green (palette_green_s),
	.blue  (palette_blue_s)
);

projectile_45_rom projectile_45_rom (
	.clock   (vga_clk),
	.address (rom_address_b_l_45),
	.q       (rom_q_b_l_45)
);

projectile_45_palette projectile_45_palette (
	.index (rom_q_b_l_45),
	.red   (palette_red_b_l_45),
	.green (palette_green_b_l_45),
	.blue  (palette_blue_b_l_45)
);

turret_45_rom turret_45_rom (
	.clock   (vga_clk),
	.address (rom_address_t_l_45),
	.q       (rom_q_t_l_45)
);

turret_45_palette turret_45_palette (
	.index (rom_q_t_l_45),
	.red   (palette_red_t_l_45),
	.green (palette_green_t_l_45),
	.blue  (palette_blue_t_l_45)
);

deflector_rom deflector_rom (
	.clock   (vga_clk),
	.address (rom_address_def_315),
	.q       (rom_q_def_315),
	.address2(rom_address_detect),
	.q2(rom_q_detect)
);

deflector_palette deflector_palette (
	.index (rom_q_def_315),
	.index2 (rom_q_detect),
	.red   (palette_red_def_315),
	.green (palette_green_def_315),
	.blue  (palette_blue_def_315),
	.red2(palette_red_detect),
	.green2(palette_green_detect),
	.blue2(palette_blue_detect)
);

endmodule
