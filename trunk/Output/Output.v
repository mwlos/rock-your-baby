module Output(
	input CLK,
	input Reset,
    input Freq,
	input Amp,
    output fPWM,
	output aPWM)
	 
	input CLK;
	input Reset;
	input [2:0] Freq;
	input [2:0] Amp;
	output fPWM;
	output aPWM;
	
	wire [15:0] f;
	wire [15:0] a;
	
	WaardeNaarPWM 	 freqConv	(Freq, 		f);
	signaalGenerator freqPWM	(CLK, 	Reset,	f,	 fPWM);
	
	WaardeNaarPWM 	 ampConv 	(Amp , 		a);
	signaalGenerator ampPWM		(CLK,	Reset,	a,	 aPWM);
	
endmodule
