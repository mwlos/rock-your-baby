module stressIn(
	input clk,
	input reset,
	input slowClk,
	input [7:0] huil,
	input DSPctrl,
	input hart,
	output stressLaag,
	output stressGelijk
	);
	
	wire [7:0] huilData;
	wire [7:0] hartData;
	
	huilVolume huilVol (clk,reset,slowClk,huil,DSPctrl,huilData);
	hartRitme  hartRit (clk,reset,slowClk,hart,hartData);
	
	deltaStressHuil (slowClk,reset,huilData[7:5],huilGedaald,huilGelijk);
	deltaStressHart (slowClk,reset,hartData[7:5],hartGedaald,hartGelijk);
	
	assign stressLaag = huilGedaald | hartGedaald;
	assign stressGelijk = huilGelijk & hartGelijk;
	
endmodule
