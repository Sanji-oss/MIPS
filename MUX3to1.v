`timescale 1ns/1ps
module MUX3to1(
    input [31:0] input1,
    input [31:0] input2,
    input [31:0] input3,
    input [1:0] select,
    output reg [31:0] out
);

    always @(*) begin
        case(select)
            2'b00: out = input1;
            2'b01: out = input2;
            2'b10: out = input3;
            default: out = input1;
        endcase
    end

endmodule
