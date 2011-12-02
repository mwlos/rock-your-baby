module FPGAControler(
	input clk,
	input reset,
	input [7:0] huilVolume,
	input [7:0] hartRitme,
	output [3:0] A,
	output [3:0] F
	)
	
	wire Alaag;
	wire Flaag;
	wire Fhoog;
	wire F0;
	wire AF0;
	wire stressGezakt;
	wire Fmin;
	
	gtlt          stress   ( clk, reset, huilVolume,   hartRitme, stressGezakt                        );
	pathFinder    pathfind ( clk, reset, stressGezakt, Fmin,      Alaag,      Fhoog, Flaag            );
	mathFunctions math     ( clk, reset, Alaag,Fhoog,  Flaag,     A,          F,     F0,    AF0, Fmin );
	
endmodule
