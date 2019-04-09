onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /de1_top_tb/dut/clock_50
add wave -noupdate -divider {Our Clock is from Key(0)}
add wave -noupdate /de1_top_tb/dut/key(0)
add wave -noupdate /de1_top_tb/dut/clk
add wave -noupdate -divider {LED Ouputs}
add wave -noupdate /de1_top_tb/dut/ledr
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
add wave -noupdate /de1_top_tb/dut/clk
add wave -noupdate /de1_top_tb/dut/q_dt
add wave -noupdate -radix hexadecimal /de1_top_tb/dut/address
add wave -noupdate -radix decimal /de1_top_tb/dut/data
add wave -noupdate /de1_top_tb/dut/upper_address
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
add wave -noupdate /de1_top_tb/dut/q_dt
add wave -noupdate /de1_top_tb/dut/clk
add wave -noupdate -radix hexadecimal -childformat {{/de1_top_tb/dut/address(4) -radix decimal} {/de1_top_tb/dut/address(3) -radix decimal} {/de1_top_tb/dut/address(2) -radix decimal} {/de1_top_tb/dut/address(1) -radix decimal} {/de1_top_tb/dut/address(0) -radix decimal}} -subitemconfig {/de1_top_tb/dut/address(4) {-height 15 -radix decimal} /de1_top_tb/dut/address(3) {-height 15 -radix decimal} /de1_top_tb/dut/address(2) {-height 15 -radix decimal} /de1_top_tb/dut/address(1) {-height 15 -radix decimal} /de1_top_tb/dut/address(0) {-height 15 -radix decimal}} /de1_top_tb/dut/address
add wave -noupdate -radix binary /de1_top_tb/dut/hex0segment/input
add wave -noupdate /de1_top_tb/dut/data
add wave -noupdate /de1_top_tb/dut/upper_address
add wave -noupdate /de1_top_tb/dut/hex0segment/hex
add wave -noupdate /de1_top_tb/dut/hex0segment/seven_seg
add wave -noupdate -radix hexadecimal -childformat {{/de1_top_tb/dut/ram/address(4) -radix decimal} {/de1_top_tb/dut/ram/address(3) -radix decimal} {/de1_top_tb/dut/ram/address(2) -radix decimal} {/de1_top_tb/dut/ram/address(1) -radix decimal} {/de1_top_tb/dut/ram/address(0) -radix decimal}} -subitemconfig {/de1_top_tb/dut/ram/address(4) {-height 15 -radix decimal} /de1_top_tb/dut/ram/address(3) {-height 15 -radix decimal} /de1_top_tb/dut/ram/address(2) {-height 15 -radix decimal} /de1_top_tb/dut/ram/address(1) {-height 15 -radix decimal} /de1_top_tb/dut/ram/address(0) {-height 15 -radix decimal}} /de1_top_tb/dut/ram/address
add wave -noupdate /de1_top_tb/dut/ram/clock
add wave -noupdate /de1_top_tb/dut/ram/data
add wave -noupdate /de1_top_tb/dut/ram/wren
add wave -noupdate -radix binary /de1_top_tb/dut/ram/q
add wave -noupdate /de1_top_tb/dut/ram/sub_wire0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {245 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 260
configure wave -valuecolwidth 103
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
WaveRestoreZoom {32 ns} {298 ns}
