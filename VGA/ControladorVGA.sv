module ControladorVGA (
				input logic clock,
				input logic reset,
				//input logic [7:0] rIn,gIn, bIn,
				output logic vga_clk, hsync, vsync, blank, syncn,
				output logic [7:0] r, g, b);
				
				wire clkwire;
				logic [9:0] cnt_h, cnt_v;
				div_clk div25 (clock,reset,clkwire);
				signals_generator generator(.clk(clkwire),
													 .reset(reset),
													 .hsync(hsync),
													 .vsync(vsync),
													 .blank(blank),
													 .sync_n(syncn),
													 .cnt_h(cnt_h),
													 .cnt_v(cnt_v));

				assign vga_clk = clkwire;
				always@(*)
				begin
					
					if(cnt_h > cnt_v)
					begin
						r = 8'b10010110;
						g = 8'b00000000;
						b = 8'b00000000;
					end
					else
					begin
						r = 8'b11111111;
						g = 8'b11111111;
						b = 8'b11111111;
					end
				end
				
endmodule 