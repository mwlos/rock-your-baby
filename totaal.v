module totaal (
	input clk,
	input reset,
	input DSPingang,
	input hartslagIngang,
	output DSPctrl,
	output PSfreq,
	output PSamp);
	
	wire hartslag;
	wire huilVol;
	wire [2:0] amp;
	wire [2:0] freq;

	huilVolume	  huil (clk, reset, DSPingang,		DSPctrl,  huilVol       ); 
	hartRitme	  hart (clk, reset, hartslagIngang,	hartslag                );
	
	FPGAControler crtl (clk, reset, huilVol,        hartslag, amp,    freq  );
	Output        out  (clk, reset, freq,           amp,      PSfreq, PSamp );
	
endmodule
