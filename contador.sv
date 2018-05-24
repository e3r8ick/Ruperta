module contador #(parameter N=2)
					(input logic clk,
					input rst,
					input logic [N:0] bits,
					output [N:0] cont);
		
		always @(posedge clk)
			if(rst)
				begin
					cont <= 0;
				end
			else
				begin
					cont <= cont + 1;
				end		
					
endmodule
