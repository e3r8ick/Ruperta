module signals_generator (
		input logic clk,
		input logic reset,
		output logic hsync,
		output logic vsync,
		output logic blank,
		output logic sync_n,
		output logic [9:0] cnt_h, cnt_v);
		
		assign sync_n = 1;
		logic [9:0] cuenta_H;
		logic [9:0] cuenta_V;
		logic reset_h, reset_v;
		logic endline;
		logic blank_h;
		logic blank_v;
		
		counter contador_h(.clk(clk), .reset(reset_h), .count(cuenta_H));
		counter contador_v(.clk(endline), .reset(reset_v), .count(cuenta_V));
		

		always_ff @(posedge clk)begin
			if(~reset)begin
				reset_h <= 0;
				$display("reseteo");
				end
			if(~reset_h) begin
				reset_h <= 1;
				hsync <= 1;
				blank_h <= 1;
				endline <= 1;
			end
			
			if(cuenta_H == 10'b0)begin
				hsync <= 1;
				blank_h <= 1;
				endline <= 1;
				reset_h <= 1;
				$display("The value of a is: %b", endline) ;
			end	
			else if(cuenta_H == 640) begin
				blank_h <= 0;
				$display("640");
			end
			else if(cuenta_H == 656) begin
				hsync <= 0;
				blank_h <= 0; 
				$display("656");
			end
			else if(cuenta_H == 752) begin
				hsync <= 1;
				blank_h <= 0;
				$display("752");
			end
			else if(cuenta_H == 800) begin
				endline <= 0;
				reset_h <= 0;
				$display("800");
			end
		end
		
		always @(posedge clk)begin
			if(~reset)begin
				reset_v <= 0;
			end
			
			if(~reset_v)begin
				reset_v <= 1;
				vsync <= 1;
				blank_v <= 1;
			end
			
			if(cuenta_V == 10'b0)begin
				blank_v <= 1;
				vsync <= 1;
				reset_v <= 1;
			end
			else if(cuenta_V == 480)begin
				blank_v <= 0;
			end
			else if(cuenta_V == 490)begin
				vsync <= 0;
				blank_v <= 0;
			end
			else if(cuenta_V == 492) begin
				vsync <= 1;
				blank_v <= 0;
			end
			else if(cuenta_V == 525) begin
				reset_v<=0;
			end
		end
		
		
		assign blank = blank_h && blank_v;
		assign cnt_h = cuenta_H;
		assign cnt_v = cuenta_V;
endmodule	