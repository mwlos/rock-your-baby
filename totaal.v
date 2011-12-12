module totaal (
	input clk,
	input reset,
	input start,
	input [7:0] DSPingang,
	input hartslagIngang,
	input DSPready,
	output PSfreq,
	output PSamp);
	
	wire [7:0] hartslag;
	wire [7:0] huilVol;
	wire [2:0] amp;
	wire [2:0] freq;
	
	wire slow4;
	wire slow12;
	wire error;
	wire intReset;
	wire extReset;
	wire stressContinu;
	
	
	// Reset en Delay modules
	
	bufferReset	  buffer (clk		, reset,	error, intReset,	extReset);
	holdReset     starter(clk   	, extReset, stressContinu,      intReset);
	clkDelay	  delay	 (clk		, extReset, slow4,				slow12  );
	
	// Input modules

	stress	  Ingang (clk, extReset, slow4, huilVol, DSPingang, DSPready, stressLaag, stressContinu); 
	
	// Controler
	
	FPGAControler crtl 	 (slow4, intReset, stressLaag, amp, freq, error);
	
	// Output module
	
	Output        out 	 (clk, extReset, freq, amp, PSfreq, PSamp);
	
endmodule
