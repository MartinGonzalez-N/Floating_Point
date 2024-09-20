`timescale 1ns/1ps
module flpmult#(parameter Bits = 32)			//Floating Point Multiplier
(
input wire [Bits-1:0] iA,
input wire [Bits-1:0] iB,
output wire [Bits-1:0] oZ
//output wire [47:0] oMul

);

localparam M_BITS = 24;
localparam E_BITS = 8;

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
logic [2*M_BITS-1:0] shifted_mult;

//others
logic zero;
logic G;
logic R;
logic S;
logic round;
logic res_nan;

///////////////////////////////////-----------Sign Bit Extracting-----------///////////////////////////////////
assign sign_A = iA[Bits-1];
assign sign_B = iB[Bits-1];

///////////////////////////////////-----------Exponent Extracting-----------///////////////////////////////////
assign exp_A = {1'b0,iA[Bits-2:Bits-(E_BITS + 1)]}; //sign added
assign exp_B = {1'b0,iB[Bits-2:Bits-(E_BITS + 1)]}; //sign added

///////////////////////////////////-----------Mantissa Extracting-----------///////////////////////////////////
assign man_A = {|iA[Bits-2:M_BITS-1],iA[Bits-10:0]};
assign man_B = {|iB[Bits-2:M_BITS-1],iB[Bits-10:0]};


//at least one zero or nan
assign zero = ~(|iA[Bits-2:0]) || ~(|iB[Bits-2:0]);
assign res_nan =((~(|iA[Bits-2:0]) && &exp_B[E_BITS-1:0]) || (~(|iB[Bits-2:0]) && &exp_A[E_BITS-1:0])) || ((&exp_A[E_BITS-1:0] && |man_A[M_BITS-2:0])||(&exp_B[E_BITS-1:0] && |man_B[M_BITS-2:0]));

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
assign sum2 = {8'd0,extra_add} - 10'd126;
assign exp1 = sum1 + sum2;
assign exp2 = exp1 - left_shift;
assign infinite = (exp2[E_BITS] || (&(exp2[E_BITS-1:0]))) && ~exp2[E_BITS+1] || (&exp_A[E_BITS-1:0] || &exp_B[E_BITS-1:0]); // exp1>255
assign normal_num = |exp2[E_BITS:0] && ~exp2[E_BITS+1];
assign subnormal_num = ~(|exp2[E_BITS:0]) || exp2[E_BITS+1];
assign right_shift = subnormal_num ? ~exp2 + 10'd2 : 10'd0; //ver si no es necesario poner una restriccion para el cero, no se por que es mas 2 en vez de mas 1
assign exp3 = (infinite || res_nan) ? 10'b00_1111_1111 : (zero || subnormal_num) ? 10'd0 :exp2;
assign exp = exp3 + (round && (&man1));

//mantissa multiplication
logic l_shift;
logic [E_BITS+1:0] shift_val;
assign mult = man_A * man_B;
LZ48 LZ_48_i(.bus(mult),.LZ(left_shift));
	//shift calc
assign l_shift = left_shift > right_shift;
assign shift_val = l_shift ? (left_shift - right_shift) : (right_shift - left_shift);
	//getting mantissa
assign shifted_mult = l_shift ? mult << shift_val : mult >> shift_val;
assign G = shifted_mult [M_BITS];
assign R = shifted_mult [M_BITS-1];
assign S = |shifted_mult [M_BITS-2:0];
assign round = R && (G||S);
assign man1 = shifted_mult[2*M_BITS-1:M_BITS];
assign man = res_nan ? 24'hc00000 :((infinite || zero) ? 24'd0: man1 + round);

//output assignament
assign oZ = {sign,exp[E_BITS-1:0],man[M_BITS-2:0]};
endmodule

//leading zeros
module LZ48 (input logic[47:0] bus, output logic [9:0] LZ);

always_comb begin
	casex(bus)
		48'b1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 0;
		end
		48'b01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 1;
		end
		48'b001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 2;
		end
		48'b0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 3;
		end
		48'b0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 4;
		end
		48'b0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 5;
		end
		48'b0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 6;
		end
		48'b0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 7;
		end
		48'b0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 8;
		end
		48'b0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 9;
		end
		48'b0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 10;
		end
		48'b0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 11;
		end
		48'b0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 12;
		end
		48'b0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 13;
		end
		48'b0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 14;
		end
		48'b0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 15;
		end
		48'b0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 16;
		end
		48'b0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 17;
		end
		48'b0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 18;
		end
		48'b0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 19;
		end
		48'b0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 20;
		end
		48'b0000_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 21;
		end
		48'b0000_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 22;
		end
		48'b0000_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 23;
		end
		48'b0000_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 24;
		end
		48'b0000_0000_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 25;
		end
		48'b0000_0000_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 26;
		end
		48'b0000_0000_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 27;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 28;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 29;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 30;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 31;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx: begin
            LZ = 32;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx: begin
            LZ = 33;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_0000_001x_xxxx_xxxx_xxxx: begin
            LZ = 34;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_0000_0001_xxxx_xxxx_xxxx: begin
            LZ = 35;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_0000_0000_1xxx_xxxx_xxxx: begin
            LZ = 36;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_0000_0000_01xx_xxxx_xxxx: begin
            LZ = 37;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_0000_0000_001x_xxxx_xxxx: begin
            LZ = 38;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0001_xxxx_xxxx: begin
            LZ = 39;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_1xxx_xxxx: begin
            LZ = 40;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_01xx_xxxx: begin
            LZ = 41;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_001x_xxxx: begin
            LZ = 42;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001_xxxx: begin
            LZ = 43;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_1xxx: begin
            LZ = 44;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_01xx: begin
            LZ = 45;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_001x: begin
            LZ = 46;
		end
		48'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001: begin
            LZ = 47;
		end
		default: begin
			LZ = 48;
		end
	endcase
end
endmodule

