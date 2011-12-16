module deltaStressHart(
		input slow,
		input reset,
		input [5:0] hart,
		output gedaald
		);
		
	wire [5:0] delayOne;
	wire [5:0] delayTwo;
	wire [5:0] delayThree;
	
	delay_6 delayModuleOne 		(slow, reset, hart, 	delayOne);
	delay_6 delayModuleTwo 		(slow, reset, delayOne, delayTwo);
	delay_6 delayModuleThree 	(slow, reset, delayTwo, delayThree);
	
	assign gedaald = ( (hart == delayOne) & (delayOne == delayTwo) & (delayTwo == delayThree) );
	
	
endmodule
