	module ControladorVGA (
				input logic clock,
				input logic reset,
				input logic [31:0] rgbInMem,
				output logic vga_clk, hsync, vsync, blank, syncn,
				output logic [7:0] r, g, b,
				output logic [31:0] dirMem);
				
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
				
				reg [31:0] inicialDir = 31'b00000000000000000000000000000000;
				reg [31:0] tempDir = 31'b01000000000000000000000000000000;
				reg [3:0] spriteCnt = 3'b0;

				assign dirMem = tempDir;
				assign vga_clk = clkwire;
				
				always@(posedge clkwire)
				begin				
					if(cnt_h < 640 && cnt_v < 480)
					begin
						case (spriteCnt)						
						1:begin
						r[7:4] = rgbInMem[23:21];
						r[3:0] = 0;
						g[7:4] = rgbInMem[20:18];
						g[3:0] = 0;
						b[7:4] = rgbInMem[17:16];
						b[3:0] = 0;
						
						end
						
						2:begin
						r[7:4] = rgbInMem[15:13];
						r[3:0] = 0;
						g[7:4] = rgbInMem[12:10];
						g[3:0] = 0;
						b[7:4] = rgbInMem[9:8];
						b[3:0] = 0;
						
						end
						
						3:begin
						r[7:4] = rgbInMem[7:5];
						r[3:0] = 0;
						g[7:4] = rgbInMem[4:2];
						g[3:0] = 0;
						b[7:4] = rgbInMem[1:0];
						b[3:0] = 0;
						
						end
						
						default:begin
						r[7:4] = rgbInMem[31:29];
						r[3:0] = 0;
						g[7:4] = rgbInMem[28:26];
						g[3:0] = 0;
						b[7:4] = rgbInMem[25:24];
						b[3:0] = 0;
						
						end
					endcase
				end
			end
				
			always @(posedge clkwire) begin
				if(cnt_h < 640 && cnt_v < 480)
					begin
					if(spriteCnt == 4)begin 
							tempDir = tempDir + 4;
							spriteCnt = 0;
					end
					else begin
							spriteCnt = spriteCnt + 3'b1;
					end
				end
				else if(cnt_h > 640 && cnt_v > 480) begin
						tempDir = inicialDir;
						spriteCnt = 2'b0;
					end
				end	
endmodule 