module div_clk_TB();
//	
	logic  vgaclk;
	logic clock;
	logic reset;
	
	div_clk dut (.clock(clock),
					 .reset(reset),
					 .vgaclk(vgaclk));
	initial begin
		reset = 1;
		#20;
		reset = 0;
		#10
		reset = 1;
	end
	
	always
	begin
		clock = 1; 
		#1; 
		clock = 0; 
		
		#1;
	end
	
	
	endmodule 