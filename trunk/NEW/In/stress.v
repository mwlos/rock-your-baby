module stress(
		input clk,
		input reset,
		input slow,
		input [7:0] huil,
		input DSPctrl,
		input hart,
		output gedaald,
		output gelijk
		);
	
	wire [7:0] hartData;
	//wire [7:0] huilData;
	wire hartLaag;
	//wire huilLaag;
	wire hartGelijk;
	//wire huilGelijk;
	
	hartRitme  hartRit (clk,reset,hart,slow,hartData);
	//huilVolume huilVol (clk,clk4,reset,huil,DSPctrl,huilData);
	
	deltaStressHart hart (slow,reset,hartData,hartGelijk,hartLaag);
	//deltaStressHuil huil (reset,clk4,clk12,huilData,huilLaag[7:4],huilGelijk);
	
	//assign gedaald = (hartLaag|huilLaag);
	//assign gelijk  = (hartGelijk|huilGelijk);
	
	assign gedaald = hartLaag;
	assign gelijk  = hartGelijk;
	
endmodule
