onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /de1_top_tb/dut/ns_main/clk
add wave -noupdate /de1_top_tb/dut/ns_main/reset_a
add wave -noupdate /de1_top_tb/dut/ns_main/green_timer_switch
add wave -noupdate /de1_top_tb/dut/ns_main/night_mode
add wave -noupdate /de1_top_tb/dut/ns_main/error_mode
add wave -noupdate /de1_top_tb/dut/ns_main/hex_0
add wave -noupdate /de1_top_tb/dut/ns_main/time_counter
add wave -noupdate /de1_top_tb/dut/ns_main/current_state
add wave -noupdate /de1_top_tb/dut/ns_main/next_state
add wave -noupdate /de1_top_tb/dut/ns_main/error_mode_active
add wave -noupdate /de1_top_tb/dut/ns_main/count
add wave -noupdate /de1_top_tb/dut/ew_main/clk
add wave -noupdate /de1_top_tb/dut/ew_main/reset_a
add wave -noupdate /de1_top_tb/dut/ew_main/red_timer_switch
add wave -noupdate /de1_top_tb/dut/ew_main/night_mode
add wave -noupdate /de1_top_tb/dut/ew_main/error_mode
add wave -noupdate /de1_top_tb/dut/ew_main/time_counter
add wave -noupdate /de1_top_tb/dut/ew_main/hex_5
add wave -noupdate /de1_top_tb/dut/ew_main/current_state
add wave -noupdate /de1_top_tb/dut/ew_main/next_state
add wave -noupdate /de1_top_tb/dut/ew_main/error_mode_active
add wave -noupdate /de1_top_tb/dut/ew_main/count
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
add wave -noupdate /de1_top_tb/dut/ns_main/night_mode_activated
add wave -noupdate /de1_top_tb/dut/stablized_sws/input
add wave -noupdate /de1_top_tb/dut/stablized_sws/clk
add wave -noupdate /de1_top_tb/dut/stablized_sws/reset
add wave -noupdate /de1_top_tb/dut/stablized_sws/output
add wave -noupdate /de1_top_tb/dut/stablized_keys/input
add wave -noupdate /de1_top_tb/dut/stablized_keys/clk
add wave -noupdate /de1_top_tb/dut/stablized_keys/reset
add wave -noupdate /de1_top_tb/dut/stablized_keys/output
add wave -noupdate /de1_top_tb/dut/reset_struc/input
add wave -noupdate /de1_top_tb/dut/reset_struc/clk
add wave -noupdate /de1_top_tb/dut/reset_struc/reset
add wave -noupdate /de1_top_tb/dut/reset_struc/output
add wave -noupdate /de1_top_tb/dut/reset_struc/first_meta_output
add wave -noupdate /de1_top_tb/dut/ew_main/night_mode_activated
add wave -noupdate /de1_top_tb/dut/ns_main/error_mode_active
add wave -noupdate /de1_top_tb/dut/ew_main/error_mode_active
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18460 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 308
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
WaveRestoreZoom {0 ns} {132109 ns}
