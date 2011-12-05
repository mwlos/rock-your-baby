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

	huilVolume	  huil (clk, reset, DSPingang,		DSPctrl,  huilVol       ); 
	hartRitme	  hart (clk, reset, hartslagIngang,	hartslag                );
	
	FPGAControler crtl (clk, reset, huilVol,        hartslag, amp,    freq  );
	Output        out  (clk, reset, freq,           amp,      PSfreq, PSamp );
	
	// Er moet een klokvertraging ingebouwd worden.
	// De modules Output en hartRitme moeten wel gewoon aan de systeemklok aangesloten worden.
	// Verder moet er een Reset ingebouwd worden om er voor te zorgen dat de regeling opnieuw begint zodra we het pad kwijt raken.
	
endmodule
