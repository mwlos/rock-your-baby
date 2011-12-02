module totaal (
	input clk,
	input reset,
	input DSPingang
	input hartslagIngang,
	output DSPctrl,
	output PSfreq,
	output PSamp)
	
	wire hartslag;
	wire huilVol;
	wire amp;
	wire freq;
	
	huilVolume    huil (clk, reset, hartslagIngang, hartslag                );
	hartRitme     hart (clk, reset, DSPingang,      huilVol                 );
	FPGAControler crtl (clk, reset, huilVol,        hartslag, amp,    freq  );
	Output        out  (clk, reset, freq,           amp,      PSfreq, PSamp );
	
endmodule
