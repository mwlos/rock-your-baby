module totaal (
	input clk,
	input reset,
	input start,
	input [7:0] DSPingang,
	input hartslagIngang,
	input [7:0] ClockSnelheid,
	input DSPready,
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
	
	assign genReset = 	 (reset | error);
	
	// Reset en Delay modules
	
	holdReset     starter(clk   	, genReset, start,              intReset                                );
	clkDelay	  delay	 (clk		, intReset, ClockSnelheid,		slowClk				 					);
	
	// Input modules

	huilVolume	  huil 	 (clk		, slowClk,  intReset, 			DSPingang,		DSPready,  		huilVol ); 
	hartRitme	  hart 	 (clk		, slowClk,	intReset, 			hartslagIngang,	hartslag             	);
	
	// Controler
	
	FPGAControler crtl 	 (slowClk	, intReset, huilVol,        	hartslag, 		amp,    freq  , error	);
	
	// Output module
	
	Output        out 	 (clk		, intReset, freq,           	amp,      		PSfreq, PSamp 			);
	
endmodule
