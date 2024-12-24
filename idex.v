`timescale 1ns/1ps
module IDEX(
  input wire clk, stall, branch, regDat,
  input wire regWrite, memToReg,
  input wire memWrite, memRead,
  input wire aluSrc,
  input wire [2:0] ALUop,
  input wire [31:0] in_address, readData1, readData2, signExtend,
  input wire [4:0] in_rs, in_rt, in_rd,
  output reg out_branch, out_regDat, out_RW, out_memToReg,
  output reg out_MW, out_MR, out_aluSrc,
  output reg [2:0] out_ALUop,
  output reg [31:0] out_address, out_readData1, out_readData2, out_signExtend,
  output reg [4:0] out_rs, out_rt, out_rd
);

  always @(posedge clk) begin
    if(!stall) begin
      out_address <= in_address;
      out_readData1 <= readData1;
      out_readData2 <= readData2;
      out_signExtend <= signExtend;
      out_rs <= in_rs;
      out_rt <= in_rt;
      out_rd <= in_rd;
      out_ALUop <= ALUop;
      out_MW <= memWrite;
      out_MR <= memRead;
      out_aluSrc <= aluSrc;
      out_branch <= branch;
      out_regDat <= regDat;
      out_RW <= regWrite;
      out_memToReg <= memToReg;
    end
    else if(stall) begin
      out_address <= 0;
      out_readData1 <= 0;
      out_readData2 <= 0;
      out_signExtend <= 0;
      out_rs <= 0;
      out_rt <= 0;
      out_rd <= 0;
      out_ALUop <= 0;
      out_MW <= 0;
      out_MR <= 0;
      out_aluSrc <= 0;
      out_branch <= 0;
      out_regDat <= 0;
      out_RW <= 0;
      out_memToReg <= 0;
    end
  end

endmodule