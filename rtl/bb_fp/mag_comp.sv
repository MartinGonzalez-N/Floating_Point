module mag_comp #(WIDTH=11)(
input logic [WIDTH-1:0]a,
input logic [WIDTH-1:0]b,
output logic a_higher
);

assign a_higher = a>b;
endmodule