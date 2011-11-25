`timescale 1ns / 1ps
/**
 * Copyright: Steven van der Schoot
 */
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
