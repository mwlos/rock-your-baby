module WaardeNaarPWM(
    input Invoer,
    output PWM)
	 
	input [2:0] Invoer;
	output reg [15:0] PWM;
	
	always @ (Invoer) begin
		case (Invoer) 
			0: PWM = 1200;			// 5%
			1: PWM = 4800;			// 20%
			2: PWM = 9600;			// 40%
			3: PWM = 14400;			// 60%
			4: PWM = 19200;			// 80%
			default: PWM = 19200; 	// default 80%
		endcase
	end
	
endmodule
