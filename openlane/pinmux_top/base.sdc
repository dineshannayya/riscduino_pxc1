###############################################################################
# Created by write_sdc
# Sat Nov 13 06:33:41 2021
###############################################################################
current_design glbl_cfg
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name mclk        -period 10.0000 [get_ports {mclk}]
create_clock -name mdio_refclk -period 10.0000 [get_pins {u_clkgen.u_mdio_ref_mux.u_mux_l10/X}]

set_clock_uncertainty -setup 0.2500 [all_clocks]
set_clock_uncertainty -hold  0.2500 [all_clocks]

set_clock_groups \
   -name clock_group \
   -logically_exclusive \
   -group [get_clocks {mclk}]\
   -group [get_clocks {mdio_refclk}]


set ::env(SYNTH_TIMING_DERATE) 0.05
puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 10}] %"
set_timing_derate -early [expr {1-$::env(SYNTH_TIMING_DERATE)}]
set_timing_derate -late [expr {1+$::env(SYNTH_TIMING_DERATE)}]


set_input_delay -max 6.0000 -clock [get_clocks {mclk}] -add_delay [get_ports {reg_addr[*]}]
set_input_delay -max 6.0000 -clock [get_clocks {mclk}] -add_delay [get_ports {reg_be[*]}]
set_input_delay -max 6.0000 -clock [get_clocks {mclk}] -add_delay [get_ports {reg_cs}]
set_input_delay -max 6.0000 -clock [get_clocks {mclk}] -add_delay [get_ports {reg_wdata[*]}]
set_input_delay -max 6.0000 -clock [get_clocks {mclk}] -add_delay [get_ports {reg_wr}]
set_input_delay -max 6.0000 -clock [get_clocks {mclk}] -add_delay [get_ports {reset_n}]

set_input_delay -min 2.0000 -clock [get_clocks {mclk}] -add_delay [get_ports {reg_addr[*]}]
set_input_delay -min 2.0000 -clock [get_clocks {mclk}] -add_delay [get_ports {reg_be[*]}]
set_input_delay -min 2.0000 -clock [get_clocks {mclk}] -add_delay [get_ports {reg_cs}]
set_input_delay -min 2.0000 -clock [get_clocks {mclk}] -add_delay [get_ports {reg_wdata[*]}]
set_input_delay -min 2.0000 -clock [get_clocks {mclk}] -add_delay [get_ports {reg_wr}]
set_input_delay -min 2.0000 -clock [get_clocks {mclk}] -add_delay [get_ports {reset_n}]

set_output_delay -max 6.0000 -clock [get_clocks {mclk}] -add_delay [get_ports {reg_ack}]
set_output_delay -max 6.0000 -clock [get_clocks {mclk}] -add_delay [get_ports {reg_rdata[*]}]

set_output_delay -min 1.0000 -clock [get_clocks {mclk}] -add_delay [get_ports {reg_ack}]
set_output_delay -min 1.0000 -clock [get_clocks {mclk}] -add_delay [get_ports {reg_rdata[*]}]



# Set max delay for clock skew
set_max_delay   3.5 -from [get_ports {wbd_clk_int}]
set_max_delay   2.5 -from wbd_clk_int -to wbd_clk_skew

set_case_analysis 0 [get_ports {cfg_cska_pinmux[0]}]
set_case_analysis 0 [get_ports {cfg_cska_pinmux[1]}]
set_case_analysis 0 [get_ports {cfg_cska_pinmux[2]}]
set_case_analysis 0 [get_ports {cfg_cska_pinmux[3]}]

set_case_analysis 0 [get_ports {scan_en}]
set_case_analysis 0 [get_ports {scan_mode}]
set_false_path -from [get_ports {scan_in[*]}]
set_false_path -to [get_ports {scan_out[*]}]

###############################################################################
# Environment
###############################################################################
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin $::env(SYNTH_DRIVING_CELL_PIN) [all_inputs]
set cap_load [expr $::env(SYNTH_CAP_LOAD) / 1000.0]
puts "\[INFO\]: Setting load to: $cap_load"
set_load  $cap_load [all_outputs]


###############################################################################
# Design Rules
###############################################################################
set_max_fanout 10.0000 [current_design]
