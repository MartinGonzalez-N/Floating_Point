module lzc_4 (
    input [3:0] a,
    output [1:0] c,
    output v
);

assign v = | a;
assign c[0] = ~a[3] & ( a[2] | (~a[1]) ) ;
assign c[1] = (~a[3] & ~a[2]) ; 

endmodule

 
 


