
`timescale 1ns/10ps
module Mips_tb;

  reg clk;
  wire flush, holdPC, hold, zero, PCsel, eqFlag, stall;
  wire regDat, regWrite, aluSrc, branch, memRead, memWrite, memToReg, jump;
  wire regDatID, regWriteID, aluSrcID, branchID, memReadID, memWriteID, memToRegID, jumpID;
  wire regDatEX, regWriteEX, aluSrcEX, branchEX, memReadEX, memWriteEX, memToRegEX;
  wire regWriteMEM, memToRegMEM, memWriteMEM, memReadMEM;
  wire regWriteWB, memToRegWB;
  wire [1:0] mux1_sel, mux2_sel;
  wire [2:0] ALUop, ALUopID, ALUopEX;
  wire [3:0] aluControl;
  wire [4:0] writeRegisterWB, rsEX, rtEX, rdEX, regDstmux, writeRegMEM, writeRegWB;
  wire [31:0] aluResultMEM, aluResultWB;
  wire [31:0] address, instructionIF, next_address, addressPC4IF;
  wire [31:0] branchAddress;
  wire [31:0] instructionID, signExtendID, signExtendEX;
  wire [31:0] addressPC4ID, addressPC4EX;
  wire [31:0] writeData;
  wire [31:0] readData1ID, readData2ID, readData1EX, readData2EX;
  wire [31:0] shiftedID;
  wire [31:0] aluData1, aluData2, aluResultEX, writeDataMEM, aluData2_mux1;
  wire [31:0] readDataMEM, readDataWB, writeDataWB;

  // ***************** Инструкц унших алах stage (IF) *****************
  ProgramCounter PC(
    .clk(clk),
    .holdPC(holdPC),
    .nextAddress(next_address),
    .address(address)
  ); // Програми гоолуур

  InstructionMemory IM(
    .address(address),
    .instruction(instructionIF)
  ); // Инструкции санах ой

  Adder PC_adder(
    .in1(32'b100),
    .in2(address),
    .out(addressPC4IF)
  ); // PC <= PC+4

  and branch_or_not(PCsel, zero, branchID); // Branch хийх эсэх

  MUX2to1_32 find_next_address(
    .input1(addressPC4IF),
    .input2(branchAddress),
    .select(PCsel),
    .out(next_address)
  ); // Дараагийн имотрукцийн хаяг олох

  IFID IIF(
    .clk(clk),
    .hold(hold),
    .flush(flush),
    .in_address(addressPC4IF),
    .in_instruction(instructionIF),
    .out_address(addressPC4ID),
    .out_instruction(instructionID)
  ); // Instruction Fetch

  // ***************** Инструки задлах stage (ID) *****************
  ControlUnit CU(
    .Opcode(instructionID[31:26]),
    .regDst(regDstID),
    .regWrite(regWriteID),
    .aluSrc(aluSrcID),
    .branch(branchID),
    .memRead(memReadID),
    .memWrite(memWriteID),
    .memToReg(memToRegID),
    // .jump(jumpID),
    .ALUop(ALUopID)
  );

  RegisterFile RF(
    .clk(clk),
    .regWrite(regWriteWB),
    .readRegister1(instructionID[25:21]),
    .readRegister2(instructionID[20:16]),
    .writeRegister(writeRegWB),
    .writeData(writeDataWB),
    .readData1(readData1ID),
    .readData2(readData2ID)
  );

  SignExtend SE(
    .offset(instructionID[15:0]),
    .extended_out(signExtendID)
  );

  shiftLeft2 SL(
    .in(signExtendID),
    .out(shiftedID)
  );

  Adder AD(
    .in1(shiftedID),
    .in2(addressPC4ID),
    .out(branchAddress)
  );

  Comparator COM(
    .in1(readData1ID),
    .in2(readData2ID),
    .eqFlag(eqFlag)
  );

  HazardDetection MD(
    .clk(clk),
    .eqFlag(eqFlag),
    .memReadEX(memReadEX),
    .rt(rtEX),
    .instruction(instructionID),
    .PC_enable(holdPC),
    .IFID_enable(hold),
    .IDEX_enable(stall),
    .stallFlush(flush)
  );

  IDEX IEX(
    .clk(clk),
    .stall(stall),
    .branch(branchID),
    .regDat(regDatID),
    .regWrite(regWriteID),
    .memToReg(memToRegID),
    .memWrite(memWriteID),
    .memRead(memReadID),
    .aluSrc(aluSrcID),
    .ALUop(ALUopID),
    .in_address(addressPC4ID),
    .readData1(readData1ID),
    .readData2(readData2ID),
    .signExtend(signExtendID),
    .in_rs(instructionID[25:21]),
    .in_rt(instructionID[20:16]),
    .in_rd(instructionID[15:11]),
    .out_branch(branchEX),
    .out_regDat(regDatEX),
    .out_RW(regWriteEX),
    .out_memToReg(memToRegEX),
    .out_MW(memWriteEX),
    .out_MR(memReadEX),
    .out_aluSrc(aluSrcEX),
    .out_ALUop(ALUopEX),
    .out_address(addressPC4EX),
    .out_readData1(readData1EX),
    .out_readData2(readData2EX),
    .out_signExtend(signExtendEX),
    .out_rs(rsEX),
    .out_rt(rtEX),
    .out_rd(rdEX)
  ); // Instruction decode

  // ***************** Инструкц харгалзах үйлдвэр гүйцэтгэх stage (EX) *****************
  MUX2to1_32 MUX11(
    .input1(readData2EX),
    .input2(signExtendEX),
    .select(aluSrcEX),
    .out(aluData2_mux1)
  ); // I эсвэл R форматаас хамаарч ALU-ийн оролт 2 түүчлэх

  MUX3to1_32 MUX1(
    .input1(readData1EX),
    .input2(writeDataWB),
    .input3(aluResultMEM),
    .select(mux1_sel),
    .out(aluData1)
  );

  MUX3to1 MUX2(
    .input1(aluData2_mux1),
    .input2(writeDataWB),
    .input3(aluResultMEM),
    .select(mux2_sel),
    .out(aluData2)
  );

  ALUControl AC(
    .functionCode(signExtendEX[5:0]),
    .aluOp(ALUopEX),
    .aluControl(aluControl)
  ); // ALU control сигнал гаргах

  ALU AL(
    .aluIn1(aluData1),
    .aluIn2(aluData2),
    .aluControl(aluControl),
    .shamt(signExtendEX[10:6]),
    .aluResult(aluResultEX),
    .zero(zero)
  ); // Arithmetic logic unit

  MUX2to1_5 MUX3(
    .input1(rtEX),
    .input2(rdEX),
    .select(regDatEX),  // Should be a 1-bit signal
    .out(writeRegisterWB)
); // I эсвэл R форматаас хамаарч destination регистр түүчлэх

  EXMEM EX(
    .clk(clk),
    .regWrite(regWriteEX),
    .memToReg(memToRegEX),
    .memWrite(memWriteEX),
    .memRead(memReadEX),
    .aluResult(aluResultEX),
    .writeData(readData2EX),
    .writeReg(regDstmux),
    .out_regWrite(regWriteMEM),
    .out_memToReg(memToRegMEM),
    .out_memWrite(memWriteMEM),
    .out_memRead(memReadMEM),
    .out_aluResult(aluResultMEM),
    .out_writeData(writeDataMEM),
    .out_writeReg(writeRegMEM)
  );

  ForwardingUnit FU(
    .regWriteMEM(regWriteMEM),
    .regWriteWB(regWriteWB),
    .rsEX(rsEX),
    .rtEX(rtEX),
    .rd_writeRegMEM(writeRegMEM),
    .rd_writeRegWB(writeRegWB),
    .data1mux_sel(mux1_sel),
    .data2mux_sel(mux2_sel)
  );

  // ***************** Санах ойн хандах stage (MEM) *****************
  DataMemory DM(
    .clk(clk),
    .memWrite(memWriteMEM),
    .memRead(memReadMEM),
    .address(aluResultMEM),
    .writeData(writeDataMEM),
    .readData(readDataMEM)
  );

  MEMWB MW(
    .clk(clk),
    .regWrite(regWriteMEM),
    .memToReg(memToRegMEM),
    .aluResult(aluResultMEM),
    .readData(readDataMEM),
    .writeReg(writeRegMEM),
    .out_regWrite(regWriteWB),
    .out_memToReg(memToRegWB),
    .out_aluResult(aluResultWB),
    .out_readData(readDataWB),
    .out_writeReg(writeRegWB)
  );

  // ***************** Үр дүнд буцаах stage (WB) *****************
  MUX2to1_32 MUX4(
    .input1(aluResultWB),
    .input2(readDataWB),
    .select(memToRegWB),
    .out(writeDataWB)
  ); // ALU үйлдлийн үр дүн // Санах ойн унших өгөгдөл түүчлэх

  // ***************** Системийн клок үүсгэх хэсэг *****************x
  initial begin
    $dumpfile("mips.vcd");  // Create VCD file
    $dumpvars(0, Mips_tb);  // Dump all variables
    clk = 0;
    #200 $finish;
  end

  always begin
    #10 clk = ~clk;
  end

endmodule