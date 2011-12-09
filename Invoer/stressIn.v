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
	
	deltaStressHuil (slowClk,reset,huilData[7:5],huilGedaald,huilGelijk);	// hier moeten we alle 8 bits gebruiken, omdat het anders waarschijnlijk best vaak allemaal nullen zijn.
	deltaStressHart (slowClk,reset,hartData[7:5],hartGedaald,hartGelijk);	// verder werken deze 2 module aanroepen niet (geen idee waarom niet)
	
	assign stressLaag = huilGedaald | hartGedaald;
	assign stressGelijk = huilGelijk & hartGelijk;
	
endmodule
