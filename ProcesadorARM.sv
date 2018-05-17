module ProcesadorARM(input logic clk, reset,
					input logic [31:0] Instr,
					input logic [31:0] ReadData,
					output logic [31:0] PC,
					output logic MemWrite,
					output logic [31:0] ALUResult, WriteData);
					
		logic [3:0] ALUFlags;
		logic RegWrite,
				ALUSrc, MemtoReg, PCSrc;
		logic [1:0] RegSrc, ImmSrc, ALUControl;
		
		unit_ctrl c(clk, reset, Instr[31:12], ALUFlags,
						RegSrc, RegWrite, ImmSrc,
						ALUSrc, ALUControl,
						MemWrite, MemtoReg, PCSrc);
						
		datapath dp(clk, reset,
						RegSrc, RegWrite, ImmSrc,
						ALUSrc, ALUControl,
						MemtoReg, PCSrc,
						ALUFlags, PC, Instr,
						ALUResult, WriteData, ReadData);
endmodule
