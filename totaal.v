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
	
	huilVolume    huil (clk, reset, hartslagIngang, hartslag );
	hartRitme     hart (clk, reset, DSPingang,      huilVol );
	FPGAControler crtl (clk, reset, ... );
	Output        out  (clk, reset, ... );
	
endmodule
