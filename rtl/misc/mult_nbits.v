`timescale 1ns/1ps
module mult_nbits#(parameter Bits = 16)	
(
input wire [Bits-1:0] iM, //multiplicand M
input wire [Bits-1:0] iQ, //multiplier Q
output wire [2*Bits-1:0] oZ
);

//Booth decoder for partial product selection
/*The simple multiplication generator can be extended to reduce the number of partial products by 
grouping the bits of the multiplier into groups, and selecting the partial products from the set M,2M,3M,4M 
where M is the multiplicand.*/

//local parameters for nbit multiplier
localparam TMP_M_SIZE = Bits+1;
localparam OUT_SIZE = 2*Bits;
localparam OUT_SIZE_MIN1 = 2*Bits - 1;
localparam PP_NUM = (Bits / 3) + (Bits % 3 == 0 ? 0 : 1);
localparam TMP_IQ_MSB_PADDING = (3 - (Bits-1)%3);
localparam PRT_PROD_MSB_SIZE = (2*Bits) - (Bits+2+4);//2 = 4M, 4 = !s,s,s,s 
localparam IDATA_WIDTH = 2*Bits;
localparam STAGES_NUM = $clog2(PP_NUM);
localparam INPUTS_NUM_INT = 2 ** STAGES_NUM;
localparam ODATA_WIDTH = IDATA_WIDTH + STAGES_NUM;


logic [PP_NUM-1:0] s;
logic [PP_NUM-1:0] [3:0] p_sel; //4bit dec for n partial products 
logic [PP_NUM-1:0] [3:0] iQ_group; //4bit groups for n partial products
logic [Bits+TMP_IQ_MSB_PADDING-1:0] tmp_iQ; //n bit signal for group selection
logic [Bits+1:0] tmp1M, tmp1MN; //18bit signals for the 4M = 2bit left shift + sign MSB
logic [Bits+1:0] tmp2M, tmp2MN;
logic [Bits+1:0] tmp3M, tmp3MN;
logic [Bits+1:0] tmp4M, tmp4MN;
logic [PP_NUM-1:0] [Bits+1:0] tmpM_val; //idata[adder][ST_WIDTH-1:0];
logic [PP_NUM-1:0] [2*Bits-1:0] prt_prod; //n partial products


//Generation of partial products (both positive and negative values eg. -M,+M)
//All xM signals are 18 bits size.
//1M = multiplicand itself or Multiplicand[k:0]. Where k is the MSB, thus k = Bits+1.
//2M = M<<1 or {Multiplicand[k-1:0],1'b0}.
//3M = (1M + 2M) = M<<1 + 1M  or  {M,0}+{0,M}  
//4M = M<<2 or {Multiplicand[k-2:0],2'b00}.
//carry s bit for negative values
always_comb begin
    tmp1M  =  {2'b00,iM}; 
    tmp1MN = ~{2'b00,iM}; 
    tmp2M  =  (tmp1M << 1); 
    tmp2MN = ~(tmp1M << 1); 
    tmp3M  =  (tmp1M + tmp2M);
    tmp3MN = ~(tmp1M + tmp2M); 
    tmp4M  =  (tmp1M << 2);  
    tmp4MN  = ~(tmp1M << 2); 
end   

//Booth decoder for partial product selection {M,2M,3M,4M}. 
assign tmp_iQ = {{TMP_IQ_MSB_PADDING{1'b0}},iQ,1'b0};

genvar i;
generate
for (i = 0; i < PP_NUM; i = i + 1) begin : Booth_decoder
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
        default: begin p_sel[i] = 4'b0000; s[i] = 1'b0; end
    endcase

    //Multiplexer for partial product selection according to p_sel and s.
    case (p_sel[i])     
        4'd0: tmpM_val[i] = (!s[i]) ? {TMP_M_SIZE{1'b0}} : ~{TMP_M_SIZE{1'b0}}; 
        4'd1: tmpM_val[i] = (!s[i]) ? tmp1M : tmp1MN;
        4'd2: tmpM_val[i] = (!s[i]) ? tmp2M : tmp2MN;
        4'd4: tmpM_val[i] = (!s[i]) ? tmp3M : tmp3MN;
        4'd8: tmpM_val[i] = (!s[i]) ? tmp4M : tmp4MN;
        default: tmpM_val[i] = {TMP_M_SIZE{1'b0}}; 
    endcase

    //Final partial product generation (of size [2*Bits-1:0]) 
    if (i == 0) begin //first partial product
        prt_prod[i] = { {PRT_PROD_MSB_SIZE{1'b0}},~s[i],s[i],s[i],s[i],tmpM_val[i]} +  {{OUT_SIZE_MIN1{1'd0}},s[i]};
    end else if (i > 0 && i < PP_NUM-2) begin
        prt_prod[i] = ({{PRT_PROD_MSB_SIZE{1'b0}},3'b011,~s[i],tmpM_val[i]} << i*3) + ({{OUT_SIZE_MIN1{1'd0}},s[i]} << i*3);
    end else if (i == PP_NUM-2) begin //penultimate partial product
        prt_prod[i] = ({{PRT_PROD_MSB_SIZE{1'b0}},3'b001,~s[i],tmpM_val[i]} << i*3) + ({{OUT_SIZE_MIN1{1'd0}},s[i]} << i*3); 
    end else if (i == PP_NUM-1) begin //last partial product
        prt_prod[i] = ({{PRT_PROD_MSB_SIZE{1'b0}},3'b000, 1'b0,tmpM_val[i]} << i*3);
    end else begin 
        prt_prod[i] = {OUT_SIZE{1'd0}};
    end
    
    end //always_comb
end
endgenerate

//Partial product addition n_words n_width adder tree 
adder_tree #(PP_NUM, OUT_SIZE) pp_adder (prt_prod, oZ);


endmodule