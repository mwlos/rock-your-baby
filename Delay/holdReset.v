module holdReset(
	input clk,
	input resetSignal,
	input stopHold,
	output reg reset);
	
	always @ (posedge clk or posedge stopHold) begin
		if (stopHold)
			reset = 0;
		else if (resetSignal)
			reset = 1;
	end
	
endmodule
