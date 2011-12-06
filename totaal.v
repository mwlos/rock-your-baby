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
	
	clkDelay	  delay(clk		, reset, ClockSnelheid,		slowClk				 	);

	huilVolume	  huil (slowClk	, reset, DSPingang,			DSPctrl,  huilVol    	); 
	hartRitme	  hart (clk		, reset, hartslagIngang,	hartslag             	);
	
	FPGAControler crtl (slowClk	, reset, huilVol,        	hartslag, amp,    freq  );
	Output        out  (clk		, reset, freq,           	amp,      PSfreq, PSamp );
	
	// Er moet een Reset ingebouwd worden om er voor te zorgen dat de regeling opnieuw begint zodra we het pad kwijt raken.
	
endmodule
