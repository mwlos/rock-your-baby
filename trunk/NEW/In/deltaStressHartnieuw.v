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
	wire resetHart;
	
	reg [5:0] memory;
	reg gelijkHold;
	reg [3:0] slower;
	reg een;
	reg twee;
	reg drie;
	reg vier;
	reg vijf;
	
	delay_6 delayModuleOne 		(slow, reset, hart, 	delayOne	);
	delay_6 delayModuleTwo 		(slow, reset, delayOne, delayTwo	);
	delay_6 delayModuleThree 	(slow, reset, delayTwo, delayThree	);
	
	assign resetSlower = reset | gelijkPuls;
	assign resetOnSlower = reset | (slower == 7);
	assign gelijk = ( (hart == delayOne) & (delayOne == delayTwo) & (delayTwo == delayThree) );
	assign gelijkPuls = gelijk & gelijkHold;
	assign resetHart = een | vijf;
	
	
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
	
	always @ (posedge slow or posedge reset) begin
		if (reset)
			een = 0;
		else
			een = gelijkPuls;
	end
	
		always @ (negedge slow or posedge reset) begin
		if (reset)
			twee = 0;
		else
			twee = een;
	end
		always @ (posedge slow or posedge reset) begin
		if (reset)
			drie = 0;
		else
			drie = twee;
	end
		always @ (negedge slow or posedge reset) begin
		if (reset)
			vier = 0;
		else
			vier = drie;
	end
		always @ (posedge slow or posedge reset) begin
		if (reset)
			vijf = 0;
		else
			vijf = vier;
	end
	
	always @ (posedge resetHart) begin
		hart = 0;
	end
	
endmodule
