onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /de1_top_tb/dut/clock_50
add wave -noupdate -divider {Our Clock is from Key(0)}
add wave -noupdate /de1_top_tb/dut/key(0)
add wave -noupdate /de1_top_tb/dut/clk
add wave -noupdate -divider {LED Ouputs}
add wave -noupdate /de1_top_tb/dut/ledr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {384021 ns} {401057 ns}
