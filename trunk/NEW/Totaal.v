module totaal (
	input clk,
	input [7:0] DSPingang,
	input hartslagIngang,
	input DSPready,
	input extReset,
	output PSfreq,
	output PSamp,
	output showClk,
	output showCont,
	output showLaag,
	output showErr,
	output error1,
	output stressLaag,
	output [7:0] hartData);
	
	wire [2:0] amp;
	wire [2:0] freq;
	
	wire slow;
//	wire error;
	wire intReset;
//	wire stressLaag;
	wire stressContinu;
	
	
	// Controle signalen
	TFF tff1 (slow, extReset, showClk);
	TFF tff2 (stressContinu, extReset, showCont);
	
	
	// Reset en Delay modules
	
	clkDelay	  delay	 (clk, extReset, slow);
	makeOneTick   oneTick (clk, extReset, stressContinu, stressContinuOneTick); // To make signal stressContinu only 1 tick long (not tested)
	
	// Input modules

	stress	  Ingang (clk, extReset, slow, DSPingang, DSPready, hartslagIngang, stressLaag, stressContinu, error1, hartData); 
	
	// Controler
	
	FPGAControler crtl 	 (stressContinuOneTick , extReset, stressLaag, amp, freq, error);
	
	// Output module
	
	Output        out 	 (clk, extReset, freq, amp, PSfreq, PSamp);
	
endmodule
