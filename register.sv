module register #(parameter N = 32) 
	(input logic clk,
    input logic [N:0] dataIn,
	 output logic [N:0]dataOut);
	
	logic [N:0] register;
	
	always_ff @(posedge clk)
		dataOut = register;
	always_ff @(negedge clk)
		register = dataIn;
endmodule