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

module delay_4(
    input clk,
    input reset,
    input [3:0] signal,
    output [3:0] q
    );
	 
	 reg [7:0] data;
	 
	 always @ (posedge clk or posedge reset) begin
		if (reset)
			data = 0;
		else
			data = {data[3:0],signal};
	 end
	 
	 assign q = data[7:4];
	 
endmodule

module delay_4_2( // 4 wide 1 tick delay
    input clk,
    input reset,
    input [3:0] signal,
    output [3:0] q
    );
	 
	 reg [11:0] data;
	 
	 always @ (posedge clk or posedge reset) begin
		if (reset)
			data = 0;
		else
			data = {data[7:0],signal};
	 end
	 
	 assign q = data[11:8];
	 
endmodule

module delay_6(
    input clk,
    input reset,
    input [5:0] signal,
    output [5:0] q
    );
	 
	 reg [11:0] data;
	 
	 always @ (posedge clk or posedge reset) begin
		if (reset)
			data = 0;
		else
			data = {data[5:0],signal};
	 end
	 
	 assign q = data[11:6];
	 
endmodule

module delay_8_2( // 8 wide 2 tick delay
    input clk,
    input reset,
    input [7:0] signal,
    output [7:0] q
    );
	 
	 reg [23:0] data;
	 
	 always @ (posedge clk or posedge reset) begin
		if (reset)
			data = 0;
		else
			data = {data[15:0],signal};
	 end
	 
	 assign q = data[23:16];
	 
endmodule
