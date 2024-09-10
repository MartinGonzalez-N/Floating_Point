class fp_test extends uvm_test;
	`uvm_component_utils(fp_test)

	virtual csr_if csr_vif;
    virtual fp_if fp_vif;

    rand shortreal s_data_a;
    rand shortreal s_data_b;
	rand real real_a;
	rand real real_b;
	rand logic [31:0] data_a;
	rand logic [31:0] data_b;
    rand shortreal s_res_add;
    rand shortreal s_res_mult;
    rand shortreal s_res_comp;
	logic [31:0] add_fd;
	logic [31:0] mult_fd;
	logic [31:0] comp_fd;
	int add_errors;
	int mult_errors;
	int comp_errors;
	logic add_diff;
	shortreal pp;

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
    	if(!uvm_config_db #(virtual csr_if)::get(this,"","csr_vif",csr_vif))
    		`uvm_fatal(get_name(),"Failed to get csr_vif")
        if(!uvm_config_db #(virtual fp_if)::get(this,"","fp_vif",fp_vif))
    		`uvm_fatal(get_name(),"Failed to get fp_vif")
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		add_errors = 0;
		mult_errors = 0;
		comp_errors = 0;
		//open files
		add_fd = $fopen("fp_add_errors.log","w");
		$fdisplay(add_fd,"input_a,input_b,soft_result,rtl_result,exp_difference,pos(1)/neg(0) difference");
		$fclose(add_fd);
		mult_fd = $fopen("fp_mult_errors.log","w");
		$fdisplay(mult_fd,"input_a,input_b,soft_result,rtl_result,at_time");
		$fclose(mult_fd);
		comp_fd = $fopen("fp_comp_errors.log","w");
		$fdisplay(comp_fd,"input_a,input_b,soft_result,rtl_result");
		$fclose(comp_fd);
		//repeat(1000000000) begin
		repeat (100) begin
			//randomization
			//NOTE : The values are fixed only for float 32 standar
			randcase
				10000: begin
					void'(std::randomize(data_a) with{data_a != 32'H00000000 | data_a != 32'H80000000;}); 	//random != 0+-
					if (data_a[30:23] == 8'hff) begin
						data_a[22:0] = 23'h00000;
					end
				end
				1:  	void'(std::randomize(data_a) with{data_a == 32'H00000000 | data_a == 32'H80000000;});	//zero+-
				1:		void'(std::randomize(data_a) with{data_a == 32'H3f800000 | data_a == 32'Hbf800000;});	//one +-
				1:  	void'(std::randomize(data_a) with{data_a == 32'H00000001 | data_a == 32'H80000001;}); 	//smallest subnormal (exp == 0)
				1:  	void'(std::randomize(data_a) with{data_a == 32'H007fffff | data_a == 32'H807fffff;});	// largest subnormal (exp == 0)
				1:  	void'(std::randomize(data_a) with{data_a == 32'H00800000 | data_a == 32'H80800000;}); 	// smallest normal
				//1:  	void'(std::randomize(data_a) with{data_a == 32'H7f800000 | data_a == 32'Hff800000;}); 	// infinite	
				1:  	void'(std::randomize(data_a) with{data_a == 32'H7f7fffff | data_a == 32'Hff7fffff;}); 	// largest normal
			endcase

			randcase
				10000:  begin
					void'(std::randomize(data_b) with{data_b != 32'H00000000 | data_b != 32'H80000000;}); 	//random != 0+-
					if (data_b[30:23] == 8'hff) begin
						data_b[22:0] = 23'h00000;
					end
				end
				1:  	void'(std::randomize(data_b) with{data_b == 32'H00000000 | data_b == 32'H80000000;});	//zero+-
				1:		void'(std::randomize(data_b) with{data_b == 32'H3f800000 | data_b == 32'Hbf800000;});	//one +-
				1:  	void'(std::randomize(data_b) with{data_b == 32'H00000001 | data_b == 32'H80000001;}); 	//smallest subnormal (exp == 0)
				1:  	void'(std::randomize(data_b) with{data_b == 32'H007fffff | data_b == 32'H807fffff;});	// largest subnormal (exp == 0)
				1:  	void'(std::randomize(data_b) with{data_b == 32'H00800000 | data_b == 32'H80800000;}); 	// smallest normal
				//1:  	void'(std::randomize(data_b) with{data_b == 32'H7f800000 | data_b == 32'Hff800000;}); 	// infinite	
				1:  	void'(std::randomize(data_b) with{data_b == 32'H7f7fffff | data_b == 32'Hff7fffff;}); 	// largest normal
			endcase

			//$display("hex data %h",data_a);
			
			s_data_a = $bitstoshortreal(data_a);
			s_data_b = $bitstoshortreal(data_b);
			//$display(s_data_a);
			fp_vif.data_a = data_a;
			fp_vif.data_b = data_b;

			//software operations
			s_res_add = s_data_a + s_data_b;
			s_res_mult = s_data_a * s_data_b;
			if (s_data_a > s_data_b) begin
				s_res_comp = s_data_a;
			end else begin
				s_res_comp = s_data_b;
			end

			//assertions
        	@(posedge csr_vif.clk);
			INPUTS_ERROR: assert (fp_vif.data_a == $shortrealtobits(s_data_a) && fp_vif.data_b == $shortrealtobits(s_data_b)) begin
				ADD_ERROR: assert (fp_vif.res_add == $shortrealtobits(s_res_add))
					else begin
						`uvm_error("ADD_ERROR","Assertion ADD_ERROR failed!");
						add_fd = $fopen("fp_add_errors.log","a");
						$fdisplay(add_fd,"A = %h, B= %h, expected = %h, RTL = %h, Exp_dif = %0d ,error = %0d, at time %0t, round = %0b, LZ %0d,carry %b",fp_vif.data_a, fp_vif.data_b,$shortrealtobits(s_res_add),fp_vif.res_add,signed'(fp_vif.data_a[32-2:32-9]-fp_vif.data_b[32-2:32-9]),signed'(signed'($shortrealtobits(s_res_add))-fp_vif.res_add),$time,tb.add.round,tb.add.LZ,tb.add.carry);
						$fclose(add_fd);
						if ((signed'(signed'($shortrealtobits(s_res_add))-fp_vif.res_add) > 1) || (signed'(signed'($shortrealtobits(s_res_add))-fp_vif.res_add) < -1) )
							//`uvm_info("|DIFF| > 1 ",$sformatf("diference is : %0d",signed'($shortrealtobits(s_res_add))-fp_vif.res_add),UVM_NONE);
						add_errors = add_errors + 1;
						if(add_errors >= 100)
							`uvm_fatal("MAX_ADD_ERRORS","stop simulation because of many add errors");
					end

				MULT_ERROR: assert (fp_vif.res_mult == $shortrealtobits(s_res_mult))
					else begin
						`uvm_error("MULT_ERROR","Assertion MULT_ERROR failed!");
						mult_fd = $fopen("fp_mult_errors.log","a");
						$fdisplay(mult_fd,"%h,%h,%h,%h, at time %0t",fp_vif.data_a, fp_vif.data_b,$shortrealtobits(s_res_mult),fp_vif.res_mult,$time);
						$fclose(mult_fd);
						mult_errors = mult_errors + 1;
						if(mult_errors >= 1000)
							`uvm_fatal("MAX_MULT_ERRORS","stop simulation because of many mult errors");
					end

				COMP_ERROR: assert (fp_vif.res_comp == $shortrealtobits(s_res_comp))
					else begin
						`uvm_error("COMP_ERROR","Assertion COMP_ERROR failed!");
						comp_fd = $fopen("fp_comp_errors.log","a");
						$fdisplay(comp_fd,"%h,%h,%h,%h",fp_vif.data_a, fp_vif.data_b,$shortrealtobits(s_res_comp),fp_vif.res_comp);
						$fclose(comp_fd);
						comp_errors = comp_errors + 1;
						if(comp_errors >= 1000)
							`uvm_fatal("MAX_COMP_ERRORS","stop simulation because of many comp errors");
					end

			end	else begin 
					$display("rand data = %h, b = %h ",data_a,data_b);
					$display("soft inputs a = %h, b = %h ",$shortrealtobits(s_data_a),$shortrealtobits(s_data_b));
					//$display("soft inputs a = %f, b = %f ",(s_data_a),(s_data_b));
					$display("soft rtl inputs a = %h, b = %h ",fp_vif.data_a,fp_vif.data_b);
					`uvm_error("INPUTS_ERROR","Assertion INPUTS_ERROR failed!");
				end


		end
		phase.drop_objection(this);
	endtask

endclass