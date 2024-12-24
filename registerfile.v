`timescale 1ns/1ps
module RegisterFile(
  input clk,
  input regWrite,
  input [4:0] readRegister1,
  input [4:0] readRegister2,
  input [4:0] writeRegister,
  input [31:0] writeData,
  output reg [31:0] readData1,
  output reg [31:0] readData2
);

  reg [31:0] Registers [0:31]; // 32 битийн урттай 32 ширхэг регистр

  // *****************************************************************
  initial begin // Анхны утга олгох
    Registers[0] <= 32'b0; // $zero
    Registers[4] <= 32'b1; // $a0
    Registers[5] <= 32'b1000; // $a1
    Registers[6] <= 32'b0; // $a2
    Registers[7] <= 32'b0; // $a3
    Registers[8] <= 32'b10000; // $t0
    Registers[9] <= 32'b1000; // $t1
    Registers[10] <= 32'b100; // $t2
    Registers[11] <= 32'b10000; // $t3
    Registers[12] <= 32'b1010; // $t4
    Registers[13] <= 32'b10101; // $t5
    Registers[14] <= 32'b1010; // $t6
    Registers[15] <= 32'b0101; // $t7
    Registers[16] <= 32'b0; // $s0
    Registers[17] <= 32'b0; // $s1
    Registers[18] <= 32'b0; // $s2
    Registers[19] <= 32'b0; // $s3
    Registers[20] <= 32'b0; // $s4
    Registers[21] <= 32'b0; // $s5
    Registers[22] <= 32'b0; // $s6
    Registers[23] <= 32'b0; // $s7
    Registers[24] <= 32'b11; // $s8
    Registers[25] <= 32'b0101; // $s9
  end

  // *****************************************************************
  always @(readRegister1 or readRegister2) begin
    readData1 <= (readRegister1 == 0) ? 32'b0 : Registers[readRegister1]; // Rs регистрийн утга
    readData2 <= (readRegister2 == 0) ? 32'b0 : Registers[readRegister2]; // Rt регистрийн утга
  end

  // *****************************************************************
  always @(negedge clk) begin // Клокны буурах фронт ирэх бүрд
    if(regWrite) begin // Регистр-т бичих сигнал ирсэн бол
      Registers[writeRegister] <= writeData; // Орох хаягаар регистр-т бичих
    end
  end

endmodule