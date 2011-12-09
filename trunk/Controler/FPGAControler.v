module FPGAControler(
	input clk,
	input reset,
	input stressGezakt,
	output [2:0] A,
	output [2:0] F,
	output err
	);
	
	wire Alaag;
	wire Flaag;
	wire Fhoog;
	wire res;
	
	pathFinder  pathfind ( clk, reset | res , stressGezakt, Alaag    , Fhoog       , Flaag, err     );
	FAG         math     ( clk, reset       , Alaag       , Fhoog    , Flaag       , A    , F  , res);
	
endmodule
