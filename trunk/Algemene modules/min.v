`timescale 1ns / 1ps
/**
 * Copyright: Steven van der Schoot
 */
module min8(
    input [7:0] a,
    input [7:0] b,
    output [7:0] q
    );

assign q = (a-b);

endmodule
