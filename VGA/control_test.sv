module control_test();
	
	logic hsync;
	logic vsync;
	logic clock;
	logic reset;
	logic	vga_clk;
	logic	blank;
	logic [7:0] r,g,b;
	
	ControladorVGA dut (.clock(clock),
							  .reset(reset), 
							  .vga_clk(vga_clk),
							  .hsync(hsync),
							  .vsync(vsync),
							  .blank(blank),
							  .r(r),
							  .g(g),
							  .b(b));

	
	initial 
	begin 
		reset = 1;
		#1;
		reset = 0;
		#1;
		reset = 1;
		#10;
		reset = 0;
		#1;
		reset = 1;
	end	

	always
	begin
		clock<=1; #1; clock<=0; #1;
	end
	
	endmodule 