module hartRitme(
	input CLK,
	input Reset,
	input Ingang,
	output [7:0] Uitvoer);

	reg [7:0] Uitvoer;
	reg [27:0] C;
	reg [7:0] Freq;
	reg in;
	
	wire k;
	wire h;
	assign h = (C==0);
	assign k = (Reset || h);
	
	always @ (posedge CLK or posedge Reset) begin
		if (Reset)
			in = 0;
		else
			in = Ingang;
	end

	always @ (posedge CLK or posedge Reset) begin
		if(Reset)
			C=0;
		else
			C = C + 1'b1;
	end

	always @ (posedge Reset or posedge h) begin
		if(h)
			Uitvoer = Freq;
		else
			Uitvoer = 0;
	end

	always @ (posedge k or posedge in) begin
		if(k)
			Freq=0;
		else 
			Freq = Freq + 1'b1;
	end

endmodule
