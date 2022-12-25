###############################################################################
# Created by write_sdc
# Sun Nov 14 09:33:23 2021
###############################################################################
current_design mbist_top
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name wb_clk_i -period 10.0000 [get_ports {wb_clk_i}]
create_clock -name wb_clk2_i -period 10.0000 [get_ports {wb_clk2_i}]
create_generated_clock -name bist_mem_clk_a[0] -add -source [get_ports {wb_clk2_i}] -master_clock [get_clocks wb_clk2_i] -divide_by 1 -comment {Mem Clock A0} [get_ports mem_clk_a[0]]
create_generated_clock -name bist_mem_clk_a[1] -add -source [get_ports {wb_clk2_i}] -master_clock [get_clocks wb_clk2_i] -divide_by 1 -comment {Mem Clock A1} [get_ports mem_clk_a[1]]
create_generated_clock -name bist_mem_clk_a[2] -add -source [get_ports {wb_clk2_i}] -master_clock [get_clocks wb_clk2_i] -divide_by 1 -comment {Mem Clock A2} [get_ports mem_clk_a[2]]
create_generated_clock -name bist_mem_clk_a[3] -add -source [get_ports {wb_clk2_i}] -master_clock [get_clocks wb_clk2_i] -divide_by 1 -comment {Mem Clock A3} [get_ports mem_clk_a[3]]

create_generated_clock -name bist_mem_clk_b[0] -add -source [get_ports {wb_clk2_i}] -master_clock [get_clocks wb_clk2_i] -divide_by 1 -comment {Mem Clock B0} [get_ports mem_clk_b[0]]
create_generated_clock -name bist_mem_clk_b[1] -add -source [get_ports {wb_clk2_i}] -master_clock [get_clocks wb_clk2_i] -divide_by 1 -comment {Mem Clock B1} [get_ports mem_clk_b[1]]
create_generated_clock -name bist_mem_clk_b[2] -add -source [get_ports {wb_clk2_i}] -master_clock [get_clocks wb_clk2_i] -divide_by 1 -comment {Mem Clock B2} [get_ports mem_clk_b[2]]
create_generated_clock -name bist_mem_clk_b[3] -add -source [get_ports {wb_clk2_i}] -master_clock [get_clocks wb_clk2_i] -divide_by 1 -comment {Mem Clock B3} [get_ports mem_clk_b[3]]

set_clock_groups -name async_clock -asynchronous -comment "Async Clock group" -group [get_clocks {wb_clk_i wb_clk2_i bist_mem_clk_a[*] bist_mem_clk_b[*]}]  
set_clock_transition 0.1500 [all_clocks]
set_clock_uncertainty -setup 0.2500 [all_clocks]
set_clock_uncertainty -hold 0.2500 [all_clocks]

set ::env(SYNTH_TIMING_DERATE) 0.05
puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 10}] %"
set_timing_derate -early [expr {1-$::env(SYNTH_TIMING_DERATE)}]
set_timing_derate -late [expr {1+$::env(SYNTH_TIMING_DERATE)}]
set_input_delay  -max 5.0000 -clock [get_clocks {wb_clk_i}] -add_delay [get_ports {rst_n}]
set_input_delay  -min 2.0000 -clock [get_clocks {wb_clk_i}] -add_delay [get_ports {rst_n}]

