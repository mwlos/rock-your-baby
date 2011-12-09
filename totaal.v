module totaal (
	input clk,
	input reset,
	input start,
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
	wire intReset;
	
	assign genReset = (reset | error);
	
	holdReset     starter(clk   , gerReset, start,              intReset                                );
	
	clkDelay	  delay(clk		, intReset, ClockSnelheid,		slowClk				 					);

	huilVolume	  huil (slowClk	, intReset, DSPingang,			DSPctrl,  		huilVol    				); 
	hartRitme	  hart (clk		, slowClk,	intReset, 			hartslagIngang,	hartslag             	);
	
	FPGAControler crtl (slowClk	, intReset, huilVol,        	hartslag, 		amp,    freq  , error	);
	Output        out  (clk		, intReset, freq,           	amp,      		PSfreq, PSamp 			);
	
endmodule
