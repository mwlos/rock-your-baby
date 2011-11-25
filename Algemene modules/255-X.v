`timescale 1ns / 1ps
/**
 * Copyright: Steven van der Schoot
 */
module 255_X8(
    input [7:0] in,
    input [7:0] out
    );

assign out = (255-in);

endmodule
