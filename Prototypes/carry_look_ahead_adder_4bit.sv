// 4-bit Carry Look Ahead Adder

module carry_look_ahead_adder_4bit(
	input [3:0]A, B, 
	input Cin, 
	
	output [3:0]S,
	output Cout
	);
	
	// Wires to connect the full adders
	wire C1, C2, C3;
	
	// Look Ahead Logic
	assign C1 = Cin&(A[0]|B[0]) | (A[0]&B[0]);
	assign C2 = C1&(A[1]|B[1]) | (A[1]&B[1]);
	assign C3 = C2&(A[2]|B[2]) | (A[2]&B[2]);
	assign Cout = C3&(A[3]|B[3]) | (A[3]&B[3]);
	
	// Instanitiation of 4 1-bit full adders
	full_adder fa_0(A[0], B[0], Cin, S[0]);
	full_adder fa_1(A[1], B[1], C1, S[1]);
	full_adder fa_2(A[2], B[2], C2, S[2]);
	full_adder fa_3(A[3], B[3], C3, S[3]);
	
endmodule