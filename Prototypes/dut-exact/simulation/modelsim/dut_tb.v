
`timescale 1 ns / 1 ps

module test_bench();

	reg [7:0] X, Y;
	reg clk;
	
	wire [15:0]P, pp3, pp2, pp1, pp0;
	wire [8:0]dec_x;
	wire [2:0]g3, g2, g1, g0;
	wire Cout;

	// Initialize registers
	initial clk = 1'b0;
	initial X = 8'd0;
	initial Y = 8'd0;
	//initial Cout = 0;
	initial #500 $stop; // set end time

	// Set clock
	always
		#1 clk = ~clk;
	
	// Begin tests
	initial
	begin

	#10 
	assign X = 8'd105;
	assign Y = -8'd107;

	end
	
	dut test_mult_1(
		.X(X), .Y(Y), 
			.P(P), .pp3(pp3), .pp2(pp2), .pp1(pp1), .pp0(pp0), // Partial Products
				.decode_x(dec_x), // 9-bit
					.g3(g3), .g2(g2), .g1(g1), .g0(g0), // 3-bit Groups
						.Cout(Cout)
		);

endmodule
