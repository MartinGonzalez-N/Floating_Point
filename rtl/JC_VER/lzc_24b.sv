module lzc_24 (
    input [23:0] a,
    output [4:0] c,
    output v
);
  timeunit 1ns; timeprecision 1ps;

  logic [2:0] z0;
  logic [2:0] z1;
  logic [2:0] z2;
  logic [2:0] v0;
  logic [4:0] c1;
  
  lzc_8 lzc_4_comp_0 (
      .a(a[7:0]),
      .c(z0),
      .v(v0[0])
  );

  lzc_8 lzc_4_comp_1 (
      .a(a[15:8]),
      .c(z1),
      .v(v0[1])
  );
  lzc_8 lzc_4_comp_2 (
      .a(a[23:16]),
      .c(z2),
      .v(v0[2])
  );	  

assign v = |v0;
assign c = c1;
always @(*) begin

	if(v0[1] == 0 && v0[2] == 0 )begin

		c1[4] = 1;
		c1[3] = 0;
		c1[2] = z0[2];
		c1[1] = z0[1];
		c1[0] = z0[0];		

	end
	else if(v0[2] == 0 )begin

		c1[4] = 0;
		c1[3] = 1;
		c1[2] = z1[2];
		c1[1] = z1[1];
		c1[0] = z1[0];		

	end			
	else begin

		c1[4] = 0;
		c1[3] = 0;
		c1[2] = z2[2];
		c1[1] = z2[1];
		c1[0] = z2[0];		
	
	end

end



endmodule
