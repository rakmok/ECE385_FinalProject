module dogactualfinal_example (
	input logic [9:0] DrawX, DrawY,
	input logic vga_clk, blank, frame_clk,
	output logic [3:0] red, green, blue
);

logic [12:0] rom_address_dog, rom_address_peng, rom_address_t_l, rom_address_b, rom_address_t_180;
logic [2:0] rom_q_d, rom_q_p, rom_q_t_l, rom_q_b,rom_q_t_180;

logic [9:0] b_motion_x, b_pos_x, b_pos_y, b_motion_y;

initial b_motion_x = 1;
initial b_motion_y = 0;
initial b_pos_x = 100;
initial b_pos_y = 200;
logic [3:0] palette_red_dog, palette_green_dog, palette_blue_dog;
logic [3:0] palette_red_peng, palette_green_peng, palette_blue_peng;
logic [3:0] palette_red_t_l, palette_green_t_l, palette_blue_t_l;
logic [3:0] palette_red_t_180, palette_green_t_180, palette_blue_t_180;
logic [9:0] actlX, actlY, turretX_left, turretY_left, b_x_left, b_y_left, turret_X_right, turret_Y_right;
logic [3:0] palette_red_b, palette_green_b, palette_blue_b;
logic flag_p, flag_d, flag_t_l, flag_b, flag_t_180;
assign turretX_left = DrawX - 50;
assign turretY_left = DrawY - 50;
assign actlX = DrawX-590;
assign actlY = DrawY-380;
assign b_x_left = DrawX - b_pos_x;
assign b_y_left = DrawY -b_pos_y;
assign turret_X_right = DrawX -550;
assign turret_Y_right = DrawY - 420;

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
if(DrawX>b_pos_x-40 && DrawY>b_pos_y-10 && DrawX<b_pos_x && DrawY<b_pos_y)
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

//assign rom_address = ((DrawX * 50) / 640) + (((DrawY * 100) / 480) * 50);
always_ff @(posedge frame_clk)
begin

if(b_pos_x+8'h28>=670)
begin
b_motion_x <= 10'h3FF;
end

else if(b_pos_x==40)
begin
b_motion_x <= 10'h001;
end

else
begin
b_motion_x <= b_motion_x;
end

b_pos_x <= b_pos_x + b_motion_x;

end
//always_ff @ (posedge Reset or posedge frame_clk )
//    begin: Move_Ball
//				 if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
//					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
//					  
//				 else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
//					  Ball_Y_Motion <= Ball_Y_Step;
//					  
//				  else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the Right edge, BOUNCE!
//					  Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
//					  
//				 else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )  // Ball is at the Left edge, BOUNCE!
//					  Ball_X_Motion <= Ball_X_Step;
//					  
//				 else 
//					begin
//					  Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
//				 			end
//				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
//				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
//    end
always_ff @ (posedge vga_clk) begin
if(~blank)
begin
	red <= 4'h0;
	green <= 4'h0;
	blue <= 4'h0;
end
else if(flag_b) begin
		red <= palette_red_b;
		green <= palette_green_b;
		blue <= palette_blue_b;
end
	
	else if (flag_d) begin
		red <= palette_red_dog;
		green <= palette_green_dog;
		blue <= palette_blue_dog;
	end
	else if (flag_p)
	begin
			red <= palette_red_peng;
		green <= palette_green_peng;
		blue <= palette_blue_peng;
	end
		else if (flag_t_l)
	begin
			red <= palette_red_t_l;
		green <= palette_green_t_l;
		blue <= palette_blue_t_l;
	end
	else if(flag_t_180)
	begin
				red <= palette_red_t_180;
		green <= palette_green_t_180;
		blue <= palette_blue_t_180;
	end
	else
	begin
	red <= 4'hF;
	green <= 4'hF;
	blue <= 4'hF;
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

endmodule
