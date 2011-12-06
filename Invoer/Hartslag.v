module hartRitme(
	input clk,
	input clkDl,
	input reset,
	input ingang,
	output reg [7:0] out);
/*
	reg [27:0] C;
	reg [7:0] Freq;
	reg in;					// TODO: hij doet een beetje moeilijk over in (zegt dat hij niet gebruikt wordt) !!!
	
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
*/
	
	/*
	 * Module van Steven:
	 */
	
	reg q;
	reg [7:0] slagen;
	
	always @ (posedge clk or posedge reset) begin
		if (reset)
			q = 0;
		else
			q = ingang;
	end
	
	always @ (posedge q or posedge reset ) begin
		if (reset)
			slagen = 0;
		else
			slagen = slagen + 1;
	end
	
	always @ (posedge clkDl or posedge reset) begin
		if (reset)
			out = 0;
		else
			out = slagen;
	end

endmodule
