`timescale 1ns / 1ps

/*
 * Basic 1 tick delay module
 */
module delay_1(
    input clk,
    input reset,
    input signal,
    output q
    );
	 
	 reg [1:0] data;
	 
	 always @ (posedge clk or posedge reset) begin
		if (reset)
			data = 0;
		else
			data = {data[0:0],signal};
	 end
	 
	 assign q = data[1:1];
	 
endmodule

/*
 * Same delay module, but gives 1 on reset;
 */
module delay_1_1(
    input clk,
    input reset,
    input signal,
    output q
    );
	 
	 reg [1:0] data;
	 
	 always @ (posedge clk or posedge reset) begin
		if (reset)
			data = 3;
		else
			data = {data[0:0],signal};
	 end
	 
	 assign q = data[1:1];
	 
endmodule

/*
 * Same delay module, but on negative edge;
 */
module delay_n_1(
    input clk,
    input reset,
    input signal,
    output q
    );
	 
	 reg [1:0] data;
	 
	 always @ (negedge clk or posedge reset) begin
		if (reset)
			data = 0;
		else
			data = {data[0:0],signal};
	 end
	 
	 assign q = data[1:1];
	 
endmodule

module delay_3(
    input clk,
    input reset,
    input [2:0] signal,
    output [2:0] q
    );
	 
	 reg [5:0] data;
	 
	 always @ (posedge clk or posedge reset) begin
		if (reset)
			data = 0;
		else
			data = {data[2:0],signal};
	 end
	 
	 assign q = data[5:3];
	 
endmodule