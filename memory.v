//-----------------------------------------------------
// Design Name : Mips_Processor
// File Name : memory.v
// Function : This file models the memory of the processor
// Coder    : Waleed Chaudhry
//--------------

module memory(address, writeData, memWrite, memRead, readData, clock);
	input wire signed [31:0] address;
	input wire signed [31:0] writeData;
	input wire memWrite;
	input wire memRead;

	input wire clock;
	integer i;
	reg [7:0] mainMemory[0:31];

	output reg signed [31:0] readData;

	initial begin
		for (i = 0; i < 32; i = i +4) begin
			{mainMemory[i],	mainMemory[i+1],mainMemory[i+2],mainMemory[i+3]} = 32'd0;
		end


		{mainMemory[0], mainMemory[1], mainMemory[2],mainMemory[3]} = 32'h1;
		{mainMemory[4], mainMemory[5], mainMemory[6],mainMemory[7]} = 32'h1;
		{mainMemory[8], mainMemory[9], mainMemory[10],mainMemory[11]} = 32'ha;

	end

	//Main Memory Read/Memory Write Functionality
	always @(*) begin
	#1
		if (memRead) begin
			readData <= {mainMemory[address], mainMemory[address+1], mainMemory[address+2],mainMemory[address+3]};	
		end

		if (memWrite) begin
			{mainMemory[address], mainMemory[address+1], mainMemory[address+2],mainMemory[address+3]} <=writeData;
		end
	end

		// // Printing the Main Memory
		always @ (negedge clock) begin
		#1
			$display("Printing Main Memory");
			for (i = 0; i < 32; i = i +4) begin
				$display("%h",{mainMemory[i], mainMemory[i+1],mainMemory[i+2],mainMemory[i+3]});
			end
		end
endmodule