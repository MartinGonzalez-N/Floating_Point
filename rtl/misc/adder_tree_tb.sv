module adder_tree_tb;
  //local parameters//
  parameter INPUTS_NUM = 8;
  parameter IDATA_WIDTH = 8;

  parameter STAGES_NUM = $clog2(INPUTS_NUM);
  parameter INPUTS_NUM_INT = 2 ** STAGES_NUM;
  parameter ODATA_WIDTH = IDATA_WIDTH + STAGES_NUM;
  
  //local variables//
  logic [INPUTS_NUM-1:0][IDATA_WIDTH-1:0] idata; //logic [INPUTS_NUM-1:0] idata [IDATA_WIDTH-1:0];
  logic [ODATA_WIDTH-1:0] odata;
  logic [ODATA_WIDTH-1:0] o_exp;
   
  //DUT instantiation//
  adder_tree #(INPUTS_NUM, IDATA_WIDTH) DUT (
    .idata(idata),
    .odata(odata)
  );
   
  //stimulus generation & verification
  initial begin
    repeat(10) begin
    if (!std::randomize(idata)) begin $error("Randomization failed for idata"); end
    #5ns;
    o_exp = adder_tree_calc(idata);
    if(odata != o_exp) $display("[Error]: result=%d, exp_result=%d", odata, o_exp);
      else $display("[Pass]: result=%d, exp_result=%d", odata, o_exp); 
    end

  $finish;
  end
 
  //verification function
  function logic signed [ODATA_WIDTH-1:0] adder_tree_calc (input logic signed [INPUTS_NUM-1:0][IDATA_WIDTH-1:0] data);
      logic signed [ODATA_WIDTH-1:0] res;
      res = 0;
      for (int i =0; i < INPUTS_NUM; i++) begin
        res = res + data[i];
      end
      return res;
  endfunction


endmodule