## Functional Inputs
set_input_delay -max 4 -clock [get_clocks {wb_clk_i}] -add_delay   [get_ports {wb_adr_i[*]}]  
set_input_delay -max 4 -clock [get_clocks {wb_clk_i}] -add_delay   [get_ports {wb_stb_i}]      
set_input_delay -max 4 -clock [get_clocks {wb_clk_i}] -add_delay   [get_ports {wb_cyc_i}]      
set_input_delay -max 4 -clock [get_clocks {wb_clk_i}] -add_delay   [get_ports {wb_we_i}]      
set_input_delay -max 4 -clock [get_clocks {wb_clk_i}] -add_delay   [get_ports {wb_dat_o[*]}] 
set_input_delay -max 4 -clock [get_clocks {wb_clk_i}] -add_delay   [get_ports {wb_sel_i[*]}]
set_input_delay -min 2 -clock [get_clocks {wb_clk_i}] -add_delay   [get_ports {wb_adr_i[*]}]  
set_input_delay -min 2 -clock [get_clocks {wb_clk_i}] -add_delay   [get_ports {wb_stb_i}]      
set_input_delay -min 2 -clock [get_clocks {wb_clk_i}] -add_delay   [get_ports {wb_cyc_i}]      
set_input_delay -min 2 -clock [get_clocks {wb_clk_i}] -add_delay   [get_ports {wb_we_i}]      
set_input_delay -min 2 -clock [get_clocks {wb_clk_i}] -add_delay   [get_ports {wb_dat_o[*]}] 
set_input_delay -min 2 -clock [get_clocks {wb_clk_i}] -add_delay   [get_ports {wb_sel_i[*]}]

set_output_delay -max 5 -clock [get_clocks {wb_clk_i}] -add_delay     [get_ports {wb_dat_o[*]}]  
set_output_delay -max 5 -clock [get_clocks {wb_clk_i}] -add_delay     [get_ports {wb_ack_o}]  
set_output_delay -max 5 -clock [get_clocks {wb_clk_i}] -add_delay     [get_ports {wb_err_o}]  
set_output_delay -min 2 -clock [get_clocks {wb_clk_i}] -add_delay     [get_ports {wb_dat_o[*]}]  
set_output_delay -min 2 -clock [get_clocks {wb_clk_i}] -add_delay     [get_ports {wb_ack_o}]  
set_output_delay -min 2 -clock [get_clocks {wb_clk_i}] -add_delay     [get_ports {wb_err_o}]  
## Towards MEMORY from MBIST CLOCK
## PORT-A
### SRAM To MBIST is haly cycle path
set_input_delay -max 3.0000 -clock [get_clocks {bist_mem_clk_a[0]}] -clock_fall -add_delay [get_ports {mem_dout_a0[*]}]
set_input_delay -min 1.0000 -clock [get_clocks {bist_mem_clk_a[0]}] -clock_fall -add_delay [get_ports {mem_dout_a0[*]}]

set_input_delay -max 3.0000 -clock [get_clocks {bist_mem_clk_a[1]}] -clock_fall -add_delay [get_ports {mem_dout_a1[*]}]
set_input_delay -min 1.0000 -clock [get_clocks {bist_mem_clk_a[1]}] -clock_fall -add_delay [get_ports {mem_dout_a1[*]}]

set_input_delay -max 3.0000 -clock [get_clocks {bist_mem_clk_a[2]}] -clock_fall -add_delay [get_ports {mem_dout_a2[*]}]
set_input_delay -min 1.0000 -clock [get_clocks {bist_mem_clk_a[2]}] -clock_fall -add_delay [get_ports {mem_dout_a2[*]}]

set_input_delay -max 3.0000 -clock [get_clocks {bist_mem_clk_a[3]}] -clock_fall -add_delay [get_ports {mem_dout_a3[*]}]
set_input_delay -min 1.0000 -clock [get_clocks {bist_mem_clk_a[3]}] -clock_fall -add_delay [get_ports {mem_dout_a3[*]}]

## MBIST to SRAM full cycle path

## mem_addr
set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[0]}] -add_delay [get_ports {mem_addr_a0[*]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[0]}] -add_delay [get_ports {mem_addr_a0[*]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[1]}] -add_delay [get_ports {mem_addr_a1[*]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[1]}] -add_delay [get_ports {mem_addr_a1[*]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[2]}] -add_delay [get_ports {mem_addr_a2[*]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[2]}] -add_delay [get_ports {mem_addr_a2[*]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[3]}] -add_delay [get_ports {mem_addr_a3[*]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[3]}] -add_delay [get_ports {mem_addr_a3[*]}]

