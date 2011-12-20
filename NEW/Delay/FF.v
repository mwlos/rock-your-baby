module DFF(
	input clk,
	input reset,
	input data,
	input CE,
	output reg q
	);
	
	always @ (posedge clk or posedge reset) begin
		if (reset)
			q = 0;
		else if (CE)
			q = data;
	end
	
endmodule


module TFF(
	input clk,
	input reset,
	output q
	);
	
DFF TFF (clk, reset, ~q, 1, q);
	
endmodule
