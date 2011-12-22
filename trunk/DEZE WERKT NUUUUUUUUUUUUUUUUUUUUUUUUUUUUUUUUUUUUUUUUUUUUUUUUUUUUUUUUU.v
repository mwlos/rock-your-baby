module hartRitme(
	input clk,
	input reset,
	input ingang,
	input slowClk,
	output reg [7:0] uitvoer);

	reg [24:0] count;
	reg [7:0] freq;
	reg  in;

	wire resetMore;
	
	assign resetMore = ( reset | in);
	
	always @ (posedge clk or posedge reset) begin
		if (reset)
			in = 0;
		else
			in = ingang;
	end
	
	always @ (posedge clk or posedge resetMore) begin
		if (resetMore)
			count = 0;
		else
			count = count + 1;
	end
	
	always @ (posedge in or posedge reset) begin
		if (reset)
			freq = 0;
		else
			freq = count[23:16];
	end
	
	always @ (posedge slowClk or posedge reset) begin
		if (reset)
			uitvoer = 0;
		else
			uitvoer = freq;
	end
	
endmodule

module deltaStressHart(
		input slow,
		input reset,
		input [5:0] hart,
		output gelijkPuls,
		output reg gedaald,
		output reg error,
		output resetDL
		);
		
	wire [5:0] delayOne;
	wire [5:0] delayTwo;
	wire [5:0] delayThree;
	wire gelijk;
	wire resetSlower;
	//wire resetDL;
	
	reg [5:0] memory;
	reg gelijkHold;
	reg [3:0] slower;
	
	delay_6   delayModuleOne 		(slow, reset, hart, 	delayOne	);
	delay_6   delayModuleTwo 		(slow, reset, delayOne, delayTwo	);
	delay_6   delayModuleThree 	(slow, reset, delayTwo, delayThree	);
	delay_1_4 delayReset          (slow, reset, 1, resetDL);
	
	assign resetSlower = reset | gelijkPuls;
	assign resetOnSlower = reset | (slower == 7);
	assign gelijk = ( (hart == delayOne) & (delayOne == delayTwo) & (delayTwo == delayThree) ) & resetDL;
	assign gelijkPuls = gelijk & gelijkHold;
	
	always @ (posedge slow or posedge resetSlower) begin
		if (resetSlower)
			slower = 0;
		else
			slower = slower + 1;
	end
	
	always @ (negedge slow or posedge resetOnSlower) begin
			if (resetOnSlower)
				gelijkHold = 1;
			else
				gelijkHold = ~gelijk;
	end
	
	always @ (negedge gelijkPuls or posedge reset) begin
		if (reset)
			memory = 0;
		else
			memory = hart;
	end
	
	always @ (posedge gelijkPuls or posedge reset) begin
		if (reset)
			gedaald = 0;
		else
			gedaald = ( hart > memory );
	end
	
	always @ (posedge gelijkPuls or posedge reset) begin
		if (reset)
			error = 0;
		else
			error = ( hart < memory );
	end
	
endmodule

module stress(
		input clk,
		input reset,
		input slow,
		input [7:0] huil,
		input DSPctrl,
		input hart,
		output gedaald,
		output gelijk,
		output error,
		output holdReset
		);
	
	wire [7:0] hartData;
	//wire [7:0] huilData;
	wire hartLaag;
	//wire huilLaag;
	wire hartGelijk;
	//wire huilGelijk;
	
	hartRitme  hartRit (clk,reset,hart,slow,hartData);
	//huilVolume huilVol (clk,clk4,reset,huil,DSPctrl,huilData);
	
	deltaStressHart stressHart (slow,reset,hartData[7:2],hartGelijk,hartLaag, error, holdReset);
	//deltaStressHuil huil (reset,clk4,clk12,huilData,huilLaag[7:4],huilGelijk);
	
	//assign gedaald = (hartLaag|huilLaag);
	//assign gelijk  = (hartGelijk|huilGelijk);
	
	assign gedaald = hartLaag;
	assign gelijk  = hartGelijk;
	
endmodule


module pathFinder(
	input clk,
	input reset,
	input stress,
	output Amin,
	output Fplus,
	output Fmin,
	output ERROR,
	output stressDel
	);
	
	//wire stressDel;
	//wire resetDel;
	wire AminDel;
	
	delay_1_1 stressDelay (clk, reset, stress, stressDel);
	//delay_1   resetDelay  (clk, reset, reset,  resetDel);
	delay_n_1 AminDelay   (clk, reset, Amin,   AminDel);
	
	//assign trigger = resetDel & ~reset;
	
	assign Fmin  =  stress             ;// |  trigger;
	assign Fplus = ( (~stress) &  (stressDel) );// & ~trigger;
	assign Amin  = ( (~stress) & (~stressDel) );// & ~trigger;
	
	assign ERROR = (AminDel & Amin & ~reset);
	
endmodule

module FPGAControler(
	input sysclk,
	input clk,
	input reset,
	input stressGezakt,
	output [2:0] A,
	output [2:0] F,
	output err,
	output stressDel,
	output Alaag    ,
	output Fhoog       ,
	output Flaag
	);
	
	//wire Alaag;
	//wire Flaag;
	//wire Fhoog;
	wire res;
	wire err1;
	wire err2;
	wire clkDl;
	
	assign err = (err1 | err2);
	
	delay_1 delayFh (sysclk,reset,clk,clkDl);
	
	pathFinder  pathfind ( clk, reset , stressGezakt, Alaag    , Fhoog       , Flaag, err1     , stressDel);
	FAG         math     ( clkDl, reset       , Alaag       , Fhoog    , Flaag       , A    , F  , res, err2);
	
