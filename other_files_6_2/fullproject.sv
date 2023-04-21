module dogactualfinal_example (
	input logic [9:0] DrawX, DrawY,
	input logic vga_clk, blank, frame_clk, KEY, Reset,
	output logic [3:0] red, green, blue
);
logic flag_b_reset;
initial flag_b_reset = 1;
initial b_motion_x = 1;
//initial flag_b_exist = 0;


always_ff@ (negedge KEY)
begin
flag_b_reset <= 0;
//flag_b_exist <= 1;
end
logic [12:0] rom_address_dog, rom_address_peng, rom_address_t_l, rom_address_b, rom_address_t_180, rom_address_b180;
logic [18:0] rom_address_s;
logic [2:0] rom_q_d, rom_q_p, rom_q_t_l, rom_q_b,rom_q_t_180, rom_q_b180, rom_q_s; //addresses, rom

logic [9:0] b_motion_x, b_pos_x, b_pos_y, b_motion_y;//bullet motions
logic [9:0] b180_motion_x, b180_pos_x, b180_pos_y, b180_motion_y;

assign rom_address_s = (DrawX) + (DrawY*640);

//initial b_motion_y = 0;
initial b_pos_x = 90;
initial b_pos_y = 52;
//initial flag_b_reset = 1;
////
//initial b180_motion_x = 0;
//initial b180_motion_y = 0;
//initial b180_pos_x = 90;
//initial b180_pos_y = 52; //initial positions

logic [3:0] palette_red_dog, palette_green_dog, palette_blue_dog;
logic [3:0] palette_red_peng, palette_green_peng, palette_blue_peng;
logic [3:0] palette_red_t_l, palette_green_t_l, palette_blue_t_l;
logic [3:0] palette_red_t_180, palette_green_t_180, palette_blue_t_180;
logic [3:0] palette_red_b, palette_green_b, palette_blue_b;
logic [3:0] palette_red_b180, palette_green_b180, palette_blue_b180; //palettes
logic [3:0] palette_red_s, palette_green_s, palette_blue_s;

logic [9:0] actlX, actlY, turretX_left, turretY_left, b_x_left, b_y_left, turret_X_right, turret_Y_right;
logic [9:0] b180_x_left, b180_y_left; //positions

logic flag_p, flag_d, flag_t_l, flag_b, flag_t_180, flag_b180; //drawing flags

logic flag_b_exist, flag_b180_exist; //exist flags

assign turretX_left = DrawX - 50;
assign turretY_left = DrawY - 50;
assign actlX = DrawX-590;
assign actlY = DrawY-380;

assign b_x_left = DrawX - b_pos_x;
assign b_y_left = DrawY - b_pos_y;

assign b180_x_left = DrawX -b180_pos_x;
assign b180_y_left = DrawY -b180_pos_y;
 
assign turret_X_right = DrawX -550;
assign turret_Y_right = DrawY - 420; //calculations of positions updating

always_comb
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

always_comb
begin
if(turretX_left<40 && turretY_left<30)
begin
rom_address_t_l = turretX_left+turretY_left*40;
flag_t_l = 1;
end
else
begin
rom_address_t_l = 0;
flag_t_l = 0;
end
end

always_comb
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

always_comb
begin
if(turret_X_right<40 && turret_Y_right<30)
begin
rom_address_t_180= turret_X_right+turret_Y_right*40;
flag_t_180 = 1;
end
else
begin
rom_address_t_180 = 0;
flag_t_180 = 0;
end
end

always_comb
begin
if(DrawX>b_pos_x && DrawY>b_pos_y && DrawX<b_pos_x+40 && DrawY<b_pos_y+10 && flag_b_exist==1)
begin
rom_address_b= b_x_left+b_y_left*40;
flag_b = 1;
end
else
begin
rom_address_b = 0;
flag_b = 0;
end
end


always_comb
begin
if(DrawX>b180_pos_x && DrawY>b180_pos_y && DrawX<b180_pos_x+40 && DrawY<b180_pos_y+10 && flag_b180_exist==1)
begin
rom_address_b180= b180_x_left+b180_y_left*40;
flag_b180 = 1;
end
else
begin
rom_address_b180 = 0;
flag_b180 = 0;
end
end

//assign rom_address = ((DrawX * 50) / 640) + (((DrawY * 100) / 480) * 50);
always_ff @(posedge (frame_clk)&~flag_b_reset)
begin


