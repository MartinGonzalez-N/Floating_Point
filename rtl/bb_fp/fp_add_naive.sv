module fp_add_naive#(BITS=16)(
    input logic [BITS-1:0]a,
    input logic [BITS-1:0]b,
    output logic [BITS-1:0]y
);
//parameters
localparam M_BITS = 11;
localparam E_BITS = 5;
logic sa;
logic sb;
logic [E_BITS-1:0] exp_a;
logic [E_BITS-1:0] exp_b;
logic [M_BITS-1:0] man_a;
logic [M_BITS-1:0] man_b;
//sign extraction
assign sa = a[BITS-1];
assign sb = b[BITS-1];
//exponent extraction
assign exp_a = a[BITS-2:M_BITS-1];
assign exp_b = b[BITS-2:M_BITS-1];
//mantissa extraction
assign man_a = {|exp_a,a[M_BITS-2:0]};
assign man_b = {|exp_b,b[M_BITS-2:0]};
//signals
logic sub;
logic [E_BITS-1:0]higher_exp;
logic [E_BITS-1:0]exp_diff;
logic a_higher;
logic [M_BITS-1:0]man_heigher;
logic [M_BITS-1:0]man_smaller;
logic [M_BITS-1:0]aligned_man;
logic [M_BITS-1:0]sum;
logic carry;
logic [M_BITS-1:0]man_denorm;
logic [M_BITS-1:0]man_norm;
logic [3:0]lzc;
logic round;
//result
logic sy;
logic [E_BITS-1:0]exp_y;
logic [M_BITS-1:0]man_y;
//////////////////////////////////////////////////////////
sign_ctrl sign_ctrl_i(.sa(sa),.sb(sb),.sub(sub),.sy(sy));

exp_diff #(.EXP_WIDTH(E_BITS)) exp_diff_i (.exp_a(exp_a),.exp_b(exp_b),.higher_exp(higher_exp),.exp_diff(exp_diff),.a_higher(a_higher));

man_swap #(.MAN_WIDTH(M_BITS)) man_swap_i (.a_higher(a_higher),.man_a(man_a),.man_b(man_b),.man_higher(man_higher),.man_smaller(man_smaller));

man_align #(.MAN_WIDTH(M_BITS),.EXP_WIDTH(E_BITS)) man_align_i (.man_smaller(man_smaller),.aligned_man(aligned_man),.exp_diff(exp_diff));

adder #(.MAN_WIDTH(M_BITS)) adder_i (.man_higher(man_higher),.aligned_man(aligned_man),.sub(sub),.sum(sum),.carry(carry));

comp2 #(.WIDTH(M_BITS+3)) comp2_i (.data_in(sum),.sign(sy),.data_out(man_denorm));

lzd lzd_i(.data(man_denorm),.lzc(lzc));

norm #(.MAN_WIDTH(M_BITS)) norm_i (.carry(carry),.lzc(lzc),.data_in(man_denorm),.data_out(man_norm));

round #(.MAN_WIDTH(M_BITS)) round_i (.man_norm(man_norm),.man_round(man_y));

//exp ajust
assign exp_y = higher_exp-lzc+carry;

assign y = {sy,exp_y,man_y};
endmodule