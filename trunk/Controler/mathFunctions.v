module FAG(
	input clk,
	input reset,
	input Alaag,
	input Fhoog,
	input Flaag,
	output reg [2:0] A,
	output reg [2:0] F,
	output F0,
	output AF0
	);
	
	wire FclkDff;
	wire [2:0] Fmin;
	wire [2:0] Fplus;
	reg [2:0] Fcalc;
	
	assign FclkDff = (Fhoog | Flaag);
	assign Fmin    = (F - 1);
	assign Fplus   = (F + 1);
	assign F0  = (F == 0);
	assign AF0 = F0 & (A == 0);
	
	// Mux t oselect F-1 or F+1
	always @ (Fhoog or Fmin or Fplus) begin
		case (Fhoog)
			0: Fcalc = Fmin;
			1: Fcalc = Fplus;
		endcase
	end
	
	// DFF to remember F
	always @ (posedge clk or posedge reset) begin	// hier stond eerst FclkDff ipv clk
		if (reset)
			F = 5;				// ik denk dat dit een 4 moet zijn, omdat de uitgang gemaakt is voor [0,4].
		else if (FclkDff)		// lost een warning op door gebruik te maken van de CE (clock enable) van de FF
			F = Fcalc;
	end
	
	// Counter for A
	always @ (posedge reset or posedge clk) begin	// hier stond eerst Alaag ipv clk
		if (reset)
			A = 5;				// zelfde als bij de FF voor de FF hier boven
		else if (Alaag)		// lost een warning op door gebruik te maken van de CE (clock enable) van de FF
			A = A-1;
	end
	
endmodule
