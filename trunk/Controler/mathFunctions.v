module mathFunctions(
	input clk,
	input reset,
	input Alaag,
	input Fhoog,
	input Flaag,
	output [3:0] A,
	output [3:0] F,
	output F0,
	output AF0
	)
	
	reg [3:0] A;
	reg [3:0] F;
	
	wire FclkDff;
	wire Fmin;
	wire Fplus;
	wire Fcalc;
	
	assign FclkDff = (Fhoog | Flaag);
	assign Fmin    = (F - 1);
	assign Fplus   = (F + 1);
	// Mux t oselect F-1 or F+1
	assign Fcalc = (Flaag & Fmin) | (Fhoog & Fmin);
	
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
