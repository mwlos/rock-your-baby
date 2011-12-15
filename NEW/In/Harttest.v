module testHart (
	input clk,
	input reset,
	input hartin,
	input [3:0] freq,
	input [3:0] amp,
	output [7:0] hartvol,
	output f,
	output a
	);
	
	wire slow4;
	wire slow12;
	
	clkDelay	  delay(clk		, reset		, slow4, slow12);
	//deltaStressHart hartVolume (reset, slow4, slow12, hartvol[4:1], daal, gelijk);
	hartRitme	  hart (clk		, reset, hartin,slow4,  hartvol  );
	Output        out  (clk,reset,freq,amp,a,f);
	
endmodule
