//////////////////////////////////////////////////////////////////////////////
// SPDX-FileCopyrightText: 2021 , Dinesh Annayya                          
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0
// SPDX-FileContributor: Created by Dinesh Annayya <dinesha@opencores.org>
//
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Digital core                                                ////
////                                                              ////
////  This file is part of the riscduino-pxt  project             ////
////  https://github.com/dineshannayya/riscduino_pxt1.git         ////
////                                                              ////
////  Description                                                 ////
////      This is digital core and integrate all the main block   ////
////      here.                                                   ////
////      1. Wishbone Host                                        ////
////      2. 4x MBIST Controller                                  ////
////      3. 4x SRAM 2KB                                          ////
////      4. Wishbone Interconnect                                ////
////      5. Global Register                                      ////
////      6. GMAC                                                 ////
////                                                              ////
////  To Do:                                                      ////
////    nothing                                                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - Dinesh Annayya, dinesh.annayya@gmail.com              ////
////                                                              ////
////  Revision :                                                  ////
////    0.1 - 15th Dec 2022, Dinesh A                             ////
////          Initial Version                                     ////
////    0.2 - 25th Dec 2022, Dinesh A                             ////
////          A. MAC core is integrated                           ////
////          B. glbl block moved inside the pinmux               ////
////          C. All the Pinmux are manged pinmux block           ////
////    1.0 - 31th Dec 2022, Dinesh A                             ////
////          A. Bus repeater added                               ////
////          B. Glbl Register added with signature/revison       ////
//////////////////////////////////////////////////////////////////////
`default_nettype none

`include "user_params.svh"

