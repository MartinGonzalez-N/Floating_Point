`timescale 1ns/1ps
module fp_mult#(parameter BITS = 16)			//Floating Point Multiplier
(
input wire [BITS-1:0] iA,
input wire [BITS-1:0] iB,
output wire [BITS-1:0] oZ
//output wire [47:0] oMul

);

//localparam M_BITS = 24;
//localparam E_BITS = 8;

localparam M_BITS = 11;
localparam E_BITS = 5;

//output
logic [E_BITS-1:0] exp;
logic [M_BITS-1:0] man;
logic sign;

//sign calc wires
logic sign_A;
logic sign_B;

//exp calc wires
logic signed [E_BITS:0] exp_A;
logic signed [E_BITS:0] exp_B;
logic signed [E_BITS+1:0] sum1;
logic signed [E_BITS+1:0] sum2;
logic signed [E_BITS+1:0] exp1;
logic signed [E_BITS+1:0] exp2;
logic signed [E_BITS+1:0] exp3;
logic infinite;
logic normal_num;
logic subnormal_num;
logic signed [E_BITS+1:0] right_shift;

//mantissa calc wires
logic [M_BITS-1:0] man_A;
logic [M_BITS-1:0] man_B;
logic [M_BITS-1:0] man1;
logic [2*M_BITS-1:0] mult;
logic signed [E_BITS+1:0] left_shift;
logic [2*M_BITS-1:0] mult1;
logic [4*M_BITS-1:0] shifted_mult;

//others
logic zero;
logic G;
logic R;
logic S;
logic round;
logic res_nan;

///////////////////////////////////-----------Sign Bit Extracting-----------///////////////////////////////////
assign sign_A = iA[BITS-1];
assign sign_B = iB[BITS-1];

///////////////////////////////////-----------Exponent Extracting-----------///////////////////////////////////
assign exp_A = {1'b0,iA[BITS-2:M_BITS-1]}; //sign added
assign exp_B = {1'b0,iB[BITS-2:M_BITS-1]}; //sign added
///////////////////////////////////-----------Mantissa Extracting-----------///////////////////////////////////
assign man_A = {|exp_A,iA[M_BITS-2:0]};
assign man_B = {|exp_B,iB[M_BITS-2:0]};

//at least one zero or nan
assign zero = ~(|iA[BITS-2:0]) || ~(|iB[BITS-2:0]);
assign res_nan =((~(|iA[BITS-2:0]) && &exp_B[E_BITS-1:0]) || (~(|iB[BITS-2:0]) && &exp_A[E_BITS-1:0])) || ((&exp_A[E_BITS-1:0] && |man_A[M_BITS-2:0])||(&exp_B[E_BITS-1:0] && |man_B[M_BITS-2:0]));

//sign calculation
assign sign = res_nan ? 1'b1 : sign_A^sign_B;

//exp calculation
logic [1:0] extra_add;
logic exp_A_zero;
logic exp_B_zero;
logic mult_MSB;
assign exp_A_zero = ~(|exp_A);
assign exp_B_zero = ~(|exp_B);
assign mult_MSB = mult[2*M_BITS-1];
always_comb begin //sumador de un bit
	case ({exp_A_zero, exp_B_zero})
		2'b00 : extra_add = 2'b00;
		2'b01 : extra_add = 2'b01;
		2'b10 : extra_add = 2'b01;
		2'b11 : extra_add = 2'b10;
	endcase
end
assign sum1 = {1'b0,exp_A} + {1'b0,exp_B};
assign sum2 = {5'd0,extra_add} - 7'd14;
assign exp1 = sum1 + sum2;
assign exp2 = exp1 - left_shift;
assign infinite = (exp2[E_BITS] || (&(exp2[E_BITS-1:0]))) && ~exp2[E_BITS+1] || (&exp_A[E_BITS-1:0] || &exp_B[E_BITS-1:0]); // exp1>255
assign normal_num = |exp2[E_BITS:0] && ~exp2[E_BITS+1];
assign subnormal_num = ~(|exp2[E_BITS:0]) || exp2[E_BITS+1]; //all zeros
assign right_shift = subnormal_num ? ~exp2 + 7'd2 : 7'd0; //ver si no es necesario poner una restriccion para el cero, no se por que es mas 2 en vez de mas 1
logic man_full;
logic man_semifull;
assign man_full = &man1;
assign man_semifull = &man1[M_BITS-2:0];
assign exp3 = exp2 + (round && man_full);
assign exp = (infinite || res_nan || ((exp3[E_BITS] ^ exp3[E_BITS+1]) && ~(zero || subnormal_num))) ? 5'b1_1111 : (zero || (subnormal_num && ~(round && man_semifull))) ? 5'd0 : (subnormal_num && (round && man_semifull)) ? 5'd1 :exp3[E_BITS-1:0]; 

//mantissa multiplication
logic l_shift;
logic [E_BITS+1:0] shift_val;
assign mult = man_A * man_B;
LZ48 LZ_48_i(.bus(mult),.LZ(left_shift));
	//shift calc
assign l_shift = left_shift > right_shift;
assign shift_val = l_shift ? (left_shift - right_shift) : (right_shift - left_shift);
	//getting mantissa
assign shifted_mult = l_shift ? {mult,22'd0} << shift_val : {mult,22'd0} >> shift_val;
assign G = shifted_mult [3*M_BITS];
assign R = shifted_mult [3*M_BITS-1];
assign S = |shifted_mult [3*M_BITS-2:0];
assign round = R && (G||S);
assign man1 = shifted_mult[4*M_BITS-1:3*M_BITS];
assign man = res_nan ? 11'h600 :((infinite || zero) ? 11'd0: man1 + round);

//output assignament
assign oZ = {sign,exp,man[M_BITS-2:0]};
endmodule

//leading zeros
module LZ48 (input logic[21:0] bus, output logic [6:0] LZ);

always_comb begin
	casex(bus)
		22'b1xxx_xxxx_xxxx_xxxx_xxxx_xx: begin
            LZ = 0;
		end
		22'b01xx_xxxx_xxxx_xxxx_xxxx_xx: begin
            LZ = 1;
		end
		22'b001x_xxxx_xxxx_xxxx_xxxx_xx: begin
            LZ = 2;
		end
		22'b0001_xxxx_xxxx_xxxx_xxxx_xx: begin
            LZ = 3;
		end
		22'b0000_1xxx_xxxx_xxxx_xxxx_xx: begin
            LZ = 4;
		end
		22'b0000_01xx_xxxx_xxxx_xxxx_xx: begin
            LZ = 5;
		end
		22'b0000_001x_xxxx_xxxx_xxxx_xx: begin
            LZ = 6;
		end
		22'b0000_0001_xxxx_xxxx_xxxx_xx: begin
            LZ = 7;
		end
		22'b0000_0000_1xxx_xxxx_xxxx_xx: begin
            LZ = 8;
		end
		22'b0000_0000_01xx_xxxx_xxxx_xx: begin
            LZ = 9;
		end
		22'b0000_0000_001x_xxxx_xxxx_xx: begin
            LZ = 10;
		end
		22'b0000_0000_0001_xxxx_xxxx_xx: begin
            LZ = 11;
		end
		22'b0000_0000_0000_1xxx_xxxx_xx: begin
            LZ = 12;
		end
		22'b0000_0000_0000_01xx_xxxx_xx: begin
            LZ = 13;
		end
		22'b0000_0000_0000_001x_xxxx_xx: begin
            LZ = 14;
		end
		22'b0000_0000_0000_0001_xxxx_xx: begin
            LZ = 15;
		end
		22'b0000_0000_0000_0000_1xxx_xx: begin
            LZ = 16;
		end
		22'b0000_0000_0000_0000_01xx_xx: begin
            LZ = 17;
		end
		22'b0000_0000_0000_0000_001x_xx: begin
            LZ = 18;
		end
		22'b0000_0000_0000_0000_0001_xx: begin
            LZ = 19;
		end
		22'b0000_0000_0000_0000_0000_1x: begin
            LZ = 20;
		end
		22'b0000_0000_0000_0000_0000_01: begin
            LZ = 21;
		end
		default: begin
			LZ = 22;
		end
	endcase
end
endmodule

