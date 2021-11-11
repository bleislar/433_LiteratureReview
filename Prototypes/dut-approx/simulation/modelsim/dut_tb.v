
`timescale 1 ns / 1 ps

module test_bench(
	wire [7:0] X,
	wire [7:0] Y,
	wire clk,
	wire [15:0]P,
	wire [15:0]pp3,
	wire [15:0]pp2,
	wire [15:0]pp1,
	wire [15:0]pp0,
	wire [8:0]dec_x,
	wire [2:0]g3,
	wire [2:0]g2,
	wire [2:0]g1,
	wire [2:0]g0,
	wire Cout,
	wire [15:0]expected,
	wire check
	);

	//-----------Initialize registers-----------
	initial begin
		clk = 1'b0;
		X = 8'd0;
		Y = 8'd0;
	end
	//----------------End time------------------
	initial #500 $stop; // set end time
	//----------------Set clock----------------
	always
		#1 clk = ~clk;

	//----------------Testing------------------
	// class randomVariables;
	// 	rand byte [7:0] randX;
	// 	rand byte [7:0] randY;
	// endclass
	//
	// always@(posedge clk)
	// begin
	// 	if(randomVariables.randomize())
	// 		expected = randX * randY;
	// 		if (P == expected)
	// 			check <= 1;
	// 		else
	// 			check <= 0;
	// end
	//
	// assgin X = randomVariables.randX;
	// assign Y = randomVariables.randY;

	initial
	begin

	#10
	assign X = 8'd105;
	assign Y = -8'd107;

	end

	//----------dut instatiation--------------
	dut test_mult_1(
		.X(X),
		.Y(Y),
		.P(P),
		.pp3(pp3),
		.pp2(pp2),
		.pp1(pp1),
		.pp0(pp0), // Partial Products
		.decode_x(dec_x), // 9-bit
		.g3(g3),
		.g2(g2),
		.g1(g1),
		.g0(g0), // 3-bit Groups
		.Cout(Cout)
		);

endmodule