## mem_mask
set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[0]}] -add_delay [get_ports {mem_mask_a0[*]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[0]}] -add_delay [get_ports {mem_mask_a0[*]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[1]}] -add_delay [get_ports {mem_mask_a1[*]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[1]}] -add_delay [get_ports {mem_mask_a1[*]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[2]}] -add_delay [get_ports {mem_mask_a2[*]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[2]}] -add_delay [get_ports {mem_mask_a2[*]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[3]}] -add_delay [get_ports {mem_mask_a3[*]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[3]}] -add_delay [get_ports {mem_mask_a3[*]}]

# mem_cen
set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[0]}] -add_delay [get_ports {mem_cen_a[0]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[0]}] -add_delay [get_ports {mem_cen_a[0]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[1]}] -add_delay [get_ports {mem_cen_a[1]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[1]}] -add_delay [get_ports {mem_cen_a[1]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[2]}] -add_delay [get_ports {mem_cen_a[2]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[2]}] -add_delay [get_ports {mem_cen_a[2]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[3]}] -add_delay [get_ports {mem_cen_a[3]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[3]}] -add_delay [get_ports {mem_cen_a[3]}]

# mem_web_a
set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[0]}] -add_delay [get_ports {mem_web_a[0]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[0]}] -add_delay [get_ports {mem_web_a[0]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[1]}] -add_delay [get_ports {mem_web_a[1]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[1]}] -add_delay [get_ports {mem_web_a[1]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[2]}] -add_delay [get_ports {mem_web_a[2]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[2]}] -add_delay [get_ports {mem_web_a[2]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[3]}] -add_delay [get_ports {mem_web_a[3]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[3]}] -add_delay [get_ports {mem_web_a[3]}]

## mem_din
set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[0]}] -add_delay [get_ports {mem_din_a0[*]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[0]}] -add_delay [get_ports {mem_din_a0[*]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[1]}] -add_delay [get_ports {mem_din_a1[*]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[1]}] -add_delay [get_ports {mem_din_a1[*]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[2]}] -add_delay [get_ports {mem_din_a2[*]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[2]}] -add_delay [get_ports {mem_din_a2[*]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_a[3]}] -add_delay [get_ports {mem_din_a3[*]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_a[3]}] -add_delay [get_ports {mem_din_a3[*]}]

## PORT-B
set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_b[0]}] -add_delay [get_ports {mem_cen_b[0]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_b[0]}] -add_delay [get_ports {mem_cen_b[0]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_b[1]}] -add_delay [get_ports {mem_cen_b[1]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_b[1]}] -add_delay [get_ports {mem_cen_b[1]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_b[2]}] -add_delay [get_ports {mem_cen_b[2]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_b[2]}] -add_delay [get_ports {mem_cen_b[2]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_b[3]}] -add_delay [get_ports {mem_cen_b[3]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_b[3]}] -add_delay [get_ports {mem_cen_b[3]}]


set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_b[0]}] -add_delay [get_ports {mem_addr_b0[*]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_b[0]}] -add_delay [get_ports {mem_addr_b0[*]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_b[1]}] -add_delay [get_ports {mem_addr_b1[*]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_b[1]}] -add_delay [get_ports {mem_addr_b1[*]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_b[2]}] -add_delay [get_ports {mem_addr_b2[*]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_b[2]}] -add_delay [get_ports {mem_addr_b2[*]}]

set_output_delay -max 4    -clock [get_clocks {bist_mem_clk_b[3]}] -add_delay [get_ports {mem_addr_b3[*]}]
set_output_delay -min -0.5 -clock [get_clocks {bist_mem_clk_b[3]}] -add_delay [get_ports {mem_addr_b3[*]}]

# Set max delay for clock skew
set_max_delay   3.5 -from [get_ports {wbd_clk_int}]
set_max_delay   2 -to   [get_ports {wbd_clk_mbist}]
set_max_delay 3.5 -from wbd_clk_int -to wbd_clk_mbist
###############################################################################
# Environment
###############################################################################
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_8 -pin $::env(SYNTH_DRIVING_CELL_PIN) [all_inputs]
set cap_load [expr $::env(SYNTH_CAP_LOAD) / 1000.0]
puts "\[INFO\]: Setting load to: $cap_load"
set_load  $cap_load [all_outputs]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_fanout 10.0000 [current_design]
