module lzd(
    input logic [10:0]data,
    output logic [$clog2(11):0]lzc
);
always_comb begin
	casex(data)
		11'b1xxx_xxxx_xxx: begin
            lzc = 0;
		end
		11'b01xx_xxxx_xxx: begin
			lzc = 1;
		end
		11'b001x_xxxx_xxx: begin
			lzc = 2;
		end
		11'b0001_xxxx_xxx: begin
			lzc = 3;
		end
		11'b0000_1xxx_xxx: begin
			lzc = 4;
		end
		11'b0000_01xx_xxx: begin
			lzc = 5;
		end
		11'b0000_001x_xxx: begin
			lzc = 6;
		end
		11'b0000_0001_xxx: begin
			lzc = 7;
		end
		11'b0000_0000_1xx: begin
			lzc = 8;
		end
		11'b0000_0000_01x: begin
			lzc = 9;
		end
		11'b0000_0000_001: begin
			lzc = 10;
		end
		default: begin
			lzc = 11;
		end
	endcase
end
    
endmodule