endmodule

module FAG(
	input clk,
	input reset,
	input Alaag,
	input Fhoog,
	input Flaag,
	output reg [2:0] A,
	output reg [2:0] F,
	output F0,
	output error
	);
	/*
	wire newFreq
	wire newAmp;
	wire freqUpdate;
	wire ampUpdate;
	
	assign Fmin = (F-1);
	assign Fplus = (F+1);
	
	assign freqUpdate = ( Flaag & (~(F==0)) ) | ( Fhoog & (~(F==4)) );
	assign ampUpdate = Alaag;
	
	assign newAmp = (A - 1);
	
	always @ (Fhoog or Fmin or Fplus) begin
		case (Fhoog)
			0: newFreq = Fmin;
			1: newFreq = Fplus;
		endcase
	end
	
	always @ (posedge clk or posedge reset) begin
		if (reset)
			F = 4;
		else if (freqUpdate)
			F = newFreq;
	end
	
	always @ (posedge clk or posedge reset) begin
		if (reset)
			A = 4;
		else if (ampUpdate)
			A = newAmp;
	end
	
	*/
	wire FclkDff;
	wire [2:0] Fmin;
	wire [2:0] Fplus;
	wire FhDel;
	wire FlDel;
	reg [2:0] Fcalc;
	
	assign F0  = (F == 0);
	
	//delay_1 delayFh (clk,reset,Fhoog,FhDel);
	//delay_1 delayFl (clk,reset,Flaag,FlDel);
	
	assign Fh = Fhoog &  ~F0             ;
	assign Fl = Flaag &  ~F0             ;
	assign Al = Alaag | ( F0 & ~(A==0) ) ;
	
	assign FclkDff = ( Fh | Fl );
	assign Fmin    = (F - 1);
	assign Fplus   = (F + 1);
	
	assign error = ( (A==0) & Alaag ) | ( (F==0) & Flaag );
	
	// Mux t oselect F-1 or F+1
	always @ (Fhoog or Fmin or Fplus) begin
		case (Fhoog)
			0: Fcalc = Fmin;
			1: Fcalc = Fplus;
		endcase
	end
	
	// DFF to remember F
	always @ (posedge clk or posedge reset) begin	// hier stond eerst FclkDff ipv clk
		if (reset)
			F = 4;				
		else if (FclkDff)                // lost een warning op door gebruik te maken van de CE (clock enable) van de FF
			F = Fcalc;
	end
	
	// Counter for A
	always @ (posedge clk or posedge reset) begin	// hier stond eerst Alaag ipv clk
		if (reset)
			A = 4;				
		else if (Al)		   // lost een warning op door gebruik te maken van de CE (clock enable) van de FF
			A = A-1;
	end
	
endmodule

module clkDelay (
	input CLK,
	input Reset,
	output Slow);
	
	reg [27:0] C;
		
	wire resetmore;
	
	assign resetmore = Reset | ( C >= 48000000 );
	
	always @ (posedge CLK or posedge resetmore) begin
		if(resetmore)
			C = 0;
		else
			C = C + 1;
	end
	
	assign Slow = (C == 0);
	
		
endmodule

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

module delay_1_4(
    input clk,
    input reset,
    input signal,
    output q
    );
	 
	 reg [3:0] data;
	 
	 always @ (posedge clk or posedge reset) begin
		if (reset)
			data = 0;
		else
			data = {data[2:0],signal};
	 end
	 
	 assign q = data[3:3];
	 
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
	 
	 reg ff1;
	 reg ff2;
	 
	 always @ (posedge clk or posedge reset) begin
	   if(reset) ff1 = 0;
		else ff1 = signal;
	 end
	 
	 always @ (negedge clk or posedge reset) begin
		if(reset) ff2=0;
		else ff2 = ff1;
	 end 
	 
	 assign q = ff2;
	 
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

module DFF(
	input clk,
	input reset,
	input data,
	input CE,
	output reg q
	);
	
	always @ (posedge clk or posedge reset) begin
		if (reset)
			q = 0;
		else if (CE)
			q = data;
	end
	
endmodule


module TFF(
	input clk,
	input reset,
	output q
	);
	
DFF TFF (clk, reset, ~q, 1, q);
	
endmodule


module totaal(
	input clk,
	input reset,
	input hart,
	output [2:0] A,
	output [2:0] F,
	output stressErr,
	output controlErr,
	output holdReset,
	output slowClk,
	output stressDel,
	output Alaag    ,
	output Fhoog       ,
	output Flaag
	);
	
	wire trigger;
	wire stressGezakt;
	wire slow;
	
	assign holdReset = stressGezakt;
	
	wire [7:0] huil;
	wire DSPctrl;
	
	clkDelay del (clk,reset,slow);
	TFF tff (slow,reset,slowClk);
	
	stress str(clk,reset,slow,huil,DSPctrl,hart,stressGezakt,trigger,stressErr,holdReset2);
	
	FPGAControler ctrl (clk,trigger,reset,stressGezakt,A,F,controlErr,stressDel,Alaag,Fhoog,Flaag);
	
endmodule
