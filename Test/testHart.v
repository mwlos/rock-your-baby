module testHart (
	input clk,
	input reset,
	input hartin,
	output [3:0] hartvol
	);
	
	wire slow4;
	wire slow12;
	
	clkDelay	  delay(clk		, reset		, slow4, slow12				 			);
	hartRitme	  hart (clk		, reset, hartin,slow4,  hartvol  );
	
endmodule