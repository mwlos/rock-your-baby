module makeOneTick(
	input clk,
	input reset,
	input data,
	output q
	);
	
	reg holdData;
	
	always @ (negedge clk or posedge reset) begin
		if (reset)
			holdData = 0;
		else 
			holdData = data;
	end
	
	assign q = data & ~holdData;
	
endmodule
