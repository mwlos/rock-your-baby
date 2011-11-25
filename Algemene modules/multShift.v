`timescale 1ns / 1ps
/**
 * Copyright: Steven van der Schoot
 */
module multShift_8(
    input [7:0] a,
    input [7:0] b,
    output [7:0] q
    );

assign q = ( (a*b) << 8 );

endmodule
