`timescale 1ns/1ps
module ALUControl(
  input wire [5:0] functionCode,
  input wire [2:0] aluOp,
  output reg [3:0] aluControl
);

  always @(aluOp or functionCode) begin
    if(aluOp == 3'b000) begin
      aluControl <= 4'b0010; // SW or LW
    end
    else if(aluOp == 3'b011) begin
      aluControl <= 4'b0010; // ADDI
    end
    else if(aluOp == 3'b100) begin
      aluControl <= 4'b0000; // ANDI
    end
    else if(aluOp == 3'b101) begin
      aluControl <= 4'b0001; // ORI
    end
    else if(aluOp == 3'b110) begin
      aluControl <= 4'b1011; // XORI
    end
    else begin // R формат
      case(functionCode)
        6'b100000: aluControl <= 4'b0010; // ADD
        6'b100010: aluControl <= 4'b0110; // SUB
        6'b100100: aluControl <= 4'b0000; // AND
        6'b100101: aluControl <= 4'b0001; // OR
        6'b100111: aluControl <= 4'b1100; // NOR
        6'b100110: aluControl <= 4'b1011; // XOR
        6'b101010: aluControl <= 4'b0111; // SLT
        6'b000000: aluControl <= 4'b1001; // SLL
        6'b000010: aluControl <= 4'b1010; // SRL
        default: aluControl <= 4'b0000; // otherwize
      endcase
    end
  end

endmodule