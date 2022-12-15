// skeleton code file for alu
// version: Sp2022

module alu(
	input [7:0] 		in_a,		// input a
	input [7:0] 		in_b,		// input b
	input [3:0] 		opcode,		// opcode input
	output reg [7:0] 	alu_out,	// alu output
	output reg		alu_zero,	// logic '1' when alu_output is all zeros
	output reg 		alu_carry	// indicates a carry out from ALU
);

	parameter c_add = 4'h1;
	parameter c_sub = 4'h2;
	parameter c_inc = 4'h3;
	parameter c_dec = 4'h4;
	parameter c_or  = 4'h5;
	parameter c_and = 4'h6;
	parameter c_xor = 4'h7;
	parameter c_shr = 4'h8;
	parameter c_shl = 4'h9;
	parameter c_onescomp = 4'ha;
	parameter c_twoscomp = 4'hb;

	/** Your code here **/
	/** Each opcode causes the ALU to perform the specific operation **/
 	always_comb begin
 		// All possibility has been listed, and no need to provide code handling invalid opcodes
		unique case (opcode)	
      		c_add:		{alu_carry, alu_out} = in_a + in_b;			// in_a + in_b
      		c_sub:		{alu_carry, alu_out} = in_a - in_b;			// in_a - in_b 
      		c_inc: 		{alu_carry, alu_out} = in_a + 1;			// in_a + 1
      		c_dec: 		{alu_carry, alu_out} = in_a - 1;			// in_a - 1
      		c_or: 		{alu_carry, alu_out} = in_a | in_b;			// in_a OR in_b
      		c_and:		{alu_carry, alu_out} = in_a & in_b;			// in_a AND in_b
      		c_xor:		{alu_carry, alu_out} = in_a ^ in_b;			// in_a XOR in_b
      		c_shr:		{alu_carry, alu_out} = in_a >> 1;			// in_a is shifted one place right, zero shifted in MSB
      		c_shl:		{alu_carry, alu_out} = in_a << 1;			// in_a is shifted one place left, zero shifted in LSB
      		c_onescomp: 	{alu_carry, alu_out} = {1'b0, in_a ^ 8'hff};		// in_a gets "ones complemented"
      		c_twoscomp:	{alu_carry, alu_out} = {1'b0, in_a ^ 8'hff} + 1;	// in_a gets "twos complemented"
		endcase
  	end
  
	always_comb begin
	// std 11.4.5 
	// if, due to unknown or high-impedance bits in the operands, the relation is ambiguous, then the result shall be a 1-bit unknown value (x)
      		alu_zero = (alu_out == 8'h00);	
	end
endmodule
