
    set ::env(USER_ROOT)    ".."
    set ::env(CARAVEL_ROOT) "/home/dinesha/workarea/efabless/MPW-7/caravel"

    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_sc_hvl/lib/sky130_fd_sc_hvl__tt_025C_3v30.lib
    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_sc_hvl/lib/sky130_fd_sc_hvl__tt_025C_3v30_lv1v80.lib
    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_gpiov2_tt_tt_025C_1v80_3v30.lib
    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_ground_hvc_wpad_tt_025C_1v80_3v30_3v30.lib
    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_ground_lvc_wpad_tt_025C_1v80_3v30.lib
    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_power_lvc_wpad_tt_025C_1v80_3v30_3v30.lib
    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_fd_io__top_xres4v2_tt_tt_025C_1v80_3v30.lib
    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__gpiov2_pad_tt_tt_025C_1v80_3v30.lib
    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib
    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vdda_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib
    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssa_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib
    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vddio_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib
    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssio_hvc_clamped_pad_tt_025C_1v80_3v30_3v30.lib
    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped3_pad_tt_025C_1v80_3v30.lib
    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vccd_lvc_clamped3_pad_tt_025C_1v80_3v30_3v30.lib
    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_fd_io/lib/sky130_ef_io__vssd_lvc_clamped_pad_tt_025C_1v80_3v30.lib
    read_liberty $::env(PDK_ROOT)/$::env(PDK)/libs.ref/sky130_sram_macros/lib/sky130_sram_2kbyte_1rw1r_32x512_8_TT_1p8V_25C.lib

    read_verilog $::env(CARAVEL_ROOT)/mgmt_core_wrapper/verilog/gl/RAM128.v
    read_verilog $::env(CARAVEL_ROOT)/mgmt_core_wrapper/verilog/gl/mgmt_core_wrapper.v
    read_verilog $::env(CARAVEL_ROOT)/mgmt_core_wrapper/verilog/gl/RAM256.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/gpio_control_block.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/mprj_logic_high.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/caravel_clocking.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/constant_block.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/caravan.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/xres_buf.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/gpio_defaults_block_0801.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/gpio_signal_buffering_alt.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/mgmt_protect_hv.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/digital_pll.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/chip_io_alt.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/gpio_logic_high.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/housekeeping.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/spare_logic_block.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/caravel.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/gpio_defaults_block.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/user_id_programming.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/gpio_defaults_block_1803.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/gpio_signal_buffering.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/mprj2_logic_high.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/chip_io.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/buff_flash_clkrst.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/mgmt_protect.v
    read_verilog $::env(CARAVEL_ROOT)/verilog/gl/gpio_defaults_block_0403.v


	# User project netlist
    read_verilog $::env(USER_ROOT)/verilog/gl/wb_interconnect.v
    read_verilog $::env(USER_ROOT)/verilog/gl/wb_host.v
    read_verilog $::env(USER_ROOT)/verilog/gl/pinmux_top.v
    read_verilog $::env(USER_ROOT)/verilog/gl/mbist_wrapper.v
    read_verilog $::env(USER_ROOT)/verilog/gl/mac_wrapper.v  
    read_verilog $::env(USER_ROOT)/verilog/gl/user_project_wrapper.v  


	link_design caravel	

    read_spef -path gpio_control_in_1[3]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path clock_ctrl              $::env(CARAVEL_ROOT)/signoff/caravel_clocking/openlane-signoff/spef/caravel_clocking.min.spef
    read_spef -path gpio_control_bidir_1[1] $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_1a[0]   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_2[8]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_2[10]   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_2[1]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path soc/core.RAM256         $::env(CARAVEL_ROOT)/mgmt_core_wrapper/signoff/RAM256/openlane-signoff/spef/RAM256.min.spef
    read_spef -path gpio_control_in_1[4]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path flash_clkrst_buffers    $::env(CARAVEL_ROOT)/signoff/buff_flash_clkrst/openlane-signoff/spef/buff_flash_clkrst.min.spef
    read_spef -path gpio_control_in_1a[1]   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_2[9]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_2[11]   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_2[2]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_bidir_2[0] $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_1[5]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_1a[2]   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_2[12]   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_2[3]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_bidir_2[1] $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_1[6]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path soc/core.RAM128         $::env(CARAVEL_ROOT)/mgmt_core_wrapper/signoff/RAM128/openlane-signoff/spef/RAM128.min.spef
    read_spef -path gpio_control_in_1a[3]   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_2[13]   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_2[4]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_bidir_2[2] $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_1[7]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_1[0]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_1[10]   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path pll                     $::env(CARAVEL_ROOT)/signoff/digital_pll/openlane-signoff/spef/digital_pll.min.spef
    read_spef -path gpio_control_in_1a[4]   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_2[14]   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_2[5]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path soc                     $::env(CARAVEL_ROOT)/mgmt_core_wrapper/signoff/mgmt_core_wrapper/openlane-signoff/spef/mgmt_core_wrapper.min.spef
    read_spef -path gpio_control_in_1[8]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_1[1]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path housekeeping            $::env(CARAVEL_ROOT)/signoff/housekeeping/openlane-signoff/spef/housekeeping.min.spef
    read_spef -path mgmt_buffers            $::env(CARAVEL_ROOT)/signoff/mgmt_protect/openlane-signoff/spef/mgmt_protect.min.spef
    read_spef -path gpio_control_in_1a[5]   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_2[15]   $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_2[6]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_1[9]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_1[2]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_bidir_1[0] $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_2[7]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef
    read_spef -path gpio_control_in_2[0]    $::env(CARAVEL_ROOT)/signoff/gpio_control_block/openlane-signoff/spef/gpio_control_block.min.spef

	## User Project Spef
    read_spef -path mprj/u_intercon      $::env(USER_ROOT)/signoff/wb_interconnect/openlane-signoff/spef/wb_interconnect.min.spef
    read_spef -path mprj/u_wb_host       $::env(USER_ROOT)/signoff/wb_host/openlane-signoff/spef/wb_host.min.spef
    read_spef -path mprj/u_mac_wrap      $::env(USER_ROOT)/signoff/mac_wrapper/openlane-signoff/spef/mac_wrapper.min.spef
    read_spef -path mprj/u_mbist0        $::env(USER_ROOT)/signoff/mbist_wrapper/openlane-signoff/spef/mbist_wrapper.min.spef
    read_spef -path mprj/u_mbist1        $::env(USER_ROOT)/signoff/mbist_wrapper/openlane-signoff/spef/mbist_wrapper.min.spef
    read_spef -path mprj/u_pinmux        $::env(USER_ROOT)/signoff/pinmux_top/openlane-signoff/spef/pinmux_top.min.spef
    read_spef -path mprj                 $::env(USER_ROOT)/signoff/user_project_wrapper/openlane-signoff/spef/user_project_wrapper.min.spef

    read_spef $::env(CARAVEL_ROOT)/signoff/caravel/openlane-signoff/spef/caravel.min.spef


	read_sdc -echo ../sdc/caravel.sdc	
	check_setup  -verbose >  unconstraints.rpt
	report_checks -path_delay min -fields {slew cap input nets fanout} -format full_clock_expanded -group_count 50	
	report_checks -path_delay max -fields {slew cap input nets fanout} -format full_clock_expanded -group_count 50	
	report_worst_slack -max 	
	report_worst_slack -min 	
	report_checks -path_delay min -fields {slew cap input nets fanout} -format full_clock_expanded -slack_max 0.18 -group_count 10	
	report_check_types -max_slew -max_capacitance -max_fanout -violators  > slew.cap.fanout.vio.rpt

