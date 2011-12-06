module testCtrl (
	input clk,
	input reset,
	input tick,
	input [7:0] hartslag,
	input [7:0] huilVol,
	output [2:0] amp,
	output [2:0] freq
	);
	
	wire [7:0] hartslag;
	wire [7:0] huilVol;
	reg slowClk;
	
	always @ (posedge clk or posedge reset) begin
		if (reset)
			slowClk = 0;
		else
			slowClk = tick;
	end
	
	FPGAControler crtl (slowClk	, reset, huilVol,        	hartslag, amp,    freq  );
	
endmodule
