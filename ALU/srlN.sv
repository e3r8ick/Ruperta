module srlN
	#(parameter width =3)
		(input logic [width-1:0] a,
		 input logic [width-1:0] b,
		 output logic [width-1:0] y);
		
	assign y = a >> b;
	
endmodule
