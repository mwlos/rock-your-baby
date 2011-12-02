module huilVolume(
	input clk,
	input reset,
	input [7:0] DSPinvoer,
	output DSPctrl,
	output reg [7:0] huilVolume);
	
	assign DSPctrl = clk;
	
	always @ (posedge clk or posedge reset) begin
		if (reset)
			huilVolume = 0;
		else
			huilVolume = DSPinvoer;
	end
	
endmodule
