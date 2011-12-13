module bufferReset(
	input clk,
	input reset,
	input error,
	input intReset,
	output reg extReset);
	
	always @ (posedge clk or posedge intReset) begin
		if (intReset)
			extReset = 0;
		else
			extReset = (reset | error);
	end
	
endmodule
