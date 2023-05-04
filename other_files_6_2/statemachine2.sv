module ISDU2 (   input logic Reset,
									input logic [7:0] keycode, output logic flag_t_r_90_exist, flag_t_r_120_exist,flag_t_r_135_exist,flag_t_r_150_exist,flag_t_r_180_exist,
flag_t_r_210_exist,flag_t_r_225_exist,flag_t_r_240_exist,flag_t_r_270_exist, output logic [9:0] b_override_motion_x_r, b_override_motion_y_r, initial_b_r_pos_x, initial_b_r_pos_y
				);

	enum logic [3:0] {T90, T120, T135, T150, T180, T210, T225, T240, T270}   State, Next_state;   // Internal state logic
	logic turret_up, turret_down, clk2;

//	initial Next_state = T0;
always_comb
begin
clk2 = 0;
if(keycode==8'h52||keycode == 8'h51)
begin
clk2 = 1;
end
end

	always_ff @ (posedge clk2)
	begin
		if (~Reset) 
			State <= T180;
		else 
			State <= Next_state;
	end
   
	always_comb
	begin 
		// Default next state is staying at current state
//		Next_state = State;
		Next_state = State;
		// Default controls signal values
flag_t_r_90_exist = 0;
flag_t_r_120_exist = 0;
flag_t_r_135_exist = 0;
flag_t_r_150_exist = 0;
flag_t_r_180_exist = 0;
flag_t_r_210_exist = 0;
flag_t_r_225_exist = 0;
flag_t_r_240_exist = 0;
flag_t_r_270_exist = 0;
b_override_motion_x_r = 10'h3FF;
b_override_motion_y_r = 0;
initial_b_r_pos_x = 510;
initial_b_r_pos_y = 420;
		// Assign next state
		unique case (State)
			T90 : 
				if (keycode == 8'h52) 
				begin
					Next_state = T90;
					end
				else if (keycode == 8'h51)
				begin
				Next_state = T120;
				end
			T120 : 
				if (keycode == 8'h52) 
				begin
					Next_state = T90;
					end
				else if (keycode == 8'h51)
				begin
				Next_state = T135;
				end
			T135 : 
				if (keycode == 8'h52) 
				begin
					Next_state = T120;
					end
				else if (keycode == 8'h51)
				begin
				Next_state = T150;
				end
			T150 :
				if (keycode == 8'h52) 
				begin
					Next_state = T135;
					end
				else if (keycode == 8'h51)
				begin
				Next_state = T180;
				end
			T180 :
				if (keycode == 8'h52) 
				begin
					Next_state = T150;
					end
				else if (keycode == 8'h51)
				begin
				Next_state = T210;
				end
			T210 :
				if (keycode == 8'h52) 
				begin
					Next_state = T180;
					end
				else if (keycode == 8'h51)
				begin
				Next_state = T225;
				end
			T225 :
				if (keycode == 8'h52) 
				begin
					Next_state = T210;
					end
				else if (keycode == 8'h51)
				begin
				Next_state = T240;
				end
			T240 :
				if (keycode == 8'h52) 
				begin
					Next_state = T225;
					end
				else if (keycode == 8'h51)
				begin
				Next_state = T270;
				end
			T270 :
				if (keycode == 8'h52) 
				begin
					Next_state = T240;
					end
				else if (keycode == 8'h51)
				begin
				Next_state = T270;
				end

			default : Next_state = T180;
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
			flag_t_r_90_exist = 1;
			b_override_motion_x_r = 0;
			b_override_motion_y_r = 10'h3FF;
			initial_b_r_pos_x = 558;
			initial_b_r_pos_y = 422;
				end
			T120 : 
				begin 
			flag_t_r_120_exist = 1;
			b_override_motion_x_r = 10'h3FF;
			b_override_motion_y_r = 10'h3FE;
			initial_b_r_pos_x = 549;
			initial_b_r_pos_y = 414;
				end
			T135 : 
				begin 
			flag_t_r_135_exist = 1;
			b_override_motion_x_r = 10'h3FF;
			b_override_motion_y_r = 10'h3FF;
			initial_b_r_pos_x = 550;
			initial_b_r_pos_y = 415;
				end
			T150 : 
				begin 
			flag_t_r_150_exist = 1;
			b_override_motion_x_r = 10'h3FE;
			b_override_motion_y_r = 10'h3FF;
			initial_b_r_pos_x = 535;
			initial_b_r_pos_y = 410;
				end
			T180 : 
				begin 
			flag_t_r_180_exist = 1;
			b_override_motion_x_r = 10'h3FF;
			b_override_motion_y_r = 0;
			initial_b_r_pos_x = 510;
			initial_b_r_pos_y = 420;
				end
			T210 : 
				begin 
			flag_t_r_210_exist = 1;
			b_override_motion_x_r = 10'h3FE;
			b_override_motion_y_r = 1;
			initial_b_r_pos_x = 513;
			initial_b_r_pos_y = 448;
				end
			T225 : 
				begin 
			flag_t_r_225_exist = 1;
			b_override_motion_x_r = 10'h3FF;
			b_override_motion_y_r = 1;
			initial_b_r_pos_x = 514;
			initial_b_r_pos_y = 453;
				end
			T240 : 
				begin 
			flag_t_r_240_exist = 1;
			b_override_motion_x_r = 10'h3FF;
			b_override_motion_y_r = 2;
			initial_b_r_pos_x = 516;
			initial_b_r_pos_y = 455;
				end
			T270 : 
				begin 
			flag_t_r_270_exist = 1;
			b_override_motion_x_r = 0;
			b_override_motion_y_r = 1;
			initial_b_r_pos_x = 545;
			initial_b_r_pos_y = 458;
				end

			default : ;
		endcase
	end 
endmodule
