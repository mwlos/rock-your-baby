module clkDelay (
	input CLK,
	input Reset,
	output SlowClk);
	
	reg [27:0] C;
	
	wire resetmore;
	
	assign resetmore = Reset | ( C == 120000000 );		// 5 sec
	
	always @ (posedge CLK or posedge resetmore) begin
		if(resetmore)
			C = 0;
		else
			C = C + 1'b1;
	end
	
	assign SlowClk = (C <= 60000000);					// 50% duty sycle
	
endmodule
