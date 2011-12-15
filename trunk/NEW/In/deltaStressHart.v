module deltaStressHart(
		input clk4,
		input clk12,
		input reset,
		input [7:0] hart,
		output gedaald,
		output err,
		output errRelease
		);
		
	wire [7:0] delayed;
	wire equal;
	wire equalDelay;
	
	delay_8_2 HartDelay (clk4, reset, hart, delayed);
	
	assign gedaald = (hart < delayed);
	assign equal = (hart == delayed);
	assign err = ~(hart | delayed);
	
	delay_1 ErrDelay (clk12, reset, equal, equalDelay);
	
	assign errRelease = (equal == equalDelay);
	
	
endmodule
