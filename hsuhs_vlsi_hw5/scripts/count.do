vlog count.sv tb.sv
vsim -voptargs=+acc work.tb_count
add wave *
add wave -position insertpoint  \
sim:/tb_count/COUNT/count_ps \
sim:/tb_count/COUNT/count_ns \
sim:/tb_count/COUNT/startToCount \
sim:/tb_count/COUNT/stopToCount \
sim:/tb_count/COUNT/a_reg \
sim:/tb_count/COUNT/countZero \
sim:/tb_count/COUNT/countOne
restart 
run -all