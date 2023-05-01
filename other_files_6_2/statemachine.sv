module ISDU (   input logic         Clk, 
									Reset,
									input logic [7:0] keycode, output logic flag_t_l_90_exist, flag_t_l_60_exist,flag_t_l_45_exist,flag_t_l_30_exist,flag_t_l_0_exist,
flag_t_l_330_exist,flag_t_l_315_exist,flag_t_l_300_exist,flag_t_l_270_exist
				);

	enum logic [3:0] {T0, T30, T45, T60, T90, T330, T315, T300, T270}   State, Next_state;   // Internal state logic
	logic turret_up, turret_down, clk2;
always_comb
begin
turret_up = 0;
turret_down = 0;
if(keycode==8'h1A)
begin
turret_up = 1;
end
if(keycode == 8'h16)
begin
turret_down = 1;
end0
end
assign clk2 = turret_up | turret_down;

	always_ff @ (posedge clk2)
	begin
		if (Reset) 
			State <= T0;
		else 
			State <= Next_state;
	end
   
	always_comb
	begin 
		// Default next state is staying at current state
		Next_state = State;
		
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

			default : 
			if(keycode == 8'h1A)
			begin
				Next_state = T30;
			end
			else if(keycode == 8'h16)
			begin
				Next_state = T330;
			end

		endcase
		
		// Assign control signals based on current state
		case (State)
			T90 : 
				begin 
			flag_t_l_90_exist = 1;
				end
			T60 : 
				begin 
			flag_t_l_60_exist = 1;
				end
			T45 : 
				begin 
			flag_t_l_45_exist = 1;
				end
			T30 : 
				begin 
			flag_t_l_30_exist = 1;
				end
			T0 : 
				begin 
			flag_t_l_0_exist = 1;
				end
			T330 : 
				begin 
			flag_t_l_330_exist = 1;
				end
			T315 : 
				begin 
			flag_t_l_315_exist = 1;
				end
			T300 : 
				begin 
			flag_t_l_300_exist = 1;
				end
			T270 : 
				begin 
			flag_t_l_270_exist = 1;
				end

			default : ;
		endcase
	end 

	
endmodule
