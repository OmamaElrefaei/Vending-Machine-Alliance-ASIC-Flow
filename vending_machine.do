# vending_machine.vhd

# Vending Machine
vcom -nolock -reportprogress 300 -work work {vending_machine.vhd}
vcom -nolock -reportprogress 300 -work work {vending_machinea_ln.vhd}
vcom -nolock -reportprogress 300 -work work {vending_machinea_s.vhd}

# Testbench
vcom -nolock -reportprogress 300 -work work {vending_machine_tb.vhd}

# Simulation and waveform plotting
do simulate.do
