`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:16:42 12/02/2011 
// Design Name: 
// Module Name:    deltaStress 
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
module deltaStress(
		input clk,
		input r,
		input[7:0] huilVolume,
		input[7:0] hartslag,
		output stressLaag,
		output [2:0] huil,
		output hartOut
    );
	 
	 //wire [2:0] huil;
	 reg [2:0] huilOud;
	 //wire huilLaag;
	 reg hartOut;
	 reg huilOut;
	 
	 wire [2:0] hart;
	 reg [2:0] hartOud;
	 wire hartLaag;
	 
	 assign huil = huilVolume[7:5];
	 assign hart = hartslag[7:5];
		
	always @ (posedge clk or posedge r) begin
		if (r) huilOud = 0;
		else huilOud = huil;
	end
	
	always @ (posedge clk or posedge r) begin
		if (r) hartOud = 0;
		else hartOud = hart;
	end
	
	assign huilLaag = (huil < huilOud);
	assign hartLaag = (hart < hartOud);
	
	always @ (posedge clk or posedge r) begin
		if (r)
			huilOut = 0;
		else
			huilOut = huilLaag;
	end
	
	always @ (posedge clk or posedge r) begin
		if (r)
			hartOut = 0;
		else
			hartOut = hartLaag;
	end
	
	assign stressLaag = clk & (huilOut | hartOut);

endmodule
