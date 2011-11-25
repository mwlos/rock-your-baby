`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:27:24 11/22/2011 
// Design Name: 
// Module Name:    add-8 
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
module add_8(
    input [7:0] a,
    input [7:0] b,
    output [7:0] q
    );

assign q = (a+b);

endmodule
