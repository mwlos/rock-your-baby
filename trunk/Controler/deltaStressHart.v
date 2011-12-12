module deltaStressHart(
		input reset,
		input clk4,
		input clk12,
		input [3:0] hart,
		output gedaald,
		output gelijk
		);
	
	wire hartDel;
	
	delay_4_2 delay (clk4,reset,hart,hartDel);
	assign gedaald = clk12 & (hart>hartDel);
	assign gelijk = clk12 & (hart==hartDel);
	
endmodule
