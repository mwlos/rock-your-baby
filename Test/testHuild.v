module testHuil (
	input clk,
	input reset,
	input [7:0] DSPingang,
	input DSPready
	output [7:0] huilVol
	);
	
	wire slow4;
	wire slow12;
	
	clkDelay	  delay(clk		, reset		, slow4, slow12				 			);
	huilVolume	  huil (clk		, slowClk	, reset, DSPingang,	DSPready,  huilVol  );
	
endmodule
