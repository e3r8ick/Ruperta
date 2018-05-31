module counter #(parameter n=10)
	 (input logic clk,
	  input logic reset,
	  output logic [n-1:0] count);
	  
	  always @(posedge clk, negedge reset)begin
	  if(~reset)begin
		count <= 0;
	  end
	  else begin
		count <= count+1'b1;
	  end
	 end
endmodule
