`timescale 1ns / 1ps
module pathFinder(
	input clk,
	input reset,
	input stress,
	output Amin,
	output Fplus,
	output Fmin,
	output ERROR
	);
	
	wire stressDel;
	wire resetDel;
	wire AminDel;
	
	delay_1_1 stressDelay (clk, reset, stress, stressDel);
	delay_1   resetDelay  (clk, reset, reset,  resetDel);
	delay_n_1 AminDelay   (clk, reset, Amin,   AminDel);
	
	assign trigger = resetDel & ~reset;
	
	assign Fmin  =  stress              |  trigger;
	assign Fplus = ~stress &  stressDel & ~trigger;
	assign Amin  = ~stress & ~stressDel & ~trigger;
	
	assign ERROR = AminDel & Amin & ~reset;
	
endmodule
