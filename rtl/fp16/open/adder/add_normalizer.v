module add_normalizer (
    input             sign,
    input      [ 4:0] exponent,
    input      [13:0] mantissa_add_in,
    output reg [15:0] result,
    input             if_carray,
    input             if_sub
    );
    wire [14:0] mantissa_add;
    reg [4:0] number_of_zero_lead;
    reg [3:0] left_shift_val;
    reg [14:0] norm_mantissa_add;
    reg [9:0] mantissa_tmp;

    wire [4:0] shift_left_exp;
    wire c1;
    wire borrow;
    reg round;
    assign mantissa_add = {if_carray,mantissa_add_in};
    always @ (*) begin
        if (mantissa_add[14:3] == 12'b0000_0000_0001) begin
            number_of_zero_lead = 5'd11;
            //norm_mantissa_add   = (mantissa_add << 4'd10);
        end else if (mantissa_add[14:4] == 11'b0000_0000_001) begin
            number_of_zero_lead = 5'd10;
            //norm_mantissa_add   = (mantissa_add << 4'd10);
        end else if (mantissa_add[14:5] == 10'b0000_0000_01) begin
            number_of_zero_lead = 5'd9;
            //norm_mantissa_add   = (mantissa_add << 4'd9);
        end else if (mantissa_add[14:6] == 9'b0000_0000_1) begin
            number_of_zero_lead = 5'd8;
            //norm_mantissa_add   = (mantissa_add << 4'd8);
        end else if (mantissa_add[14:7] == 8'b0000_0001) begin
            number_of_zero_lead = 5'd7;
            //norm_mantissa_add   = (mantissa_add << 4'd7);
        end else if (mantissa_add[14:8] == 7'b0000_001) begin
            number_of_zero_lead = 5'd6;
            //norm_mantissa_add   = (mantissa_add << 4'd6);
        end else if (mantissa_add[14:9] == 6'b0000_01) begin 
            number_of_zero_lead = 5'd5;
            //norm_mantissa_add   = (mantissa_add << 4'd5);
        end else if (mantissa_add[14:10] == 5'b0000_1) begin
            number_of_zero_lead = 5'd4;
            //norm_mantissa_add   = (mantissa_add << 4'd4);
        end else if (mantissa_add[14:11] == 4'b0001) begin
            number_of_zero_lead = 5'd3;
            //norm_mantissa_add   = (mantissa_add << 4'd3);
        end else if (mantissa_add[14:12] == 3'b001) begin
            number_of_zero_lead = 5'd2;
            //norm_mantissa_add   = (mantissa_add << 4'd2);
        end else if (mantissa_add[14:13] == 2'b01) begin
            number_of_zero_lead = 5'd1;
            //norm_mantissa_add   = (mantissa_add << 4'd1);
        end else begin 
            number_of_zero_lead = 5'd0;
            //norm_mantissa_add   = mantissa_add[13:0];
        end 
    end
    
    always @(*) begin
        result[15]          = sign;
        left_shift_val      = number_of_zero_lead > shift_left_exp ? shift_left_exp : number_of_zero_lead;
        norm_mantissa_add   = (mantissa_add << left_shift_val[3:0]);
        if (!if_sub) begin 
            result[14:10] = if_carray ? exponent + 1'b1 : exponent;
            //result[9:0]   = if_carray ? mantissa_add[13:4] : mantissa_add[12:3];
        end else begin 
            result[14:10] = borrow ? 5'd0 : shift_left_exp ;
            //result[9:0]   = norm_mantissa_add[12:3] + (|norm_mantissa_add[1:0] || norm_mantissa_add[3])&&norm_mantissa_add[2] ;
        end 
        round = (|norm_mantissa_add[2:0] || norm_mantissa_add[4])&&norm_mantissa_add[3];
        result[9:0]   = norm_mantissa_add[13:4] + {8'd0,round};
    end

    //cla_nbit #(.n(5)) u1(exponent,~number_of_zero_lead+1'b1,1'b0,shift_left_exp,c1);
    assign {borrow, shift_left_exp} = exponent-number_of_zero_lead + 1;

endmodule
