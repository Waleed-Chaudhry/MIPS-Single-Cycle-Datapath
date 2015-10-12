# MIPS Single Cycle Datapath
The processor implements R Type, I Type and Branching Instructions  
The following programs were used to test out the correct operation of the processor  

These v files can be compiled and tested using a Verilog compiler such as Icarus Verilog.   
Installation instructions are available here:  

http://www.swarthmore.edu/NatSci/mzucker1/e15_f2014/iverilog.html  

Test Program  

This program adds the numbers between A and B, inclusive, where A originally resides at address 4 in data memory and B resides in address 8 in data memory. The result is placed at data memory location 0.   

The program is:  
sub r0,r0,r0 ; set reg[0] to 0, use as base  
lw r1,0(r0) ; reg[1] <- mem[0]   
lw r2,4(r0) ; reg[2] <- mem[4]    
lw r3,8(r0) ; reg[3] <- mem[8]    
add r4,r6,r6 ; reg[6] <- reg[6] keeps track of the overall sum  
sub r4,r4,r4 ; reg[4] <- 0, Resets r4  
add r4,r2,r4 ; reg[4]+ = A  
slt r5,r2,r3 ; reg[5] <- A < B  
beq r5,r0,3 ; if reg[5] = FALSE, go forward 3 instructions  
add r2,r1,r2 ; A++  
beq r0,r0,-6 ; go back 6 instructions  
add r4,r6,r6 ; adding the final value to the overall sum  
sw r6,0(r0) ; mem[0] <- reg[6]  
halt  

Initial Data Memory Configuration  
00000001  
00000001 //A  
0000000a //B  

Initial Register Configuration  
All Registers were set to 0  

Result  
  
The program prints out the correct register state and memory configuration of the program at every clock cycle   
The correct final value of x37 ends up at data memory location 3  
The final states of the register and main memory have been saved in Output.txt  
