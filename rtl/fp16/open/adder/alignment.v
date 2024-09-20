module alignment (
	input  [14:0] bigger, 
	input  [14:0] smaller,
	output [13:0] aligned_small
	);

	wire c1;
	wire G;
	wire R;
	wire S;
	wire [4:0] bigger_exponent, smaller_exponent,shift_bits;
	wire [21:0] aligned_full;

	assign bigger_exponent  = bigger  [14:10];
	assign smaller_exponent = smaller [14:10];

	assign aligned_full = ({1'b1,smaller[9:0],11'd0} >> shift_bits);
	assign G = aligned_full[10];
	assign S = aligned_full[9];
	assign R = |aligned_full[8:0];
	assign aligned_small = {aligned_full[21:11],G,R,S};

	cla_nbit #(.n(5)) u1(bigger_exponent,~smaller_exponent+1'b1,1'b0,shift_bits,c1);

endmodule
