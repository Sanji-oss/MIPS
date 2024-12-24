`timescale 1ns/1ps
module ForwardingUnit(
  input regWriteMEM,
  input regWriteWB,
  input [4:0] rsEX,
  input [4:0] rtEX,
  input [4:0] rd_writeRegMEM,
  input [4:0] rd_writeRegWB,
  output [1:0] data1mux_sel,
  output [1:0] data2mux_sel
);

  reg a,b,c,d;

  always @* begin
    if((regWriteMEM == 1) && (rd_writeRegMEM != 0) && (rd_writeRegMEM == rsEX)) begin
      a <= 1'b1;
    end
    else if((regWriteWB == 1) && (rd_writeRegWB != 0) && (rd_writeRegWB == rsEX)) begin
      b <= 1'b1;
    end
    else begin
      a <= 1'b0;
      b <= 1'b0;
    end

    if((regWriteMEM == 1) && (rd_writeRegMEM != 0) && (rd_writeRegMEM == rtEX)) begin
      c <= 1'b1;
    end
    else if((regWriteWB == 1) && (rd_writeRegWB != 0) && (rd_writeRegWB == rtEX)) begin
      d <= 1'b1;
    end
    else begin
      c <= 1'b0;
      d <= 1'b0;
    end
  end

  assign data1mux_sel[1] = a;
  and (data1mux_sel[0], (~a), b);
  assign data2mux_sel[1] = c;
  and (data2mux_sel[0], (~c), d);

endmodule

