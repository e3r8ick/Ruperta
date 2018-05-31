module sumador1bit(
		input  A1bit,
		B1bit,
		Cin1bit,
		output logic Q1bit,
		Cout1bit);

		assign Q1bit = A1bit^B1bit^Cin1bit;
		assign Cout1bit =  (A1bit & B1bit) | (A1bit & Cin1bit) | (B1bit & Cin1bit);
endmodule
		