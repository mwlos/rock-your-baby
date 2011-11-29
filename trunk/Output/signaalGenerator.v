module signaalGenerator(
    input CLK,
    input Reset,
    input Invoer,
    output Uitvoer)
	 
	input CLK;
	input Reset;
	input [15:0] Invoer;
	output Uitvoer;
	reg [15:0] C;
	
	wire resetmore;
	
	assign resetmore = Reset | ( C == 24000 );
	
	always @ (posedge CLK or posedge resetmore) begin
		if(resetmore)
			C = 0;
		else
			C = C + 1'b1;
	end
	
	assign Uitvoer = (C <= Invoer);
	
endmodule
