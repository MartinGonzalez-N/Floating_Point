`timescale 1ns/1ps
module fp_add#(parameter BITS = 16)			//Floating Point Adder
(
input wire [BITS-1:0] iA,
input wire [BITS-1:0] iB,
output wire [BITS-1:0] oZ
);
//32 BITS
//localparam M_BITS = 24;
//localparam E_BITS = 8;

//16 BITS
localparam M_BITS = 11;
localparam E_BITS = 5;

logic sign_A;
logic sign_B;
logic [E_BITS-1:0] exp_A;
logic [E_BITS-1:0] exp_B;
logic [M_BITS-1:0] man_A;
logic [M_BITS-1:0] man_B;

///////////////////////////////////-----------Sign Bit Extracting-----------///////////////////////////////////
assign sign_A = iA[BITS-1];
assign sign_B = iB[BITS-1];
///////////////////////////////////-----------Sign Bit Extracting-----------///////////////////////////////////

///////////////////////////////////-----------Exponent Extracting-----------///////////////////////////////////
assign exp_A = iA[BITS-2:M_BITS-1];
assign exp_B = iB[BITS-2:M_BITS-1];
///////////////////////////////////-----------Exponent Extracting-----------///////////////////////////////////

///////////////////////////////////-----------Mantissa Extracting-----------///////////////////////////////////
assign man_A = {|exp_A,iA[M_BITS-2:0]};
assign man_B = {|exp_B,iB[M_BITS-2:0]};

//SPECIAL CASES
logic res_nan;
logic pos_inf;
logic neg_inf;
assign res_nan = ((&exp_A && &exp_B) && (sign_A ^ sign_B)) || ((&exp_A && |man_A[M_BITS-2:0])||(&exp_B && |man_B[M_BITS-2:0]));
assign pos_inf = ((&exp_A && ~sign_A)||(&exp_B && ~sign_B)) && ~res_nan;
assign neg_inf = ((&exp_A && sign_A)||(&exp_B && sign_B)) && ~res_nan;

//bigger number detection
logic exp_equals;
logic expA_higher;
logic expB_higher;
logic [E_BITS-1:0] higher_exp;
//exp comparation
assign exp_equals = exp_A == exp_B;
assign expA_higher = exp_A > exp_B;
assign expB_higher = !expA_higher && !exp_equals;
assign higher_exp = expA_higher ? (exp_A) : (exp_B);

logic [E_BITS-1:0] exp_diff;
//exp substraction
assign exp_diff = expA_higher ? (exp_A - exp_B) : (expB_higher ? (exp_B - exp_A) : 5'd0);

logic [M_BITS-1:0] man_to_shift;
logic [M_BITS-1:0] man_higher;
logic [2*M_BITS-1:0] double_man;
logic [2*M_BITS-1:0] shifted_man;
logic G1;
logic R1;
logic S1;
logic subnormal_to_shift;
logic [E_BITS-1:0] right_shift_val;

//mantissa shifting
assign man_to_shift =  (expA_higher && !exp_equals) ? (man_B) : (man_A); //if expa are eq man_to_shift = Aman
assign man_higher = (expA_higher && !exp_equals) ? (man_A) : (man_B); //if expa are eq man_heigher = Bman
assign double_man = {man_to_shift, 11'b0};
assign subnormal_to_shift = (~|exp_A || ~(|exp_B)) && (exp_diff!=0) ? ~man_to_shift [M_BITS-1] : 1'b0; //expdiff != 0 ya que no puede ser negativo el shift
assign right_shift_val = (exp_diff - subnormal_to_shift);
always_comb begin
    shifted_man = double_man >> right_shift_val;
    G1 = shifted_man [M_BITS-1];
    R1 = shifted_man [M_BITS-2];
	S1 = |shifted_man [M_BITS-3:0];
end

logic [M_BITS+2:0] X1; //mantisa + G,R,S
logic [M_BITS+2:0] X2;
logic X1s;
logic X2s;
logic [M_BITS+4:0] SUM1;
logic [M_BITS+4:0] SUM2;
logic carry;
logic [M_BITS+3:0] SUM;
logic sb;
logic sb1;


// adder X1 + X2 
assign X1s = (shifted_man[2*M_BITS-1:M_BITS-3] == 0) ? (1'b0):((expA_higher && !exp_equals) ?  sign_B : sign_A);
assign X2s = (man_higher == 0) ? (1'b0):((expA_higher && !exp_equals) ? sign_A : sign_B);
assign X1 = (X1s ? (({~shifted_man[2*M_BITS-1:M_BITS],~G1,~R1,~S1}) + 14'd1) : {shifted_man[2*M_BITS-1:M_BITS],G1,R1,S1});
assign X2 = (X2s ? ((~{man_higher,3'd0}) + 14'd1) : {man_higher,3'd0}); 
assign SUM1 = {X1s,X1} + {X2s,X2};
assign sb1 = (X1s || X2s) ? ((X1s && X2s) ? (1'b1) : (SUM1[M_BITS+3])):(1'b0);
assign SUM2 = (sb1)?((~SUM1) + 16'd1):(SUM1);
assign carry = ((X1s||X2s)?(SUM2[M_BITS+3]):(SUM1[M_BITS+3]));
assign SUM =  (right_shift_val > 12) ? {1'b0,man_higher,3'b0} : {carry,SUM2[M_BITS+2:0]};

//Leading Zeros
logic [E_BITS-1:0] LZ;
logic [E_BITS-1:0] left_shift_val;
always_comb begin
	casex(SUM[M_BITS+3:3])
		12'b1xxx_xxxx_xxxx: begin
            LZ = 0;
		end
		12'b01xx_xxxx_xxxx: begin
			LZ = 1;
		end
		12'b001x_xxxx_xxxx: begin
			LZ = 2;
		end
		12'b0001_xxxx_xxxx: begin
			LZ = 3;
		end
		12'b0000_1xxx_xxxx: begin
			LZ = 4;
		end
		12'b0000_01xx_xxxx: begin
			LZ = 5;
		end
		12'b0000_001x_xxxx: begin
			LZ = 6;
		end
		12'b0000_0001_xxxx: begin
			LZ = 7;
		end
		12'b0000_0000_1xxx: begin
			LZ = 8;
		end
		12'b0000_0000_01xx: begin
			LZ = 9;
		end
		12'b0000_0000_001x: begin
			LZ = 10;
		end
		12'b0000_0000_0001: begin
			LZ = 11;
		end
		default: begin
			LZ = 12;
		end
	endcase
end

//infinite
logic infinite;
assign infinite = (&exp_A || &exp_B);

// calc exponent
logic [E_BITS-1:0] exp1;
logic [E_BITS-1:0] exp;
always_comb begin
	if (higher_exp==0) begin //the result is tentatively a subnormal number
		exp1 = 5'd0;
		left_shift_val = 5'd1;
	end else if (LZ > higher_exp)begin // the maximum left shift is higher_exp, so, if LZ > higher_exp, the result es tentatively a subnormal number
		exp1 = 5'd0;
		left_shift_val = higher_exp;
	end else begin //the most common case, the mantissa is normalized
		exp1 = higher_exp - LZ + 5'd1;
		left_shift_val = LZ;
	end
end

// calc mantissa
logic [M_BITS+3:0] norm_man;
logic G;
logic R;
logic S;

always_comb begin
	norm_man = SUM << left_shift_val;
	G = norm_man[4];
	R = norm_man[3];
	S = |norm_man[2:0];
end

assign round = R && (G||S);
logic [M_BITS-1:0]mantissa;
logic [M_BITS-1:0]mantissa1;
assign mantissa1 = (norm_man[M_BITS+3:4] + round);//(&norm_man[M_BITS+3:4] && round) ? 24'h800000:(norm_man[M_BITS+3:4] + round);
always_comb begin
	if (infinite || res_nan) begin
		exp = 5'h1f;
		//$display("holaaaaaaaaaa");
	end else if ((!mantissa1[M_BITS-1] && norm_man[M_BITS+3]) || (mantissa1[M_BITS-1] && (exp1==0))) begin 
	//MSB of norm_man indicate that hiden bit == 1 (is a normal number), in addition if mantissa1 MSB == 0 means that round make norm_man overflow, so exp increase
	//if mantissa1 MSB is 1 that means that is a normal number, so exp cant be 0.
		exp = exp1 + 5'd1;
	end else if(!(|mantissa1)) begin // if mantissa is 0, (including the hiden bit) exp = 0.
		exp = 5'd0;

	end else begin
		exp = exp1;
	end
end

assign mantissa = res_nan ? 11'h600 :(&exp ? 11'd0 : mantissa1);

assign sb = pos_inf ? 1'b0 : (neg_inf || res_nan ? 1'b1 : sb1);
assign oZ = {sb, exp, mantissa[M_BITS-2:0]};

endmodule