`timescale 1ns / 1ps
/**
 * Copyright: Steven van der Schoot
 */
module GT8(
    input [7:0] a,
    input [7:0] b,
    output q
    );

assign q = (a>b);

endmodule
