vlog src/tb.sv src/gcd.sv src/gcd_ctrl.sv 
vsim -voptargs=+acc work.tb
add wave *
run -all