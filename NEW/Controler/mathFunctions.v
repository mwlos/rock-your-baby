module FAG(
	input clk,
	input reset,
	input Alaag,
	input Fhoog,
	input Flaag,
	output reg [2:0] A,
	output reg [2:0] F,
	output F0,
	output error
	);
	
	wire FclkDff;
	wire [2:0] Fmin;
	wire [2:0] Fplus;
	wire FhDel;
	wire FlDel;
	reg [2:0] Fcalc;
	
	assign F0  = (F == 0);
	
	delay_1 delayFh (clk,reset,Fhoog,FhDel);
	delay_1 delayFl (clk,reset,Flaag,FlDel);
	
	assign Fh = Fhoog &  ~F0             ;
	assign Fl = Flaag &  ~F0             ;
	assign Al = Alaag | ( F0 & ~(A==0) ) ;
	
	assign FclkDff = ( Fh | Fl );
	assign Fmin    = (F - 1);
	assign Fplus   = (F + 1);
	
	assign error = ( (A==0) & Alaag ) | ( (F==0) & Flaag );
	
	// Mux t oselect F-1 or F+1
	always @ (Flaag or Fmin or Fplus) begin
		case (Flaag)
			0: Fcalc = Fplus;
			1: Fcalc = Fmin;
		endcase
	end
	
	// DFF to remember F
	always @ (posedge clk or posedge reset) begin	// hier stond eerst FclkDff ipv clk
		if (reset)
			F = 4;				
		else if (FclkDff)                // lost een warning op door gebruik te maken van de CE (clock enable) van de FF
			F = Fcalc;
	end
	
	// Counter for A
	always @ (posedge clk or posedge reset) begin	// hier stond eerst Alaag ipv clk
		if (reset)
			A = 4;				
		else if (Al)		   // lost een warning op door gebruik te maken van de CE (clock enable) van de FF
			A = A-1;
	end
	
endmodule
