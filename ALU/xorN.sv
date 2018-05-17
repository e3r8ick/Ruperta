module xorN #(parameter N=3)
	(input logic[N-1: 0] A,
	 input logic[N-1: 0] B,
	 output logic[N-1: 0] Q);
	 
	 assign Q = A^B;
endmodule
