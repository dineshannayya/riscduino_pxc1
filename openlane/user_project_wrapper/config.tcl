# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0

# Base Configurations. Don't Touch
# section begin

set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hd"

# YOU ARE NOT ALLOWED TO CHANGE ANY VARIABLES DEFINED IN THE FIXED WRAPPER CFGS 
source $::env(DESIGN_DIR)/fixed_dont_change/fixed_wrapper_cfgs.tcl


# YOU CAN CHANGE ANY VARIABLES DEFINED IN THE DEFAULT WRAPPER CFGS BY OVERRIDING THEM IN THIS CONFIG.TCL
source $::env(DESIGN_DIR)/fixed_dont_change/default_wrapper_cfgs.tcl


set script_dir [file dirname [file normalize [info script]]]
set proj_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) user_project_wrapper
set verilog_root $::env(DESIGN_DIR)/../../verilog/
set lef_root $::env(DESIGN_DIR)/../../lef/
set gds_root $::env(DESIGN_DIR)/../../gds/
#section end

# User Configurations
#
set ::env(DESIGN_IS_CORE) 1


## Source Verilog Files
set ::env(VERILOG_FILES) "\
	$::env(DESIGN_DIR)/../../verilog/rtl/user_project_wrapper.v"


## Clock configurations
set ::env(CLOCK_PORT) "user_clock2 wb_clk_i"
#set ::env(CLOCK_NET) "mprj.clk"

set ::env(CLOCK_PERIOD) "10"

## Internal Macros
### Macro Placement
set ::env(MACRO_PLACEMENT_CFG) $::env(DESIGN_DIR)/macro.cfg

set ::env(PDN_CFG) $::env(DESIGN_DIR)/pdn_cfg.tcl

set ::env(SDC_FILE) $::env(DESIGN_DIR)/base.sdc
set ::env(BASE_SDC_FILE) $::env(DESIGN_DIR)/base.sdc

set ::env(SYNTH_READ_BLACKBOX_LIB) 1

### Black-box verilog and views
set ::env(VERILOG_FILES_BLACKBOX) "\
	    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_sram_macros/verilog/sky130_sram_2kbyte_1rw1r_32x512_8.v \
	    $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_sram_macros/verilog/sky130_sram_1kbyte_1rw1r_32x256_8.v \
	    $::env(DESIGN_DIR)/../../verilog/gl/wb_interconnect.v \
	    $::env(DESIGN_DIR)/../../verilog/gl/wb_host.v \
	    $::env(DESIGN_DIR)/../../verilog/gl/pinmux_top.v\
	    $::env(DESIGN_DIR)/../../verilog/gl/mbist_wrapper.v\
	    $::env(DESIGN_DIR)/../../verilog/gl/mac_wrapper.v\
	"

set ::env(EXTRA_LEFS) "\
	$::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_sram_macros/lef/sky130_sram_2kbyte_1rw1r_32x512_8.lef \
	$::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_sram_macros/lef/sky130_sram_1kbyte_1rw1r_32x256_8.lef \
	$::env(DESIGN_DIR)/../../lef/pinmux_top.lef \
	$::env(DESIGN_DIR)/../../lef/mbist_wrapper.lef \
	$::env(DESIGN_DIR)/../../lef/mac_wrapper.lef \
	$::env(DESIGN_DIR)/../../lef/wb_interconnect.lef \
	$::env(DESIGN_DIR)/../../lef/wb_host.lef"

set ::env(EXTRA_GDS_FILES) "\
	$::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_sram_macros/gds/sky130_sram_2kbyte_1rw1r_32x512_8.gds \
	$::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_sram_macros/gds/sky130_sram_1kbyte_1rw1r_32x256_8.gds \
	$::env(DESIGN_DIR)/../../gds/pinmux_top.gds \
	$::env(DESIGN_DIR)/../../gds/mbist_wrapper.gds \
	$::env(DESIGN_DIR)/../../gds/mac_wrapper.gds \
	$::env(DESIGN_DIR)/../../gds/wb_interconnect.gds \
	$::env(DESIGN_DIR)/../../gds/wb_host.gds"

set ::env(SYNTH_DEFINES) [list SYNTHESIS ]

#set ::env(VERILOG_INCLUDE_DIRS) [glob $::env(DESIGN_DIR)/../../verilog/rtl/yifive/ycr1c/src/includes ]

#set ::env(GLB_RT_MAXLAYER) 6
set ::env(RT_MAX_LAYER) {met5}

## Internal Macros
### Macro PDN Connections
## Temp Masked to 0
set ::env(FP_PDN_CHECK_NODES) 1
set ::env(FP_PDN_IRDROP) "1"
set ::env(RUN_IRDROP_REPORT) "1"
####################

