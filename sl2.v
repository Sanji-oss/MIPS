`timescale 1ns/1ps
module shiftLeft2(
  input [31:0] in,
  output [31:0] out
);

  assign out = in << 2; // Оролтын утгыг 2 шифт хийж гаргах

endmodule