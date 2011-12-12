module huilVolume(
	input clk,
	input slowClk,
	input reset,
	input [7:0] DSPinvoer,
	input DSPready,
	output [7:0] huilVolume);
	
	reg [13:0] Memory;
	reg [7:0] MemoryOut;
	reg ready;
	reg [7:0] DSP;
	wire resetmore;
	
	assign resetmore = ( reset | slowClk );
	
	always @ (posedge clk or posedge resetmore) begin
		if (resetmore)
			ready = 0;
		else
			ready = DSPready;
	end
	
	always @ (posedge clk or posedge resetmore) begin
		if (resetmore)
			DSP = 0;
		else
			DSP = DSPinvoer;
	end

	always @ (posedge ready or posedge resetmore) begin
		if (resetmore)
			Memory = 0;
		else
			Memory = Memory + DSP;
	end
	
	always @ (posedge slowClk) begin
			MemoryOut=Memory[13:6];
	end
	
	assign huilVolume = MemoryOut;

endmodule