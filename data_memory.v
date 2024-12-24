`timescale 1ns/1ps
module DataMemory(
  input clk,
  input memWrite,
  input memRead,
  input [31:0] address, writeData,
  output reg [31:0] readData
);

  reg [31:0] memory [0:31];

  initial begin // Анхны утга олгох
    memory[0] <= 8'b0;
    memory[1] <= 8'b0;
    memory[2] <= 8'b0;
    memory[3] <= 8'b1000; // Санах ойн эхний хэдэн утга хадгалах
  end

  // ***************** Санах ойд бичих *****************
  always @(memWrite) begin
    if(memWrite) begin // Санах ойд бичих сигнал ирсэн бол
      memory[address]       <= writeData[31:24];
      memory[address+2'b01] <= writeData[23:16];
      memory[address+2'b10] <= writeData[15:8];
      memory[address+2'b11] <= writeData[7:0]; // Оролтын өгөгдлийг санах ойд бичих
    end
  end

  // ***************** Санах ойгоос унших *****************
  always @(memRead or address) begin // Оролтод хандах хаяг өөрчлөгдөх эсвэл унших сигнал ирсэн бол
    if(memRead)                      // Санах ойгоос унших сигнал ирсэн бол
      readData <= {memory[address], 
                    memory[address+2'b01], 
                    memory[address+2'b10],
                     memory[address+2'b11]}; // Оролтын хаягаар утгыг гаргах
  end

endmodule
