`timescale 1ns/1ps
module Comparator(
  input [31:0] in1,
  input [31:0] in2,
  output eqFlag
);

  reg flag;

  initial begin
    flag <= 1'b0;
  end

  always @* begin
    if(in1 == in2)
      flag <= 1'b1;
    else
      flag <= 1'b0;
  end

  assign eqFlag = flag;

endmodule