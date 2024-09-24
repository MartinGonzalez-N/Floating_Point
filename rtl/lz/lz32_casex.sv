module LZ32 (input logic[31:0] bus, output logic [4:0] LZ);
always_comb begin
	casex(bus)
		32'b1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 0;
		end
		32'b01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 1;
		end
		32'b001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 2;
		end
		32'b0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 3;
		end
		32'b0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 4;
		end
		32'b0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 5;
		end
		32'b0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 6;
		end
		32'b0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 7;
		end
		32'b0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 8;
		end
		32'b0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 9;
		end
		32'b0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 10;
		end
		32'b0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 11;
		end
		32'b0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 12;
		end
		32'b0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 13;
		end
		32'b0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 14;
		end
		32'b0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx: begin
            LZ = 15;
		end
		32'b0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx: begin
            LZ = 16;
		end
		32'b0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx: begin
            LZ = 17;
		end
		32'b0000_0000_0000_0000_001x_xxxx_xxxx_xxxx: begin
            LZ = 18;
		end
		32'b0000_0000_0000_0000_0001_xxxx_xxxx_xxxx: begin
            LZ = 19;
		end
		32'b0000_0000_0000_0000_0000_1xxx_xxxx_xxxx: begin
            LZ = 20;
		end
		32'b0000_0000_0000_0000_0000_01xx_xxxx_xxxx: begin
            LZ = 21;
		end
		32'b0000_0000_0000_0000_0000_001x_xxxx_xxxx: begin
            LZ = 22;
		end
		32'b0000_0000_0000_0000_0000_0001_xxxx_xxxx: begin
            LZ = 23;
		end
		32'b0000_0000_0000_0000_0000_0000_1xxx_xxxx: begin
            LZ = 24;
		end
		32'b0000_0000_0000_0000_0000_0000_01xx_xxxx: begin
            LZ = 25;
		end
		32'b0000_0000_0000_0000_0000_0000_001x_xxxx: begin
            LZ = 26;
		end
		32'b0000_0000_0000_0000_0000_0000_0001_xxxx: begin
            LZ = 27;
		end
		32'b0000_0000_0000_0000_0000_0000_0000_1xxx: begin
            LZ = 28;
		end
		32'b0000_0000_0000_0000_0000_0000_0000_01xx: begin
            LZ = 29;
		end
		32'b0000_0000_0000_0000_0000_0000_0000_001x: begin
            LZ = 30;
		end
		32'b0000_0000_0000_0000_0000_0000_0000_0001: begin
            LZ = 31;
		end
		default: begin
			LZ = 32;
		end
	endcase
end
endmodule
