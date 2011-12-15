module stress(
		input clk,
		input reset,
		input clk4,
		input clk12,
		input [7:0] huil,
		input DSPctrl,
		input hart,
		output gedaald,
		output gelijk,
		output error
		);
	
	wire [7:0] hartData;
	//wire [7:0] huilData;
	wire hartLaag;
	//wire huilLaag;
	wire hartGelijk;
	//wire huilGelijk;
	wire hartError
	//wire huilError;
	
	hartRitme  hartRit (clk,clk4,reset,hart,hartData);
	//huilVolume huilVol (clk,clk4,reset,huil,DSPctrl,huilData);
	
	deltaStressHart hart (reset,clk4,hartData,hartLaag,hartGelijk,hartError);
	//deltaStressHuil huil (reset,clk4,clk12,huilData,huilLaag[7:4],huilGelijk);
	
	//assign gedaald = (hartLaag|huilLaag);
	//assign gelijk  = (hartGelijk|huilGelijk);
	//assign error   = (hartError|huilError);
	
	assign gedaald = hartLaag;
	assign gelijk  = hartGelijk;
	assign error   = hartError;
	
endmodule
