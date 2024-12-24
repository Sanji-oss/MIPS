`timescale 1ns/1ps
module MUX2to1_32(
  input [31:0] input1,
  input [31:0] input2,
  input select,
  output [31:0] out
);

  assign out = (select == 0) ? input1 : input2;

endmodule