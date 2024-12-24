`timescale 1ns/1ps
module IFID(
  input clk, hold, flush,
  input wire [31:0] in_address,
  input wire [31:0] in_instruction,
  output reg [31:0] out_address,
  output reg [31:0] out_instruction
);

  always @(posedge clk) begin
    if(!hold) begin
      out_address <= in_address;
      out_instruction <= in_instruction;
    end
    else if(flush) begin
      out_address <= in_address;
      out_instruction <= 32'b0;
    end
    else if(hold) begin
      out_address <= out_address;
      out_instruction <= out_instruction;
      //out_instruction <= 32'b0;
    end
    else if(!flush) begin
      out_address <= in_address;
      out_instruction <= out_instruction;
    end
  end

endmodule