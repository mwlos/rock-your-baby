module testHuil (
	input clk,
	input reset,
	input [7:0] DSPingang,
	input [7:0] ClockSnelheid,
	output [7:0] huilVol
	);
	
	wire slowClk;
	
	clkDelay	  delay(clk		, reset, ClockSnelheid,		slowClk				 	);
	huilVolume	  huil (slowClk	, reset, DSPingang,			DSPctrl,  huilVol    	);
	
endmodule
