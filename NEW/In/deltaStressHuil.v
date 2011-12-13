module deltaStressHuil(
		input reset,
		input clk12,
		input [3:0] huil,
		output gedaald,
		output gelijk
		);
	
	wire huilDel;
	
	delay_4 delay (clk12,reset,huil,huilDel);
	assign gedaald = clk12 & (huil<huilDel);
	assign gelijk = clk12 & (huil==huilDel);
	
endmodule
