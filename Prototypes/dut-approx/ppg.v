module ppg(
    input neg,
    input two,
    input zero,
    input x_j,
    input x_jm1,
    
    output pp
);
    
    wire m;
    
    assign m = (x_j & ~two) | (x_jm1 & two);
    assign pp = ~zero & (neg ^ m);

endmodule
