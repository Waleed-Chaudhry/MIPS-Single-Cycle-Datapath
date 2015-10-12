//-----------------------------------------------------
// Design Name : Mips_Processor
// File Name : mainfile.v
// Function : This program will be the mainfile for the proessor
// Coder    : Waleed Chaudhry
//--------------
`include "secClock.v"
`include "fetch.v"
`include "decode.v"
`include "mux32bit.v"
`include "alu.v"
`include "aluControl.v"
`include "memory.v"
`include "mainControl.v"

module mainfile;

//Declaring wires and registers

//Step 0
	wire clock;
	reg halt;

//Step 1
	reg signed [31:0] PC;
	reg signed [31:0] address;
	wire [31:0] instruction;

//Step 2
	wire [4:0] muxOut;

	wire regDst;
	wire regWrite;
	wire signed [31:0] writeData;
	wire signed [31:0] readData1;
	wire signed [31:0] readData2;

//Step 3
	wire signed [31:0] signedImmediate;
	wire aluScr;
	wire signed [31:0] mux2Out;

	wire [3:0] aluOperation;
	wire [1:0] aluOp;

	wire zero;
	wire signed [31:0] aluResult;

//Step 4 and 5
	wire signed [31:0] readData;
	wire signed [31:0] mux3out;

	wire memWrite;
	wire memRead;
	wire memToReg;

//Step 6
	wire branch;
	wire PCSrc;
	wire signed [31:0] target_address;
	wire signed [31:0] mux4Out;

//Initializing the variables 
initial begin
//Step 0
	PC = 32'd0;
	address = 32'd0;
	halt = 1'b0;
end

//Step 0: Setting the Program Counter
	secClock getClock(halt,clock);

	always @ (negedge clock) begin
		address <= mux4Out;
	end
//Step 1: Fetch
	fetch step1(address, instruction);

//Step 2: Decode
	mux5bit mux1(instruction[20:16], instruction[15:11], regDst, muxOut);
	decode step2(regDst, instruction[25:21], instruction[20:16], muxOut, writeData, regWrite, readData1, readData2, clock);


//Step 3: ALU
	assign signedImmediate = {{16{instruction[15]}}, instruction[15:0]};
	mux32bit mux2(readData2, signedImmediate, aluScr, mux2Out);

	aluControl control2(instruction[5:0], aluOp, aluOperation);

	alu step3(aluOperation, readData1, mux2Out, zero, aluResult);

//Step 4 and 5: Reading to and Wrinting From Memory
	memory step4(aluResult, readData2, memWrite, memRead, readData,clock);

	mux32bit mux3(aluResult, readData, memToReg, writeData);

//Designing the Main Control for the Processor
	mainControl step6(instruction[31:26], {regDst,aluScr,memToReg,regWrite,memRead,memWrite,branch,aluOp});


//Step 6: Branching Instruction
	assign PCSrc = branch & zero;
	assign target_address = (signedImmediate << 2) + address;
	mux32bit mux4(address + 4, target_address, PCSrc, mux4Out);
 

//Halting the Processor
	always @(posedge clock) begin
		halt <= &instruction;
	end
endmodule