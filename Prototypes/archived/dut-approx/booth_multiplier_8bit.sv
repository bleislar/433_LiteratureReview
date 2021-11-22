// 8-bit Modified Booth Multiplier

module booth_multiplier_8bit(
	input [7:0]X, Y, 
	
	output [15:0]P, pp3, pp2, pp1, pp0, // Partial Products
	output [8:0]decode_x, // 9-bit
	output [2:0]g3, g2, g1, g0, // 3-bit Groups
	output Cout
	);
	
	
	//wire [15:0]pp3, pp2, pp1, pp0; // Partial Products
	//wire [8:0]decode_x; // 9-bit
	//wire [2:0]g3, g2, g1, g0; // 3-bit Groups
	
	assign decode_x = {X, 1'b0}; // Pad LSB with 0
	
	assign g0 = decode_x[2:0]; // Groups to find operation
	assign g1 = decode_x[4:2];
	assign g2 = decode_x[6:4];
	assign g3 = decode_x[8:6];
	
	// 4 Blocks
	action_dec block_0(.Y(Y), .g(g0), .pp(pp0));
	action_dec block_1(.Y(Y), .g(g1), .pp(pp1));
	action_dec block_2(.Y(Y), .g(g2), .pp(pp2));
	action_dec block_3(.Y(Y), .g(g3), .pp(pp3));

	assign P = (pp0 + (pp1 << 2) + (pp2 << 4) + (pp3 << 6));
	
	
endmodule
		
