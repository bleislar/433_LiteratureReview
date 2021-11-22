// 8-bit Carry Select Adder

module carry_select_adder_8bit(
	input [7:0]A, B, 
	input Cin, 
	
	output [7:0]S,
	output Cout
	);
	
	
	wire [3:0]low, high;
	wire C_sel, C_low, C_high;
	
	
	// First 4-bits
	carry_look_ahead_adder_4bit claa_0_LSB(
		.A(A[3:0]), .B(B[3:0]), .Cin(Cin), .S(S[3:0]), .Cout(C_sel)
		);
	
	// Last 4-bits
	carry_look_ahead_adder_4bit claa_1_MSB_Low(
		.A(A[7:4]), .B(B[7:4]), .Cin(1'b0), .S(low), .Cout(C_low)
		);
	
	carry_look_ahead_adder_4bit claa_2_MSB_High(
		.A(A[7:4]), .B(B[7:4]), .Cin(1'b1), .S(high), .Cout(C_high)
		);
	
	// Select logic
	always @ *
		if (C_sel) // C_sel set
			begin
			S[7:4] <=  high;
			Cout <= C_high;
			end
			
		else
			begin
			S[7:4] <=  low;
			Cout <= C_low;
			end
			
endmodule