module huilVolume(
	input clk,
	input slowClk,
	input reset,
	input [7:0] DSPinvoer,
	input DSPready,
	output reg [7:0] huilVolume);
	
	reg [15:0] Memory;
	wire resetmore;
	
	assign resetmore = ( reset | slowClk );

	always @ (posedge DSPready or posedge resetmore) begin
		if (reset)
			Memory = 0;
		else
			Memory = Memory + DSPinvoer;
	end
	
	assign huilVolume = [15:8] Memory;
	
endmodule
