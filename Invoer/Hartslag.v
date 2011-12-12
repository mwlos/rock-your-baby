module hartRitme(
	input clk,
	input reset,
	input ingang,
	input slowClk,
	output reg [3:0] uitvoer);

	reg [24:0] count;
	reg [3:0] freq;
	reg  in;
	wire inDelay;
	
	wire invInDelay;
	wire en;
	wire resetMore;
	
	assign invInDelay = ( inDelay ^ 1);
	assign en = (invInDelay & in);
	assign resetMore = ( reset | en);
	
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
	
	always @ (posedge clk or posedge resetMore) begin
		if (resetMore)
			freq = 0;
		else
			freq = count[24:21];
	end
	
	always @ (posedge slowClk or posedge resetMore) begin
		if (resetMore)
			uitvoer= 0;
		else
			uitvoer = freq;
	end

	delay_1 delay (clk,reset,in,inDelay);
	
endmodule
