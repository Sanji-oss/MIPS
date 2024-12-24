`timescale 1ns/1ps
module MEMWB(
  input clk,
  input regWrite, memToReg,
  input [31:0] aluResult, readData,
  input [4:0] writeReg,
  output reg out_regWrite, out_memToReg,
  output reg [31:0] out_aluResult, out_readData,
  output reg [4:0] out_writeReg
);

  always @(posedge clk) begin
    out_regWrite <= regWrite;
    out_memToReg <= memToReg;
    out_aluResult <= aluResult;
    out_readData <= readData;
    out_writeReg <= writeReg;
  end
endmodule