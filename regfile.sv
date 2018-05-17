module regfile(input  logic 		  iClk,
					input  logic 		  iWe3,
					input  logic [3:0]  iRa1, iRa2, iWa3,
					input  logic [31:0] iWd3, iR15,
					output logic [31:0] oRd1, oRd2);
	
	logic [31:0] rf[14:0];
	
	always_ff @(posedge iClk)
		if (iWe3) rf[iWa3] <= iWd3;
		
	assign oRd1 = (iRa1==4'b1111) ? iR15 : rf[iRa1];
	assign oRd2 = (iRa2==4'b1111) ? iR15 : rf[iRa2];

endmodule 