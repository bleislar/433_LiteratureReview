module HA(
	input  a,
	input  b,
	
	output sum,
	output carry
);
	
	or or0(sum, a, b);
	and and0(carry, a, b);
	
endmodule
