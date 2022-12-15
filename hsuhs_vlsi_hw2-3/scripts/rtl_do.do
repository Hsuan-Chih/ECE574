# do file for RTL alu
# version: Sp2022

# 0th: compile code (into "rtl_work" work library)
vlog rtl_src/alu.sv -work rtl_work
# 1st: set up simulator (set time step to ns and optimizer off)
vsim rtl_work.alu -t ns

# 2nd_A: add all waveforms in model
add wave *

# 2nd_B: make a list that will be updated every 10ns...wait 9ns before sampling starts
# See modelsim_reference_manual_v11.c pg 60
# the second line(add...) removes the delta column. Then -label shortens the name of each column so it is more convenient to fit in a txtfile.
config list -strobeperiod {10 ns} -strobestart {9 ns} -usestrobe 1
add list -nodelta -notrigger -label OP opcode -label A in_a -label B in_b -label OUT alu_out -label CRY alu_carry -label ZRO alu_zero

# 3rd start simulation:
#force opcode 1 @ 100, 1 @ 200,0 @ 300, 1 @ 400

#################################
# Sim opcode in_a+in_b
#################################
force opcode 'd1

# Case 1: 0+0 = 0 (min case)
force in_a 'h0
force in_b 'h0
run 10ns

#Case 2: h0A+h0B = h15 (some other case)
force in_a 'h0A
force in_b 'h0B
run 10ns

#Case3: hFF+hFF = h1FE (max case, test alu_carry)
force in_a 'hFF
force in_b 'hFF
run 10ns
#################################
# Sim opcode in_a-in_b
#################################
force opcode 'd2
# Hardware implementation of (a - b) is (a + ~b + 1)
# but the output   word has a 9-bit width, alu_carry is MSB

# Case 1: h00-hFF = h101
force in_a 'h00
force in_b 'hFF
run 10ns

#Case 2: h0B-h0A = h01  (some case in the middle)
force in_a 'h0B
force in_b 'h0A
run 10ns

#Case3: hFF-h00 = hFF (max case)
force in_a 'hFF
force in_b 'h00
run 10ns
#################################
# Sim opcode in_a+1
#################################
force opcode 'd3
# Case 1: 'h0+1 = 1 (min case)
force in_a 'h00
force in_b 'hXX
run 10ns

#Case 2: 0h0F+1 = 0h10
force in_a 'h0F
run 10ns

#Case3: hFF+1 = h100 (max case, test alu_carry)
force in_a 'hFF
run 10ns
#################################
# Sim opcode: in_a-1 
#################################
force opcode 'd4
#Case 1: 'h01-1 = 00  (min out case, alu_zero)
force in_a 'h01
run 10ns

#Case 2: h00-1 = h1FF  (rolls over to the max value 1FF)
force in_a 'h00
run 10ns

#Case3: hFF-1 = 0hFE (max case, test alu_carry)
force in_a 'hFF
run 10ns
#################################
# Sim opcode: bitwise_OR(in_a,in_b)
#################################
force opcode 'd5
# Case 1: output 'h41
force in_a 'h40
force in_b 'h01
run 10ns

#Case 2: output 00  (test alu_zero)
force in_a 'h00
force in_b 'h00
run 10ns

#Case3: output FF
force in_a 'hD2
force in_b 'h2D
run 10ns
#################################
# Sim opcode: bitwise_AND(in_a,in_b)
#################################
force opcode 'd6
# Case 1: output 'h41
force in_a 'h41
force in_b 'hFF
run 10ns

#Case 2: output 00   (test alu_zero)
force in_a 'hF0
force in_b 'h07
run 10ns

#Case3: output FF
force in_a 'hFF
force in_b 'hFF
run 10ns
#################################
# Sim opcode: bitwise_XOR(in_a,in_b)
#################################
force opcode 'd7
# Case 1: output 'h41
force in_a 'h41
force in_b 'h00
run 10ns

#Case 2: output 00   (test alu_zero)
force in_a 'h26
force in_b 'h26
run 10ns

#Case3: output FF
force in_a 'h89
force in_b 'h76
run 10ns
#################################
# Sim opcode: in_a Shift right
#################################
force opcode 'd8
# Case 1: output 'h41
force in_a 'h82
force in_b 'hXX
run 10ns

#Case 2: output 00   (test alu_zero)
force in_a 'h01
run 10ns

#Case3: output XX   (test alu_zero passing X) 
force in_a 'hXX
run 10ns
#################################
# Sim opcode: in_a Shift left
#################################
force opcode 'd9
# Case 1: output 'h82
force in_a 'h41
run 10ns

#Case 2: output 100   (test alu_zero and alu_carry)
force in_a 'h80
run 10ns

#Case3: output XX   (test alu_zero passing X)
force in_a 'hXX
run 10ns
#################################
# Sim opcode: in_a 1s Comp
#################################
force opcode 'd10
# Case 1: min output (00)   (test alu_zero) 
force in_a 'hFF
run 10ns

#Case 2: max output (FF)
force in_a 'h00
run 10ns

#Case3: some output ('h53)
force in_a 'hAC
run 10ns
#################################
# Sim opcode: in_a 2s Comp
#################################
force opcode 'd11
# The input to this 
#Hardware implementation of 2sComp(in_a) = ~a + 1
#but is done in a register of 9 bits, to include the carry bit.

# Case 1: in_a=h00  out= h00 (unique 0 repreesntation)
force in_a 'h00
run 10ns

#Case 2: ina = h5A  out = h1A6  (test, alu_carry )
force in_a 'h5A
run 10ns

#Case3: in_a=hFF out=h101 (max case, test alu_carry)
force in_a 'hFF
run 10ns
#################################
# Sim opcode: invalid codes
#################################
#

force opcode 'd00
run 10ns

force opcode 'd12
run 10ns

force opcode 'd13
run 10ns

force opcode 'd14
run 10ns

force opcode 'd15
run 10ns

#################################

# 4th: Write data in a .list and exit 
write list rtl_alu.list
exit
