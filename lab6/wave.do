onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /de1_top_tb/dut/simulation_wide
add wave -noupdate /de1_top_tb/dut/simulation_max
add wave -noupdate /de1_top_tb/dut/clock_50
add wave -noupdate -divider {large counter}
add wave -noupdate -divider {My one second timer}
add wave -noupdate -divider {one second hex output}
add wave -noupdate -divider {My ten second counter}
add wave -noupdate -divider {Ten Second Hex Output}
add wave -noupdate -divider {LED Ouputs}
add wave -noupdate /de1_top_tb/dut/ledr
add wave -noupdate /de1_top_tb/dut/key
add wave -noupdate /de1_top_tb/dut/sw
add wave -noupdate /de1_top_tb/aclr_n
add wave -noupdate /de1_top_tb/clk
add wave -noupdate /de1_top_tb/sw
add wave -noupdate /de1_top_tb/key
add wave -noupdate /de1_top_tb/ledr
add wave -noupdate /de1_top_tb/hex0
add wave -noupdate /de1_top_tb/hex1
add wave -noupdate /de1_top_tb/hex2
add wave -noupdate /de1_top_tb/hex3
add wave -noupdate /de1_top_tb/hex4
add wave -noupdate /de1_top_tb/hex5
add wave -noupdate /de1_top_tb/clk_half_period
add wave -noupdate /de1_top_tb/clk_cycle
add wave -noupdate /de1_top_tb/dut/clock_50
add wave -noupdate /de1_top_tb/dut/hex0
add wave -noupdate /de1_top_tb/dut/hex1
add wave -noupdate /de1_top_tb/dut/hex2
add wave -noupdate /de1_top_tb/dut/hex3
add wave -noupdate /de1_top_tb/dut/hex4
add wave -noupdate /de1_top_tb/dut/hex5
add wave -noupdate /de1_top_tb/dut/ledr
add wave -noupdate /de1_top_tb/dut/key
add wave -noupdate /de1_top_tb/dut/sw
add wave -noupdate /de1_top_tb/dut/enable_pulse_every_half_second
add wave -noupdate /de1_top_tb/dut/reset_n
add wave -noupdate /de1_top_tb/dut/sw0
add wave -noupdate /de1_top_tb/dut/enable_pulse_every_three_fourth_second
add wave -noupdate /de1_top_tb/dut/selected_timer_value
add wave -noupdate /de1_top_tb/dut/msg_main/clk
add wave -noupdate /de1_top_tb/dut/msg_main/count
add wave -noupdate /de1_top_tb/dut/msg_main/current_state
add wave -noupdate /de1_top_tb/dut/msg_main/halt_shift
add wave -noupdate /de1_top_tb/dut/msg_main/hex_0
add wave -noupdate /de1_top_tb/dut/msg_main/hex_1
add wave -noupdate /de1_top_tb/dut/msg_main/hex_2
add wave -noupdate /de1_top_tb/dut/msg_main/hex_3
add wave -noupdate /de1_top_tb/dut/msg_main/hex_4
add wave -noupdate /de1_top_tb/dut/msg_main/hex_5
add wave -noupdate /de1_top_tb/dut/msg_main/next_state
add wave -noupdate /de1_top_tb/dut/msg_main/reset_a
add wave -noupdate /de1_top_tb/dut/msg_main/shift_msg_left
add wave -noupdate /de1_top_tb/dut/msg_main/sliding_msg_sw
add wave -noupdate /de1_top_tb/dut/one_half_second_counter/clk
add wave -noupdate /de1_top_tb/dut/one_half_second_counter/data
add wave -noupdate /de1_top_tb/dut/one_half_second_counter/load
add wave -noupdate /de1_top_tb/dut/one_half_second_counter/enable
add wave -noupdate /de1_top_tb/dut/one_half_second_counter/reset_n
add wave -noupdate /de1_top_tb/dut/one_half_second_counter/count
add wave -noupdate /de1_top_tb/dut/one_half_second_counter/term
add wave -noupdate /de1_top_tb/dut/one_half_second_counter/i_count
add wave -noupdate /de1_top_tb/dut/three_fourth_second_counter/clk
add wave -noupdate /de1_top_tb/dut/three_fourth_second_counter/data
add wave -noupdate /de1_top_tb/dut/three_fourth_second_counter/load
add wave -noupdate /de1_top_tb/dut/three_fourth_second_counter/enable
add wave -noupdate /de1_top_tb/dut/three_fourth_second_counter/reset_n
add wave -noupdate /de1_top_tb/dut/three_fourth_second_counter/count
add wave -noupdate /de1_top_tb/dut/three_fourth_second_counter/term
add wave -noupdate /de1_top_tb/dut/three_fourth_second_counter/i_count
add wave -noupdate /de1_top_tb/dut/large_counter/clk
add wave -noupdate /de1_top_tb/dut/large_counter/data
add wave -noupdate /de1_top_tb/dut/large_counter/load
add wave -noupdate /de1_top_tb/dut/large_counter/enable
add wave -noupdate /de1_top_tb/dut/large_counter/reset_n
add wave -noupdate /de1_top_tb/dut/large_counter/count
add wave -noupdate /de1_top_tb/dut/large_counter/term
add wave -noupdate /de1_top_tb/dut/large_counter/i_count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 260
configure wave -valuecolwidth 77
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
WaveRestoreZoom {0 ns} {22448 ns}
