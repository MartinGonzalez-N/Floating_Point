`timescale 1ns/1ps
module flpcomp#(parameter Bits = 32)(
	input logic [Bits-1:0] a,
	input logic [Bits-1:0] b,
	output logic [Bits-1:0] y
);
	logic a_mag_higher;
	logic b_mag_higher;
	logic dif_sign;

	always_comb begin
		if(a[Bits-2:0] < b[Bits-2:0]) begin
			a_mag_higher = 0;
			b_mag_higher = 1;
		end else begin
			a_mag_higher = 1;
			b_mag_higher = 0;
		end
	end

	always_comb begin
		case({a[Bits-1],b[Bits-1],a_mag_higher,b_mag_higher})
			//both positive
			4'b0001: y = b;
			4'b0010: y = a;
			//a higher
			4'b0101: y = a;
			4'b0110: y = a;
			//b higher
			4'b1001: y = b;
			4'b1010: y = b;
			//both negative
			4'b1101: y = a;
			4'b1110: y = b;
			default: y = a;
		endcase
	end

endmodule
