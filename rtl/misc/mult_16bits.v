`timescale 1ns/1ps
module mult_16bits#(parameter Bits = 16)			//16 bit multiplier (no fp)
(
input wire [Bits-1:0] iM, //multiplicand M
input wire [Bits-1:0] iQ, //multiplier Q
output wire [2*Bits-1:0] oZ;
);

//Booth decoder for partial product selection
/*The simple multiplication generator can be extended to reduce the number of partial products by 
grouping the bits of the multiplier into groups, and selecting the partial products from the set M,2M,3M,4M 
where M is the multiplicand.*/

logic [3:0] p_sel;
logic s;
logic [Bits+1:0] tmp1M; //18bit signals for the 4M = 2bit left shift
logic [Bits+1:0] tmp2M;
logic [Bits+1:0] tmp3M;
logic [Bits+1:0] tmp4M;

//Booth decoder for partial product selection {M,2M,3M,4M}.
//DUDA: how to select the group of bits in the multiplier (Q_group)? By shifting left 4 bits every clk edge? sequential ckt
always_comb begin
    case (Q_group)     //{1M,2M,3M,4M}
        4'b0000: p_sel = 4'b0000; s = 1'b0; //S=0 
        4'b0001: p_sel = 4'b1000; s = 1'b0; 
        4'b0010: p_sel = 4'b1000; s = 1'b0; 
        4'b0011: p_sel = 4'b0100; s = 1'b0; 
        4'b0100: p_sel = 4'b0100; s = 1'b0; 
        4'b0101: p_sel = 4'b0010; s = 1'b0; 
        4'b0110: p_sel = 4'b0010; s = 1'b0; 
        4'b0111: p_sel = 4'b0001; s = 1'b0; 
        4'b1000: p_sel = 4'b0001; s = 1'b1; //S=1 
        4'b1001: p_sel = 4'b0010; s = 1'b1;
        4'b1010: p_sel = 4'b0010; s = 1'b1;
        4'b1011: p_sel = 4'b0100; s = 1'b1;
        4'b1100: p_sel = 4'b0100; s = 1'b1;
        4'b1101: p_sel = 4'b1000; s = 1'b1;
        4'b1110: p_sel = 4'b1000; s = 1'b1;
        4'b1111: p_sel = 4'b0000; s = 1'b1;
        default: p_sel = 4'b0000; s = 1'b1; 
    endcase
end

//Generation of partial products (both positive and negative values eg. -M,+M)
//All xM signals are 18 bits size.
//1M = multiplicand itself or Multiplicand[k:0]. Where k is the MSB, thus k = Bits+1 (18bits).
//2M = M<<1 or {Multiplicand[k-1:0],1'b0}.
//3M = (1M + 2M) = M<<1 + 1M  or  {M,0}+{0,M}  
//4M = M<<2 or {Multiplicand[k-2:0],2'b00}.
always_comb begin
    tmp1M  =  {2'b00,iM} 
    tmp1MN = ~{2'b00,iM} + 18'd1;
    tmp2M  =  (tmp1M << 1); //k-1 = Bits (17th bit out of [Bits+1:0] = 18bits) --> DUDA: {tmp1M[Bits:0],1'b0}
    tmp2MN = ~(tmp1M << 1) + 18'd1; 
    tmp3M  =  (tmp1M + tmp2M);
    tmp3MN = ~(tmp1M + tmp2M) + 18'd1;
    tmp4M  =  (tmp1M << 2); //k-2 = Bits-1 (16th bit) --> DUDA: {tmp1M[Bits-1:0],2'b00} 
    tmp4M  = ~(tmp1M << 2) + 18'd1; //DUDA: could this overflow thus requiring 19 bits? 
end   

//Multiplexer for partial product selection according to p_sel and s.
//DUDA: Will there be 6 partial products always for 16 bit multiplication?
//DUDA: generate structure for 6 partial products?? otherwise "foreach group in multiplier -> (mult = mult + prt_prod)""
always_comb begin
    case (p_sel)     
        4'd0: prt_prod = 18'd0;  //DUDA: include -0? 
        4'd1: prt_prod = (!s) ? tmp1M : tmp1MN;
        4'd2: prt_prod = (!s) ? tmp2M : tmp2MN;
        4'd4: prt_prod = (!s) ? tmp3M : tmp3MN;
        4'd8: prt_prod = (!s) ? tmp4M : tmp4MN;
        default: prt_prod = 18'd0; 
    endcase
end





endmodule

