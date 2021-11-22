
`timescale 1 ns / 1 ps

class randomVariables;
	rand byte [7:0] randX;
	rand byte [7:0] randY;
endclass

module test_bench();

	reg [7:0] X, Y;
	reg clk;
	
	wire [15:0]P, pp3, pp2, pp1, pp0;
	wire [8:0]dec_x;
	wire [2:0]g3, g2, g1, g0;
	wire Cout;
	wire check;

	//----------Initialization------------
	initial begin
		clk = 1'b0;
	 	X = 8'd0;
	 	Y = 8'd0;
		#500 $stop;
	end

	//--------------clock-------------------
	always #1 clk = ~clk;
	
	//-------------Testing------------------
	
	always @(posedge clk)
	begin
		if(randomVariables.randomize())
			expected = randX * randY;
			if (P == expected)
				check <= 1;
			else
				check <= 0;
	end
	
	assign X = randomVariables.randX;
	assign Y = randomVariables.randY;
	
	dut test_mult_1(
		.clk(clk),
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
