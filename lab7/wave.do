onerror {resume}
quietly WaveActivateNextPane {} 0
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
add wave -noupdate /de1_top_tb/dut/enable_pulse_every_one_fourth_second
add wave -noupdate /de1_top_tb/dut/enable_pulse_every_one_second
add wave -noupdate /de1_top_tb/dut/one_sec_count_value
add wave -noupdate /de1_top_tb/dut/enable_pulse_seven_seconds
add wave -noupdate /de1_top_tb/dut/enable_pulse_seven_half_seconds
add wave -noupdate /de1_top_tb/dut/enable_pulse_ten_seconds
add wave -noupdate /de1_top_tb/dut/enable_pulse_one_point_five_seconds
add wave -noupdate /de1_top_tb/dut/seven_sec_count_value
add wave -noupdate /de1_top_tb/dut/seven_half_sec_count_value
add wave -noupdate /de1_top_tb/dut/ten_sec_count_value
add wave -noupdate /de1_top_tb/dut/one_point_five_sec_count_value
add wave -noupdate /de1_top_tb/dut/enable_pulse_nine_seconds
add wave -noupdate /de1_top_tb/dut/enable_pulse_eleven_half_seconds
add wave -noupdate /de1_top_tb/dut/enable_pulse_five_fourth_seconds
add wave -noupdate /de1_top_tb/dut/enable_pulse_one_point_seven_five_seconds
add wave -noupdate /de1_top_tb/dut/nine_sec_count_value
add wave -noupdate /de1_top_tb/dut/eleven_half_sec_count_value
add wave -noupdate /de1_top_tb/dut/five_fourth_sec_count_value
add wave -noupdate /de1_top_tb/dut/one_point_seven_five_sec_count_value
add wave -noupdate /de1_top_tb/dut/reset_n
add wave -noupdate /de1_top_tb/dut/sw8
add wave -noupdate /de1_top_tb/dut/selected_green_ns_timer_value
add wave -noupdate /de1_top_tb/dut/selected_red_ew_timer_value
add wave -noupdate /de1_top_tb/dut/load_counter
add wave -noupdate /de1_top_tb/dut/nw_state_input
add wave -noupdate /de1_top_tb/dut/ew_state_input
add wave -noupdate /de1_top_tb/dut/ns_main/clk
add wave -noupdate /de1_top_tb/dut/ns_main/reset_a
add wave -noupdate /de1_top_tb/dut/ns_main/red_timer
add wave -noupdate /de1_top_tb/dut/ns_main/green_timer
add wave -noupdate /de1_top_tb/dut/ns_main/yellow_timer
add wave -noupdate /de1_top_tb/dut/ns_main/flash_yellow_timer
add wave -noupdate /de1_top_tb/dut/ns_main/night_mode
add wave -noupdate /de1_top_tb/dut/ns_main/error_mode
add wave -noupdate /de1_top_tb/dut/ns_main/east_west_state
add wave -noupdate /de1_top_tb/dut/ns_main/hex_0
add wave -noupdate /de1_top_tb/dut/ns_main/nw_state_out
add wave -noupdate /de1_top_tb/dut/ns_main/current_state
add wave -noupdate /de1_top_tb/dut/ns_main/next_state
add wave -noupdate /de1_top_tb/dut/ns_main/error_mode_active
add wave -noupdate /de1_top_tb/dut/ew_main/clk
add wave -noupdate /de1_top_tb/dut/ew_main/reset_a
add wave -noupdate /de1_top_tb/dut/ew_main/red_timer
add wave -noupdate /de1_top_tb/dut/ew_main/green_timer
add wave -noupdate /de1_top_tb/dut/ew_main/yellow_timer
add wave -noupdate /de1_top_tb/dut/ew_main/flash_red_timer
add wave -noupdate /de1_top_tb/dut/ew_main/night_mode
add wave -noupdate /de1_top_tb/dut/ew_main/error_mode
add wave -noupdate /de1_top_tb/dut/ew_main/north_south_state
add wave -noupdate /de1_top_tb/dut/ew_main/hex_5
add wave -noupdate /de1_top_tb/dut/ew_main/ew_state_out
add wave -noupdate /de1_top_tb/dut/ew_main/current_state
add wave -noupdate /de1_top_tb/dut/ew_main/next_state
add wave -noupdate /de1_top_tb/dut/ew_main/error_mode_active
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2005 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 347
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
configure wave -timelineunits ps
update
WaveRestoreZoom {2002 ns} {2005 ns}
