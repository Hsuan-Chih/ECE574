#########################################################################
##To collect statement, branch, condition, expression, and FSM coverage##
#########################################################################
vlog src/tb.sv src/gcd*.sv -cover sbcef +cover=f -O0
vsim tb -c -coverage

##########################################################################
##No need to include tb.sv because miss in testbench is normal situation##
##########################################################################
coverage exclude -srcfile src/tb.sv
run -all
#coverage save a.ucdb
coverage report -details -output post-coverage.rpt

################################################
##Produce a file which can be opened via .html##
################################################
#coverage report -details -html

exit