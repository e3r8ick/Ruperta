module restadorNbits #(parameter N = 32)
			(input logic [N-1:0] A,
			 input logic [N-1:0] B,
			 output logic [N-1:0] Q,
			 output logic negativo,
			 output logic zero,
			 output logic overflow);
			 always @*
			 begin
				Q <= A-B;
				overflow <= 0;
			
				if(Q == 0)begin 
					zero <= 1;
				end
				else if(A<B)begin
					negativo <= 1;
				end
				else begin 						
					zero <= 0;
					negativo <= 0;
				end
			end			
endmodule 