module user_project_wrapper   (
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A                        )
    input         wb_clk_i,
    input         wb_rst_i,
    input         wbs_stb_i,
    input         wbs_cyc_i,
    input         wbs_we_i,
    input [3:0]   wbs_sel_i,
    input [31:0]  wbs_dat_i,
    input [31:0]  wbs_adr_i,
    output        wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [37:0] io_in,
    output [37:0] io_out,
    output [37:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
          // GPIO indexing by (also upper 2 GPIOs do not havanalog_io                                                  )                                              .
    inout [28:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

parameter BIST_ADDR_WD = 9; // 512x32 SRAM
parameter BIST_DATA_WD = 32;
parameter WB_WIDTH = 32; // WB ADDRESS/DARA WIDTH
parameter BIST_NO_SRAM = 8;

parameter SCW = 8;   // SCAN CHAIN WIDTH
//---------------------------------------------------------------------
// WB HOST <=> WB Interconnect Interface
//---------------------------------------------------------------------
wire                           wbd_int_cyc_i      ; // strobe/request
wire                           wbd_int_stb_i      ; // strobe/request
wire   [WB_WIDTH-1:0]          wbd_int_adr_i      ; // address
wire                           wbd_int_we_i       ;  // write
wire   [WB_WIDTH-1:0]          wbd_int_dat_i      ; // data output
wire   [3:0]                   wbd_int_sel_i      ; // byte enable
wire   [WB_WIDTH-1:0]          wbd_int_dat_o      ; // data input
wire                           wbd_int_ack_o      ; // acknowlegement
wire                           wbd_int_err_o      ; // error

//---------------------------------------------------------------------
//    Pinmux Register <==> WB Interconnect Interface
//---------------------------------------------------------------------
wire                           wbd_pinmux_stb_o     ; // strobe/request
wire   [7:0]                   wbd_pinmux_adr_o     ; // address
wire                           wbd_pinmux_we_o      ;  // write
wire   [WB_WIDTH-1:0]          wbd_pinmux_dat_o     ; // data output
wire   [3:0]                   wbd_pinmux_sel_o     ; // byte enable
wire                           wbd_pinmux_cyc_o     ;
wire   [WB_WIDTH-1:0]          wbd_pinmux_dat_i     ; // data input
wire                           wbd_pinmux_ack_i     ; // acknowlegement
wire                           wbd_pinmux_err_i     ;  // error

//---------------------------------------------------------------------
//  MBIST0  <===> WB Interconnect Interface
//---------------------------------------------------------------------
wire                           wbd_mbist0_stb_o    ; // strobe/request
wire   [14:0]                  wbd_mbist0_adr_o    ; // address
wire                           wbd_mbist0_we_o     ;  // write
wire   [WB_WIDTH-1:0]          wbd_mbist0_dat_o    ; // data output
wire   [3:0]                   wbd_mbist0_sel_o    ; // byte enable
wire   [9:0]                   wbd_mbist0_bl_o     ; // Burst Length
wire                           wbd_mbist0_bry_o    ; // Burst Ready
wire                           wbd_mbist0_cyc_o    ;
wire   [WB_WIDTH-1:0]          wbd_mbist0_dat_i    ; // data input
wire                           wbd_mbist0_ack_i    ; // acknowlegement
wire                           wbd_mbist0_err_i    ;  // error

//---------------------------------------------------------------------
//  MBIST1  <===> WB Interconnect Interface
//---------------------------------------------------------------------
wire                           wbd_mbist1_stb_o    ; // strobe/request
wire   [14:0]                  wbd_mbist1_adr_o    ; // address
wire                           wbd_mbist1_we_o     ;  // write
wire   [WB_WIDTH-1:0]          wbd_mbist1_dat_o    ; // data output
wire   [3:0]                   wbd_mbist1_sel_o    ; // byte enable
wire   [9:0]                   wbd_mbist1_bl_o     ; // Burst Length
wire                           wbd_mbist1_bry_o    ; // Burst Ready
wire                           wbd_mbist1_cyc_o    ;
wire   [WB_WIDTH-1:0]          wbd_mbist1_dat_i    ; // data input
wire                           wbd_mbist1_ack_i    ; // acknowlegement
wire                           wbd_mbist1_err_i    ;  // error

//--------------------------------------------
// GMAC TX WB Master I/F
//--------------------------------------------
wire [31:0]                    wbm_gtx_dat_i      ;
wire                           wbm_gtx_ack_i      ;
wire [31:0]                    wbm_gtx_dat_o      ;
wire [15:0]                    wbm_gtx_adr_o      ;
wire [3:0]                     wbm_gtx_sel_o      ;
wire                           wbm_gtx_we_o       ;
wire                           wbm_gtx_stb_o      ;
wire                           wbm_gtx_cyc_o      ;
                
//--------------------------------------------
// GMAC RX WB Master I/F
//--------------------------------------------
wire [31:0]                    wbm_grx_dat_i      ;
wire                           wbm_grx_ack_i      ;
wire [31:0]                    wbm_grx_dat_o      ;
wire [15:0]                    wbm_grx_adr_o      ;
wire [3:0]                     wbm_grx_sel_o      ;
wire                           wbm_grx_we_o       ;
wire                           wbm_grx_stb_o      ;
wire                           wbm_grx_cyc_o      ;
                
//--------------------------------------------
// GMAC REG WB SLAVE I/F
//--------------------------------------------
wire [31:0]                    wbs_grg_dat_o     ;
wire                           wbs_grg_ack_o     ;
wire [31:0]                    wbs_grg_dat_i     ;
wire [12:0]                    wbs_grg_adr_i     ;
wire [3:0]                     wbs_grg_sel_i     ;
wire                           wbs_grg_we_i      ;
wire                           wbs_grg_stb_i     ;
wire                           wbs_grg_cyc_i     ;


//----------------------------------------------------

wire                           wbd_int_rst_n      ;
wire                           bist_rst_n         ;
wire                           mac_rst_n          ;

//-----------------------------------------------------
// towards MBIST-0 <==> memory 0/1/2/3/
// towards MBIST-1 <==> memory 4/5/6/7
//------------------------------------------------------
// PORT-A Common Signals
wire   [BIST_NO_SRAM-1:0]     mem_clk_a          ;
wire   [BIST_NO_SRAM-1:0]     mem_cen_a          ;
wire   [BIST_NO_SRAM-1:0]     mem_web_a          ;

// MEM0 - PORT-A Signals
wire   [BIST_ADDR_WD-1:0]     mem0_addr_a         ;
wire [BIST_DATA_WD/8-1:0]     mem0_mask_a         ;
wire   [BIST_DATA_WD-1:0]     mem0_din_a          ;
wire   [BIST_DATA_WD-1:0]     mem0_dout_a         ;

// MEM1 - PORT-A Signals
wire   [BIST_ADDR_WD-1:0]     mem1_addr_a         ;
wire [BIST_DATA_WD/8-1:0]     mem1_mask_a         ;
wire   [BIST_DATA_WD-1:0]     mem1_din_a          ;
wire   [BIST_DATA_WD-1:0]     mem1_dout_a         ;

// MEM2 - PORT-A Signals
wire   [BIST_ADDR_WD-1:0]     mem2_addr_a         ;
wire [BIST_DATA_WD/8-1:0]     mem2_mask_a         ;
wire   [BIST_DATA_WD-1:0]     mem2_din_a          ;
wire   [BIST_DATA_WD-1:0]     mem2_dout_a         ;

// MEM3 - PORT-A Signals
wire   [BIST_ADDR_WD-1:0]     mem3_addr_a         ;
wire [BIST_DATA_WD/8-1:0]     mem3_mask_a         ;
wire   [BIST_DATA_WD-1:0]     mem3_din_a          ;
wire   [BIST_DATA_WD-1:0]     mem3_dout_a         ;

// MEM4 - PORT-A Signals
wire   [BIST_ADDR_WD-1:0]     mem4_addr_a         ;
wire [BIST_DATA_WD/8-1:0]     mem4_mask_a         ;
wire   [BIST_DATA_WD-1:0]     mem4_din_a          ;
wire   [BIST_DATA_WD-1:0]     mem4_dout_a         ;

// MEM5 - PORT-A Signals
wire   [BIST_ADDR_WD-1:0]     mem5_addr_a         ;
wire [BIST_DATA_WD/8-1:0]     mem5_mask_a         ;
wire   [BIST_DATA_WD-1:0]     mem5_din_a          ;
wire   [BIST_DATA_WD-1:0]     mem5_dout_a         ;

// MEM6 - PORT-A Signals
wire   [BIST_ADDR_WD-1:0]     mem6_addr_a         ;
wire [BIST_DATA_WD/8-1:0]     mem6_mask_a         ;
wire   [BIST_DATA_WD-1:0]     mem6_din_a          ;
wire   [BIST_DATA_WD-1:0]     mem6_dout_a         ;

// MEM7 - PORT-A Signals
wire   [BIST_ADDR_WD-1:0]     mem7_addr_a         ;
wire [BIST_DATA_WD/8-1:0]     mem7_mask_a         ;
wire   [BIST_DATA_WD-1:0]     mem7_din_a          ;
wire   [BIST_DATA_WD-1:0]     mem7_dout_a         ;

// PORT-B Signals
wire [BIST_NO_SRAM-1:0]       mem_clk_b          ;
wire [BIST_NO_SRAM-1:0]       mem_cen_b          ;

wire [BIST_ADDR_WD-1:0]       mem0_addr_b         ;
wire [BIST_ADDR_WD-1:0]       mem1_addr_b         ;
wire [BIST_ADDR_WD-1:0]       mem2_addr_b         ;
wire [BIST_ADDR_WD-1:0]       mem3_addr_b         ;
wire [BIST_ADDR_WD-1:0]       mem4_addr_b         ;
wire [BIST_ADDR_WD-1:0]       mem5_addr_b         ;
wire [BIST_ADDR_WD-1:0]       mem6_addr_b         ;
wire [BIST_ADDR_WD-1:0]       mem7_addr_b         ;

//----------------------------------------------------
// Clock & clock skew feed through
//--------------------------------------------------
wire                          wbd_clk_pinmux_rp    ;
wire                          wbd_clk_mbist0_rp   ;
wire                          wbd_clk_mbist1_rp   ;
wire                          wbd_clk_mac_rp     ;

wire                          wbd_clk_wi_skew  ;
wire                          wbd_clk_pinmux_skew  ;
wire                          wbd_clk_mbist0_skew ;
wire                          wbd_clk_mbist1_skew ;
wire                          wbd_clk_mac_skew ;

wire                          lbist_clk          ;
wire                          wbd_clk_wh         ;
wire                          wbd_clk_int        ;
wire [31:0]                   cfg_clk_ctrl1      ;
wire [31:0]                   cfg_clk_ctrl2      ;

//---------------------------------------------------
// Scan Control Signal
//---------------------------------------------------
////////////////////////////////////////////////////////////
//  Scan Tree Map
///////////////////////////////////////////////////////////

// WB_HOST(LBIST) => MBIST0 => MBIST1 => WB_INTERCONNECT => PINMUX => MAC => WB_HOST(LBIST) 
wire                          scan_clk            ; // Scan Clock
wire                          scan_rst_n          ; // Scan Reset

wire                          scan_mode           ; // Scan Mode
wire                          scan_en             ; // Scan Enable
wire [SCW-1:0]                scan_in             ; // Scan Chain-In
wire [SCW-1:0]                scan_out            ; // Scan Chain Out

wire                          scan_mode_mbist0    ;
wire                          scan_en_mbist0      ;
wire [SCW-1:0]                scan_so_mbist0      ;

wire                          scan_mode_mbist1    ;
wire                          scan_en_mbist1      ;
wire [SCW-1:0]                scan_so_mbist1      ;

wire                          scan_mode_wi        ;
wire                          scan_en_wi          ;
wire [SCW-1:0]                scan_so_wi          ;

wire                          scan_mode_pinmux    ;
wire                          scan_en_pinmux      ;
wire [SCW-1:0]                scan_so_pinmux      ;

wire                          scan_mode_mac       ;
wire                          scan_en_mac         ;
wire [SCW-1:0]                scan_so_mac         ;

// SPIS I/F
wire                           sspis_sck                              ; // clock out
wire                           sspis_so                               ; // serial data out
wire                           sspis_si                               ; // serial data in
wire                           sspis_ssn                              ; // cs_n


//-----------------------------------------------------------------------
// MAC Line-Tx Signal
//-----------------------------------------------------------------------
wire         mac_tx_en      ;
wire         mac_tx_er      ;
wire [7:0]   mac_txd        ;
wire	     mac_tx_clk     ;

//-----------------------------------------------------------------------
// MAC Line-Rx Signal
//-----------------------------------------------------------------------
wire        mac_rx_clk      ;
wire	    mac_rx_er       ;
wire	    mac_rx_dv       ;
wire [7:0]  mac_rxd         ;
wire	    mac_crs         ;


//-----------------------------------------------------------------------
// MAC MDIO Signal
//-----------------------------------------------------------------------
wire	    mdio_clk        ;
wire        mdio_in         ;
wire        mdio_out_en     ;
wire        mdio_out        ;

//--------------------------------------------
// MAC Q Occupancy
//--------------------------------------------
wire [9:0]  mac_tx_qbase_addr;
wire [9:0]  mac_rx_qbase_addr;
wire        mac_tx_qcnt_inc;
wire        mac_tx_qcnt_dec;
wire        mac_rx_qcnt_inc;  
wire        mac_rx_qcnt_dec;      

//---------------------------------------------
// UART Master I/F
//---------------------------------------------
wire        uartm_rxd;
wire        uartm_txd;


/////////////////////////////////////////////////////////
// Clock Skew Ctrl
////////////////////////////////////////////////////////

wire [3:0] cfg_cska_wh       = cfg_clk_ctrl1[3:0];
wire [3:0] cfg_cska_wi       = cfg_clk_ctrl1[7:4];
wire [3:0] cfg_cska_pinmux   = cfg_clk_ctrl1[11:8];
wire [3:0] cfg_cska_lbist    = cfg_clk_ctrl1[15:12];
wire [3:0] cfg_cska_mbist0   = cfg_clk_ctrl1[19:16];
wire [3:0] cfg_cska_mbist1   = cfg_clk_ctrl1[23:20];
wire [3:0] cfg_cska_mac      = cfg_clk_ctrl1[27:24];

wire   cfg_mem_lphase        = cfg_clk_ctrl1[31]; // SRAM data lanuch phase selection


//----------------------------------------------------------
// Bus Repeater Initiatiation
//----------------------------------------------------------
wire  [37:0]                io_in_rp           ;
wire  [37:0]                io_in_rp1          ;
wire  [37:0]                io_in_rp2          ;
wire  [37:0]                io_out_int         ;
wire  [37:0]                io_oeb_int         ;
wire  [37:0]                io_out_rp1         ;
wire  [37:0]                io_oeb_rp1         ;
wire                        user_clock2_rp     ;
wire [127:0]                la_data_out_int    ;

`include "bus_repeater.sv"

/***********************************************
 Wishbone HOST
*************************************************/


wb_host 
   #(
     `ifndef SYNTHESIS
          .SCW                (SCW                          )   // SCAN CHAIN WIDTH
     `endif
     ) 
  u_wb_host(
`ifdef USE_POWER_PINS
          .vccd1              (vccd1                        ),// User area 1 1.8V supply
          .vssd1              (vssd1                        ),// User area 1 digital ground
`endif
          .user_clock1        (wb_clk_i                     ),
          .user_clock2        (user_clock2                  ),
          .user_irq           (user_irq                     ),

    // Master Port
          .wbm_rst_i               (wb_rst_i_rp             ),  
          .wbm_clk_i               (wb_clk_i_rp             ),  
          .wbm_cyc_i               (wbs_cyc_i_rp            ),  
          .wbm_stb_i               (wbs_stb_i_rp            ),  
          .wbm_adr_i               (wbs_adr_i_rp            ),  
          .wbm_we_i                (wbs_we_i_rp             ),  
          .wbm_dat_i               (wbs_dat_i_rp            ),  
          .wbm_sel_i               (wbs_sel_i_rp            ),  
          .wbm_dat_o               (wbs_dat_int_o           ),  
          .wbm_ack_o               (wbs_ack_int_o           ),  
          .wbm_err_o               (                        ),  

    // Clock Skeq Adjust
          .wbd_clk_int             (wbd_clk_int             ),
          .wbd_clk_wh              (wbd_clk_wh              ),  
          .cfg_cska_wh             (cfg_cska_wh             ),

    // Clock Skeq Adjust
          .lbist_clk_int           (lbist_clk               ),
          .lbist_clk_out           (lbist_clk               ),  
          .cfg_cska_lbist          (cfg_cska_lbist          ),

    // Slave Port
          .wbs_clk_out             (wbd_clk_int             ),
          .wbs_clk_i               (wbd_clk_wh              ),  
          .wbs_cyc_o               (wbd_int_cyc_i           ),  
          .wbs_stb_o               (wbd_int_stb_i           ),  
          .wbs_adr_o               (wbd_int_adr_i           ),  
          .wbs_we_o                (wbd_int_we_i            ),  
          .wbs_dat_o               (wbd_int_dat_i           ),  
          .wbs_sel_o               (wbd_int_sel_i           ),  
          .wbs_dat_i               (wbd_int_dat_o           ),  
          .wbs_ack_i               (wbd_int_ack_o           ),  
          .wbs_err_i               (wbd_int_err_o           ),  

          .cfg_clk_ctrl1           (cfg_clk_ctrl1           ),
          .cfg_clk_ctrl2           (cfg_clk_ctrl2           ),

          .mac_rst_n               (mac_rst_n               ),
          .bist_rst_n              (bist_rst_n              ),
          .wbd_int_rst_n           (wbd_int_rst_n           ),

          .la_data_in              (la_data_in_rp[35:0]     ),
          .la_data_out             (la_data_out_int         ),

          .uartm_rxd               (uartm_rxd               ),
          .uartm_txd               (uartm_txd               ),

          .sclk                    (sspis_sck               ),
          .ssn                     (sspis_ssn               ),
          .sdin                    (sspis_si                ),
          .sdout                   (sspis_so                ),
          .sdout_oen               (                        ),

	// Scan Control Signal
          .scan_clk                (scan_clk                     ),
          .scan_rst_n              (scan_rst_n                   ),
          .scan_mode               (scan_mode                    ),
          .scan_en                 (scan_en                      ),
          .scan_in                 (scan_in                      ),
          .scan_out                (scan_so_mac                  )

    );

wb_interconnect  #(
	`ifndef SYNTHESIS
          .SCW                (SCW                          ),   // SCAN CHAIN WIDTH
          .CH_CLK_WD          (4                            )
        `endif
	   )
     u_intercon (
`ifdef USE_POWER_PINS
          .vccd1              (vccd1                        ),// User area 1 1.8V supply
          .vssd1              (vssd1                        ),// User area 1 digital ground
`endif
      // Scan I/F
          .scan_en            (scan_en_mbist1               ),
          .scan_mode          (scan_mode_mbist1             ),
          .scan_si            (scan_so_mbist1               ),
          .scan_so            (scan_so_wi                   ),
          .scan_en_o          (scan_en_wi                   ),
          .scan_mode_o        (scan_mode_wi                 ),

     // Clock Skew adjust
          .wbd_clk_int        (wbd_clk_int                  ), 
          .cfg_cska_wi        (cfg_cska_wi                  ), 
          .wbd_clk_skew       (wbd_clk_wi_skew              ),

          .ch_clk_in          ({ wbd_clk_int, 
                                 wbd_clk_int,
                                 wbd_clk_int,
                                 wbd_clk_int}               ),
          .ch_clk_out         ({
                                 wbd_clk_mac_rp, 
                                 wbd_clk_mbist1_rp, 
                                 wbd_clk_mbist0_rp, 
			                     wbd_clk_pinmux_rp
		                       }),

          .clk_i              (wbd_clk_wi_skew              ), 
          .rst_n              (wbd_int_rst_n                ),

         // Master 0 Interface
          .m0_wbd_dat_i       (wbd_int_dat_i                ),
          .m0_wbd_adr_i       (wbd_int_adr_i                ),
          .m0_wbd_sel_i       (wbd_int_sel_i                ),
          .m0_wbd_we_i        (wbd_int_we_i                 ),
          .m0_wbd_cyc_i       (wbd_int_cyc_i                ),
          .m0_wbd_stb_i       (wbd_int_stb_i                ),
          .m0_wbd_dat_o       (wbd_int_dat_o                ),
          .m0_wbd_ack_o       (wbd_int_ack_o                ),
          .m0_wbd_err_o       (wbd_int_err_o                ),

         // Master 1 Interface
          .m1_wbd_dat_i       (wbm_gtx_dat_o                ),
          .m1_wbd_adr_i       (wbm_gtx_adr_o                ),
          .m1_wbd_sel_i       (wbm_gtx_sel_o                ),
          .m1_wbd_we_i        (wbm_gtx_we_o                 ),
          .m1_wbd_cyc_i       (wbm_gtx_cyc_o                ),
          .m1_wbd_stb_i       (wbm_gtx_stb_o                ),
          .m1_wbd_dat_o       (wbm_gtx_dat_i                ),
          .m1_wbd_ack_o       (wbm_gtx_ack_i                ),
          .m1_wbd_err_o       (                             ),

         // Master 2 Interface
          .m2_wbd_dat_i       (wbm_grx_dat_o                ),
          .m2_wbd_adr_i       (wbm_grx_adr_o                ),
          .m2_wbd_sel_i       (wbm_grx_sel_o                ),
          .m2_wbd_we_i        (wbm_grx_we_o                 ),
          .m2_wbd_cyc_i       (wbm_grx_cyc_o                ),
          .m2_wbd_stb_i       (wbm_grx_stb_o                ),
          .m2_wbd_dat_o       (wbm_grx_dat_i                ),
          .m2_wbd_ack_o       (wbm_grx_ack_i                ),
          .m2_wbd_err_o       (                             ),

         // Slave 0 Interface
         // .s0_wbd_err_i     (1'b0                         ), - Moved inside IP
          .s0_wbd_dat_i       (wbd_pinmux_dat_i               ),
          .s0_wbd_ack_i       (wbd_pinmux_ack_i               ),
          .s0_wbd_dat_o       (wbd_pinmux_dat_o               ),
          .s0_wbd_adr_o       (wbd_pinmux_adr_o               ),
          .s0_wbd_sel_o       (wbd_pinmux_sel_o               ),
          .s0_wbd_we_o        (wbd_pinmux_we_o                ),  
          .s0_wbd_cyc_o       (wbd_pinmux_cyc_o               ),
          .s0_wbd_stb_o       (wbd_pinmux_stb_o               ),

          // Slave 1 Interface
          //.s1_wbd_err_i     (1'b0                         ), - Moved inside IP
          .s1_wbd_dat_i       (wbs_grg_dat_o                ),
          .s1_wbd_ack_i       (wbs_grg_ack_o                ),
          .s1_wbd_dat_o       (wbs_grg_dat_i                ),
          .s1_wbd_adr_o       (wbs_grg_adr_i                ),
          .s1_wbd_sel_o       (wbs_grg_sel_i                ),
          .s1_wbd_we_o        (wbs_grg_we_i                 ),  
          .s1_wbd_cyc_o       (wbs_grg_cyc_i                ),
          .s1_wbd_stb_o       (wbs_grg_stb_i                ),

         // Slave 2 Interface
          //.s2_wbd_err_i     (1'b0                         ), - Moved inside IP
          .s2_wbd_dat_i       (wbd_mbist0_dat_i             ),
          .s2_wbd_ack_i       (wbd_mbist0_ack_i             ),
          .s2_wbd_dat_o       (wbd_mbist0_dat_o             ),
          .s2_wbd_adr_o       (wbd_mbist0_adr_o             ),
          .s2_wbd_sel_o       (wbd_mbist0_sel_o             ),
          .s2_wbd_bl_o        (wbd_mbist0_bl_o              ),
          .s2_wbd_bry_o       (wbd_mbist0_bry_o             ),
          .s2_wbd_we_o        (wbd_mbist0_we_o              ),  
          .s2_wbd_cyc_o       (wbd_mbist0_cyc_o             ),
          .s2_wbd_stb_o       (wbd_mbist0_stb_o             ),

         // Slave 3 Interface
          //.s3_wbd_err_i     (1'b0                         ), - Moved inside IP
          .s3_wbd_dat_i       (wbd_mbist1_dat_i             ),
          .s3_wbd_ack_i       (wbd_mbist1_ack_i             ),
          .s3_wbd_dat_o       (wbd_mbist1_dat_o             ),
          .s3_wbd_adr_o       (wbd_mbist1_adr_o             ),
          .s3_wbd_sel_o       (wbd_mbist1_sel_o             ),
          .s3_wbd_bl_o        (wbd_mbist1_bl_o              ),
          .s3_wbd_bry_o       (wbd_mbist1_bry_o             ),
          .s3_wbd_we_o        (wbd_mbist1_we_o              ),  
          .s3_wbd_cyc_o       (wbd_mbist1_cyc_o             ),
          .s3_wbd_stb_o       (wbd_mbist1_stb_o             ),

          // Q Occupancy
          .mac_tx_qbase_addr  (mac_tx_qbase_addr            ) ,
          .mac_rx_qbase_addr  (mac_rx_qbase_addr            ) ,

          .mac_tx_qcnt_inc    (mac_tx_qcnt_inc              ),
          .mac_tx_qcnt_dec    (mac_tx_qcnt_dec              ),
          .mac_rx_qcnt_inc    (mac_rx_qcnt_inc              ),  
          .mac_rx_qcnt_dec    (mac_rx_qcnt_dec              )       
	);


pinmux_top #(
     `ifndef SYNTHESIS
          .SCW                (SCW                          )   // SCAN CHAIN WIDTH
     `endif
     ) u_pinmux(
`ifdef USE_POWER_PINS
          .vccd1              (vccd1                        ),// User area 1 1.8V supply
          .vssd1              (vssd1                        ),// User area 1 digital ground
`endif
      // Scan I/F
          .scan_en            (scan_en_wi               ),
          .scan_mode          (scan_mode_wi             ),
          .scan_si            (scan_so_wi               ),
          .scan_so            (scan_so_pinmux           ),
          .scan_en_o          (scan_en_pinmux           ),
          .scan_mode_o        (scan_mode_pinmux         ),


          .wbd_clk_int        (wbd_clk_pinmux_rp            ), 
          .cfg_cska_pinmux    (cfg_cska_pinmux              ), 
          .wbd_clk_skew       (wbd_clk_pinmux_skew          ), 

          .mclk               (wbd_clk_pinmux_skew          ),
          .reset_n            (wbd_int_rst_n                ),

        // Reg Bus Interface Signal
          .reg_cs             (wbd_pinmux_stb_o             ),
          .reg_wr             (wbd_pinmux_we_o              ),
          .reg_addr           (wbd_pinmux_adr_o             ),
          .reg_wdata          (wbd_pinmux_dat_o             ),
          .reg_be             (wbd_pinmux_sel_o             ),

       // Outputs
          .reg_rdata          (wbd_pinmux_dat_i             ),
          .reg_ack            (wbd_pinmux_ack_i             ),


          //-----------------------------------------------------------------------
          // MAC Line-Tx Signal
          //-----------------------------------------------------------------------
          .mac_tx_en          (mac_tx_en                    ),
          .mac_tx_er          (mac_tx_er                    ),
          .mac_txd            (mac_txd                      ),
          .mac_tx_clk         (mac_tx_clk                   ),
                   
          //-----------------------------------------------------------------------
          // MAC Line-Rx Signal
          //-----------------------------------------------------------------------
          .mac_rx_clk         (mac_rx_clk                   ),
          .mac_rx_er          (mac_rx_er                    ),
          .mac_rx_dv          (mac_rx_dv                    ),
          .mac_rxd            (mac_rxd                      ),
          .mac_crs            (mac_crs                      ),
                   
                   
          //-----------------------------------------------------------------------
          // MAC MDIO Signal
          //-----------------------------------------------------------------------
          .mdio_clk           (mdio_clk                     ),
          .mdio_in            (mdio_in                      ),
          .mdio_out_en        (mdio_out_en                  ),
          .mdio_out           (mdio_out                     ),

          //-------------------------------------
          // Master UART TXD
          //-------------------------------------
          .uartm_rxd          (uartm_rxd                    ),
          .uartm_txd          (uartm_txd                    ),

          //-------------------------------------
          // SPI SLAVE
          //-------------------------------------

          .spis_sck           (sspis_sck                    ),
          .spis_ssn           (sspis_ssn                    ),
          .spis_miso          (sspis_so                     ),
          .spis_mosi          (sspis_si                     ),


          //-------------------------------------
          // Caravel IO I/F
          //-------------------------------------
          .io_in              (io_in_rp                     ),
          .io_out             (io_out_int                   ),
          .io_oeb             (io_oeb_int                   )


    );

//------------- MBIST-0 - 512x32 * 4          ----


mbist_wrapper  #(
	`ifndef SYNTHESIS
          .SCW                   (SCW                          ),
          .BIST_NO_SRAM          (4                            ),
          .BIST_ADDR_WD          (BIST_ADDR_WD                 ),
          .BIST_DATA_WD          (BIST_DATA_WD                 ),
          .BIST_ADDR_START       (9'h000                       ),
          .BIST_ADDR_END         (9'h1FB                       ),
          .BIST_REPAIR_ADDR_START(9'h1FC                       ),
          .BIST_RAD_WD_I         (BIST_ADDR_WD                 ),
          .BIST_RAD_WD_O         (BIST_ADDR_WD                 )
        `endif
     ) 
	     u_mbist0 (
`ifdef USE_POWER_PINS
          .vccd1              (vccd1                        ),// User area 1 1.8V supply
          .vssd1              (vssd1                        ),// User area 1 digital ground
`endif
     // Clock Skew adjust
          .wbd_clk_int        (wbd_clk_mbist0_rp            ), 
          .cfg_cska_mbist     (cfg_cska_mbist0              ), 
          .wbd_clk_skew       (wbd_clk_mbist0_skew           ),


          .scan_en            (scan_en                      ),
          .scan_mode          (scan_mode                    ),
          .scan_si            (scan_in                      ),
          .scan_so            (scan_so_mbist0               ),
          .scan_en_o          (scan_en_mbist0               ),
          .scan_mode_o        (scan_mode_mbist0             ),


	// WB I/F
          .wb_clk2_i          (wbd_clk_mbist0_skew           ),  
          .wb_clk_i           (wbd_clk_mbist0_skew           ),  
          .wb_cyc_i           (wbd_mbist0_cyc_o              ),  
          .wb_stb_i           (wbd_mbist0_stb_o              ),  
          .wb_adr_i           (wbd_mbist0_adr_o              ),  
          .wb_we_i            (wbd_mbist0_we_o               ),  
          .wb_dat_i           (wbd_mbist0_dat_o              ),  
          .wb_sel_i           (wbd_mbist0_sel_o              ),
          .wb_bl_i            (wbd_mbist0_bl_o               ),
          .wb_bry_i           (wbd_mbist0_bry_o              ),
          .wb_dat_o           (wbd_mbist0_dat_i              ),  
          .wb_ack_o           (wbd_mbist0_ack_i              ),  
          .wb_err_o           (                             ), 
          .rst_n              (bist_rst_n                   ),


     // towards memory
     // PORT-A
          .mem_clk_a          (mem_clk_a[3:0]               ),
          .mem_cen_a          (mem_cen_a[3:0]               ),
          .mem_web_a          (mem_web_a[3:0]               ),

          .mem_addr_a0        (mem0_addr_a                  ),
          .mem_mask_a0        (mem0_mask_a                  ),
          .mem_din_a0         (mem0_din_a                   ),
          .mem_dout_a0        (mem0_dout_a                  ),

          .mem_addr_a1        (mem1_addr_a                  ),
          .mem_mask_a1        (mem1_mask_a                  ),
          .mem_din_a1         (mem1_din_a                   ),
          .mem_dout_a1        (mem1_dout_a                  ),

          .mem_addr_a2        (mem2_addr_a                  ),
          .mem_mask_a2        (mem2_mask_a                  ),
          .mem_din_a2         (mem2_din_a                   ),
          .mem_dout_a2        (mem2_dout_a                  ),

          .mem_addr_a3        (mem3_addr_a                  ),
          .mem_mask_a3        (mem3_mask_a                  ),
          .mem_din_a3         (mem3_din_a                   ),
          .mem_dout_a3        (mem3_dout_a                  ),

     // PORT-B
          .mem_clk_b          (mem_clk_b[3:0]               ),
          .mem_cen_b          (mem_cen_b[3:0]               ),

          .mem_addr_b0        (mem0_addr_b                  ),
          .mem_addr_b1        (mem1_addr_b                  ),
          .mem_addr_b2        (mem2_addr_b                  ),
          .mem_addr_b3        (mem3_addr_b                  )
);


//----------------------------
// SRAM 2KB BANK=0
//---------------------
sky130_sram_2kbyte_1rw1r_32x512_8 u_sram0_2kb(
`ifdef USE_POWER_PINS
          .vccd1              (vccd1                        ),// User area 1 1.8V supply
          .vssd1              (vssd1                        ),// User area 1 digital ground
`endif
// Port 0: RW
          .clk0               (mem_clk_a[0]                 ),
          .csb0               (mem_cen_a[0]                 ),
          .web0               (mem_web_a[0]                 ),
          .wmask0             (mem0_mask_a                  ),
          .addr0              (mem0_addr_a                  ),
          .din0               (mem0_din_a                   ),
          .dout0              (mem0_dout_a                  ),
// Port 1: R
          .clk1               (mem_clk_b[0]                 ),
          .csb1               (mem_cen_b[0]                 ),
          .addr1              (mem0_addr_b                  ),
          .dout1              (                             )
  );
//----------------------------
// SRAM 2KB BANK=1
//---------------------
sky130_sram_2kbyte_1rw1r_32x512_8 u_sram1_2kb(
`ifdef USE_POWER_PINS
          .vccd1              (vccd1                        ),// User area 1 1.8V supply
          .vssd1              (vssd1                        ),// User area 1 digital ground
`endif
// Port 0: RW
          .clk0               (mem_clk_a[1]                 ),
          .csb0               (mem_cen_a[1]                 ),
          .web0               (mem_web_a[1]                 ),
          .wmask0             (mem1_mask_a                  ),
          .addr0              (mem1_addr_a                  ),
          .din0               (mem1_din_a                   ),
          .dout0              (mem1_dout_a                  ),
// Port 1: R
          .clk1               (mem_clk_b[1]                 ),
          .csb1               (mem_cen_b[1]                 ),
          .addr1              (mem1_addr_b                  ),
          .dout1              (                             )
  );
//----------------------------
// SRAM 2KB BANK=2
//---------------------
sky130_sram_2kbyte_1rw1r_32x512_8 u_sram2_2kb(
`ifdef USE_POWER_PINS
          .vccd1              (vccd1                        ),// User area 1 1.8V supply
          .vssd1              (vssd1                        ),// User area 1 digital ground
`endif
// Port 0: RW
          .clk0               (mem_clk_a[2]                 ),
          .csb0               (mem_cen_a[2]                 ),
          .web0               (mem_web_a[2]                 ),
          .wmask0             (mem2_mask_a                  ),
          .addr0              (mem2_addr_a                  ),
          .din0               (mem2_din_a                   ),
          .dout0              (mem2_dout_a                  ),
// Port 1: R
          .clk1               (mem_clk_b[2]                 ),
          .csb1               (mem_cen_b[2]                 ),
          .addr1              (mem2_addr_b                  ),
          .dout1              (                             )
  );
//----------------------------
// SRAM 2KB BANK=3
//---------------------
sky130_sram_2kbyte_1rw1r_32x512_8 u_sram3_2kb(
`ifdef USE_POWER_PINS
          .vccd1              (vccd1                        ),// User area 1 1.8V supply
          .vssd1              (vssd1                        ),// User area 1 digital ground
`endif
// Port 0: RW
          .clk0               (mem_clk_a[3]                 ),
          .csb0               (mem_cen_a[3]                 ),
          .web0               (mem_web_a[3]                 ),
          .wmask0             (mem3_mask_a                  ),
          .addr0              (mem3_addr_a                  ),
          .din0               (mem3_din_a                   ),
          .dout0              (mem3_dout_a                  ),
// Port 1: R
          .clk1               (mem_clk_b[3]                 ),
          .csb1               (mem_cen_b[3]                 ),
          .addr1              (mem3_addr_b                  ),
          .dout1              (                             )
  );

//------------- MBIST-1 - 512x32 * 4          ----


mbist_wrapper  #(
	`ifndef SYNTHESIS
          .SCW                   (SCW                          ),
          .BIST_NO_SRAM          (4                            ),
          .BIST_ADDR_WD          (BIST_ADDR_WD                 ),
          .BIST_DATA_WD          (BIST_DATA_WD                 ),
          .BIST_ADDR_START       (9'h000                       ),
          .BIST_ADDR_END         (9'h1FB                       ),
          .BIST_REPAIR_ADDR_START(9'h1FC                       ),
          .BIST_RAD_WD_I         (BIST_ADDR_WD                 ),
          .BIST_RAD_WD_O         (BIST_ADDR_WD                 )
        `endif
     ) 
	     u_mbist1 (
`ifdef USE_POWER_PINS
          .vccd1              (vccd1                        ),// User area 1 1.8V supply
          .vssd1              (vssd1                        ),// User area 1 digital ground
`endif
     // Clock Skew adjust
          .wbd_clk_int        (wbd_clk_mbist1_rp            ), 
          .cfg_cska_mbist     (cfg_cska_mbist1              ), 
          .wbd_clk_skew       (wbd_clk_mbist1_skew          ),

      // Scan I/F
          .scan_en            (scan_en_mbist0               ),
          .scan_mode          (scan_mode_mbist0             ),
          .scan_si            (scan_so_mbist0               ),
          .scan_so            (scan_so_mbist1               ),
          .scan_en_o          (scan_en_mbist1               ),
          .scan_mode_o        (scan_mode_mbist1             ),

	// WB I/F
          .wb_clk2_i          (wbd_clk_mbist1_skew          ),  
          .wb_clk_i           (wbd_clk_mbist1_skew          ),  
          .wb_cyc_i           (wbd_mbist1_cyc_o              ),  
          .wb_stb_i           (wbd_mbist1_stb_o             ),  
          .wb_adr_i           (wbd_mbist1_adr_o             ),  
          .wb_we_i            (wbd_mbist1_we_o              ),  
          .wb_dat_i           (wbd_mbist1_dat_o             ),  
          .wb_sel_i           (wbd_mbist1_sel_o             ),
          .wb_bl_i            (wbd_mbist1_bl_o              ),
          .wb_bry_i           (wbd_mbist1_bry_o             ),
          .wb_dat_o           (wbd_mbist1_dat_i             ),  
          .wb_ack_o           (wbd_mbist1_ack_i             ),  
          .wb_err_o           (                             ), 
          .rst_n              (bist_rst_n                   ),


     // towards memory
     // PORT-A
          .mem_clk_a          (mem_clk_a[7:4]                    ),
          .mem_cen_a          (mem_cen_a[7:4]                   ),
          .mem_web_a          (mem_web_a[7:4]                   ),

          .mem_addr_a0        (mem4_addr_a                  ),
          .mem_mask_a0        (mem4_mask_a                  ),
          .mem_din_a0         (mem4_din_a                   ),
          .mem_dout_a0        (mem4_dout_a                  ),

          .mem_addr_a1        (mem5_addr_a                  ),
          .mem_mask_a1        (mem5_mask_a                  ),
          .mem_din_a1         (mem5_din_a                   ),
          .mem_dout_a1        (mem5_dout_a                  ),

          .mem_addr_a2        (mem6_addr_a                  ),
          .mem_mask_a2        (mem6_mask_a                  ),
          .mem_din_a2         (mem6_din_a                   ),
          .mem_dout_a2        (mem6_dout_a                  ),

          .mem_addr_a3        (mem7_addr_a                  ),
          .mem_mask_a3        (mem7_mask_a                  ),
          .mem_din_a3         (mem7_din_a                   ),
          .mem_dout_a3        (mem7_dout_a                  ),

     // PORT-B
          .mem_clk_b          (mem_clk_b[7:4]               ),
          .mem_cen_b          (mem_cen_b[7:4]               ),

          .mem_addr_b0        (mem4_addr_b                  ),
          .mem_addr_b1        (mem5_addr_b                  ),
          .mem_addr_b2        (mem6_addr_b                  ),
          .mem_addr_b3        (mem7_addr_b                  )
);


//----------------------------
// SRAM 2KB BANK=4
//---------------------
sky130_sram_2kbyte_1rw1r_32x512_8 u_sram4_2kb(
`ifdef USE_POWER_PINS
          .vccd1              (vccd1                        ),// User area 1 1.8V supply
          .vssd1              (vssd1                        ),// User area 1 digital ground
`endif
// Port 0: RW
          .clk0               (mem_clk_a[4]                 ),
          .csb0               (mem_cen_a[4]                 ),
          .web0               (mem_web_a[4]                 ),
          .wmask0             (mem4_mask_a                  ),
          .addr0              (mem4_addr_a                  ),
          .din0               (mem4_din_a                   ),
          .dout0              (mem4_dout_a                  ),
// Port 1: R
          .clk1               (mem_clk_b[4]                 ),
          .csb1               (mem_cen_b[4]                 ),
          .addr1              (mem4_addr_b                  ),
          .dout1              (                             )
  );
//----------------------------
// SRAM 2KB BANK=5
//---------------------
sky130_sram_2kbyte_1rw1r_32x512_8 u_sram5_2kb(
`ifdef USE_POWER_PINS
          .vccd1              (vccd1                        ),// User area 1 1.8V supply
          .vssd1              (vssd1                        ),// User area 1 digital ground
`endif
// Port 0: RW
          .clk0               (mem_clk_a[5]                 ),
          .csb0               (mem_cen_a[5]                 ),
          .web0               (mem_web_a[5]                 ),
          .wmask0             (mem5_mask_a                  ),
          .addr0              (mem5_addr_a                  ),
          .din0               (mem5_din_a                   ),
          .dout0              (mem5_dout_a                  ),
// Port 1: R
          .clk1               (mem_clk_b[5]                 ),
          .csb1               (mem_cen_b[5]                 ),
          .addr1              (mem5_addr_b                  ),
          .dout1              (                             )
  );
//----------------------------
// SRAM 2KB BANK=6
//---------------------
sky130_sram_2kbyte_1rw1r_32x512_8 u_sram6_2kb(
`ifdef USE_POWER_PINS
          .vccd1              (vccd1                        ),// User area 1 1.8V supply
          .vssd1              (vssd1                        ),// User area 1 digital ground
`endif
// Port 0: RW
          .clk0               (mem_clk_a[6]                 ),
          .csb0               (mem_cen_a[6]                 ),
          .web0               (mem_web_a[6]                 ),
          .wmask0             (mem6_mask_a                  ),
          .addr0              (mem6_addr_a                  ),
          .din0               (mem6_din_a                   ),
          .dout0              (mem6_dout_a                  ),
// Port 1: R
          .clk1               (mem_clk_b[6]                 ),
          .csb1               (mem_cen_b[6]                 ),
          .addr1              (mem6_addr_b                  ),
          .dout1              (                             )
  );
//----------------------------
// SRAM 2KB BANK=3
//---------------------
sky130_sram_2kbyte_1rw1r_32x512_8 u_sram7_2kb(
`ifdef USE_POWER_PINS
          .vccd1              (vccd1                        ),// User area 1 1.8V supply
          .vssd1              (vssd1                        ),// User area 1 digital ground
`endif
// Port 0: RW
          .clk0               (mem_clk_a[7]                 ),
          .csb0               (mem_cen_a[7]                 ),
          .web0               (mem_web_a[7]                 ),
          .wmask0             (mem7_mask_a                  ),
          .addr0              (mem7_addr_a                  ),
          .din0               (mem7_din_a                   ),
          .dout0              (mem7_dout_a                  ),
// Port 1: R
          .clk1               (mem_clk_b[7]                 ),
          .csb1               (mem_cen_b[7]                 ),
          .addr1              (mem7_addr_b                  ),
          .dout1              (                             )
  );


//------------------------------------------------
// MAC WRAPPER
//------------------------------------------------

mac_wrapper u_mac_wrap(

          .app_clk            (wbd_clk_mac_skew   ),
          .reset_n            (mac_rst_n          ),

    // Clock Skeq Adjust
          .wbd_clk_int        (wbd_clk_mac_rp     ),
          .wbd_clk_skew       (wbd_clk_mac_skew   ),  
          .cfg_cska_mac       (cfg_cska_mac       ),

      // Scan I/F
          .scan_en            (scan_en_pinmux     ),
          .scan_mode          (scan_mode_pinmux   ),
          .scan_si            (scan_so_pinmux     ),
          .scan_so            (scan_so_mac        ),
          .scan_en_o          (scan_en_mac        ),
          .scan_mode_o        (scan_mode_mac      ),

          //-----------------------------------------------------------------------
          // MAC Line-Tx Signal
          //-----------------------------------------------------------------------
          .phy_tx_en          (mac_tx_en          ),
          .phy_tx_er          (mac_tx_er          ),
          .phy_txd            (mac_txd            ),
          .phy_tx_clk         (mac_tx_clk         ),
                   
          //-----------------------------------------------------------------------
          // MAC Line-Rx Signal
          //-----------------------------------------------------------------------
          .phy_rx_clk         (mac_rx_clk         ),
          .phy_rx_er          (mac_rx_er          ),
          .phy_rx_dv          (mac_rx_dv          ),
          .phy_rxd            (mac_rxd            ),
          .phy_crs            (mac_crs            ),
                   
                   
          //-----------------------------------------------------------------------
          // MAC MDIO Signal
          //-----------------------------------------------------------------------
          .mdio_clk           (mdio_clk           ),
          .mdio_in            (mdio_in            ),
          .mdio_out_en        (mdio_out_en        ),
          .mdio_out           (mdio_out           ),

          //--------------------------------------------
          // GMAC TX WB Master I/F
          //--------------------------------------------
          .wbm_gtx_dat_i      (wbm_gtx_dat_i      ),
          .wbm_gtx_ack_i      (wbm_gtx_ack_i      ),
          .wbm_gtx_dat_o      (wbm_gtx_dat_o      ),
          .wbm_gtx_adr_o      (wbm_gtx_adr_o      ),
          .wbm_gtx_sel_o      (wbm_gtx_sel_o      ),
          .wbm_gtx_we_o       (wbm_gtx_we_o       ),
          .wbm_gtx_stb_o      (wbm_gtx_stb_o      ),
          .wbm_gtx_cyc_o      (wbm_gtx_cyc_o      ),
                
          //--------------------------------------------
          // GMAC RX WB Master I/F
          //--------------------------------------------
          .wbm_grx_dat_i      (wbm_grx_dat_i      ),
          .wbm_grx_ack_i      (wbm_grx_ack_i      ),
          .wbm_grx_dat_o      (wbm_grx_dat_o      ),
          .wbm_grx_adr_o      (wbm_grx_adr_o      ),
          .wbm_grx_sel_o      (wbm_grx_sel_o      ),
          .wbm_grx_we_o       (wbm_grx_we_o       ),
          .wbm_grx_stb_o      (wbm_grx_stb_o      ),
          .wbm_grx_cyc_o      (wbm_grx_cyc_o      ),
                
          //--------------------------------------------
          // GMAC REG WB SLAVE I/F
          //--------------------------------------------
          .wbs_grg_dat_o      (wbs_grg_dat_o      ),
          .wbs_grg_ack_o      (wbs_grg_ack_o      ),
          .wbs_grg_dat_i      (wbs_grg_dat_i      ),
          .wbs_grg_adr_i      (wbs_grg_adr_i      ),
          .wbs_grg_sel_i      (wbs_grg_sel_i      ),
          .wbs_grg_we_i       (wbs_grg_we_i       ),
          .wbs_grg_stb_i      (wbs_grg_stb_i      ),
          .wbs_grg_cyc_i      (wbs_grg_cyc_i      ),
                   
          // Q Occupancy
          .cfg_tx_qbase_addr  (mac_tx_qbase_addr  ),
          .cfg_rx_qbase_addr  (mac_rx_qbase_addr  ),

          .mac_tx_qcnt_inc    (mac_tx_qcnt_inc    ),
          .mac_tx_qcnt_dec    (mac_tx_qcnt_dec    ),
          .mac_rx_qcnt_inc    (mac_rx_qcnt_inc    ),  
          .mac_rx_qcnt_dec    (mac_rx_qcnt_dec    )       

       );



endmodule	// user_project_wrapper

`default_nettype wire
