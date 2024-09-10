/*
function void read_file();
	inc_addr = 0;
	input_path = "path";
	fd_input = $fopen(input_path, "r");
	while (!$feof(fd_input)) begin
		asd = $fgets(data_in,fd_input);
		main_mem[0 + inc_addr] = data_in.atohex();
		inc_addr = inc_addr + 1;
	end
	$fclose(fd_input);
endfunction

function void write_file();
	output_path = "path";
	fd_w = $fopen(output_path,"w");
	foreach(main_mem[i]) begin
		if (i >= used_mem)
			break;
		$fdisplay(fd_w,"%h",mem[i]);
	end
	$fclose(fd_w);
endfunction

strig file_name;
asd = $value$plusargs("model_arg=%s", file_name);
*/
module tb_fp16 ();
parameter WORD_LENGHT = 16;
logic clk;
logic arstn;
logic mode;
logic [WORD_LENGHT-1:0] a;
logic [WORD_LENGHT-1:0] b;
logic [WORD_LENGHT-1:0] c;
logic mul_error;

always #5ns clk = !clk;

int_fp_add add_i(
	.clk(clk),
	.rst_n(arstn),
	.mode(mode),
	.a(a),
	.b(b),
	.c(c)
);

int_fp_mul mul_i(
	.clk(clk),
	.rst_n(arstn),
	.mode(mode),
	.a(a),
	.b(b),
	.c(c),
	.error(mul_error)
);

initial begin
	#1000;
	$finish;
end

endmodule