module totaal (
	input clk,
	input reset,
	input DSPingang,
	input hartslagIngang,
	output DSPctrl,
	output PSfreq,
	output PSamp);
	
	wire [7:0] hartslag;
	wire [7:0] huilVol;
	wire [2:0] amp;
	wire [2:0] freq;
	
	clkDelay	  delay(clk		, reset, slowClk								 );

	huilVolume	  huil (slowClk	, reset, DSPingang,		DSPctrl,  huilVol        ); 
	hartRitme	  hart (clk		, reset, hartslagIngang,	hartslag             );
	
	FPGAControler crtl (slowClk	, reset, huilVol,        hartslag, amp,    freq  );
	Output        out  (clk		, reset, freq,           amp,      PSfreq, PSamp );
	
	// Verder moet er een Reset ingebouwd worden om er voor te zorgen dat de regeling opnieuw begint zodra we het pad kwijt raken.
	
endmodule
