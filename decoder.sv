module decoder (input  logic [1:0] iOp,
					 input  logic [5:0] iFunct,
					 input  logic [3:0] oRd,
					 output logic [1:0] oFlagW,
					 output logic       oPCS, oRegW, oMemW,
					 output logic       oMemtoReg, oALUSrc,
					 output logic [1:0] oImmSrc, oRegSrc, oALUControl);

	logic [9:0] controls;
	logic       Branch, ALUOp;
	
	//Decoder principal
	always_comb
		casex(iOp)					//Immediate
			2'b00: if(iFunct[5])	controls = 10'b0000101001;
										//Register
					 else				controls = 10'b0000001001;
										//LDR
			2'b01: if(iFunct[0]) controls = 10'b0001111000;
										//STR
					 else				controls = 10'b1001110100;
										//B
			2'b10:					controls = 10'b0110100010;
										//Sin implementar
			default:					controls = 10'bx;
		endcase
		
	assign {oRegSrc, oImmSrc, oALUSrc, oMemtoReg,
			  oRegW, oMemW, Branch, ALUOp} = controls;
			  
	//Decoder ALU
	always_comb
	if(ALUOp) begin
		case(iFunct[4:1])
			4'b0100: oALUControl=2'b00;	//ADD
			4'b0010: oALUControl=2'b01;	//SUB
			4'b0000: oALUControl=2'b10;	//AND
			4'b1100: oALUControl=2'b11;	//ORR
			default: oALUControl=2'bx; 	//Sin implementar
		endcase
		
		//Actualizar banderas si S bit se establece (C & V solo para arith)
		oFlagW[1] = iFunct[0];
		oFlagW[0] = iFunct[0] & (oALUControl == 2'b00 | oALUControl == 2'b01);
	
	end else begin
		oALUControl = 2'b00; 				//ADD para instrucciones no DP
		oFlagW	 	= 2'b00;					//No actualiza banderas
	end
	
	//Logica PC
	assign oPCS = ((oRd == 4'b1111) & oRegW) | Branch;
		
endmodule 