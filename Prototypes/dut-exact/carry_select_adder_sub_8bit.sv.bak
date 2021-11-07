// 8-bit Carry Select Adder and Subtractor
// AddSub == 1'b0 --> Add
// AddSub == 1'b1 --> Sub

module carry_select_adder_sub_8bit(
	input [7:0]A, B, 
	input AddSub,
	
	output [7:0]S,
	output Cout
	);
	
	
	wire [7:0]addr_in; // Output of XOR
	
	assign addr_in = B ^ {8{AddSub}};
	
	carry_select_adder_8bit csa_0(
		.A(A), .B(addr_in), .Cin(AddSub), .S(S), .Cout(Cout)
		);
		
endmodule