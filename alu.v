//-----------------------------------------------------
// Design Name : Mips_Processor
// File Name : alu.v
// Function : This file models the ALU
// Coder    : Waleed Chaudhry
//--------------

module alu(aluOperation, readData1, mux2Out, zero, aluResult);
	input wire [3:0] aluOperation;
	input wire signed [31:0] readData1;
	input wire signed [31:0] mux2Out;

	output reg zero;
	output reg signed [31:0] aluResult;

	always @ (*) begin
		case(aluOperation) 
		    4'b0000: aluResult = readData1 & mux2Out; //AND
		    4'b0001: aluResult = readData1 | mux2Out; //OR
		    4'b0010: aluResult = readData1 + mux2Out; //add
		    4'b0110: aluResult = readData1 - mux2Out; //sub
		    4'b0111: aluResult = (readData1 < mux2Out)? 32'd1:32'd0; //slt
		    default: aluResult = readData1 ~| mux2Out; //NOR 4'b1100
	 	endcase 

	 	zero = ~(|aluResult);
	end
endmodule