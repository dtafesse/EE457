onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /de1_top_tb/dut/clock_50
add wave -noupdate -divider {Our Clock is from Key(0)}
add wave -noupdate /de1_top_tb/dut/key(0)
add wave -noupdate -divider {LED Ouputs}
add wave -noupdate /de1_top_tb/dut/ledr
add wave -noupdate /de1_top_tb/dut/enable_pulse_every_second
add wave -noupdate -radix hexadecimal /de1_top_tb/dut/one_second_counter/count
add wave -noupdate /de1_top_tb/dut/ram/clock
add wave -noupdate /de1_top_tb/dut/ram/data
add wave -noupdate /de1_top_tb/dut/ram/rdaddress
add wave -noupdate /de1_top_tb/dut/ram/wraddress
add wave -noupdate /de1_top_tb/dut/ram/wren
add wave -noupdate /de1_top_tb/dut/ram/q
add wave -noupdate /de1_top_tb/dut/ram/sub_wire0
add wave -noupdate /de1_top_tb/dut/data
add wave -noupdate /de1_top_tb/dut/q_data
add wave -noupdate -radix hexadecimal /de1_top_tb/dut/read_address
add wave -noupdate /de1_top_tb/dut/read_address_lower
add wave -noupdate /de1_top_tb/dut/read_address_upper
add wave -noupdate /de1_top_tb/dut/sw_output
add wave -noupdate /de1_top_tb/dut/write_address
add wave -noupdate /de1_top_tb/dut/write_address_upper
add wave -noupdate /de1_top_tb/dut/hex0segment/input
add wave -noupdate /de1_top_tb/dut/hex0segment/hex
add wave -noupdate /de1_top_tb/dut/hex0segment/seven_seg
add wave -noupdate /de1_top_tb/dut/hex1segment/input
add wave -noupdate /de1_top_tb/dut/hex1segment/hex
add wave -noupdate /de1_top_tb/dut/hex1segment/seven_seg
add wave -noupdate -radix hexadecimal /de1_top_tb/dut/hex2segment/input
add wave -noupdate -radix symbolic /de1_top_tb/dut/hex2segment/hex
add wave -noupdate /de1_top_tb/dut/hex2segment/seven_seg
add wave -noupdate -radix hexadecimal /de1_top_tb/dut/hex3segment/input
add wave -noupdate /de1_top_tb/dut/hex3segment/hex
add wave -noupdate /de1_top_tb/dut/hex3segment/seven_seg
add wave -noupdate /de1_top_tb/dut/hex4segment/input
add wave -noupdate /de1_top_tb/dut/hex4segment/hex
add wave -noupdate /de1_top_tb/dut/hex4segment/seven_seg
add wave -noupdate /de1_top_tb/dut/hex5segment/input
add wave -noupdate /de1_top_tb/dut/hex5segment/hex
add wave -noupdate /de1_top_tb/dut/hex5segment/seven_seg
add wave -noupdate /de1_top_tb/dut/large_counter/clk
add wave -noupdate /de1_top_tb/dut/large_counter/data
add wave -noupdate /de1_top_tb/dut/large_counter/load
add wave -noupdate /de1_top_tb/dut/large_counter/enable
add wave -noupdate /de1_top_tb/dut/large_counter/reset_n
add wave -noupdate /de1_top_tb/dut/large_counter/count
add wave -noupdate /de1_top_tb/dut/large_counter/term
add wave -noupdate /de1_top_tb/dut/large_counter/i_count
add wave -noupdate /de1_top_tb/dut/one_second_counter/clk
add wave -noupdate /de1_top_tb/dut/one_second_counter/data
add wave -noupdate /de1_top_tb/dut/one_second_counter/load
add wave -noupdate /de1_top_tb/dut/one_second_counter/enable
add wave -noupdate -radix hexadecimal /de1_top_tb/dut/one_second_counter/count
add wave -noupdate /de1_top_tb/dut/one_second_counter/reset_n
add wave -noupdate /de1_top_tb/dut/one_second_counter/term
add wave -noupdate /de1_top_tb/dut/one_second_counter/i_count
add wave -noupdate /de1_top_tb/sw
add wave -noupdate /de1_top_tb/key
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11580 ns} 0}
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
WaveRestoreZoom {11316 ns} {13446 ns}
