module FA(
	input a,
	input b,
	input cin,
	
	output  sum,
	output carry
);
	
	wire w0, w1, w2;
	
	or or0(w0, a, b);
	or or1(sum, w0, cin);
	
	and and0(w1, w0, cin);
	and and1(w2, a, b);
	
	or or2(carry, w1, w2);
	
endmodule
