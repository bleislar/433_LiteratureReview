
`timescale 1 ns / 1 ps


module test_bench();

	reg [7:0] X, Y;
	reg clk;
	
	wire [15:0]P, pp3, pp2, pp1, pp0;
	wire [8:0]dec_x;
	wire [2:0]g3, g2, g1, g0;
	wire Cout;
	wire check;
	wire expected;

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

	class randomVariables;
        rand bit [7:0] randX;
        rand bit [7:0] randY;
    endclass

    randomVariables rv;

	always @(posedge clk)
	begin
		if(rv.randomize())
			expected = rv.randX * rv.randY;
			if (P == expected)
				check <= 1;
			else
				check <= 0;
	end
	
    always @(posedge clk) begin
        X = rv.randX;
	    Y = rv.randY;
    end
	
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
