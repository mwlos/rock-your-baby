module totaal (
	input clk,
	input reset,
	input hartslagIngang,
	input [7:0] ClockSnelheid,
	output [7:0] hartslag);
	
	wire slowClk;
	
	clkDelay	  delay(clk		, reset, ClockSnelheid,		slowClk				 	);
	hartRitme	  hart (clk		, slowClk,  reset, hartslagIngang,	hartslag             	);
	
endmodule
