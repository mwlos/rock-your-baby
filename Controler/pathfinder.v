module pathFinder(
	input clk,
	input reset,
	input stress,
	input Flow,
	output Amin,
	output Fplus,
	output Fmin,
	output ERROR
	);
	
	wire data;
	reg wrong;
	
	assign data = ( Flow | wrong ) & ( (~Flow) | stress);
	assign Fmin = (~reset) & ( clk | ( (~Flow) | stress ) );
	assign Fplus = (~reset) & data;
	assign Amin = (~reset) & ( (~( (~Flow) | stress )) | ( Flow | wrong ) );
	
	always @ (posedge clk or posedge reset) begin
		if (reset)
			wrong = 0;
		else
			wrong = data;
	end
	
	always @ (posedge clk or posedge reset) begin
		if (reset)
			oldAmin = 0;
		else 
			oldAmin = Amin;
	end
	
	assign ERROR = (oldAmin & ~stress);
	
endmodule
