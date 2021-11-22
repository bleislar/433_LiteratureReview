// 1-bit Half Adder (Approximate) 

module half_adder_approx(
	input A, B,
	
	output S, C
	);
	
	
	assign S = A | B; // Uses OR instead of XOR
	assign C = A & B; 
	
endmodule