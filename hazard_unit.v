module HazardDetection(
  input clk,
  input eqFlag,
  input memReadEX,
  input [4:0] rt,
  input [31:0] instruction,
  output reg PC_enable,
  output reg IFID_enable,
  output reg IDEX_enable,
  output reg stallFlush
);

  initial begin
    PC_enable <= 1'b0;
    IFID_enable <= 1'b0;
    IDEX_enable <= 1'b0;
    stallFlush <= 1'b0;
  end

  always @(negedge clk) begin
    if((memReadEX == 1) && (PC_enable != 1) && (IFID_enable != 1) && ((rt == instruction[25:21]) || (rt == instruction[20:16]))) begin
      PC_enable <= 1'b1;
      IFID_enable <= 1'b1;
      IDEX_enable <= 1'b0;
      stallFlush <= 1'b1;
    end
    else if((instruction[31:26] == 6'b000100) && (eqFlag == 1) && (PC_enable != 1) && (IFID_enable != 1)) begin
      PC_enable <= 1'b0;
      IFID_enable <= 1'b1;
      IDEX_enable <= 1'b0;
      stallFlush <= 1'b1;
    end
    else begin
      PC_enable <= 1'b0;
      IFID_enable <= 1'b0;
      IDEX_enable <= 1'b0;
      stallFlush <= 1'b0;
    end
  end

endmodule