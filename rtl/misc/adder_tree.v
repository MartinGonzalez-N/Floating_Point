// INFO -------------------------------------------------------------------------
// Pipelined tree adder with parametrized input width written in System Verilog
// - Number of inputs is NOT required to be power of two
// - This code can generate entirely combinational circuit 


module adder_tree #(
  parameter INPUTS_NUM = 6,
  parameter IDATA_WIDTH = 32,
  localparam STAGES_NUM = $clog2(INPUTS_NUM),
  localparam INPUTS_NUM_INT = 2 ** STAGES_NUM,
  localparam ODATA_WIDTH = IDATA_WIDTH + STAGES_NUM
)(
  input logic [INPUTS_NUM-1:0][IDATA_WIDTH-1:0] idata,
  output logic [ODATA_WIDTH-1:0] odata
);

/*
localparam STAGES_NUM = $clog2(INPUTS_NUM);
localparam INPUTS_NUM_INT = 2 ** STAGES_NUM;
localparam ODATA_WIDTH = IDATA_WIDTH + STAGES_NUM;
*/

logic [STAGES_NUM:0][INPUTS_NUM_INT-1:0][ODATA_WIDTH-1:0] data;

// generating tree
genvar stage, adder;
generate
  for( stage = 0; stage <= STAGES_NUM; stage++ ) begin: stage_gen

    localparam ST_OUT_NUM = INPUTS_NUM_INT >> stage;
    localparam ST_WIDTH = IDATA_WIDTH + stage;

    if( stage == '0 ) begin
      // stege 0 is actually module inputs
      for( adder = 0; adder < ST_OUT_NUM; adder++ ) begin: inputs_gen

        always_comb begin
          if( adder < INPUTS_NUM ) begin
            data[stage][adder][ST_WIDTH-1:0] <= idata[adder][ST_WIDTH-1:0];
            data[stage][adder][ODATA_WIDTH-1:ST_WIDTH] <= '0;
          end else begin
            data[stage][adder][ODATA_WIDTH-1:0] <= '0;
          end
        end // always_comb

      end // for
    end else begin
      // all other stages hold adders outputs
      for( adder = 0; adder < ST_OUT_NUM; adder++ ) begin: adder_gen

        always_comb begin
            data[stage][adder][ST_WIDTH-1:0] <=
            data[stage-1][adder*2][(ST_WIDTH-1)-1:0] +
            data[stage-1][adder*2+1][(ST_WIDTH-1)-1:0];
        end // always

      end // for
    end // if stage
  end // for
endgenerate

assign odata = data[STAGES_NUM][0];

endmodule
