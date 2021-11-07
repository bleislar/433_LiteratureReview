// 4-bit Carry Look Ahead Adder

module carry_look_ahead_adder_4bit(
	input [3:0]A, B, 
	input Cin, 
	
	output [3:0]S,
	output Cout
	);
	
	//-----------------Wires--------------------
	wire C1, C2, C3;
	wire [3:0]P;
	wire [3:0]G;
	//-------------Propagate Logic--------------
	initial begin
		for(int i = 0; i < 4; i++)
			P[i] = A[i] | B[i];
	end
	//-------------Generate Logic---------------
	initial begin
		for(int i = 0; i < 4; i++)
			G[i] = A[i] & B[i];
	end
	//------------Look Ahead Logic--------------
	assign C1 = Cin & P[0] | G[0];
	assign C2 = C1 & P[1] | G[1];
	assign C3 = C2 & P[2] | G[2];
	assign Cout = C3 & P[3] | G[3];
	
	//---Instanitiation of 4 1-bit full adders--
	full_adder_approx fa_0(A[0], B[0], Cin, S[0]);
	full_adder_approx fa_1(A[1], B[1], C1, S[1]);
	full_adder_approx fa_2(A[2], B[2], C2, S[2]);
	full_adder_approx fa_3(A[3], B[3], C3, S[3]);
	
endmodule
