module totaal (
	input clk,
	input reset,
	input [7:0] DSPingang,
	input hartslagIngang,
	input [7:0] ClockSnelheid,
	output [7:0] hartslag);
	
	wire slowClk;
	
	clkDelay	  delay(clk		, reset, ClockSnelheid,		slowClk				 	);

	hartRitme	  hart (clk		, slowClk,  reset, hartslagIngang,	hartslag             	);
	
	// Er moet een Reset ingebouwd worden om er voor te zorgen dat de regeling opnieuw begint zodra we het pad kwijt raken.
	
endmodule