//if(~Reset)
//begin
if(b_pos_x+40>=639)
begin
b180_motion_x <= 10'h3FF;
b_motion_x <= 10'h3FF;

b180_pos_x <= b_pos_x;
b180_pos_y <= b_pos_y;

flag_b_exist <= 0;
flag_b180_exist <= 1;
end



else if(b180_pos_x==10)
begin
b_motion_x <= 10'h001;
b180_motion_x <= 10'h001;

b_pos_x <= b180_pos_x;
b_pos_y <= b180_pos_y;

flag_b_exist <= 1;
flag_b180_exist <= 0;
end



else
begin

flag_b_exist <= flag_b_exist;
flag_b180_exist<= flag_b180_exist;

b_motion_x <= b_motion_x;
b180_motion_x <= b180_motion_x;

end

b_pos_x <= b_pos_x + b_motion_x;
b180_pos_x<=b180_pos_x + b180_motion_x;
end

//else
//begin
//b_pos_x <= 90;
//b_pos_y <= 52;
//b180_pos_x <= 0;
//b180_pos_x<= 0;
//end
//end





always_ff @ (posedge vga_clk) begin
if(~blank)
begin
	red <= 4'h0;
	green <= 4'h0;
	blue <= 4'h0;
end
else if(flag_b&&(palette_red_b !=4'hF && palette_green_b !=4'hF && palette_blue_b != 4'hF)) begin
		red <= palette_red_b;
		green <= palette_green_b;
		blue <= palette_blue_b;
end
else if(flag_b180&&(palette_red_b180 !=4'hF && palette_green_b180 !=4'hF && palette_blue_b180 != 4'hF)) begin
		red <= palette_red_b180;
		green <= palette_green_b180;
		blue <= palette_blue_b180;
end
	
	else if (flag_d&&(palette_red_dog !=4'hF && palette_green_dog !=4'h0 && palette_blue_dog != 4'hF)) begin
//	if(flag_d&&(palette_red_dog !=4'hC && palette_green_dog !=4'h2 && palette_blue_dog != 4'hA))
//	begin
		red <= palette_red_dog;
		green <= palette_green_dog;
		blue <= palette_blue_dog;
//	end
	end
	else if (flag_p&&(palette_red_peng != 4'hF && palette_green_peng !=4'h0 && palette_blue_peng != 4'hF))
	begin
//	if (flag_p&&(palette_red_peng !=4'hD && palette_green_peng !=4'h3 && palette_blue_peng != 4'hC))
//	begin
			red <= palette_red_peng;
		green <= palette_green_peng;
		blue <= palette_blue_peng;
//	end
	end
	
		else if (flag_t_l&&(palette_red_t_l !=4'hF && palette_green_t_l !=4'hF && palette_blue_t_l != 4'hF))
	begin
			red <= palette_red_t_l;
		green <= palette_green_t_l;
		blue <= palette_blue_t_l;
	end
	else if(flag_t_180&&(palette_red_t_180 !=4'hF && palette_green_t_180 !=4'hF && palette_blue_t_180 != 4'hF))
	begin
				red <= palette_red_t_180;
		green <= palette_green_t_180;
		blue <= palette_blue_t_180;
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
	.address (rom_address_t_l),
	.q       (rom_q_t_l)
);

turret_palette turret_palette (
	.index (rom_q_t_l),
	.red   (palette_red_t_l),
	.green (palette_green_t_l),
	.blue  (palette_blue_t_l)
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
	.address (rom_address_b),
	.q       (rom_q_b)
);

rocketforfinal_palette rocketforfinal_palette (
	.index (rom_q_b),
	.red   (palette_red_b),
	.green (palette_green_b),
	.blue  (palette_blue_b)
);

turret_180_rom turret_180_rom (
	.clock   (vga_clk),
	.address (rom_address_t_180),
	.q       (rom_q_t_180)
);

turret_180_palette turret_180_palette (
	.index (rom_q_t_180),
	.red   (palette_red_t_180),
	.green (palette_green_t_180),
	.blue  (palette_blue_t_180)
);
projectile_180_rom projectile_180_rom (
	.clock   (vga_clk),
	.address (rom_address_b180),
	.q       (rom_q_b180)
);

projectile_180_palette projectile_180_palette (
	.index (rom_q_b180),
	.red   (palette_red_b180),
	.green (palette_green_b180),
	.blue  (palette_blue_b180)
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

endmodule
