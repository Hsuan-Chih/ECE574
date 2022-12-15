vlog src/tb.sv src/gcd*.sv
vsim tb -c
run -all

##############################
##Functional coverage report##
##############################
#coverage report -details -output func.low.rpt
coverage report -details -output func.high.rpt
exit