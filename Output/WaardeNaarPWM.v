module WaardeNaarPWM(
    input [2:0] Invoer,
    output [15:0] PWM);
	 
	reg [15:0] Uitgang;
	
	always @ (Invoer) begin
		case (Invoer) 
			0: Uitgang = 1200;			// 5%
			1: Uitgang = 4800;			// 20%
			2: Uitgang = 9600;			// 40%
			3: Uitgang = 14400;			// 60%
			4: Uitgang = 19200;			// 80%
			default: Uitgang = 19200; 	// default 80%
		endcase
	end
	
	assign PWM = Uitgang;
	
endmodule
