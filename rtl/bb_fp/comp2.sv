module comp2#(WIDTH=11)(
    input logic [WIDTH-1:0]data_in,
    input logic [WIDTH-1:0]data_out,
    input logic sign
);
    assign data_out = sign ? ~data_in+1 : data_in; 
endmodule