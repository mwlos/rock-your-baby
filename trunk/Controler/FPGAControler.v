module FPGAControler(
	input clk,
	input reset,
	input stressGezakt,
	output [2:0] A,
	output [2:0] F,
	output err,
	);
	
	wire Alaag;
	wire Flaag;
	wire Fhoog;
	wire res;
	wire err1;
	wire err2;
	
	assign err = (err1 | err2);
	
	pathFinder  pathfind ( clk, reset | res , stressGezakt, Alaag    , Fhoog       , Flaag, err1     );
	FAG         math     ( clk, reset       , Alaag       , Fhoog    , Flaag       , A    , F  , res, err2);
	
endmodule
