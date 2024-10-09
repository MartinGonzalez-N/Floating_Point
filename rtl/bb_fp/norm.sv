module norm #(MAN_WIDTH=11)(
    input logic carry,
    input logic [3:0]lzc,
    input logic [MAN_WIDTH-1:0]data_in,
    output logic [MAN_WIDTH-1:0]data_out
);
logic [MAN_WIDTH-1:0] data_w;
assign data_w = data_in >> carry;
assign data_out = data_w << lzc;
    
endmodule