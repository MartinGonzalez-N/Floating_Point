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