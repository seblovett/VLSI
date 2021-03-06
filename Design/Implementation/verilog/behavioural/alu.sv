// Written by hl13g10 
module alu(
  	output 	logic 	[3:0]	Flags, 
  	output 	logic 	[15:0]	Result,
  	input      	[15:0]	Op1,
  	input        	[15:0]	Op2,
	input opcodes::Opcode_t OpCode,
  	input 	wire		CarryIn,
	input	logic 	[3:0]	ShAmount
);

timeunit 1ns; timeprecision 100ps;

import opcodes::*;


logic Carry;
assign Flags[`FLAGS_Z] = (Result == 0);
assign Flags[`FLAGS_N] = Result[15];
assign Flags[`FLAGS_C] = Carry;
assign Flags[`FLAGS_V] = (~Op1[15] & ~Op2[15] & Result[15]) | ( Op1[15] & Op2[15] & ~Result[15]);
always_comb
begin
   	Carry = 0; 		//default case
	case(OpCode)
		ADD,ADDI,ADDIB,BRANCH,INTERRUPT,POP, LDW,STW: {Carry,Result} = {1'b0, Op1} + {1'b0, Op2};
		ADC,ADCI: {Carry,Result} = {1'b0, Op1} + {1'b0, Op2} + CarryIn; 
		NEG: Result = -Op1;
		SUB, SUBI,SUBIB,CMP,CMPI,PUSH: {Carry,Result} = {1'b0, Op1} - {1'b0, Op2};
		SUC, SUCI: {Carry, Result} = {1'b0,Op1} - {1'b0,Op2} - (CarryIn);
		AND:Result = Op1 & Op2; 
		OR: Result = Op1 | Op2;		
		XOR:Result = Op1 ^ Op2;    		
		NOT:Result = ~Op1;   		
		NAND: Result = ~(Op1 & Op2);   		
		NOR:Result = ~(Op1 | Op2);  		
		LSL:Result = Op1 << ShAmount;   		
		LSR:Result = Op1 >> ShAmount;   		
		ASR:Result = Op1 >>> ShAmount;   		
		LUI:Result = {Op2[7:0], 8'b0};   		
		LLI:Result = {Op1[15:8], Op2[7:0]};
	endcase
end
endmodule
