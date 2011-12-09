module clkDelay (
	input CLK,
	input Reset,
	output Slow4,
	output Slow12);
	
	reg [27:0] C;
	reg [1:0]  D;
	
	wire reset4;
	wire reset12;
	
	assign reset4 = reset12 | ( C >= 96000000 );
	
	always @ (posedge CLK or posedge reset4) begin
		if(reset4)
			C = 0;
		else
			C = C + 1;
	end
	
	assign Slow4 = (C == 0);
	
	assign reset12 = Reset | ( D >= 3 );

	always @ (posedge Slow4 or posedge reset12) begin
		if(reset12)
			D = 0;
		else
			D = D + 1;
	end
	
	assign Slow12 = ( (D == 0) & (C == 0) );
	
endmodule
