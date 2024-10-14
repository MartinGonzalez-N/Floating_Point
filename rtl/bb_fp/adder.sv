module adder #(MAN_WIDTH=11)(
    input logic [MAN_WIDTH+2:0] man_higher,
    input logic [MAN_WIDTH+2:0] aligned_man,
    input logic sub,
    output logic [MAN_WIDTH+2:0]sum,
    output logic carry
);
logic [MAN_WIDTH+3:0]sum1 ;
// if a number is negative (sub==1) will be inverted (comp1), so is necesary to add 1 
assign sum1 = man_higher + aligned_man + sub;
assign sum = sum1[MAN_WIDTH+2:0];
assign cout = sum1[MAN_WIDTH+3];
endmodule