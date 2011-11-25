`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:23:15 11/22/2011 
// Design Name: 
// Module Name:    mux-8 
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
module mux8(
    input [7:0] a,
    input [7:0] b,
    input sel,
    output [7:0] q
    );

always @ (sel or a or b) begin
	case (sel)
		0: q = a;
		1: q = b;
	endcase
end

endmodule
