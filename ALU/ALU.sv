module ALU
			#(parameter width = 32)
			 (input logic [width-1:0] a,
			  input logic [width-1:0] b,
			  input logic [2:0] control,
			  output logic [width-1:0] result,
			  output logic [3:0] ALUFlags);		//Flags en orden: n,z,c,v
			  
	
	logic [width-1:0] d0,d1,d2,d3,d4,d5,d6,d7;
	
	generate
		
		sumadorNbits 
		#(width)
		sumaN(a,b,0,ALUFlags[1],d0);
		
		restadorNbits
		#(width)
		restador(a,b,d1,ALUFlags[3],ALUFlags[2],ALUFlags[0]);
		
		andN
		#(width)
		andgate(a,b,d2);
		
		orN
		#(width)
		orgate(a,b,d3);
		
		sllN
		#(width)
		shiftL(a,b,d4);
		
		srlN
		#(width)
		shiftR(a,b,d5);
		
		xorN
		#(width)
		xorgate(a,b,d6);
		
		notN
		#(width)
		notgate(a,d7);
		
		
		//Elige resultado: 000 > add
		//						 001 > subs
		//						 010 > and
		//						 011 > or
		//						 100 > sll
		//						 101 > srl
		//						 110 > xor
		//						 111 > not
		MUX
		#(width)
		muxresult(d0,d1,d2,d3,d4,d5,d6,d7,control,result);
		
	endgenerate
	

endmodule
