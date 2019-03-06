onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /de1_top_tb/dut/simulation_wide
add wave -noupdate /de1_top_tb/dut/simulation_max
add wave -noupdate /de1_top_tb/dut/clock_50
add wave -noupdate -divider {large counter}
add wave -noupdate -radix unsigned /de1_top_tb/dut/large_counter/i_count
add wave -noupdate /de1_top_tb/dut/large_counter/term
add wave -noupdate -divider {My one second timer}
add wave -noupdate /de1_top_tb/dut/one_second_counter/wide
add wave -noupdate /de1_top_tb/dut/one_second_counter/max
add wave -noupdate -radix hexadecimal /de1_top_tb/dut/one_second_counter/count
add wave -noupdate /de1_top_tb/dut/one_second_counter/term
add wave -noupdate -divider {one second hex output}
add wave -noupdate -radix hexadecimal /de1_top_tb/dut/hex0_driver/input
add wave -noupdate /de1_top_tb/dut/one_second_counter/term
add wave -noupdate -divider {My ten second counter}
add wave -noupdate /de1_top_tb/dut/ten_second_counter/wide
add wave -noupdate /de1_top_tb/dut/ten_second_counter/max
add wave -noupdate -radix unsigned /de1_top_tb/dut/ten_second_counter/count
add wave -noupdate /de1_top_tb/dut/ten_second_counter/term
add wave -noupdate -divider {Ten Second Hex Output}
add wave -noupdate -radix unsigned /de1_top_tb/dut/hex1_driver/input
add wave -noupdate -divider {LED Ouputs}
add wave -noupdate /de1_top_tb/dut/ledr
add wave -noupdate /de1_top_tb/dut/key
add wave -noupdate /de1_top_tb/dut/sw
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3469 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 260
configure wave -valuecolwidth 100
configure wave -justifyvalue right
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {3362 ns} {4213 ns}
