`timescale 1ns/1ps
module SignExtend(
  input wire [15:0] offset,
  output reg [31:0] extended_out
);

  always @(offset) begin // offset-н утга өөрчлөгдөх үед
    extended_out[15:0] = offset[15:0]; // Зөвхөн 16 битээр хадгалах
    extended_out[31:16] = {16{offset[15]}}; // Анхны 16 бит offset-ын тэмдэгтээс хамаарч 16 битээр нэмэгдүүлэх
  end

endmodule
