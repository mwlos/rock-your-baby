module totaal (
	input clk,
	input reset,
	input [7:0] DSPingang,
	input hartslagIngang,
	input DSPready,
	input extReset,
	output PSfreq,
	output PSamp);
	
	wire [2:0] amp;
	wire [2:0] freq;
	
	wire slow4;
	wire slow12;
	wire error;
	wire intReset;
	wire extReset;
	wire stressLaag;
	wire stressContinu;
	wire stressError;
	
	
	// Reset en Delay modules
	
	holdReset     starter(clk   	, (extReset|stressError), stressContinu,      intReset);
	clkDelay	  delay	 (clk		, extReset, slow4,				slow12  );
	
	// Input modules

	stress	  Ingang (clk, extReset, slow4, slow12, DSPingang, DSPready, hartslagIngang, stressLaag, stressContinu, stressError); 
	
	// Controler
	
	FPGAControler crtl 	 (slow4, intReset, stressLaag, amp, freq, error);
	
	// Output module
	
	Output        out 	 (clk, extReset, freq, amp, PSfreq, PSamp);
	
endmodule
