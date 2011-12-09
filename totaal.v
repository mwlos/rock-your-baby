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
	wire intReset;
	wire extReset;
	wire stressContinu;
	
	assign extReset = (reset | error) & ~intReset;
	
	// Reset en Delay modules
	
	holdReset     starter(clk   	, extReset, stressContinu,      intReset);
	clkDelay	  delay	 (clk		, extReset, ClockSnelheid,		slowClk);
	
	// Input modules

	stressIn	  stress (clk, extReset, slowClk, huilVol, DSPingang, DSPready, stressLaag, stressContinu); 
	
	// Controler
	
	FPGAControler crtl 	 (slowClk, intReset, stressLaag, amp, freq, error);
	
	// Output module
	
	Output        out 	 (clk, extReset, freq, amp, PSfreq, PSamp);
	
endmodule
