module huilVolume(
	input clk,
	input slowClk,
	input reset,
	input [7:0] DSPinvoer,
	input DSPready,
	output reg [7:0] huilVolume);
	
	reg [13:0] Memory;
	wire resetmore;
	
	assign resetmore = ( reset | slowClk );

	always @ (posedge DSPready or posedge resetmore) begin
		if (reset)
			Memory = 0;
		else
			Memory = Memory + DSPinvoer;
	end
	
	assign huilVolume = [13:6] Memory;
	
endmodule
