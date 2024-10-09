`timescale 1ns/1ps
module flpcomp#(parameter Bits = 16)(
	input logic [Bits-1:0] iA,
	input logic [Bits-1:0] iB,
	output logic [Bits-1:0] oZ
);
	logic a_mag_higher;
	logic b_mag_higher;
	logic dif_sign;

	always_comb begin
		if(iA[Bits-2:0] < iB[Bits-2:0]) begin
			a_mag_higher = 0;
			b_mag_higher = 1;
		end else begin
			a_mag_higher = 1;
			b_mag_higher = 0;
		end
	end

	always_comb begin
		case({iA[Bits-1],iB[Bits-1],a_mag_higher,b_mag_higher})
			//both positive
			4'b0001: oZ = iB;
			4'b0010: oZ = iA;
			//iA higher
			4'b0101: oZ = iA;
			4'b0110: oZ = iA;
			//iB higher
			4'b1001: oZ = iB;
			4'b1010: oZ = iB;
			//both negative
			4'b1101: oZ = iA;
			4'b1110: oZ = iB;
			default: oZ = iA;
		endcase
	end

endmodule
