module hartRitme(
	input clk,
	input reset,
	input ingang,
	input slowClk,
	output reg [7:0] uitvoer);

	reg [24:0] count;
	reg [7:0] freq;
	reg  in;

	wire resetMore;
	
	assign resetMore = ( reset | in);
	
	always @ (posedge clk or posedge reset) begin
		if (reset)
			in = 0;
		else
			in = ingang;
	end
	
	always @ (posedge clk or posedge resetMore) begin
		if (resetMore)
			count = 0;
		else
			count = count + 1;
	end
	
	always @ (posedge in or posedge reset) begin
		if (reset)
			freq = 0;
		else
			freq = count[23:16];
	end
	
	always @ (posedge slowClk or posedge reset) begin
		if (reset)
			uitvoer = 0;
		else
			uitvoer = freq;
	end
	
endmodule