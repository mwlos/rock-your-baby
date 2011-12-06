module FPGAControler(
	input clk,
	input reset,
	input [7:0] huilVolume,
	input [7:0] hartRitme,
	output [2:0] A,
	output [2:0] F,
	output error
	);
	
	wire Alaag;
	wire Flaag;
	wire Fhoog;
	wire F0;
	wire AF0;
	wire stressGezakt;
	wire error;
	
	deltaStress stress   ( clk, reset		, huilVolume,   hartRitme, stressGezakt                    );
	pathFinder  pathfind ( clk, reset | AF0 , stressGezakt, F0,        Alaag,       Fhoog, Flaag, error);
	FAG         fag      ( clk, reset		, Alaag,Fhoog,  Flaag,     A,           F,     F0,    AF0  );
	
endmodule
