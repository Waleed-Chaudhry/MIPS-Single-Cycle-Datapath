//-----------------------------------------------------
// Design Name : Mips_Processor
// File Name : secClock.v
// Function : This program will output a clock of frequency 1 Hz
// Coder    : Waleed Chaudhry
// iverilog -o secClock.vvp secClock.v
// vvp secClock.vvp
// Both clock50 and clk_out start out as 0
// 0-149,999 clk_out = 0;
// 150,000-299,999 clk_out = 1;
//--------------

module secClock(stop, clkOut);

//Declaring wires and registers
	input wire stop;
	output reg clkOut;

	reg ClOCK_50;
	reg [24:0] countReg; // 2^(24+1) > 1

//Creating Parameters
	parameter clkFrequency = 300000;
	parameter desiredFrequency = 1;
	parameter maxCount = 149999; //((clkFrequency/desiredFrequency)/2)-1

	initial begin
		ClOCK_50 = 0;
		clkOut = 0;
		countReg = 0;
	end

//Making a 0.3MHz Clock
	always begin
		#1 ClOCK_50 = ~ClOCK_50;
	end

//Scaling the Clock to 1 Hz Frequency
	always @ (posedge ClOCK_50 or posedge stop) begin
		if (stop != 1'b1) begin
			if (countReg < maxCount) begin
				countReg <= countReg + 1;
			end else begin
				countReg <= 0;
				clkOut <= ~ clkOut;
			end
		end
	end

endmodule