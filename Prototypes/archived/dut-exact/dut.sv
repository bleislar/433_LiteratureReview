module dut(
	input clk,
	input reg [7:0] X,
	input reg [7:0] Y,
	output reg [15:0]P, 
	output reg [15:0]pp3,
	output reg [15:0]pp2, 
	output reg [15:0]pp1, 
	output reg [15:0]pp0, 
	output reg [8:0]decode_x, 
	output reg [2:0]g3, 
	output reg [2:0]g2, 
	output reg [2:0]g1, 
	output reg [2:0]g0, 
	output reg Cout
);

	reg [7:0] X_temp;
	reg [7:0] Y_temp;
	reg [15:0]P_temp; 
	reg [15:0]pp3_temp;
	reg [15:0]pp2_temp; 
	reg [15:0]pp1_temp; 
	reg [15:0]pp0_temp; 
	reg [8:0]decode_x_temp; 
	reg [2:0]g3_temp; 
	reg [2:0]g2_temp; 
	reg [2:0]g1_temp; 
	reg [2:0]g0_temp; 
	reg Cout_temp;
	
	always@(posedge clk)
		begin
			X_temp <= X;
			Y_temp <= Y;
			P <= P_temp; 
			pp3 <= pp3_temp;
			pp2 <= pp2_temp;
			pp1 <= pp1_temp;
         pp0 <= pp0_temp;
			decode_x <= decode_x_temp;
			g3 <= g3_temp;
			g2 <= g2_temp;
			g1 <= g1_temp;
			g0 <= g0_temp;
			Cout <= Cout_temp;
		end
		
		
	booth_multiplier_8bit bm(
		.X(X_temp),
		.Y(Y_temp),
		.P(P_temp),
		.pp3(pp3_temp),
		.pp2(pp2_temp),
		.pp1(pp1_temp),
		.pp0(pp0_temp),
		.decode_x(decode_x_temp),
		.g3(g3_temp),
		.g2(g2_temp),
		.g1(g1_temp),
		.g0(g0_temp),
		.Cout(Cout_temp)
	);
	

endmodule
