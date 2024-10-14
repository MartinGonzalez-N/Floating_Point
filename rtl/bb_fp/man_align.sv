module man_align  #(MAN_WIDTH = 11, EXP_WIDTH = 5)(
    input logic  [MAN_WIDTH-1:0]man_smaller,
    input logic [EXP_WIDTH-1:0]exp_diff,
    output logic  [MAN_WIDTH+2:0]aligned_man
);
logic [MAN_WIDTH-1:0] shifted_man;
logic [2:0]grs;
logic [MAN_WIDTH-3:0]sticky_bus;
assign {shifted_man,grs[2:1],sticky_bus} = {man_smaller,{(MAN_WIDTH){0}}} >> exp_diff;
assign grs[0] = |sticky_bus;
assign aligned_man = {shifted_man,grs};
endmodule