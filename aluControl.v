//-----------------------------------------------------
// Design Name : Mips_Processor
// File Name : aluControl.v
// Function : This file generates the ALU Operation Code
// Coder    : Waleed Chaudhry
//--------------

module aluControl (opCode, aluOp, aluOperation);
	input wire [5:0] opCode;
	input wire [1:0] aluOp;

	output reg [3:0] aluOperation;

	always @ (*) begin
		// $display("Value of aluOp is %b", aluOp);
		casex(aluOp) 
			2'b1x: begin //R-Type Instructions
		    	case(opCode)        
			        6'b100000: aluOperation = 4'b0010;    //Add
			        6'b100010: aluOperation = 4'b0110;    //Sub
			        6'b100100: aluOperation = 4'b0000;    //AND
			        6'b100101: aluOperation = 4'b0001;    //OR
			        6'b101010: aluOperation = 4'b0111;    //slt
			        default: aluOperation = 4'b1100;    //NOR 4'b1100;
		    	endcase
			end 
			// I-Type Instructions 
		    2'b00: begin // lw/sw Instuction
		        aluOperation = 4'b0010;
		    end
		    
		    default: begin // bne/bnq Instruction (aluOp == 2'bx1)
		   		aluOperation = 4'b0110;
			end
		endcase   
	end
endmodule