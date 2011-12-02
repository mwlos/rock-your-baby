module totaal (
	input clk,
	input reset,
	input DSPingang
	input hartslagIngang,
	output DSPctrl,
	output PSfreq,
	output PSamp)
	
	
	
	huilVolume    huil (clk, reset, ... );
	hartRitme     hart (clk, reset, ... );
	FPGAControler crtl (clk, reset, ... );
	Output        out  (clk, reset, ... );
	
endmodule
