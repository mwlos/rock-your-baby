module clkDelay (
	input CLK,
	input Reset,
	input [7:0] ingang,
	output SlowClk);
	
	reg [27:0] C;
	wire [27:0] speed;
	
	assign speed = {ingang,20'b10};		// als ingang 0 is, toch een kleine klokvertraging
	
	wire resetmore;
	
	assign resetmore = Reset | ( C >= speed );
	
	always @ (posedge CLK or posedge resetmore) begin
		if(resetmore)
			C = 0;
		else
			C = C + 1;
	end
	
	assign SlowClk = (C == 0);
	
endmodule
