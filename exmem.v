`timescale 1ns/1ps
module EXMEM(
  input clk,
  input regWrite, memToReg,
  input memWrite, memRead,
  input [31:0] aluResult, writeData,
  input [4:0] writeReg,
  output reg out_regWrite, out_memToReg, out_memWrite, out_memRead,
  output reg [31:0] out_aluResult, out_writeData,
  output reg [4:0] out_writeReg
);

  always @(posedge clk) begin
    out_regWrite <= regWrite;
    out_memToReg <= memToReg;
    out_memWrite <= memWrite;
    out_memRead <= memRead;
    out_aluResult <= aluResult;
    out_writeData <= writeData;
    out_writeReg <= writeReg;
  end

endmodule