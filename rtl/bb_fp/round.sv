module round #(MAN_WIDTH=11)(
    input logic [MAN_WIDTH-1:0]man_norm,
    output logic [MAN_WIDTH-1:0]man_round
);
logic m0;
logic r;
logic s;
logic round;
assign m0 = man_norm[4]; 
assign r = man_norm[3];
assign s = |man_norm[2:0];
assign round = r && (m0||s);
assign man_round = man_norm + round;
endmodule