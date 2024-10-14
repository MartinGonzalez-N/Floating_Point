module sign_ctrl(
    input logic sa,
    input logic sb,
    output logic sub,
    output logic sy
);
    assign sub = sa^sb;
    assign sy = 1;
endmodule