`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:18:11 11/22/2011 
// Design Name: 
// Module Name:    min-8 
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
module min8(
    input [7:0] a,
    input [7:0] b,
    output [7:0] q
    );

assign q = (a-b);

endmodule
