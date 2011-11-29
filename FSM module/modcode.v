`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:14:30 11/29/2011 
// Design Name: 
// Module Name:    modcode 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module modcode(input stress,input clr,input clk,input reset,output Fmin,output Fplus,output Amin);
	reg Amin1;
	reg Fmin1;
	reg Fplus1;
	reg gf; 
	reg dclk;
	reg [21:0] counter;
	reg [21:0] delay = 22'b1111111111111111111111;
	wire delayclk;
always @ (posedge clk or posedge clr)begin
	
	if(clr)begin
	counter = 0;
	end
	else begin
	counter = counter + 1;
	end
end

always @ (posedge clk) begin
	
	if(delay == counter)begin
	dclk = 1;
	counter = 0;
	end
	else dclk = 0;
end
assign delayclk = dclk;
always @(posedge delayclk)begin
	if(stress == 1)
	Fmin1 = 1;
	else
	Fmin1 = 0;
end
always @ (posedge delayclk) begin
	if(stress == 0)begin
	Fplus1 = 1;
	gf = 1;
	end
	else begin 
	Fplus1 = 0;
	gf = 0;
	end
end
always @ (posedge delayclk)begin
	if(gf == 1)
	
	Amin1 = 1;
	else 
   Amin1 = 0;
end
assign Fplus = Fplus1;
assign Fmin = Fmin1;
assign Amin = Amin1;

endmodule
