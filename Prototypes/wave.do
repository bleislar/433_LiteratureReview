onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /test_bench/X
add wave -noupdate -radix decimal /test_bench/Y
add wave -noupdate -radix decimal /test_bench/clk
add wave -noupdate -radix decimal /test_bench/P
add wave -noupdate /test_bench/pp3
add wave -noupdate /test_bench/pp2
add wave -noupdate /test_bench/pp1
add wave -noupdate /test_bench/pp0
add wave -noupdate /test_bench/dec_x
add wave -noupdate /test_bench/g3
add wave -noupdate /test_bench/g2
add wave -noupdate /test_bench/g1
add wave -noupdate /test_bench/g0
add wave -noupdate /test_bench/Cout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {498731 ps} {500067 ps}
