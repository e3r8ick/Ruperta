module SignalTB();
	
		logic clk;
		logic reset;
		logic hsync;
		logic vsync;
		logic blank;
		logic sync_n;
		logic [9:0] cnt_h, cnt_v;
	
	signals_generator dut (.clk(clk),
							  .reset(reset), 
							  .hsync(hsync),
							  .vsync(vsync),
							  .blank(blank),
							  .sync_n(sync_n),
							  .cnt_h(cnt_h),
							  .cnt_v(cnt_v));

	
	initial 
	begin 
		reset = 1;
		#1;
		reset = 0;
		#1;
		reset = 1;
		#1;
		reset = 0;
		#1;
		reset = 1;
		#1;
		reset = 1;
		#1;
		reset = 0;
		#1;
		reset = 1;
		#1;
		reset = 0;
		#1;
		reset = 1;
	end	

	always
	begin
		clk<=1; #1; clk<=0; #1;
	end
	
	endmodule 