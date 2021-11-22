module dut (
	input clk,
	input rst,
	input [7:0] x,
	input [7:0] y,
	output reg [15:0] p
	);


	reg [7:0] x_temp;
	reg [7:0] y_temp;
	wire [15:0] p_temp;
	
	always@(posedge clk) begin
		x_temp <= x;
		y_temp <= y;
		p <= p_temp;
	end
	
	
	booth_8x8_radix_4_approx dut(
		.x(x_temp),
		.y(y_temp),
		.p(p_temp),
		.rst(rst),
		.clk(clk)
		);

endmodule
