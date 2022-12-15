# SPDX-FileCopyrightText:  2021 , Dinesh Annayya
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
# SPDX-FileContributor: Modified by Dinesh Annayya <dinesha@opencores.org>

# Global
# ------

set script_dir [file dirname [file normalize [info script]]]
# Name

set ::env(DESIGN_NAME) mbist_top2

set ::env(DESIGN_IS_CORE) "0"

# Timing configuration
set ::env(CLOCK_PERIOD) "10"
set ::env(CLOCK_PORT) "u_cts_wb_clk_b1.u_buf/X  u_cts_wb_clk_b2.u_buf/X u_mem_sel.u_cts_mem_clk_a.u_buf/X u_mem_sel.u_cts_mem_clk_b.u_buf/X"

set ::env(SYNTH_MAX_FANOUT) 4
set ::env(SYNTH_BUFFERING) {0}

## CTS BUFFER
set ::env(CTS_CLK_BUFFER_LIST) "sky130_fd_sc_hd__clkbuf_4 sky130_fd_sc_hd__clkbuf_8"
set ::env(CTS_SINK_CLUSTERING_SIZE) "16"
set ::env(CLOCK_BUFFER_FANOUT) "8"

# Sources
# -------

# Local sources + no2usb sources
set ::env(VERILOG_FILES) "\
     $::env(DESIGN_DIR)/../../verilog/rtl/clk_skew_adjust/src/clk_skew_adjust.gv \
     $::env(DESIGN_DIR)/../../verilog/rtl/mbist/src/core/mbist_addr_gen.sv \
     $::env(DESIGN_DIR)/../../verilog/rtl/mbist/src/core/mbist_fsm.sv     \
     $::env(DESIGN_DIR)/../../verilog/rtl/mbist/src/core/mbist_op_sel.sv  \
     $::env(DESIGN_DIR)/../../verilog/rtl/mbist/src/core/mbist_repair_addr.sv \
     $::env(DESIGN_DIR)/../../verilog/rtl/mbist/src/core/mbist_sti_sel.sv \
     $::env(DESIGN_DIR)/../../verilog/rtl/mbist/src/core/mbist_pat_sel.sv \
     $::env(DESIGN_DIR)/../../verilog/rtl/mbist/src/core/mbist_mux.sv \
     $::env(DESIGN_DIR)/../../verilog/rtl/mbist/src/core/mbist_data_cmp.sv \
     $::env(DESIGN_DIR)/../../verilog/rtl/mbist/src/core/mbist_mem_wrapper.sv \
     $::env(DESIGN_DIR)/../../verilog/rtl/mbist/src/top/mbist_top2.sv  \
     $::env(DESIGN_DIR)/../../verilog/rtl/lib/ctech_cells.sv     \
     $::env(DESIGN_DIR)/../../verilog/rtl/lib/reset_sync.sv \
	     "

set ::env(VERILOG_INCLUDE_DIRS) [glob $::env(DESIGN_DIR)/../../verilog/rtl/mbist/include ]


set ::env(SYNTH_PARAMETERS) "SCW=8 \
                         BIST_ADDR_WD=8\
	                 BIST_DATA_WD=32\
		         BIST_ADDR_START=8'h000\
			 BIST_ADDR_END=8'h0FB\
			 BIST_REPAIR_ADDR_START=8'h0FC\
			 BIST_RAD_WD_I=8\
			 BIST_RAD_WD_O=8\
			 "

set ::env(SYNTH_READ_BLACKBOX_LIB) 1
set ::env(SYNTH_DEFINES) [list SYNTHESIS ]
set ::env(SDC_FILE) "$::env(DESIGN_DIR)/base.sdc"
set ::env(BASE_SDC_FILE) "$::env(DESIGN_DIR)/base.sdc"

set ::env(LEC_ENABLE) 0

set ::env(VDD_PIN) [list {vccd1}]
set ::env(GND_PIN) [list {vssd1}]

set ::env(SCAN_TOTAL_CHAINS) 8

# Floorplanning
# -------------

set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 250 250"


# If you're going to use multiple power domains, then keep this disabled.
set ::env(RUN_CVC) 0

#set ::env(PDN_CFG) $script_dir/pdn.tcl


set ::env(PL_TIME_DRIVEN) 1
set ::env(PL_TARGET_DENSITY) "0.35"

# helps in anteena fix
set ::env(USE_ARC_ANTENNA_CHECK) "1"

set ::env(FP_IO_VEXTEND) 4
set ::env(FP_IO_HEXTEND) 4

set ::env(FP_PDN_VPITCH) 100
set ::env(FP_PDN_HPITCH) 100
set ::env(FP_PDN_VWIDTH) 6.2
set ::env(FP_PDN_HWIDTH) 6.2

#set ::env(GLB_RT_MAXLAYER) 5
set ::env(RT_MAX_LAYER) {met4}

#Lef 
set ::env(MAGIC_GENERATE_LEF) {1}
set ::env(MAGIC_WRITE_FULL_LEF) {0}

set ::env(DIODE_INSERTION_STRATEGY) 4


#LVS Issue - DEF Base looks to having issue
set ::env(MAGIC_EXT_USE_GDS) {1}

set ::env(GLB_RESIZER_MAX_SLEW_MARGIN) {1.5}
set ::env(PL_RESIZER_MAX_SLEW_MARGIN) {1.5}

set ::env(GLB_RESIZER_MAX_CAP_MARGIN) {0.25}
set ::env(PL_RESIZER_MAX_CAP_MARGIN) {0.25}

set ::env(GLB_RESIZER_MAX_WIRE_LENGTH) {500}
set ::env(PL_RESIZER_MAX_WIRE_LENGTH) {500}

set ::env(QUIT_ON_TIMING_VIOLATIONS) "0"
set ::env(QUIT_ON_MAGIC_DRC) "1"
set ::env(QUIT_ON_LVS_ERROR) "1"
set ::env(QUIT_ON_SLEW_VIOLATIONS) "0"
