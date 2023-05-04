module ISDU (   input logic Reset,
									input logic [7:0] keycode, output logic flag_t_l_90_exist, flag_t_l_60_exist,flag_t_l_45_exist,flag_t_l_30_exist,flag_t_l_0_exist,
flag_t_l_330_exist,flag_t_l_315_exist,flag_t_l_300_exist,flag_t_l_270_exist, output logic [9:0] b_override_motion_x, b_override_motion_y, initial_b_l_pos_x, initial_b_l_pos_y
				);

	enum logic [3:0] {T0, T30, T45, T60, T90, T330, T315, T300, T270}   State, Next_state;   // Internal state logic
	logic turret_up, turret_down, clk2;
	
//	initial Next_state = T0;
always_comb
begin
clk2 = 0;
if(keycode==8'h1A||keycode == 8'h16)
begin
clk2 = 1;
end
end


	always_ff @ (posedge clk2)
	begin
		if (~Reset) 
			State <= T0;
		else 
			State <= Next_state;
	end
   
	always_comb
	begin 
		// Default next state is staying at current state
//		Next_state = State;
		Next_state = T0;
		// Default controls signal values
flag_t_l_0_exist = 0;
flag_t_l_30_exist = 0;
flag_t_l_45_exist = 0;
flag_t_l_60_exist = 0;
flag_t_l_90_exist = 0;
flag_t_l_270_exist = 0;
flag_t_l_300_exist = 0;
flag_t_l_315_exist = 0;
flag_t_l_330_exist = 0;
b_override_motion_x = 1;
b_override_motion_y = 0;
initial_b_l_pos_x = 85;
initial_b_l_pos_y = 40;
		// Assign next state
		unique case (State)
			T90 : 
				if (keycode == 8'h1A) 
				begin
					Next_state = T90;
					end
				else if (keycode == 8'h16)
				begin
				Next_state = T60;
				end
			T60 : 
				if (keycode == 8'h1A) 
				begin
					Next_state = T90;
					end
				else if (keycode == 8'h16)
				begin
				Next_state = T45;
				end
			T45 : 
				if (keycode == 8'h1A) 
				begin
					Next_state = T60;
					end
				else if (keycode == 8'h16)
				begin
				Next_state = T30;
				end
			T30 :
				if (keycode == 8'h1A) 
				begin
					Next_state = T45;
					end
				else if (keycode == 8'h16)
				begin
				Next_state = T0;
				end
			T0 :
				if (keycode == 8'h1A) 
				begin
					Next_state = T30;
					end
				else if (keycode == 8'h16)
				begin
				Next_state = T330;
				end
			T330 :
				if (keycode == 8'h1A) 
				begin
					Next_state = T0;
					end
				else if (keycode == 8'h16)
				begin
				Next_state = T315;
				end
			T315 :
				if (keycode == 8'h1A) 
				begin
					Next_state = T330;
					end
				else if (keycode == 8'h16)
				begin
				Next_state = T300;
				end
			T300 :
				if (keycode == 8'h1A) 
				begin
					Next_state = T315;
					end
				else if (keycode == 8'h16)
				begin
				Next_state = T270;
				end
			T270 :
				if (keycode == 8'h1A) 
				begin
					Next_state = T300;
					end
				else if (keycode == 8'h16)
				begin
				Next_state = T270;
				end

			default : Next_state = T0;
//			if(keycode == 8'h1A)
//			begin
//				Next_state = T0;
//			end
//			else if(keycode == 8'h16)
//			begin
//				Next_state = T330;
//			end

		endcase
		
		// Assign control signals based on current state
		case (State)
			T90 : 
				begin 
			flag_t_l_90_exist = 1;
			b_override_motion_x = 0;
			b_override_motion_y = 10'h3FF;
			initial_b_l_pos_x = 38;
			initial_b_l_pos_y = 42;
				end
			T60 : 
				begin 
			flag_t_l_60_exist = 1;
			b_override_motion_x = 1;
			b_override_motion_y = 10'h3FE;
			initial_b_l_pos_x = 40;
			initial_b_l_pos_y = 43;
				end
			T45 : 
				begin 
			flag_t_l_45_exist = 1;
			b_override_motion_x = 1;
			b_override_motion_y = 10'h3FF;
			initial_b_l_pos_x = 40;
			initial_b_l_pos_y = 42;
				end
			T30 : 
				begin 
			flag_t_l_30_exist = 1;
			b_override_motion_x = 2;
			b_override_motion_y = 10'h3FF;
			initial_b_l_pos_x = 65;
			initial_b_l_pos_y = 25;
				end
			T0 : 
				begin 
			flag_t_l_0_exist = 1;
			b_override_motion_x = 1;
			b_override_motion_y = 0;
			initial_b_l_pos_x = 85;
			initial_b_l_pos_y = 40;
				end
			T330 : 
				begin 
			flag_t_l_330_exist = 1;
			b_override_motion_x = 2;
			b_override_motion_y = 1;
			initial_b_l_pos_x = 73;
			initial_b_l_pos_y = 60;
				end
			T315 : 
				begin 
			flag_t_l_315_exist = 1;
			b_override_motion_x = 1;
			b_override_motion_y = 1;
			initial_b_l_pos_x = 73;
			initial_b_l_pos_y = 71;
				end
			T300 : 
				begin 
			flag_t_l_300_exist = 1;
			b_override_motion_x = 1;
			b_override_motion_y = 2;
			initial_b_l_pos_x = 67;
			initial_b_l_pos_y = 75;
				end
			T270 : 
				begin 
			flag_t_l_270_exist = 1;
			b_override_motion_x = 0;
			b_override_motion_y = 1;
			initial_b_l_pos_x = 48;
			initial_b_l_pos_y = 78;
				end

			default : ;
		endcase
	end 
//	if(flag_b_l_90_exist)
//	begin
//	def_detection_x = b_l_pos_x+20;
//	def_detection_y = b_l_pos_y;
//	end
//	else if(flag_b_l_60_exist)
//	begin
//	def_detection_x = b_l_pos_x+25;
//	def_detection_y = b_l_pos_y+10;
//	end
//	else if(flag_b_l_45_exist)
//	begin
//	def_detection_x = b_l_pos_x+26;
//	def_detection_y = b_l_pos_y+13;
//	end
//	else if(flag_b_l_30_exist)
//	begin
//	def_detection_x = b_l_pos_x+28;
//	def_detection_y = b_l_pos_y+14;
//	end
//	else if(flag_b_l_0_exist)
//	begin
//	def_detection_x = b_l_pos_x+40;
//	def_detection_y = b_l_pos_y+20;
//	end
//	else if(flag_b_l_120_exist)
//	begin
//	def_detection_x = b_l_pos_x+15;
//	def_detection_y = b_l_pos_y+10;
//	end
//	else if(flag_b_l_135_exist)
//	begin
//	def_detection_x = b_l_pos_x+10;
//	def_detection_y = b_l_pos_y+10;
//	end
//	else if(flag_b_l_150_exist)
//	begin
//	def_detection_x = b_l_pos_x+10;
//	def_detection_y = b_l_pos_y+15;
//	end
//	else if(flag_b_l_180_exist)
//	begin
//	def_detection_x = b_l_pos_x+5;
//	def_detection_y = b_l_pos_y+20;
//	end
//	else if(flag_b_l_210_exist)
//	begin
//	def_detection_x = b_l_pos_x+10;
//	def_detection_y = b_l_pos_y+25;
//	end
//	else if(flag_b_l_225_exist)
//	begin
//	def_detection_x = b_l_pos_x+13;
//	def_detection_y = b_l_pos_y+26;
//	end
//	else if(flag_b_l_240_exist)
//	begin
//	def_detection_x = b_l_pos_x+15;
//	def_detection_y = b_l_pos_y+28;
//	end
//	else if(flag_b_l_270_exist)
//	begin
//	def_detection_x = b_l_pos_x+20;
//	def_detection_y = b_l_pos_y+40;
//	end
//	else if(flag_b_l_300_exist)
//	begin
//	def_detection_x = b_l_pos_x+25;
//	def_detection_y = b_l_pos_y+28;
//	end
//	else if(flag_b_l_315_exist)
//	begin
//	def_detection_x= b_l_pos_x+27;
//	def_detection_y = b_l_pos_y+27;
//	end
//	else if(flag_b_l_330_exist)
//	begin
//	def_detection_x = b_l_pos_x+28;
//	def_detection_y = b_l_pos_y+25;
//	end
	
endmodule

