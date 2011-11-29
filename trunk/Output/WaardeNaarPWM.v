module toestandKeuze(
    Invoer,
    PWM);
	 
	input [2:0] Invoer;
	output reg [15:0] PWM;
	reg [2:0] State;
	
	always @ (State) begin
		case (State) 
			0: PWM = 0;		// 0%
			1: PWM = 4800;	// 20%
			2: PWM = 9600;	// 40%
			3: PWM = 14400;	// 60%
			4: PWM = 19200;	// 80%
		endcase
	end
	
endmodule
