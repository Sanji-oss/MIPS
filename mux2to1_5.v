`timescale 1ns/1ps
module MUX2to1_5(
  input [4:0] input1,
  input [4:0] input2,
  input select,
  output [4:0] out
);

  assign out = (select == 0) ? input1 : input2;

endmodule
