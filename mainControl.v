//-----------------------------------------------------
// Design Name : Mips_Processor
// File Name : mainControl.v
// Function : This file handles the main Control of the Processor
// Coder    : Waleed Chaudhry
//--------------

module mainControl(functField, controlData);
	input wire [5:0] functField;
	output reg [8:0] controlData;

	always @ (*) begin
		case(functField) 
		    6'b000000: controlData = 9'b100_100_010; //R-Type
		    6'b100011: controlData = 9'b011_110_000; //lw
		    6'b101011: controlData = 9'b010_001_000; //sw
		    
		    6'b000100: controlData = 9'b000_000_101; ///branch 6'b000100

	 	endcase 
	end
endmodule