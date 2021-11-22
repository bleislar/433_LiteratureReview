module FA(
	input a,
	input b,
	input cin,
	
	output  sum,
	output carry
);
	
	wire w0, w1, w2;
	
	xor xor0(w0, a, b);
	xor xor1(sum, w0, cin);
	
	and and0(w1, w0, cin);
	and and1(w2, a, b);
	
	or or0(carry, w1, w2);
	
endmodule
