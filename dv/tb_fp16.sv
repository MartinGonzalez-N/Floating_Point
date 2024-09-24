module tb_fp16 ();
parameter WORD_LENGHT = 16;
bit clk;
bit arstn;
logic mode;
logic [WORD_LENGHT-1:0] a;
logic [WORD_LENGHT-1:0] b;
logic [WORD_LENGHT-1:0] add;
logic [WORD_LENGHT-1:0] mul;
logic mul_error;

always #5ns clk = !clk;

string seed;
int x;
string str_a;
string str_b;
string path_a;
string path_b;
string path_add;
string path_mul;
int fd_a;
int fd_b;
int fd_add;
int fd_mul;

/*
int_fp_add add_i(
`ifdef PIPLINE
	.clk(clk),
	.rst_n(arstn),
`endif
	.mode(mode),
	.a(a),
	.b(b),
	.c(add)
);

int_fp_mul mul_i(
`ifdef PIPLINE
	.clk(clk),
	.rst_n(arstn),
`endif
	.mode(mode),
	.a(a),
	.b(b),
	.c(mul),
	.error(mul_error)
);
*/
fp_add #(.BITS(WORD_LENGHT)) add_i (
	.iA(a),
	.iB(b),
	.oZ(add)
);

fp_mult #(.BITS(WORD_LENGHT)) mult_i(
	.iA(a),
	.iB(b),
	.oZ(mul)
);

initial begin
	x = $value$plusargs("seed_arg=%s", seed);
	arstn = 0;
	mode = 1;
	#100ns;
	$display("simulated seed %s",seed);
	arstn = 1;
	path_a = {"../software/fp16_vectors/",seed,"/input_a.mem"};
	fd_a = $fopen(path_a, "r");
	path_b = {"../software/fp16_vectors/",seed,"/input_b.mem"};
	fd_b = $fopen(path_b, "r");
	path_add = {"../software/fp16_vectors/",seed,"/output_sim_add.mem"};
	fd_add = $fopen(path_add,"w");
	path_mul = {"../software/fp16_vectors/",seed,"/output_sim_mult.mem"};
	fd_mul = $fopen(path_mul,"w");
	#100ns;
	while (!$feof(fd_a)) begin
		x = $fgets(str_a,fd_a);
		x = $fgets(str_b,fd_b);
		a = str_a.atohex();
		b = str_b.atohex();
		repeat (1) @(posedge clk);
		$fdisplay(fd_add,"%h",add);
		$fdisplay(fd_mul,"%h",mul);
	end
	$fclose(fd_a);
	$fclose(fd_b);
	$fclose(fd_add);
	$fclose(fd_mul);
	#100ns;
	$finish;
end

endmodule