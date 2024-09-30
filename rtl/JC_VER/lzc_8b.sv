module lzc_8 (
    input [7:0] a,
    output [2:0] c,
    output v
);
  timeunit 1ns; timeprecision 1ps;

  logic [1:0] z0;
  logic [1:0] z1;
  logic [1:0] v0;
  logic [2:0] c1;
	
  
  lzc_4 lzc_4_comp_0 (
      .a(a[3:0]),
      .c(z0),
      .v(v0[0])
  );

  lzc_4 lzc_4_comp_1 (
      .a(a[7:4]),
      .c(z1),
      .v(v0[1])
  );

assign v = |v0;
assign c = c1;

always @(*) begin

	if(v0[1] == 0)begin

		c1[2] = 1;
		c1[1] = z0[1];
		c1[0] = z0[0];		

	end 			
	else begin

		c1[2] = 0;
		c1[1] = z1[1];
		c1[0] = z1[0];		
	
	end

end



endmodule
