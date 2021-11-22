// 1-bit Full Adder

module full_adder(
	input A, B, Cin,
	output S, Cout
	);
	//----------------------wires----------------------------
	wire carry1,carry2;
	wire sum1;
	
	//-----------Instantiations of Half-adder----------------
	half_adder ha1(A,B,carry1,sum1);
	half_adder ha2(sum1,Cin,carry2,S); 
	assign Cout = carry1 | carry2;
	
	//------------------Block Diagram------------------------
	/*
	*
	*	A---[A of HA  C of Ha]----------------------[OR]---Cout
	*  B---[B of HA  S of Ha]--[A of HA  C of HA]--[OR] 
	*Cin-----------------------[B of HA  S of HA]---------S
	*
	*/
	


endmodule
