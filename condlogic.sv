module condlogic (input  logic 		 iClk, iReset,
						input  logic [3:0] iCond,
						input  logic [3:0] iALUFlags,
						input  logic [1:0] iFlagW,
						input  logic       iPCS, iRegW, iMemW,
						output logic       oPCSrc, oRegWrite, oMemWrite);
						
	logic [1:0] FlagWrite;
	logic [3:0] Flags;
	logic			CondEx;
	
	flopenr #(2)flagreg1(iClk, iReset, FlagWrite[1], iALUFlags[3:2], Flags[3:2]);
	flopenr #(2)flagreg0(iClk, iReset, FlagWrite[0], iALUFlags[1:0], Flags[1:0]);
	
	condcheck cc(iCond, Flags, CondEx);
	assign FlagWrite = iFlagW & {2{CondEx}};
	assign oRegWrite = iRegW & CondEx;
	assign oMemWrite = iMemW & CondEx;
	assign oPCSrc	  = iPCS & CondEx;
	
end module 

module condcheck (input  logic [3:0] iCond,
						input  logic [3:0] iFlags,
						output logic 		 oCondEx);
						
	logic neg, zero, carry, overflow, ge;
	assign {neg, zero, carry, overflow} = iFlags;
	assign ge = (neg == overflow);
	
	always_comb
		case(iCond)
			4'b0000: oCondEx = Zero;				//EQ
			4'b0001: oCondEx = ~Zero;				//NE
			4'b0010: oCondEx = carry;				//CS
			4'b0011: oCondEx = ~carry;				//CC
			4'b0100: oCondEx = neg;					//MI
			4'b0101: oCondEx = ~neg;				//PL
			4'b0110: oCondEx = overflow;			//VS
			4'b0111: oCondEx = ~overflow;			//VC
			4'b1000: oCondEx = carry & ~zero;	//HI
			4'b1001: oCondEx = ~(carry & ~zero);//LS
			4'b1010: oCondEx = ge;					//GE
			4'b1011: oCondEx = ~ge;					//LT
			4'b1100: oCondEx = ~zero & ge;		//GT
			4'b1101: oCondEx = ~(~Zero & ge);	//LE
			4'b1110: oCondEx = 1'b1;				//Always
			default: oCondEx = 1'bx;				//sin definir
		endcase
			
end module 