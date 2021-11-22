module action_dec(
		input [7:0]Y,
		input [2:0]g,
		
		output [16:0]pp
		);
		
	wire [7:0]neg_Y, Y_plus_Y, neg_Y_min_Y;
	wire C_ypy, C_nymy;
	
	assign neg_Y = (~Y) + 1'b1; // Logic for negative Y
	
	
	carry_select_adder_sub_8bit adder_1(
			.A(Y), .B(Y), .AddSub(1'b0), .S(Y_plus_Y), .Cout(C_ypy)
			);
	
	carry_select_adder_sub_8bit adder_2(
			.A(neg_Y), .B(neg_Y), .AddSub(1'b0), .S(neg_Y_min_Y), .Cout(C_nymy)
			);
	
	
	always @ *
	begin
		case(g)
			3'b000	:	pp = 0; // 0 * Y
			3'b001	:	pp = {{8{Y[7]}}, Y}; // 1 * Y
			3'b010	:	pp = {{8{Y[7]}}, Y}; // 1 * Y
			3'b011	:	pp = {{8{C_ypy}}, Y_plus_Y}; // 2 * Y --> Should have a mult. here I think
			3'b100	:	pp = {{8{C_nymy}}, neg_Y_min_Y}; // -2 * Y
			3'b101	:	pp = {{8{neg_Y[7]}}, neg_Y}; // -1 * Y
			3'b110	:	pp = {{8{neg_Y[7]}}, neg_Y}; // -1 * Y
			3'b111	:	pp = 0; // 0 * Y
		endcase
	end
endmodule
