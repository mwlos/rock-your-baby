module deltaStressHart(
		input slow,
		input reset,
		input [5:0] hart,
		output gelijkPuls,
		output gedaald,
		output error
		);
		
	wire [5:0] delayOne;
	wire [5:0] delayTwo;
	wire [5:0] delayThree;
	wire gelijk;
	wire resetSlower;
	
	reg  [5:0] memory;
	reg gelijkHold;
	reg slower;
	
	delay_6 delayModuleOne 		(slow, reset, hart, 	delayOne	);
	delay_6 delayModuleTwo 		(slow, reset, delayOne, delayTwo	);
	delay_6 delayModuleThree 	(slow, reset, delayTwo, delayThree	);
	
	assign resetSlower = reset | (slower == 7);
	assign gelijk = ( (hart == delayOne) & (delayOne == delayTwo) & (delayTwo == delayThree) );
	assign gelijkPuls = gelijk & gelijkHold;
	
	always @ (posedge slow or posedge resetSlower) begin
		if (resetSlower)
			slower = 0;
		else
			slower = slower + 1;
	end
	
	always @ (negedge clk or posedge resetSlower) begin
			if (resetSlower)
				gelijkHold = 0;
			else
				gelijkHold = ~gelijk;
	end
	
	always @ (posedge gelijkPuls or posedge reset) begin
		if (reset)
			memory = 63;
		else
			memory = hart;
	end
	
	assign gedaald = ( hart > memory );
	assign error	= ( hart < memory );
	
endmodule