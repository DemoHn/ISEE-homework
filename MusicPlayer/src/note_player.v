module note_player(
   clk,
   reset,
   play_enable,
   note_to_load,
   duration_to_load,
   done_with_note,
   load_new_note,
   beat,
   generate_next_sample,
   sample_out,
   new_sample_ready);
   input clk;
   input reset;
    // When high we play, when low we don't.
   input play_enable;
    // The note to play
   input [5:0] note_to_load;
   // The duration of the note to play
   input [5:0] duration_to_load;
   // Tells us when we have a new note to load
   input load_new_note;
   
   // When we are done with the note this stays high.
   output done_with_note;
   //reg  done_with_note;
   // This is our 1/48th second beat
   input beat;
   
   // Tells us when the codec wants a new sample
   input generate_next_sample;
   // Our sample output
   output [15:0] sample_out;
   // Tells the codec when we've got a sample
   output new_sample_ready;
   
	
	
   //
   //----sine_read  ģ��ʵ��-----//
	//
	
	wire[19:0] step_size;
	reg [5:0] count_number = 0;
	sine_reader  sine_reader_inst(
   .clk(clk),
   .reset(reset),
	//����ʱsine_readerģ��ʱ���ɽ���һ��ע�ͷ�ȥ��������ڶ��м���ע�ͷ������е��������������Ϊsine_reader������
	 // .step_size({10'd18, 10'd791}),
    .step_size(step_size),
   .generate_next_sample(generate_next_sample),//?
   .new_sample_ready(new_sample_ready),
   .sample_out(sample_out)
   );
   	

	
	
	//
	//------note_play������״̬��
	//һ��ʽ����
	//
	
	parameter RESET=0,PLAY=1,LOAD=2,DONE=3;
	reg [1:0] state;
	reg   done_with_note;
	reg   timer_clear;
	reg timer_done;
	reg[5:0] note;
	always @( posedge clk)
	begin
	
		 if (reset)	  
		     begin
    		    state<=RESET;
			    note<=6'b0;
				 done_with_note<=0;
				 timer_clear<=1;
			end
		 else
		 case (state)
		 	 RESET,LOAD,DONE:
			       if (~play_enable) 
					     begin 
							state<=RESET;
							note<=6'b0;
							done_with_note<=0;
				         timer_clear<=1;
						  end
					 else if(~load_new_note)	
					          begin 
							     state<=PLAY; 
								  done_with_note<=0;
				              timer_clear<=0;
							    end
					      else 
 							    begin 
								  state<=LOAD;
								  note<=note_to_load;
                          done_with_note<=0;
				              timer_clear<=1;
								 end
			 PLAY:
			      if(timer_done)  
					   begin 
						  state<=DONE;
						  note<=note_to_load;
						  done_with_note<=1;
				        timer_clear<=1;
					end
			    
				 else if (~play_enable) 
					     begin 
							state<=RESET;
							note<=6'b0;
							done_with_note<=0;
				         timer_clear<=1;
						  end
					 else if(~load_new_note)	
					          begin 
							     state<=PLAY; 
								  done_with_note<=0;
				              timer_clear<=0;
							    end
					      else 
 							    begin 
								  state<=LOAD;
								  note<=note_to_load;
                          done_with_note<=0;
				              timer_clear<=1;
								 end
			
		    default: 
			   begin 
			    state<=RESET;
			    note<=6'b0;
				 done_with_note<=0;
				 timer_clear<=1;
				end
		endcase


		if(timer_clear)
		begin
			count_number <= 0;
			timer_done <= 0;
		end

		else
		begin
			if(beat)
				count_number <= count_number + 1;
				timer_done <= 0;
			if(count_number == duration_to_load)
			begin
				count_number <= 0;
				timer_done <= 1;
			end
			else
			   timer_done <= 0;
		end
	end
		
			frequency_rom rom_inst(.clk(clk), .dout(step_size), .addr(note));
	endmodule
   