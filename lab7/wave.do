onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /de1_top_tb/dut/ns_main/clk
add wave -noupdate /de1_top_tb/dut/ns_main/reset_a
add wave -noupdate /de1_top_tb/dut/ns_main/green_timer_switch
add wave -noupdate /de1_top_tb/dut/ns_main/night_mode
add wave -noupdate /de1_top_tb/dut/ns_main/error_mode
add wave -noupdate /de1_top_tb/dut/ns_main/east_west_state
add wave -noupdate /de1_top_tb/dut/ns_main/hex_0
add wave -noupdate /de1_top_tb/dut/ns_main/time_counter
add wave -noupdate /de1_top_tb/dut/ns_main/nw_state_out
add wave -noupdate /de1_top_tb/dut/ns_main/current_state
add wave -noupdate /de1_top_tb/dut/ns_main/next_state
add wave -noupdate /de1_top_tb/dut/ns_main/error_mode_active
add wave -noupdate /de1_top_tb/dut/ns_main/count
add wave -noupdate /de1_top_tb/dut/ew_main/clk
add wave -noupdate /de1_top_tb/dut/ew_main/reset_a
add wave -noupdate /de1_top_tb/dut/ew_main/red_timer_switch
add wave -noupdate /de1_top_tb/dut/ew_main/night_mode
add wave -noupdate /de1_top_tb/dut/ew_main/error_mode
add wave -noupdate /de1_top_tb/dut/ew_main/north_south_state
add wave -noupdate /de1_top_tb/dut/ew_main/time_counter
add wave -noupdate /de1_top_tb/dut/ew_main/hex_5
add wave -noupdate /de1_top_tb/dut/ew_main/ew_state_out
add wave -noupdate /de1_top_tb/dut/ew_main/current_state
add wave -noupdate /de1_top_tb/dut/ew_main/next_state
add wave -noupdate /de1_top_tb/dut/ew_main/error_mode_active
add wave -noupdate /de1_top_tb/dut/ew_main/count
add wave -noupdate /de1_top_tb/dut/one_second_counter/clk
add wave -noupdate /de1_top_tb/dut/one_second_counter/data
add wave -noupdate /de1_top_tb/dut/one_second_counter/load
add wave -noupdate /de1_top_tb/dut/one_second_counter/enable
add wave -noupdate /de1_top_tb/dut/one_second_counter/reset_n
add wave -noupdate /de1_top_tb/dut/one_second_counter/count
add wave -noupdate /de1_top_tb/dut/one_second_counter/term
add wave -noupdate /de1_top_tb/dut/one_second_counter/i_count
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
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
WaveRestoreZoom {0 ns} {2461 ns}
