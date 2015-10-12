//-----------------------------------------------------
// Design Name : Mips_Processor
// File Name : decode.v
// Function : This file will fetch the instruction
// Coder    : Waleed Chaudhry
//--------------

`include "mux5bit.v"

module decode(regDst, readRegister1, readRegister2, writeRegister, writeData, regWrite, readData1, readData2, clock);
	input wire [4:0] readRegister1;
	input wire [4:0] readRegister2;
	input wire [4:0] writeRegister;

	input wire regDst;

	input wire signed [31:0] writeData;
	input wire regWrite;
	output reg signed [31:0] readData1;
	output reg signed [31:0] readData2;

	
	reg [31:0] registerMemory[0:31];
	integer i;

	input clock;
	
	//Initializing the register memory
	initial begin
		for (i = 0; i < 32; i = i +1) begin
			registerMemory[i] = 32'd0;
		end
	end

	//The Main Decode Step
	always @ (*) begin
		readData1 <= registerMemory[readRegister1];
		readData2 <= registerMemory[readRegister2];
	end

	always @ (posedge clock) begin
		if (regWrite) begin
			registerMemory[writeRegister] <= writeData;	
		end
	end

	// Printing the Register Memory
	always @ (negedge clock) begin
		$display("Printing Register Memory");
		for (i = 0; i < 32; i = i +8) begin
			$display("%h, %h, %h, %h, %h, %h, %h, %h", 
			registerMemory[i],registerMemory[i+1],registerMemory[i+2],registerMemory[i+3],
			registerMemory[i+4],registerMemory[i+5],registerMemory[i+6],registerMemory[i+7],);
		end
	end


endmodule