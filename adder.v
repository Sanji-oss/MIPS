`timescale 1ns/1ps
module Adder(
  input wire [31:0] in1,
  input wire [31:0] in2,
  output wire [31:0] out
);

  assign out = in1 + in2;

endmodule