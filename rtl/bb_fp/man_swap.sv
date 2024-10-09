module man_swap #(MAN_WIDTH = 11)(
    input logic a_higher,
    input logic [MAN_WIDTH-1:0]man_a,
    input logic [MAN_WIDTH-1:0]man_b,
    input logic [MAN_WIDTH-1:0]man_higher,
    input logic [MAN_WIDTH-1:0]man_smaller
);
assign man_higher = a_higher ? man_a : man_b;
assign man_smaller = a_higher ? man_b : man_a;
endmodule