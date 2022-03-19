vsim work.vending_machine_tb

add wave -position insertpoint  \
sim:/vending_machine_tb/soft_drink \
sim:/vending_machine_tb/juice \
sim:/vending_machine_tb/piasters \
sim:/vending_machine_tb/clock \
sim:/vending_machine_tb/reset \
sim:/vending_machine_tb/beh/CS \
sim:/vending_machine_tb/beh/NS \
sim:/vending_machine_tb/cancel \
sim:/vending_machine_tb/drink_b \
sim:/vending_machine_tb/drink_s \
sim:/vending_machine_tb/drink_d \
sim:/vending_machine_tb/change25_b \
sim:/vending_machine_tb/change25_s \
sim:/vending_machine_tb/change25_d \
sim:/vending_machine_tb/change50_b \
sim:/vending_machine_tb/change50_s \
sim:/vending_machine_tb/change50_d \
sim:/vending_machine_tb/change100_b \
sim:/vending_machine_tb/change100_s \
sim:/vending_machine_tb/change100_d \
sim:/vending_machine_tb/scanin \
sim:/vending_machine_tb/scanout \
sim:/vending_machine_tb/test \

run 1.6 us