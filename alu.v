`timescale 1ns/1ps
module ALU(
  input wire [31:0] aluIn1,
  input wire [31:0] aluIn2,
  input wire [3:0] aluControl,
  input wire [4:0] shamt,
  output reg [31:0] aluResult,
  output reg zero
);

  initial begin
    zero = 1'b0;
  end

  always @(aluControl or aluIn1 or aluIn2) begin
    case (aluControl)
      4'b0000: aluResult <= aluIn1 & aluIn2; // AND
      4'b0001: aluResult <= aluIn1 | aluIn2; // OR
      4'b0010: aluResult <= aluIn1 + aluIn2; // ADD
      4'b0110: aluResult <= aluIn1 - aluIn2; // SUB
      4'b0111: aluResult <= ($signed(aluIn1) < $signed(aluIn2)) ? 1 : 0; // SLT
      4'b1001: aluResult <= aluIn2 << shamt; // SLL
      4'b1010: aluResult <= aluIn2 >> shamt; // SRL
      4'b1011: aluResult <= aluIn1 ^ aluIn2; // XOR
      4'b1100: aluResult <= ~(aluIn1 | aluIn2); // NOR
      default: aluResult <= 32'b0;
    endcase
    zero = (aluIn2 == aluIn1) ? 1 : 0; // Оролтын 2 утга тэнцүү бол 1
  end

endmodule