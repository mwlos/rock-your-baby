module clkDelay (
	input CLK,
	input Reset,
	output Slow);
	
	reg [27:0] C;
		
	wire resetmore;
		
	assign resetmore = Reset | ( C >= 48000000 );
	
	always @ (posedge CLK or posedge resetmore) begin
		if(resetmore)
			C = 0;
		else
			C = C + 1;
	end
	
	assign Slow = (C == 0);
	
		
endmodule
