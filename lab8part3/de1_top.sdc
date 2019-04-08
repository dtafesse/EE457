create_clock -name clock_50Mhz -period 20 [get_ports {clock_50}]
derive_pll_clocks
derive_clock_uncertainty
set_input_delay  -clock { clock_50Mhz } 0 [get_ports {*}]
set_output_delay -clock { clock_50Mhz } 0 [get_ports {*}]