#    echo " Management Area Interface "	
#    report_checks -to soc/core_clk -unconstrained -group_count 1	
#    echo " User project Interface "	
#    report_checks -to mprj/wb_clk_i -unconstrained -group_count 1	
#    report_checks -to mprj/wb_rst_i -unconstrained -group_count 1	
#    report_checks -to mprj/wbs_cyc_i -unconstrained -group_count 1	
#    report_checks -to mprj/wbs_stb_i -unconstrained -group_count 1	
#    report_checks -to mprj/wbs_we_i -unconstrained -group_count 1	
#    report_checks -to mprj/wbs_sel_i[*] -unconstrained -group_count 4	
#    report_checks -to mprj/wbs_adr_i[*] -unconstrained -group_count 32	
#    report_checks -to mprj/io_in[*] -unconstrained -group_count 32	
#    report_checks -to mprj/user_clock2 -unconstrained -group_count 32	
#    report_checks -to mprj/user_irq[*] -unconstrained -group_count 32	
#    report_checks -to mprj/la_data_in[*] -unconstrained -group_count 128	
#    report_checks -to mprj/la_oenb[*] -unconstrained -group_count 128	
#
#
#	echo "Wishbone Interface Timing.................." > wb.max.rpt
#	echo "Wishbone Interface Timing.................." > wb.min.rpt
#	set wb_port [get_pins {mprj/wbs_adr_i[*]}]
#	set wb_port [concat $wb_port [get_pins {mprj/wbs_cyc_i}]]
#	set wb_port [concat $wb_port [get_pins {mprj/wbs_dat_i[*]}]]
#	set wb_port [concat $wb_port [get_pins {mprj/wbs_sel_i[*]}]]
#	set wb_port [concat $wb_port [get_pins {mprj/wbs_stb_i}]]
#	set wb_port [concat $wb_port [get_pins {mprj/wbs_we_i}]]
#	set wb_port [concat $wb_port [get_pins {mprj/wbs_ack_o}]]
#	set wb_port [concat $wb_port [get_pins {mprj/wbs_dat_o[*]}]]
#	foreach pin $wb_port {
#	   echo "Wishbone Interface Timing for : [get_full_name $pin]"  >> wb.max.rpt
#           report_checks -path_delay max -fields {slew cap input nets fanout} -through $pin  >> wb.max.rpt 
#        }
#	foreach pin $wb_port {
#	   echo "Wishbone Interface Timing for [get_full_name $pin]" >> wb.min.rpt
#           report_checks -path_delay min -fields {slew cap input nets fanout} -through $pin  >> wb.min.rpt
#        }
#       
#	echo "SRAM Interface Timing.................." > sram.min.rpt
#	echo "SRAM Interface Timing.................." > sram.min.summary.rpt

    ### Caravel SRAM Path ######################################
    #set sram_iport [get_pins {soc/core/sky130_sram_2kbyte_1rw1r_32x512_8/din0[*]}]
	#set sram_iport [concat $sram_iport [get_pins {soc/core/sky130_sram_2kbyte_1rw1r_32x512_8/addr0[*]}]]
	#set sram_iport [concat $sram_iport [get_pins {soc/core/sky130_sram_2kbyte_1rw1r_32x512_8/addr1[*]}]]
	#set sram_iport [concat $sram_iport [get_pins {soc/core/sky130_sram_2kbyte_1rw1r_32x512_8/csb0[*]}]]
	#set sram_iport [concat $sram_iport [get_pins {soc/core/sky130_sram_2kbyte_1rw1r_32x512_8/csb1[*]}]]
	#set sram_iport [concat $sram_iport [get_pins {soc/core/sky130_sram_2kbyte_1rw1r_32x512_8/web0[*]}]]
	#set sram_iport [concat $sram_iport [get_pins {soc/core/sky130_sram_2kbyte_1rw1r_32x512_8/wmask0[*]}]]
 
    #set sram_oport [get_pins {soc/core/sky130_sram_2kbyte_1rw1r_32x512_8/dout0[*]}]
	#set sram_oport [concat $sram_oport [get_pins {soc/core/sky130_sram_2kbyte_1rw1r_32x512_8/dout1[*]}]]
    ### Caravel SRAM Path ######################################
   

