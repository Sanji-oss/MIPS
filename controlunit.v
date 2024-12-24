`timescale 1ns/1ps
module ControlUnit(
  input wire [5:0] Opcode,
  output reg regDst, regDat, regWrite, aluSrc, branch, memRead, memWrite, memToReg,
  output reg [2:0] ALUop
);

  always @(Opcode) begin
    case(Opcode)
      6'b000000: begin /* R type */
        regDst <= 1'b1;
        regWrite <= 1'b1;
        aluSrc <= 1'b0;
        branch <= 1'b0;
        memRead <= 1'b0;
        memWrite <= 1'b0;
        memToReg <= 1'b0;
        ALUop <= 3'b010;
      end
      6'b000100: begin /* beq */
        regDst <= 1'b0;
        regWrite <= 1'b0;
        aluSrc <= 1'b0;
        branch <= 1'b1;
        memRead <= 1'b0;
        memWrite <= 1'b0;
        memToReg <= 1'b0;
        ALUop <= 3'b001;
      end
      6'b001000: begin /* addi */
        regDst <= 1'b0;
        regWrite <= 1'b1;
        aluSrc <= 1'b1;
        branch <= 1'b0;
        memRead <= 1'b0;
        memWrite <= 1'b0;
        memToReg <= 1'b0;
        ALUop <= 3'b011;
      end
      6'b001100: begin /* andi */
        regDst <= 1'b0;
        regWrite <= 1'b1;
        aluSrc <= 1'b1;
        branch <= 1'b0;
        memRead <= 1'b0;
        memWrite <= 1'b0;
        memToReg <= 1'b0;
        ALUop <= 3'b100;
      end
      6'b001110: begin /* NORI */
        regDst <= 1'b0;
        regWrite <= 1'b0;
        aluSrc <= 1'b1;
        branch <= 1'b0;
        memRead <= 1'b0;
        memWrite <= 1'b1;
        memToReg <= 1'b0;
        ALUop <= 3'b110;
      end
      6'b001101: begin /* ori */
        regDst <= 1'b0;
        regWrite <= 1'b1;
        aluSrc <= 1'b1;
        branch <= 1'b0;
        memRead <= 1'b0;
        memWrite <= 1'b0;
        memToReg <= 1'b0;
        ALUop <= 3'b101;
      end
      6'b100011: begin /* load word */
        regDst <= 1'b0;
        regWrite <= 1'b1;
        aluSrc <= 1'b1;
        branch <= 1'b0;
        memRead <= 1'b1;
        memWrite <= 1'b0;
        memToReg <= 1'b1;
        ALUop <= 3'b000;
      end
      6'b101011: begin /* store word */
        regDst <= 1'bx;
        regWrite <= 1'b0;
        aluSrc <= 1'b1;
        branch <= 1'b0;
        memRead <= 1'b0;
        memWrite <= 1'b1;
        memToReg <= 1'bx;
        ALUop <= 3'b000;
      end
      default: begin /* default */
        regDst <= 1'b0;
        regWrite <= 1'b0;
        aluSrc <= 1'b0;
        branch <= 1'b0;
        memRead <= 1'b0;
        memWrite <= 1'b0;
        memToReg <= 1'b0;
        ALUop <= 3'b000;
      end
    endcase
  end

endmodule