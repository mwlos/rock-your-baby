module FAG(
	input clk,
	input reset,
	input Alaag,
	input Fhoog,
	input Flaag,
	output reg [3:0] A,
	output reg [3:0] F,
	output F0,
	output AF0
	)
	
	wire FclkDff;
	wire Fmin;
	wire Fplus;
	wire Fcalc;
	
	assign FclkDff = (Fhoog | Flaag);
	assign Fmin    = (F - 1);
	assign Fplus   = (F + 1);
	// Mux t oselect F-1 or F+1
	assign Fcalc = (Flaag & Fmin) | (Fhoog & Fmin);
	assign F0  = (F == 0);
	assign AF0 = F0 & (A == 0);
	
	// DFF to remember F
	always @ (posedge FclkDff or posedge reset) begin
		if (reset)
			F = 5;
		else
			F = Fcalc;
	end
	
	// Counter for A
	always @ (posedge reset or posedge Alaag) begin
		if (reset)
			A = 5
		else
			A = A-1;
	end
	
endmodule
