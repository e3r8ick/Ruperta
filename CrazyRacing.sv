module CrazyRacing (
			input logic clk, reset,
					output logic vga_clk, hsync, vsync, blank, syncn,
			output logic [7:0] r, g, b);
			
	logic [31:0] PC, Instr, ReadData, vgaMemData, vgaMemDir ;
	logic [31:0] WriteData, DataAdr; 
	logic MemWrite;
	
	// instantiate processor and memories
	ProcesadorARM arm(
							clk,
							reset, 
							PC, 
							Instr, 
							MemWrite, 
							DataAdr,
							WriteData,
							ReadData);
							
	imem imem(
				PC,
				Instr);
	
	dmem dmem(
				clk,
				MemWrite, 
				DataAdr,
				vgaMemData, 
				WriteData, 
				ReadData,
				vgaMemDir);
	
	ControladorVGA myVGA (
								.clock(clk),
								.reset(reset),
								.rgbInMem(vgaMemData),
								.vga_clk(vga_clk),
								.hsync(hsync),
								.vsync(vsync),
								.blank(blank),
								.syncn(syncn),
								.r(r),
								.g(g),
								.b(b),
								.dirMem(vgaMemDir));
	
	
endmodule
