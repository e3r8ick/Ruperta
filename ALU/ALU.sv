module ALU
			#(parameter width = 3)
			 (input logic [width-1:0] a,
			  input logic [width-1:0] b,
			  input logic [2:0] control,
			  input logic carryin,
			  output logic [width-1:0] result,
			  output logic n,
			  output logic z,
			  output logic c,
			  output logic v);
			  
	
	logic [width-1:0] d0,d1,d2,d3,d4,d5,d6,d7; //d7 : resultado para restador
	
	generate
		
		sumadorNbits 
		#(width)
		sumaN(a,b,carryin,c,d0);
		
		sllN
		#(width)
		shiftL(a,b,d1);
		
		srlN
		#(width)
		shiftR(a,b,d2);
		
		xorN
		#(width)
		xorgate(a,b,d3);
		
		orN
		#(width)
		orgate(a,b,d4);
		
		notN
		#(width)
		notgate(a,d5);
		
		andN
		#(width)
		andgate(a,b,d6);
		
		//falta restador
		
		MUX
		#(width)
		muxresult(d0,d1,d2,d3,d4,d5,d6,d7,control,result);
		
	endgenerate
	

endmodule
