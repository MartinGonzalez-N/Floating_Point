module mult_16bits_tb(); 

	localparam N = 16;


	//Testbench variables//
	logic clock;
	logic [N-1:0] A; //multiplicand M
	logic [N-1:0] B; //multiplier Q
	logic [2*N-1:0] OUT;
	logic [2*N-1:0] OUT_exp;

	//TB signal initiallization block & reset generation
	initial begin: TB_signal_init
	clock = 0;
	A = '0;
	B = '0;
	OUT_exp = '0;
	end: TB_signal_init

	//Clock generation block
	always #2ns clock=~clock;

	//Total simulation time
	initial begin
	#1ms;
	$stop;
	end

	//DUT instantiation//
	mult_16bits #(N) DUT (A, B, OUT);


	//------------------------------- MODULE TEST CASES (VERIFICATION LOGIC) ---------------------------------- // 
	initial begin : multest
	int error_status;

	$display("===========================");
	$display("---- Random data test -----");
	$display("===========================");
	repeat(1000000) begin  //for (int i = 0; i < 1000; i++)
		@(posedge clock);
		void'(std::randomize(A,B));
		//A = 40119; 
		//B = 63669;
		OUT_exp = A*B;
		@(negedge clock);//#1;
		error_status = checkit(A, B, OUT, OUT_exp);
	end

	printstatus(error_status);
	$finish;

	end: multest 


	//--- Function declaration ---
	function int checkit(input [N-1:0] A,B, input [2*N-1:0] actual, expected);
		static int error_status;
		if (actual !== expected) begin
			$display("[Error] Multiplication %d x %d | Result: %d Expected: %d", A, B, actual, expected);
		error_status++;
		end
		else
			//$display("[Pass] Multiplication %d x %d | Result: %d Expected: %d ", A, B, actual, expected);  
		return (error_status);
	endfunction : checkit

	function void printstatus(input int status);
		if (status == 0)
		$display("Test Passed - No Errors!");
		else
		$display("Test failed with %d Errors", status);
	endfunction


endmodule
