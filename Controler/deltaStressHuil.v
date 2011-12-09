module deltaStressHuil(
		input clk,
		input reset,
		input [2:0] status,
		output gedaald,
		output gelijk
		);
		
	wire [2:0] data;	
	wire [2:0] dataDly;
	wire const;
	wire constDly;
	
	assign data = status;
	
	delay_3 delay1 (clk, reset, data, dataDly);
	
	assign gedaald = (data < dataDly);	
	assign const = (data==dataDly);
	
	delay_1 delay2 (clk, reset, const, constDly);
	
	assign gelijk = (const&constDly);
	
endmodule
	
	
	
	