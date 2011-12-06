module clkDelay (
	input CLK,
	input Reset,
	input [7:0] ingang,
	output SlowClk);
	
	reg [27:0] C;
	reg [27:0] speed;
	
	assign speed = {ingang,20'b0};
	
	wire resetmore;
	
	assign resetmore = Reset | ( C == speed );
	
	always @ (posedge CLK or posedge resetmore) begin
		if(resetmore)
			C = 0;
		else
			C = C + 1'b1;
	end
	
	assign SlowClk = (C <= (speed >> 1));	// 50% duty sycle
	
endmodule
