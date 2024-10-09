module exp_diff #(EXP_WIDTH = 5)(
    input logic [EXP_WIDTH-1:0] exp_a,
    input logic [EXP_WIDTH-1:0] exp_b,
    output logic [EXP_WIDTH-1:0] higher_exp,
    output logic [EXP_WIDTH-1:0] exp_diff,
    output logic a_higher
);
logic [EXP_WIDTH-1:0] a_high_diff;
logic [EXP_WIDTH-1:0] b_high_diff;
assign a_high_diff = exp_a - exp_b;
assign b_high_diff = exp_b - exp_a;
assign a_higher = exp_a > exp_b;
assign higher_exp = a_higher ? (exp_a) : (exp_b);
assign exp_diff = a_higher ? a_high_diff : b_high_diff;
endmodule