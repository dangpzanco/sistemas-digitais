vsim +altera -do topocalc_run_msim_gate_vhdl.do -l msim_transcript -gui work.topocalc

add wave -position insertpoint  \
sim:/topocalc/SW \
sim:/topocalc/HEX0 \
sim:/topocalc/HEX1 \
sim:/topocalc/LEDR \
sim:/topocalc/KEY \
sim:/topocalc/CLOCK_50 \
sim:/topocalc/gnd \
sim:/topocalc/vcc \
sim:/topocalc/unknown \
sim:/topocalc/devoe \
sim:/topocalc/devclrn \
sim:/topocalc/devpor \
sim:/topocalc/ww_devoe \
sim:/topocalc/ww_devclrn \
sim:/topocalc/ww_devpor \
sim:/topocalc/ww_SW \
sim:/topocalc/ww_HEX0 \
sim:/topocalc/ww_HEX1 \
sim:/topocalc/ww_LEDR \
sim:/topocalc/ww_KEY \
sim:/topocalc/ww_CLOCK_50

force -freeze sim:/topocalc/CLOCK_50 1 0, 0 {50 ps} -r 100
run

vsim -voptargs=+acc work.topocalc
# vsim -voptargs=+acc work.topocalc 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.topocalc(topo_estru)
# Loading work.fsm(fsm_beh)
# Loading work.minitopo(topo_estru)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading work.c1_soma(c1_estr)
# Loading work.c2_ou(c2_estr)
# Loading work.desloca_esquerda(behv)
# Loading work.desloca_direita(behv)
# Loading work.mux4x1(mux_estr)
# Loading work.flipf(behv)
# Loading work.decodehex(dec_estr)
add wave -position insertpoint  \
sim:/topocalc/SW \
sim:/topocalc/HEX0 \
sim:/topocalc/HEX1 \
sim:/topocalc/LEDR \
sim:/topocalc/KEY \
sim:/topocalc/CLOCK_50 \
sim:/topocalc/EN \
sim:/topocalc/S \
sim:/topocalc/X
force -freeze sim:/topocalc/SW(7) 1 0
force -freeze sim:/topocalc/SW(6) 1 0
force -freeze sim:/topocalc/SW(5) 0 0
force -freeze sim:/topocalc/SW(4) 0 0
force -freeze sim:/topocalc/SW(3) 1 0
force -freeze sim:/topocalc/SW(2) 1 0
force -freeze sim:/topocalc/SW(1) 0 0
force -freeze sim:/topocalc/SW(0) 1 0
force -freeze sim:/topocalc/CLOCK_50 1 0, 0 {50 ps} -r 100
force -freeze sim:/topocalc/KEY 01 0
force -freeze sim:/topocalc/KEY 00 0
run
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ps  Iteration: 0  Instance: /topocalc/L2/L1
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ps  Iteration: 0  Instance: /topocalc/L2/L1
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ps  Iteration: 1  Instance: /topocalc/L2/L1
run
run
run
run
run
run
force -freeze sim:/topocalc/KEY(0) 1 0
force -freeze sim:/topocalc/SW(17) 0 0
force -freeze sim:/topocalc/SW(16) 0 0
run
run
run
run
run
run
run
run
run
force -freeze sim:/topocalc/KEY 11 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
force -freeze sim:/topocalc/KEY(1) 0 0
run
run
run
run
run
run
run
run
run
force -freeze sim:/topocalc/KEY(1) 1 0
run
run
run
run
run
run
run
run
run
run
run
add wave -position insertpoint  \
sim:/topocalc/L1/EA \
sim:/topocalc/L1/PE
run
run
run
run
run
run
run
run
run
run
force -freeze sim:/topocalc/KEY(1) 0 0
run
run
run
run
run
run
run
run
run
