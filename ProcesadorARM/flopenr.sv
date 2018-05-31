module flopenr #(parameter WIDTH=8)
					 (input  logic				   iClk, iReset, iEn,
					  input  logic [WIDTH-1:0] iD,
					  output logic [WIDTH-1:0] oQ);
	always_ff @(posedge iClk, posedge iReset)
		if (iReset)   oQ   <= 0;
		else if (iEn) oQ   <= iD;

endmodule 