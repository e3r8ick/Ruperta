module div_clk(
		input logic clock, reset,
		output logic vgaclk);
		
		always_ff @( posedge clock, negedge reset)begin
			if(~reset)begin
				vgaclk <= 1'b0;
			end
			else begin
				vgaclk = ~vgaclk;
			end
		end
endmodule 