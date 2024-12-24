`timescale 1ns/1ps
module ProgramCounter(
  input clk,
  input holdPC,
  input wire [31:0] nextAddress,
  output reg [31:0] address
);

  initial begin // Анхны утга олгох
    address <= 32'hfffffffc; // Хаяг = "-4"
  end

  always @(posedge clk) begin // Клокны өсөх фронт ирэх бүрд
    if(!holdPC) // Hold сигнал идэвхжээгүй бол
      address <= nextAddress; // Дараагийн хаягийг гаргах
  end

endmodule