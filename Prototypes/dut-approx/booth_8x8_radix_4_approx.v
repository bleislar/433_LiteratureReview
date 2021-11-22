module booth_8x8_radix_4_approx #(parameter M=16) (
	input wire [7:0] x,
	input wire [7:0] y,
	
	output [M-1:0] p,
	
	input wire [0:0] clk,
	input wire [0:0] rst
);
	
	localparam N = 8;
	
	genvar i, j;
	
	//------------------clock inputs-------------------
	reg [7:0] xs, ys;
	always @ (posedge clk or posedge rst)
		if (rst == 1'b1) begin
			xs <= 8'd0;
			ys <= 8'd0;
		end else begin
			xs <= x;
			ys <= y;
		end
	
	//-------------radix-4 booth recoding--------------
	wire [N/2:0] zero;
	wire [N/2-1:0] neg, two, cor;

	assign neg[0] = ys[1];
	assign two[0] = ys[1] & ~ys[0];
	assign zero[0] = ~ys[1] & ~ys[0];
	assign cor[0] = neg[0];
	
	generate
		for (i=1; i < N/2; i=i+1) begin: gen_booth_encoding 
			assign neg[i] = ys[2*i+1] & ~(ys[2*i] & ys[2*i-1]);
			assign two[i] = ~ys[2*i+1] & ys[2*i] & ys[2*i-1]| ys[2*i+1] & ~ys[2*i] & ~ys[2*i-1];
			assign zero[i] = ys[2*i+1] & ys[2*i] & ys[2*i-1]| ~ys[2*i+1] & ~ys[2*i] & ~ys[2*i-1];
			assign cor[i] = neg[i];
		end
	endgenerate
	
	assign zero[N/2] = ~ys[N-1];
	
	//-----radix-4 booth partial product generation-----
	wire [N:0] pp [0:N/2];


	generate
		for (i=0; i < N/2; i=i+1) begin: gen_pp_i
			ppg ppg_0(.neg(neg[i]), .two(two[i]), .zero(zero[i]), .x_j(xs[0]), .x_jm1(1'b0), .pp(pp[i][0]));
			for (j=1; j < N; j=j+1) begin: gen_pp_j
				ppg ppg_1 ( .neg(neg[i]), .two(two[i]), .zero(zero[i]), .x_j(xs[j]), .x_jm1(xs[j-1]), .pp(pp[i][j]));
			end 
			ppg ppg_2(.neg(neg[i]), .two(two[i]), .zero(zero[i]), .x_j(1'b0), .x_jm1(xs[N-1]), .pp(pp[i][N]));
		end
	endgenerate
	
	ppg ppg_3(.neg(1'b0), .two(1'b0), .zero(zero[N/2]), .x_j(xs[0]), .x_jm1(1'b0), .pp(pp[N/2][0]));
	generate
		for (j=1; j < N; j=j+1) begin: gen_pp4_js
			ppg ppg_4(.neg(1'b0), .two(1'b0), .zero(zero[N/2]), .x_j(xs[j]), .x_jm1(xs[j-1]), .pp(pp[N/2][j]));
		end
		ppg ppg_5(.neg(1'b0), .two(1'b0), .zero(zero[N/2]), .x_j(1'b0), .x_jm1(xs[N-1]), .pp(pp[N/2][N]));
	endgenerate
	
	//-----------acumulate partial products--------------
	
	// stage 1
	wire [12:6] s1;
	wire [13:7] c1;
	
	HA comp_00(pp[0][6], pp[1][4], s1[6], c1[7]);
	HA comp_01(pp[0][7], pp[1][5], s1[7], c1[8]);
	FA comp_02(pp[0][8], pp[1][6], pp[2][4], s1[8], c1[9]);
	FA comp_03(cor[0], pp[1][7], pp[2][5], s1[9], c1[10]);
	FA comp_04(cor[0], pp[1][8], pp[2][6], s1[10], c1[11]);
	FA comp_05(~cor[0], ~cor[1], pp[2][7], s1[11], c1[12]);
	HA comp_06(1'b1, pp[2][8], s1[12], c1[13]);
	
	// stage 2
	wire [14:4] s2;
	wire [15:5] c2;
	
	HA comp_07(pp[0][4], pp[1][2], s2[4], c2[5]);
	HA comp_08(pp[0][5], pp[1][3], s2[5], c2[6]);
	FA comp_09(s1[6], pp[2][2], pp[3][0], s2[6], c2[7]);
	FA comp_10(s1[7], c1[7], pp[2][3], s2[7], c2[8]);
	FA comp_11(s1[8], c1[8], pp[3][2], s2[8], c2[9]);
	FA comp_12(s1[9], c1[9], pp[3][3], s2[9], c2[10]);
	FA comp_13(s1[10], c1[10], pp[3][4], s2[10], c2[11]);
	FA comp_14(s1[11], c1[11], pp[3][5], s2[11], c2[12]);
	FA comp_15(s1[12], c1[12], pp[3][6], s2[12], c2[13]);
	FA comp_16(c1[13], ~cor[2], pp[3][7], s2[13], c2[14]);
	HA comp_17(1'b1, pp[3][8], s2[14], c2[15]);
	
	// stage 3
	wire [15:2] s3;
	wire [16:3] c3;
	
	HA comp_18(pp[0][2], pp[1][0], s3[2], c3[3]);
	HA comp_19(pp[0][3], pp[1][1], s3[3], c3[4]);
	FA comp_20(s2[4], pp[2][0], cor[2], s3[4], c3[5]);
	FA comp_21(s2[5], c2[5], pp[2][1], s3[5], c3[6]);
	FA comp_22(s2[6], c2[6], cor[3], s3[6], c3[7]);
	FA comp_23(s2[7], c2[7], pp[3][1], s3[7], c3[8]);
	FA comp_24(s2[8], c2[8], pp[4][0], s3[8], c3[9]);
	FA comp_25(s2[9], c2[9], pp[4][1], s3[9], c3[10]);
	FA comp_26(s2[10], c2[10], pp[4][2], s3[10], c3[11]);
	FA comp_27(s2[11], c2[11], pp[4][3], s3[11], c3[12]);
	FA comp_28(s2[12], c2[12], pp[4][4], s3[12], c3[13]);
	FA comp_29(s2[13], c2[13], pp[4][5], s3[13], c3[14]);
	FA comp_30(s2[14], c2[14], pp[4][6], s3[14], c3[15]);
	FA comp_31(c2[15], ~cor[3], pp[4][7], s3[15], c3[16]);
	
	// stage 4

	wire [16:1] cout;
	
	HA comp_32(pp[0][0], cor[0], p[0], cout[1]);
	HA comp_33(pp[0][1], cout[1], p[1], cout[2]);
	FA comp_34(s3[2], cor[1], cout[2], p[2], cout[3]);
	FA comp_35(s3[3], c3[3], cout[3], p[3], cout[4]);
	FA comp_36(s3[4], c3[4], cout[4], p[4], cout[5]);
	FA comp_37(s3[5], c3[5], cout[5], p[5], cout[6]);
	FA comp_38(s3[6], c3[6], cout[6], p[6], cout[7]);
	FA comp_39(s3[7], c3[7], cout[7], p[7], cout[8]);
	FA comp_40(s3[8], c3[8], cout[8], p[8], cout[9]);
	FA comp_41(s3[9], c3[9], cout[9], p[9], cout[10]);
	FA comp_42(s3[10], c3[10], cout[10], p[10], cout[11]);
	FA comp_43(s3[11], c3[11], cout[11], p[11], cout[12]);
	FA comp_44(s3[12], c3[12], cout[12], p[12], cout[13]);
	FA comp_45(s3[13], c3[13], cout[13], p[13], cout[14]);
	FA comp_46(s3[14], c3[14], cout[14], p[14], cout[15]);
	FA comp_47(s3[15], c3[15], cout[15], p[15], cout[16]);
	
	
  
	

endmodule
