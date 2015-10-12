//-----------------------------------------------------
// Design Name : Mips_Processor
// File Name : fetch.v
// Function : This file will fetch the instruction
// Coder    : Waleed Chaudhry
//--------------

module fetch(address, instruction);
	
	//Declaring wires and registers
	input wire [31:0] address;
	output wire [31:0] instruction;

	reg [7:0] instructionMemory[0:55];

	//Initializing the Instruction Memory
	initial begin

	{instructionMemory[0], instructionMemory[1], instructionMemory[2], instructionMemory[3]} =  
	32'h00000022; //sub r0,r0,r0

	{instructionMemory[4], instructionMemory[5], instructionMemory[6], instructionMemory[7]} =  
	32'h8c010000; //lw  r1,0(r0)

	{instructionMemory[8], instructionMemory[9], instructionMemory[10], instructionMemory[11]} = 
	32'h8c020004; //lw  r2,4(r0)

	{instructionMemory[12], instructionMemory[13], instructionMemory[14], instructionMemory[15]} =  
	32'h8c030008; //lw  r3,8(r0)

	{instructionMemory[16], instructionMemory[17], instructionMemory[18], instructionMemory[19]} =  
	32'h00863020; //add r4,r6,r6

	{instructionMemory[20], instructionMemory[21], instructionMemory[22], instructionMemory[23]} =  
	32'h00842022; //sub r4,r4,r4

	{instructionMemory[24], instructionMemory[25], instructionMemory[26], instructionMemory[27]} =  
	32'h00822020; //add r4,r2,r4

	{instructionMemory[28], instructionMemory[29], instructionMemory[30], instructionMemory[31]} =  
	32'h0043282a; //slt r5,r2,r3

	{instructionMemory[32], instructionMemory[33], instructionMemory[34], instructionMemory[35]} =  
	32'h10a00003; //beq r5,r0,3 

	{instructionMemory[36], instructionMemory[37], instructionMemory[38], instructionMemory[39]} =  
	32'h00411020; //add r2,r1,r2

	{instructionMemory[40], instructionMemory[41], instructionMemory[42], instructionMemory[43]} =  
	32'h1000fffa; //beq r0,r0,-6 

	{instructionMemory[44], instructionMemory[45], instructionMemory[46], instructionMemory[47]} =  
	32'h00863020; //add r4,r6,r6

	{instructionMemory[48], instructionMemory[49], instructionMemory[50], instructionMemory[51]} =  
	32'hac060000; //sw r6,0(r0)

	{instructionMemory[52], instructionMemory[53], instructionMemory[54], instructionMemory[55]} =  
	32'hffffffff; //halt
	end

	assign instruction =  {instructionMemory[address], instructionMemory[address+1], instructionMemory[address+2],instructionMemory[address+3]};

endmodule
