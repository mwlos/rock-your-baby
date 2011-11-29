module signaalGenerator(
    CLK,
    Reset,
    Invoer,
    Uitvoer);
	 
	input CLK;
	input Reset;
	input [15:0] Invoer;
	output reg Uitvoer;
	reg [15:0] C;
	
	wire resetmore;
	
	assign resetmore = Reset | ( C == 24000 );
	
	always @ (posedge CLK or posedge resetmore) begin
		if(resetmore)
			C = 0;
		else
			C = C + 1'b1;
	end
	
	assign on  = (C == 0);
	assign off = (C == Invoer);
	
	always @ (posedge CLK) begin
		if(off)
			Uitvoer = 0;
		else if (on)
			Uitvoer = 1;
	end
	
endmodule
