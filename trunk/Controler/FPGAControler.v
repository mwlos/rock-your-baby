module FPGAControler(
	input clk,
	input reset,
	input [7:0] huilVolume,
	input [7:0] hartRitme,
	output [2:0] A,
	output [2:0] F,
	output err
	);
	
	wire Alaag;
	wire Flaag;
	wire Fhoog;
	wire stressGezakt;
	wire res;
	
	deltaStress stress   ( clk, reset		, huilVolume  , hartRitme, stressGezakt                 );
	pathFinder  pathfind ( clk, reset | res , stressGezakt, Alaag    , Fhoog       , Flaag, err     );
	FAG         math     ( clk, reset       , Alaag       , Fhoog    , Flaag       , A    , F  , res);
	
endmodule
