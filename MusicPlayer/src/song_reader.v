module song_reader
(
clk,
reset,
play,
song,
song_done,
note,
duration,
new_note,
note_done
);

input clk, reset, play, song, note_done;
output wire [5:0] note;
output wire [5:0] duration;
output wire song_done;
output reg new_note;

reg [1:0] state = 2'b00;
wire [11:0] sig;
reg [6:0] sound_addr = 0;
reg [6:0] real_addr = 0;
reg song_temp_done = 0;

parameter RESET=2'b00, NEW_NOTE=2'b01, WAIT=2'b11, NEXT_NOTE=2'b10;
always @(posedge clk)
begin
	if(reset)
	begin
		state <= RESET;
	end
	else
	
	case(state)
		RESET:
		begin
			new_note <=0;
			sound_addr <= 0;
			real_addr <= 0;
			song_temp_done <= 1;
			if(play == 1)
				state <= NEW_NOTE;
			else
				state <= RESET;
		end
		
		NEW_NOTE:
		begin
			new_note <= 1;
			sound_addr <= sound_addr + 1;
			real_addr <= sound_addr + song * 32;
			
			if(sound_addr == 31)
			begin
				song_temp_done <= 1;
				sound_addr <= 0;
			end
			
			else
				song_temp_done <= 0;
			
			state <= WAIT;
		end
		
		WAIT:
		begin
			new_note <= 0;
			if(play == 1)
				begin
					if(note_done == 1)
						state <= NEXT_NOTE;
					else
						state <= WAIT;
				end
			else
				begin
					state <= RESET;
				end
		end
		
		NEXT_NOTE:
		begin
			new_note <= 0;
			state <= NEW_NOTE;
		end
			
		default:
		begin
			state <= RESET;
		end
	endcase 
end

song_rom new_rom(.clk(clk), .dout(sig), .addr(real_addr));
one_pulse song_end_pulse(.clk(clk), .in(song_temp_done), .out(song_done));
assign note = sig[11:6];
assign duration = sig[5:0];

endmodule