module sine_reader(clk, reset, step_size, generate_next_sample, new_sample_ready, sample_out);
	input clk, reset, generate_next_sample;
	output new_sample_ready;
	input  [19:0] step_size;
	output [15:0] sample_out;
	reg	[21:0] raw_addr = 22'b0000000000000000000000;
   reg [9:0] final_addr;
	//step_size := new_sample_ready + step_size?
	wire [15:0] sample_temp_out;
   always @ (posedge clk)
      begin
         if ( reset )
            raw_addr <= {22{1'b0}};
         else if(generate_next_sample == 1)
            raw_addr <= raw_addr + step_size;
         else
            raw_addr <= raw_addr;
        if(raw_addr[20] == 1)
           begin
              if(raw_addr[19:10] == 0)
                 final_addr <= 1023;
              else
                 final_addr <= ~raw_addr[19:10] + 1;
           end

        else
           final_addr <= raw_addr[19:10];
        
     end

	sine_rom rom(.clk(clk), .dout(sample_out), .addr(final_addr), .i(raw_addr[21]));
	//D_FFRE _out(.d(sample_temp_out), .en(generate_next_sample), .r(0), .clk(clk), .q(sample_out));
	D_FFRE _sample_ready(.d(generate_next_sample), .en(1), .r(0), .clk(clk), .q(new_sample_ready));
endmodule