module totaal (
	input clk,
	input reset,
	input [7:0] DSPingang,
	input hartslagIngang,
	input [7:0] ClockSnelheid,
	output DSPctrl,
	output PSfreq,
	output PSamp);
	
	wire [7:0] hartslag;
	wire [7:0] huilVol;
	wire [2:0] amp;
	wire [2:0] freq;
	wire slowClk;
	wire error;
	wire genReset;
	
	assign genReset = (reset | error);
	
	clkDelay	  delay(clk		, genReset, ClockSnelheid,		slowClk				 					);

	huilVolume	  huil (slowClk	, genReset, DSPingang,			DSPctrl,  		huilVol    				); 
	hartRitme	  hart (clk		, slowClk,	genReset, 			hartslagIngang,	hartslag             	);
	
	FPGAControler crtl (slowClk	, genReset, huilVol,        	hartslag, 		amp,    freq  , error	);
	Output        out  (clk		, genReset, freq,           	amp,      		PSfreq, PSamp 			);
	
endmodule
