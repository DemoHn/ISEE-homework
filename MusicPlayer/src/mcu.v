module mcu(clk, reset, play_button, next, play, song, reset_play, song_done);
	input clk, reset;
	input song_done, play_button, next;
	output reg play,reset_play =1;
	output reg [1:0] song = 0;
	
	parameter RESET = 3'b000, WAIT = 3'b001, NEXT = 3'b011, PLAY = 3'b010, END = 3'b110; 
	reg [2:0] state = 3'b000;
	always @(posedge clk)
	begin
	    if(reset)
	     begin  
		   state <= RESET;
			play <= 0;
			song <= 0;
			reset_play <= 1;
			end
		case(state)
		
		RESET:
		begin
		//	play <= 0;
		//	song <= 0;
			reset_play <= 0;
			state <= WAIT;
		end
		
		WAIT:
		begin
			
			if(song_done == 1)
				begin 
					state <= END;
					play <= 0;
					reset_play <= 1;
				end	
				
				else
					if(next == 1)
					begin
					  state <= NEXT;
					  play <= 1;
			        reset_play <= 1;
			        song <= song +1;
					end  
					  
						else
							if(play_button == 0)
							begin
							state <= PLAY;
	                  play <= 1;
			            reset_play <= 0;	
							end
							
		end
		
		END,NEXT,PLAY:
		begin
			
			reset_play <= 0;
			state <= WAIT;
		end
		default:;
		
		endcase
	end
endmodule