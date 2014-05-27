module beat_generator(clk, ci,co,clear);

// clk == clock
// ci == clock input.0 means not to add. 1 means to add.
// co == If count = N ,then return 1;else return 0;
// count == current number of the counter.
// #CounterBits == data width of the counter.
// #N == diagnose the number of a circle.
	parameter CounterBits = 3;
	parameter N = 5;
	 
	input clk, ci;
	input clear;
	reg[CounterBits-1:0] count=0;	
   output reg co;
	//TODO to fix the bugs
	always @(posedge clk)
	begin
	    if(clear)
	       begin
	          count <=0;
	          co <= 0;
	       end

	    else
	       begin 
	         if(~ci)
	            count <= count;
	         else
	         begin   
	            if((count+1) == N)
	               count <= 0;
	            else
	               count <= count +1;
	         end
	     co <= ci && (count == N-1);
	   end
	end
endmodule