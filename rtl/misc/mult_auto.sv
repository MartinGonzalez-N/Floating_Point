module mult_auto(
    input logic[15:0]a,
    input logic[15:0]b,
    input logic[31:0]c,

);
    assign c = a*b;
endmodule