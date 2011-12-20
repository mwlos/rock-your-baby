module deltaStressHart(
		input slow,
		input reset,
		input [5:0] hart,
		output gelijkPuls,
		output reg gedaald,
		output reg error
		);
		
	wire [5:0] delayOne;
	wire [5:0] delayTwo;
	wire [5:0] delayThree;
	wire gelijk;
	wire resetSlower;
	
	reg  [5:0] memory;
	reg gelijkHold;
	reg [3:0] slower;
	
	delay_6 delayModuleOne 		(slow, reset, hart, 	delayOne	);
	delay_6 delayModuleTwo 		(slow, reset, delayOne, delayTwo	);
	delay_6 delayModuleThree 	(slow, reset, delayTwo, delayThree	);
	
	assign resetSlower = reset | gelijkPuls;
	assign resetOnSlower = reset | (slower == 3'b111);
	assign gelijk = ( (hart == delayOne) & (delayOne == delayTwo) & (delayTwo == delayThree) );
	assign gelijkPuls = gelijk & gelijkHold;
	
	always @ (posedge slow or posedge resetSlower) begin
		if (resetSlower)
			slower = 0;
		else
			slower = slower + 1;
	end
	
	always @ (negedge slow or posedge resetOnSlower) begin
			if (resetOnSlower)
				gelijkHold = 1;
			else
				gelijkHold = ~gelijk;
	end
	
	always @ (negedge gelijkPuls or posedge reset) begin
		if (reset)
			memory = 0;
		else
			memory = hart;
	end
	
	always @ (posedge gelijkPuls or posedge reset) begin
		if (reset)
			gedaald = 0;
		else
			gedaald = ( hart > memory );
	end
	
	always @ (posedge gelijkPuls or posedge reset) begin
		if (reset)
			error = 0;
		else
			error = ( hart < memory );
	end
	
endmodule
