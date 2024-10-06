`timescale 1ns/1ps
module mult_16bits#(parameter Bits = 16)			//16 bit multiplier (no fp)
(
input wire [Bits-1:0] iM, //multiplicand M
input wire [Bits-1:0] iQ, //multiplier Q
output wire [2*Bits-1:0] oZ
);

//Booth decoder for partial product selection
/*The simple multiplication generator can be extended to reduce the number of partial products by 
grouping the bits of the multiplier into groups, and selecting the partial products from the set M,2M,3M,4M 
where M is the multiplicand.*/

logic s [5:0];
logic [3:0] p_sel [5:0];
logic [3:0] iQ_group [5:0];
logic [Bits+2:0] tmp_iQ; //19 bit signal for group selection
logic [Bits+1:0] tmp1M, tmp1MN; //18bit signals for the 4M = 2bit left shift + sign MSB
logic [Bits+1:0] tmp2M, tmp2MN;
logic [Bits+1:0] tmp3M, tmp3MN;
logic [Bits+1:0] tmp4M, tmp4MN;
logic [Bits+1:0] tmpM_val [5:0];
logic [2*Bits-1:0] prt_prod [5:0]; //6 partial products
logic [2*Bits-1:0] SUM1,SUM2,SUM3,SUM4;


//Generation of partial products (both positive and negative values eg. -M,+M)
//All xM signals are 18 bits size.
//1M = multiplicand itself or Multiplicand[k:0]. Where k is the MSB, thus k = Bits+1 (18bits).
//2M = M<<1 or {Multiplicand[k-1:0],1'b0}.
//3M = (1M + 2M) = M<<1 + 1M  or  {M,0}+{0,M}  
//4M = M<<2 or {Multiplicand[k-2:0],2'b00}.
//carry s bit for negative values
always_comb begin
    tmp1M  =  {2'b00,iM}; 
    tmp1MN = ~{2'b00,iM}; //+ 18'd1; 
    tmp2M  =  (tmp1M << 1); 
    tmp2MN = ~(tmp1M << 1); // + 18'd1; 
    tmp3M  =  (tmp1M + tmp2M);
    tmp3MN = ~(tmp1M + tmp2M); // + 18'd1;
    tmp4M  =  (tmp1M << 2);  
    tmp4MN  = ~(tmp1M << 2); // + 18'd1; 
end   


//Booth decoder for partial product selection {M,2M,3M,4M}. 
//Generated 6 times as 6 partial products are generated from 6 iQ groups.
assign tmp_iQ = {2'b00,iQ,1'b0};

genvar i;
generate
for (i = 0; i < 6; i = i + 1) begin : Booth_decoder
    always_comb begin
    iQ_group[i] = tmp_iQ[((i*3)+3):i*3]; //i=0 => LSB

      case (iQ_group[i])     // {4M,3M,2M,1M}
        4'b0000: begin p_sel[i] = 4'b0000; s[i] = 1'b0; end //S=0 
        4'b0001: begin p_sel[i] = 4'b0001; s[i] = 1'b0; end
        4'b0010: begin p_sel[i] = 4'b0001; s[i] = 1'b0; end
        4'b0011: begin p_sel[i] = 4'b0010; s[i] = 1'b0; end
        4'b0100: begin p_sel[i] = 4'b0010; s[i] = 1'b0; end
        4'b0101: begin p_sel[i] = 4'b0100; s[i] = 1'b0; end
        4'b0110: begin p_sel[i] = 4'b0100; s[i] = 1'b0; end
        4'b0111: begin p_sel[i] = 4'b1000; s[i] = 1'b0; end
        4'b1000: begin p_sel[i] = 4'b1000; s[i] = 1'b1; end//S=1 
        4'b1001: begin p_sel[i] = 4'b0100; s[i] = 1'b1; end
        4'b1010: begin p_sel[i] = 4'b0100; s[i] = 1'b1; end
        4'b1011: begin p_sel[i] = 4'b0010; s[i] = 1'b1; end
        4'b1100: begin p_sel[i] = 4'b0010; s[i] = 1'b1; end
        4'b1101: begin p_sel[i] = 4'b0001; s[i] = 1'b1; end
        4'b1110: begin p_sel[i] = 4'b0001; s[i] = 1'b1; end
        4'b1111: begin p_sel[i] = 4'b0000; s[i] = 1'b1; end
        default: begin p_sel[i] = 4'b0000; s[i] = 1'b1; end
    endcase

    //Multiplexer for partial product selection according to p_sel and s.
    case (p_sel[i])     
        4'd0: tmpM_val[i] = (!s[i]) ? 18'd0 : ~18'd0;
        4'd1: tmpM_val[i] = (!s[i]) ? tmp1M : tmp1MN;
        4'd2: tmpM_val[i] = (!s[i]) ? tmp2M : tmp2MN;
        4'd4: tmpM_val[i] = (!s[i]) ? tmp3M : tmp3MN;
        4'd8: tmpM_val[i] = (!s[i]) ? tmp4M : tmp4MN;
        default: tmpM_val[i] = 18'd0; 
    endcase

    //Final partial product generation (of size [2*Bits-1:0] = 32 bits)
    //Instead of shifting 6 partial products of 32 bits are created, to then be added accordingly. 
    //should a carry vector be created instead of adding the sign bit in every partial prod? s_Carry[i] = 1 << xbits
    case (i)    
        3'd0: prt_prod[i] = { 10'd0,~s[i],s[i],s[i],s[i],tmpM_val[i]} +  {31'd0,s[i]}; //LSB
        3'd1: prt_prod[i] = ({10'd0,3'b011,~s[i],tmpM_val[i]} << i*3) + ({31'd0,s[i]} << i*3);
        3'd2: prt_prod[i] = ({10'd0,3'b011,~s[i],tmpM_val[i]} << i*3) + ({31'd0,s[i]} << i*3);  
        3'd3: prt_prod[i] = ({10'd0,3'b011,~s[i],tmpM_val[i]} << i*3) + ({31'd0,s[i]} << i*3);
        3'd4: prt_prod[i] = ({10'd0,3'b001,~s[i],tmpM_val[i]} << i*3) + ({31'd0,s[i]} << i*3);
        3'd5: prt_prod[i] = ({10'd0,3'b000, 1'b0,tmpM_val[i]} << i*3);
        default: prt_prod[i] = 32'd0; 
    endcase

    end
end
endgenerate

//Partial product addition
assign SUM1 = prt_prod[0] + prt_prod[1];
assign SUM2 = prt_prod[2] + prt_prod[3];
assign SUM3 = prt_prod[4] + prt_prod[5];
assign SUM4 = SUM1 + SUM2;
assign oZ = SUM3 + SUM4;

endmodule