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
	
	wire slow;
	wire error;
	wire intReset;
	wire stressLaag;
	wire stressContinu;
	
	
	// Reset en Delay modules
	
	clkDelay	  delay	 (clk, extReset, slow);
	makeOneTick   oneTick (clk, extReset, stressContinu, stressContinuOneTick); // To make signal stressContinu only 1 tick long (not tested)
	
	// Input modules

	stress	  Ingang (clk, extReset, slow, DSPingang, DSPready, hartslagIngang, stressLaag, stressContinu); 
	
	// Controler
	
	FPGAControler crtl 	 (stressContinuOneTick , extReset, stressLaag, amp, freq, error);
	
	// Output module
	
	Output        out 	 (clk, extReset, freq, amp, PSfreq, PSamp);
	
endmodule