set ::env(FP_PDN_ENABLE_MACROS_GRID) {1}
set ::env(FP_PDN_ENABLE_GLOBAL_CONNECTIONS) "0"
set ::env(FP_PDN_CHECK_NODES) 1
set ::env(FP_PDN_ENABLE_RAILS) 0
set ::env(FP_PDN_IRDROP) "1"
set ::env(FP_PDN_HORIZONTAL_HALO) "10"
set ::env(FP_PDN_VERTICAL_HALO) "10"
set ::env(FP_PDN_VOFFSET) "5"
set ::env(FP_PDN_VPITCH) "80"
set ::env(FP_PDN_HOFFSET) "5"
set ::env(FP_PDN_HPITCH) "80"
set ::env(FP_PDN_HWIDTH) {5.2}
set ::env(FP_PDN_VWIDTH) {5.2}
set ::env(FP_PDN_HSPACING) {13.8}
set ::env(FP_PDN_VSPACING) {13.8}

set ::env(VDD_NETS) {vccd1 vccd2 vdda1 vdda2}
set ::env(GND_NETS) {vssd1 vssd2 vssa1 vssa2}
#
set ::env(VDD_NET) {vccd1}
set ::env(GND_NET) {vssd1}
set ::env(VDD_PIN) {vccd1}
set ::env(GND_PIN) {vssd1}

set ::env(PDN_STRIPE) {vccd1 vssd1 }
set ::env(DRT_OPT_ITERS) {32}

# Add Blockage arond the SRAM to avoid Magic DRC & 
# add signal routing blockage for met5
#set ::env(GLB_RT_OBS) "met1 2000.00 800.00  2683.10 1216.54, \
#	                   met2 2000.00 800.00  2683.10 1216.54, \
#		               met3 2000.00 800.00  2683.10 1216.54, \
#	                   met1 2000.00 1400.00 2683.10 1816.54, \
#	                   met2 2000.00 1400.00 2683.10 1816.54, \
#	                   met3 2000.00 1400.00 2683.10 1816.54, \
#	                   met1 2000.00 2000.00 2683.10 2416.54, \
#	                   met2 2000.00 2000.00 2683.10 2416.54, \
#	                   met3 2000.00 2000.00 2683.10 2416.54, \
#	                   met1 2000.00 2600.00 2683.10 3016.54, \
#	                   met2 2000.00 2600.00 2683.10 3016.54, \
#	                   met3 2000.00 2600.00 2683.10 3016.54, \
#	                   met1 200.00 1200.00 679.78 1597.5, \
#	                   met2 200.00 1200.00 679.78 1597.5, \
#	                   met3 200.00 1200.00 679.78 1597.5, \
#	                   met1 200.00 1800.00 679.78 2197.5, \
#	                   met2 200.00 1800.00 679.78 2197.5, \
#	                   met3 200.00 1800.00 679.78 2197.5, \
#	                   met1 200.00 2400.00 679.78 2797.5, \
#	                   met2 200.00 2400.00 679.78 2797.5, \
#	                   met3 200.00 2400.00 679.78 2797.5, \
#	                   met1 200.00 3000.00 679.78 3397.5, \
#	                   met2 200.00 3000.00 679.78 3397.5, \
#	                   met3 200.00 3000.00 679.78 3397.5, \
#		               met5 0 0 2920 3520"
#

set ::env(FP_PDN_MACRO_HOOKS) "\
     u_wb_host	       vccd1 vssd1 vccd1 vssd1,\
     u_intercon        vccd1 vssd1 vccd1 vssd1,\
     u_pinmux	       vccd1 vssd1 vccd1 vssd1,\
     u_mac_wrap        vccd1 vssd1 vccd1 vssd1,\
     u_mbist0          vccd1 vssd1 vccd1 vssd1,\
     u_mbist1          vccd1 vssd1 vccd1 vssd1,\
     u_sram0_2kb       vccd1 vssd1 vccd1 vssd1,\
     u_sram1_2kb       vccd1 vssd1 vccd1 vssd1,\
     u_sram2_2kb       vccd1 vssd1 vccd1 vssd1,\
     u_sram3_2kb       vccd1 vssd1 vccd1 vssd1,\
     u_sram4_2kb       vccd1 vssd1 vccd1 vssd1,\
     u_sram5_2kb       vccd1 vssd1 vccd1 vssd1,\
     u_sram6_2kb       vccd1 vssd1 vccd1 vssd1,\
     u_sram7_2kb       vccd1 vssd1 vccd1 vssd1\
     "


# The following is because there are no std cells in the example wrapper project.
set ::env(SYNTH_TOP_LEVEL) 0
set ::env(PL_RANDOM_GLB_PLACEMENT) 1
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_BUFFER_INPUT_PORTS) 0
set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) {0}
set ::env(GLB_OPTIMIZE_MIRRORING) {0}
set ::env(DIODE_INSERTION_STRATEGY) 0
set ::env(RUN_FILL_INSERTION) 0
set ::env(RUN_TAP_DECAP_INSERTION) 0
set ::env(CLOCK_TREE_SYNTH) 0
set ::env(QUIT_ON_LVS_ERROR) "1"
set ::env(QUIT_ON_MAGIC_DRC) "0"
set ::env(QUIT_ON_NEGATIVE_WNS) "0"
set ::env(QUIT_ON_SLEW_VIOLATIONS) "0"
set ::env(QUIT_ON_TIMING_VIOLATIONS) "0"

## Temp Masked due to long Run Time
set ::env(RUN_KLAYOUT_XOR) {0}

