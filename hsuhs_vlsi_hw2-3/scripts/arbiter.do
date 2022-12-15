vlog arbiter.sv tb_arbiter.sv
vsim -voptargs=+acc work.tb_arbiter
add wave *
add wave -position insertpoint  \
sim:/tb_arbiter/iDUT/count \
sim:/tb_arbiter/iDUT/arbiter_ps \
sim:/tb_arbiter/iDUT/arbiter_ns
restart 
run -all