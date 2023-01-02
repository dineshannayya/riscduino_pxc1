set spef_mapping(rstb_level)                         $::env(CARAVEL_ROOT)/spef/xres_buf.spef
set spef_mapping(mgmt_buffers/powergood_check)       $::env(CARAVEL_ROOT)/spef/mgmt_protect_hv.spef
set spef_mapping(padframe)                           $::env(CARAVEL_ROOT)/spef/chip_io.spef
set spef_mapping(mgmt_buffers/mprj2_logic_high_inst) $::env(CARAVEL_ROOT)/spef/mprj2_logic_high.spef
set spef_mapping(mgmt_buffers/mprj_logic_high_inst)  $::env(CARAVEL_ROOT)/spef/mprj_logic_high.spef

#set spef_mapping(por)                                $::env(CARAVEL_ROOT)/spef/simple_por.spef

# error in rcx extraction for the section/paragraph below
# [ERROR ODB-0299] Via via3_320_320 has only 2 shapes and must have at least three.

set spef_mapping(gpio_defaults_block_0)   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_1803.spef
set spef_mapping(gpio_defaults_block_1)   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_1803.spef
set spef_mapping(gpio_defaults_block_2)   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
set spef_mapping(gpio_defaults_block_3)   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef
set spef_mapping(gpio_defaults_block_4)   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_0403.spef

set spef_mapping(gpio_defaults_block_10)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_11)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_12)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_13)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_14)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_15)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_16)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_17)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_18)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_19)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_20)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_21)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_22)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_23)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_24)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_25)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_26)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_27)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_28)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_29)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_30)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_31)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_32)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_33)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_34)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_35)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_36)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_37)  $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_5)   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_6)   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_7)   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_8)   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_defaults_block_9)   $::env(CARAVEL_ROOT)/spef/gpio_defaults_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_bidir_1[0]) $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_bidir_1[1]) $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_bidir_2[0]) $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_bidir_2[1]) $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_bidir_2[2]) $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_1[0])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_1[10])   $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_1[1])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_1[2])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_1[3])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_1[4])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_1[5])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_1[6])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_1[7])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_1[8])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_1[9])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_1a[0])   $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_1a[1])   $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_1a[2])   $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_1a[3])   $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_1a[4])   $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_1a[5])   $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_2[0])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_2[10])   $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_2[11])   $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_2[12])   $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_2[13])   $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_2[14])   $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_2[15])   $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_2[1])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_2[2])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_2[3])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_2[4])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_2[5])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_2[6])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_2[7])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_2[8])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(gpio_control_in_2[9])    $::env(CARAVEL_ROOT)/spef/gpio_control_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(housekeeping)            $::env(CARAVEL_ROOT)/spef/housekeeping_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(mgmt_buffers)            $::env(CARAVEL_ROOT)/spef/mgmt_protect_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(pll)                     $::env(CARAVEL_ROOT)/spef/digital_pll_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(spare_logic[0])          $::env(CARAVEL_ROOT)/spef/spare_logic_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(spare_logic[1])          $::env(CARAVEL_ROOT)/spef/spare_logic_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(spare_logic[2])          $::env(CARAVEL_ROOT)/spef/spare_logic_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(spare_logic[3])          $::env(CARAVEL_ROOT)/spef/spare_logic_block_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef

set spef_mapping(soc)                     $::env(MCW_ROOT)/spef/mgmt_core_wrapper_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(soc/DFFRAM_0)            $::env(MCW_ROOT)/spef/DFFRAM_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
set spef_mapping(soc/core)                $::env(MCW_ROOT)/spef/mgmt_core_$::env(RCX_CORNER)_$::env(LIB_CORNER).spef
