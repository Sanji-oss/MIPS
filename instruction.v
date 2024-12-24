`timescale 1ns/1ps

module InstructionMemory(
  input wire [31:0] address, // Инструкц унших хаяг
  output reg [31:0] instruction // Хаягаас уншсан инструкцийг хадгалах хувьсагч
);

  reg [7:0] instrmem [0:15]; // 8 байт урттай 256 ширхэг инструкцийн санах ой үүсгэх

  // *****************************************************************
  initial begin // Гадны үүсгэл ашиглана
    $readmemh("program.txt", instrmem); // Text файлаас инструкцийн мэдээллийг санах ойд руу бичих
    $display("Instruction Memory Contents:");
    $display("Addr | Value");
    $display("-----------------");
    for (integer i = 0; i < 16; i = i + 4) begin
      $display("%2d: %h %h %h %h", 
        i, instrmem[i], instrmem[i+1], instrmem[i+2], instrmem[i+3]);
    end
  end

  // *****************************************************************
  always @(address) begin // Instruction Memory-д хаяг өөрчлөгдөх бүрд ажиллана
    instruction[31:24] <= instrmem[address];
    $display("Instruction Memory Address: %d", address);
    instruction[23:16] <= instrmem[address+2'b01];
    $display("Instruction Memory Address+1: %d", address+2'b01);
    instruction[15:8] <= instrmem[address+2'b10];
    $display("Instruction Memory Address+2: %d", address+2'b10);
    instruction[7:0] <= instrmem[address+2'b11]; // Санах ойгоос 1,1 байтаар инструкцийг 'instruction' хувьсагчид уншиж авах
    $display("Instruction Memory Address+3: %d", address+2'b11);  
  end

endmodule