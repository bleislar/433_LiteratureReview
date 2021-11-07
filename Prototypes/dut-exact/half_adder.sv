// 1-bit Half Adder (Exact) 

module half_adder(
	input A, B,
	output S, C
	);
	
	
	assign S = A ^ B;
	assign C = A & B;
	
endmodule
