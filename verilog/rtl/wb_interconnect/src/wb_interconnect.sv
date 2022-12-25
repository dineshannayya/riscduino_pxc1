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
// SPDX-FileContributor: Created by Dinesh Annayya <dinesh.annayya@gmail.com>
//
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Wishbone Interconnect                                       ////
////                                                              ////
////  This file is part of the mbist_ctrl cores project           ////
////  https://github.com/dineshannayya/mbist_ctrl.git             ////
////                                                              ////
////  Description                                                 ////
////	1. 1 masters and 2 slaves share bus Wishbone connection   ////
////     M0 - WB_PORT                                             ////
////     M1 - MAC-TX                                              ////
////     M2 - MAC-RX                                              ////
////     S0 - Glbl_Reg                                            ////
////     S1 - MAC                                                 ////
////     S2 - MBIST/SRAM BANK                                     ////
////   Architecturally M0 can communicate to S0/S1/S2             ////
////      M1/M2 will communicate only S2                          ////
////   Wishone Interconnect Build with Architecture Advantage to  ////
////     Avoid Routing conjustion                                 ////
////                                                              ////
////  To Do:                                                      ////
////    nothing                                                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - Dinesh Annayya, dinesh.annayya@gmail.com              ////
////                                                              ////
////  Revision :                                                  ////
////     0.0 - Dec 15, 2022, Dinesh A                             ////
////           Inital Version                                     ////
////     0.1 - Dec 17, 2022, Dinesh A                             ////
////           A. Master Port M1/M2 Added                         ////
////           B. Slave Port S2 Added                             ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////



module wb_interconnect #(
	parameter SCW = 8,   // SCAN CHAIN WIDTH
	parameter CH_CLK_WD = 9,
	parameter CH_DATA_WD = 95
        ) (
`ifdef USE_POWER_PINS
         input logic             vccd1,    // User area 1 1.8V supply
         input logic             vssd1,    // User area 1 digital ground
`endif
         // SCAN Daisy chain
         input logic             scan_en,
         input logic             scan_mode,
         input logic [SCW-1:0]   scan_si,
         output logic [SCW-1:0]  scan_so,
         output logic            scan_en_o,
         output logic            scan_mode_o,

         // Clock Skew Adjust
         input logic [3:0]       cfg_cska_wi,
         input logic             wbd_clk_int,
	     output logic            wbd_clk_skew,

	     // Bus repeaters
	     input [CH_CLK_WD-1:0]   ch_clk_in,
	     output [CH_CLK_WD-1:0]  ch_clk_out,

         input logic		     clk_i, 
         input logic             rst_n,
         
         // Master 0 Interface - WB-HOST
         input   logic	[31:0]	 m0_wbd_dat_i,
         input   logic  [31:0]	 m0_wbd_adr_i,
         input   logic  [3:0]	 m0_wbd_sel_i,
         input   logic  	     m0_wbd_we_i,
         input   logic  	     m0_wbd_cyc_i,
         input   logic  	     m0_wbd_stb_i,
         output  logic	[31:0]	 m0_wbd_dat_o,
         output  logic		     m0_wbd_ack_o,
         output  logic		     m0_wbd_err_o,

         // Master 1 Interface - MAC-TX
         input   logic	[31:0]	 m1_wbd_dat_i,
         input   logic  [15:0]	 m1_wbd_adr_i,
         input   logic  [3:0]	 m1_wbd_sel_i,
         input   logic  	     m1_wbd_we_i,
         input   logic  	     m1_wbd_cyc_i,
         input   logic  	     m1_wbd_stb_i,
         output  logic	[31:0]	 m1_wbd_dat_o,
         output  logic		     m1_wbd_ack_o,
         output  logic		     m1_wbd_err_o,
         
         // Master 2 Interface - MAC-TX
         input   logic	[31:0]	 m2_wbd_dat_i,
         input   logic  [15:0]	 m2_wbd_adr_i,
         input   logic  [3:0]	 m2_wbd_sel_i,
         input   logic  	     m2_wbd_we_i,
         input   logic  	     m2_wbd_cyc_i,
         input   logic  	     m2_wbd_stb_i,
         output  logic	[31:0]	 m2_wbd_dat_o,
         output  logic		     m2_wbd_ack_o,
         output  logic		     m2_wbd_err_o,
         
         // Slave 0 Interface  - GLOBAL-REG/PINMUX
         input	logic [31:0]	s0_wbd_dat_i,
         input	logic 	        s0_wbd_ack_i,
         output	logic [31:0]	s0_wbd_dat_o,
         output	logic [7:0]	    s0_wbd_adr_o,
         output	logic [3:0]	    s0_wbd_sel_o,
         output	logic 	        s0_wbd_we_o,
         output	logic 	        s0_wbd_cyc_o,
         output	logic 	        s0_wbd_stb_o,
         //input	logic 	s0_wbd_err_i, - unused
         
         // Slave 1 Interface - MAC
         input	logic [31:0]	s1_wbd_dat_i,
         input	logic 	        s1_wbd_ack_i,
         output	logic [31:0]	s1_wbd_dat_o,
         output	logic [12:0]	s1_wbd_adr_o,
         output	logic [3:0]	    s1_wbd_sel_o,
         output	logic 	        s1_wbd_we_o,
         output	logic 	        s1_wbd_cyc_o,
         output	logic 	        s1_wbd_stb_o,
         // input	logic 	s1_wbd_err_i, - unused

         // Slave 2 Interface - MBIST/SRAMG0 WRAPPER
         input	logic [31:0]	s2_wbd_dat_i,
         input	logic 	        s2_wbd_ack_i,
         output	logic [31:0]	s2_wbd_dat_o,
         output	logic [14:0]	s2_wbd_adr_o,
         output	logic [3:0]	    s2_wbd_sel_o,
         output	logic [9:0]	    s2_wbd_bl_o,
         output	logic    	    s2_wbd_bry_o,
         output	logic 	        s2_wbd_we_o,
         output	logic 	        s2_wbd_cyc_o,
         output	logic 	        s2_wbd_stb_o,
      // input	logic 	        s2_wbd_err_i, - unused

         // Slave 2 Interface - MBIST/SRAMG1 WRAPPER
         input	logic [31:0]	s3_wbd_dat_i,
         input	logic 	        s3_wbd_ack_i,
         output	logic [31:0]	s3_wbd_dat_o,
         output	logic [14:0]	s3_wbd_adr_o,
         output	logic [3:0]	    s3_wbd_sel_o,
         output	logic [9:0]	    s3_wbd_bl_o,
         output	logic    	    s3_wbd_bry_o,
         output	logic 	        s3_wbd_we_o,
         output	logic 	        s3_wbd_cyc_o,
         output	logic 	        s3_wbd_stb_o,
      // input	logic 	        s3_wbd_err_i, - unused

         // MAC Q Occupancy computation
         input logic [9:0]      mac_tx_qbase_addr,
         input logic [9:0]      mac_rx_qbase_addr,
         output logic           mac_tx_qcnt_inc,
         output logic           mac_tx_qcnt_dec,
         output logic           mac_rx_qcnt_inc,  
         output logic           mac_rx_qcnt_dec       
  

    );

////////////////////////////////////////////////////////////////////
//
// Type define
//
parameter TARGET_NULL    = 4'b0000;
parameter TARGET_PINMUX  = 4'b0001;
parameter TARGET_MAC     = 4'b0010;
parameter TARGET_SRAMG0  = 4'b0011;
parameter TARGET_SRAMG1  = 4'b0100;


// WishBone Wr Interface
typedef struct packed { 
  logic	[31:0]	wbd_dat;
  logic  [31:0]	wbd_adr;
  logic  [3:0]	wbd_sel;
  logic  [9:0]	wbd_bl;
  logic  	wbd_bry;
  logic  	wbd_we;
  logic  	wbd_cyc;
  logic  	wbd_stb;
  logic [3:0] 	wbd_tid; // target id
} type_wb_wr_intf;

// WishBone Rd Interface
typedef struct packed { 
  logic	[31:0]	wbd_dat;
  logic  	wbd_ack;
  logic  	wbd_lack;
  logic  	wbd_err;
} type_wb_rd_intf;


// Master Write Interface
type_wb_wr_intf  m0_wb_wr;
type_wb_wr_intf  m1_wb_wr;
type_wb_wr_intf  m2_wb_wr;

// Master Read Interface
type_wb_rd_intf  m0_wb_rd;
type_wb_rd_intf  m0_s0_wb_rd;
type_wb_rd_intf  m0_s1_wb_rd;
type_wb_rd_intf  m0_s2_wb_rd;
type_wb_rd_intf  m0_s3_wb_rd;

type_wb_rd_intf  m1_wb_rd;
type_wb_rd_intf  m1_s2_wb_rd;
type_wb_rd_intf  m1_s3_wb_rd;

type_wb_rd_intf  m2_wb_rd;
type_wb_rd_intf  m2_s2_wb_rd;
type_wb_rd_intf  m2_s3_wb_rd;

// Slave Write Interface
type_wb_wr_intf  s0_wb_wr;
type_wb_wr_intf  s1_wb_wr;
type_wb_wr_intf  s2_wb_wr;
type_wb_wr_intf  s3_wb_wr;

// Slave Read Interface
type_wb_rd_intf  s0_wb_rd;
type_wb_rd_intf  s1_wb_rd;
type_wb_rd_intf  s2_wb_rd;
type_wb_rd_intf  s3_wb_rd;


// channel repeater
assign ch_clk_out  = ch_clk_in;

assign scan_en_o = scan_en;
assign scan_mode_o = scan_mode;

// Wishbone interconnect clock skew control
clk_skew_adjust u_skew_wi
       (
`ifdef USE_POWER_PINS
               .vccd1      (vccd1                      ),// User area 1 1.8V supply
               .vssd1      (vssd1                      ),// User area 1 digital ground
`endif
	           .clk_in     (wbd_clk_int                 ), 
	           .sel        (cfg_cska_wi                 ), 
	           .clk_out    (wbd_clk_skew                ) 
       );

//-------------------------------------------------------------------
// EXTERNAL MEMORY MAP
// 0x0000_0000 to 0x0000_00FF  - GLBL
// 0x0000_0100 to 0x0000_01FF  - MAC
// 0x0000_0200 to 0x0000_02FF  - MBIST0-REG
// 0x0000_0300 to 0x0000_03FF  - MBIST1-REG
// 0x0000_2000 to 0x0000_27FF  - SRAM-2KB - 0
// 0x0000_2800 to 0x0000_2FFF  - SRAM-2KB - 1
// 0x0000_3000 to 0x0000_37FF  - SRAM-2KB - 2
// 0x0000_3800 to 0x0000_3FFF  - SRAM-2KB - 3
// 0x0000_4000 to 0x0000_47FF  - SRAM-2KB - 4
// 0x0000_4800 to 0x0000_4FFF  - SRAM-2KB - 5
// 0x0000_5000 to 0x0000_57FF  - SRAM-2KB - 6
// 0x0000_5800 to 0x0000_5FFF  - SRAM-2KB - 7
// ---------------------------------------------------------------------------
//
wire [3:0] m0_wbd_tid_i       = (m0_wbd_adr_i[15:8]  == 8'h00  ) ? TARGET_PINMUX :   // GLBL
                                (m0_wbd_adr_i[15:8]  == 8'h01  ) ? TARGET_MAC    :   // MAC
                                (m0_wbd_adr_i[15:13] == 3'b001 ) ? TARGET_SRAMG0 :   // SRAMG0
                                (m0_wbd_adr_i[15:8]  == 8'h02  ) ? TARGET_SRAMG0 :   // MBIST-REG-0
                                (m0_wbd_adr_i[15:13] == 3'b010 ) ? TARGET_SRAMG1 :   // SRAMG1
                                (m0_wbd_adr_i[15:8]  == 8'h03  ) ? TARGET_SRAMG1 :   // MBIST-REG-1
				                 TARGET_NULL; 
//-------------------------------------------------------------------
// EXTERNAL MEMORY MAP
// 0x0000_0000 to 0x0000_0FFF  - GLBL
// 0x0000_0100 to 0x0000_01FF  - MAC
// 0x0000_0200 to 0x0000_02FF  - MBIST0-REG
// 0x0000_2000 to 0x0000_27FF  - SRAM-2KB - 0
// 0x0000_2800 to 0x0000_2FFF  - SRAM-2KB - 1
// 0x0000_3000 to 0x0000_37FF  - SRAM-2KB - 2
// 0x0000_3800 to 0x0000_3FFF  - SRAM-2KB - 3
// 0x0000_4000 to 0x0000_47FF  - SRAM-2KB - 4
// 0x0000_4800 to 0x0000_4FFF  - SRAM-2KB - 5
// 0x0000_5000 to 0x0000_57FF  - SRAM-2KB - 6
// 0x0000_5800 to 0x0000_5FFF  - SRAM-2KB - 7
// ---------------------------------------------------------------------------
//
wire [3:0] m1_wbd_tid_i       = (m1_wbd_adr_i[15:13] == 3'b001   ) ? TARGET_SRAMG0 :   // SRAMG0
                                (m1_wbd_adr_i[15:13] == 3'b010   ) ? TARGET_SRAMG1 :   // SRAMG1
                                TARGET_NULL;

//-------------------------------------------------------------------
// EXTERNAL MEMORY MAP
// 0x0000_0000 to 0x0000_00FF  - GLBL
// 0x0000_0100 to 0x0000_01FF  - MAC
// 0x0000_0200 to 0x0000_02FF  - MBIST0-REG
// 0x0000_2000 to 0x0000_27FF  - SRAM-2KB - 0
// 0x0000_2800 to 0x0000_2FFF  - SRAM-2KB - 1
// 0x0000_3000 to 0x0000_37FF  - SRAM-2KB - 2
// 0x0000_3800 to 0x0000_3FFF  - SRAM-2KB - 3
// ---------------------------------------------------------------------------
//
wire [3:0] m2_wbd_tid_i       = (m2_wbd_adr_i[15:13] == 3'b001 ) ? TARGET_SRAMG0 :   // SRAMG0
                                (m2_wbd_adr_i[15:13] == 3'b010 ) ? TARGET_SRAMG1 :   // SRAMG1
                                TARGET_NULL;
//----------------------------------------
// Master Mapping - M0
// -------------------------------------
assign m0_wb_wr.wbd_dat = m0_wbd_dat_i;
assign m0_wb_wr.wbd_adr = {m0_wbd_adr_i[31:2],2'b00};
assign m0_wb_wr.wbd_sel = m0_wbd_sel_i;
assign m0_wb_wr.wbd_we  = m0_wbd_we_i;
assign m0_wb_wr.wbd_cyc = m0_wbd_cyc_i;
assign m0_wb_wr.wbd_stb = m0_wbd_stb_i;
assign m0_wb_wr.wbd_tid = m0_wbd_tid_i;

assign m0_wbd_dat_o     =  m0_wb_rd.wbd_dat;
assign m0_wbd_ack_o     =  m0_wb_rd.wbd_ack;
assign m0_wbd_err_o     =  m0_wb_rd.wbd_err;

//----------------------------------------
// Master Mapping - M1
// -------------------------------------
assign m1_wb_wr.wbd_dat = m1_wbd_dat_i;
assign m1_wb_wr.wbd_adr = {16'h0,m1_wbd_adr_i[15:2],2'b00};
assign m1_wb_wr.wbd_sel = m1_wbd_sel_i;
assign m1_wb_wr.wbd_we  = m1_wbd_we_i;
assign m1_wb_wr.wbd_cyc = m1_wbd_cyc_i;
assign m1_wb_wr.wbd_stb = m1_wbd_stb_i;
assign m1_wb_wr.wbd_tid = m1_wbd_tid_i;

assign m1_wbd_dat_o     =  m1_wb_rd.wbd_dat;
assign m1_wbd_ack_o     =  m1_wb_rd.wbd_ack;
assign m1_wbd_err_o     =  m1_wb_rd.wbd_err;

//----------------------------------------
// Master Mapping - M2
// -------------------------------------
assign m2_wb_wr.wbd_dat = m2_wbd_dat_i;
assign m2_wb_wr.wbd_adr = {16'h0,m2_wbd_adr_i[15:2],2'b00};
assign m2_wb_wr.wbd_sel = m2_wbd_sel_i;
assign m2_wb_wr.wbd_we  = m2_wbd_we_i;
assign m2_wb_wr.wbd_cyc = m2_wbd_cyc_i;
assign m2_wb_wr.wbd_stb = m2_wbd_stb_i;
assign m2_wb_wr.wbd_tid = m2_wbd_tid_i;

assign m2_wbd_dat_o     =  m2_wb_rd.wbd_dat;
assign m2_wbd_ack_o     =  m2_wb_rd.wbd_ack;
assign m2_wbd_err_o     =  m2_wb_rd.wbd_err;
//----------------------------------------
// Slave Mapping
// -------------------------------------
// Masked Now and added stagging FF now
 assign  s0_wbd_dat_o =  s0_wb_wr.wbd_dat ;
 assign  s0_wbd_adr_o =  s0_wb_wr.wbd_adr[7:0] ;
 assign  s0_wbd_sel_o =  s0_wb_wr.wbd_sel ;
 assign  s0_wbd_we_o  =  s0_wb_wr.wbd_we  ;
 assign  s0_wbd_cyc_o =  s0_wb_wr.wbd_cyc ;
 assign  s0_wbd_stb_o =  s0_wb_wr.wbd_stb ;
         
 assign s0_wb_rd.wbd_dat  = s0_wbd_dat_i ;
 assign s0_wb_rd.wbd_ack  = s0_wbd_ack_i ;
 assign s0_wb_rd.wbd_err  = 1'b0; // s0_wbd_err_i ; - unused

//--------------------------------------------
// MAC
//--------------------------------------------
 assign  s1_wbd_dat_o =  s1_wb_wr.wbd_dat ;
 assign  s1_wbd_adr_o =  s1_wb_wr.wbd_adr[12:0] ;
 assign  s1_wbd_sel_o =  s1_wb_wr.wbd_sel ;
 assign  s1_wbd_we_o  =  s1_wb_wr.wbd_we  ;
 assign  s1_wbd_cyc_o =  s1_wb_wr.wbd_cyc ;
 assign  s1_wbd_stb_o =  s1_wb_wr.wbd_stb ;
                      
 assign s1_wb_rd.wbd_dat  = s1_wbd_dat_i ;
 assign s1_wb_rd.wbd_ack  = s1_wbd_ack_i ;
 assign s1_wb_rd.wbd_err  = 1'b0; // s1_wbd_err_i ; - unused

//---------------------------------------------
// SRAM-GROUP-0: 2KB * 4 SRAM  + MBIST WB REG
//---------------------------------------------
 assign  s2_wbd_dat_o =  s2_wb_wr.wbd_dat ;
 assign  s2_wbd_adr_o =  s2_wb_wr.wbd_adr[14:0] ;
 assign  s2_wbd_sel_o =  s2_wb_wr.wbd_sel ;
 assign  s2_wbd_bl_o  =  'h1 ;
 assign  s2_wbd_bry_o =  'b1 ;
 assign  s2_wbd_we_o  =  s2_wb_wr.wbd_we  ;
 assign  s2_wbd_cyc_o =  s2_wb_wr.wbd_cyc ;
 assign  s2_wbd_stb_o =  s2_wb_wr.wbd_stb ;
                      
 assign s2_wb_rd.wbd_dat  = s2_wbd_dat_i ;
 assign s2_wb_rd.wbd_ack  = s2_wbd_ack_i ;
 assign s2_wb_rd.wbd_err  = 1'b0; // s1_wbd_err_i ; - unused
 
//---------------------------------------------
// SRAM-GROUP-1: 2KB * 4 SRAM  + MBIST WB REG
//---------------------------------------------
 assign  s3_wbd_dat_o =  s3_wb_wr.wbd_dat ;
 assign  s3_wbd_adr_o =  s3_wb_wr.wbd_adr[14:0] ;
 assign  s3_wbd_sel_o =  s3_wb_wr.wbd_sel ;
 assign  s3_wbd_bl_o  =  'h1 ;
 assign  s3_wbd_bry_o =  'b1 ;
 assign  s3_wbd_we_o  =  s3_wb_wr.wbd_we  ;
 assign  s3_wbd_cyc_o =  s3_wb_wr.wbd_cyc ;
 assign  s3_wbd_stb_o =  s3_wb_wr.wbd_stb ;
                      
 assign s3_wb_rd.wbd_dat  = s3_wbd_dat_i ;
 assign s3_wb_rd.wbd_ack  = s3_wbd_ack_i ;
 assign s3_wb_rd.wbd_err  = 1'b0; // s1_wbd_err_i ; - unused

//---------------------------------------------
// Connect Master => Slave
// Connect Slave to Master
//---------------------------------------------
assign  m0_wb_rd = (m0_wbd_tid_i == TARGET_PINMUX) ? m0_s0_wb_rd :
                   (m0_wbd_tid_i == TARGET_MAC)    ? m0_s1_wb_rd :
                   (m0_wbd_tid_i == TARGET_SRAMG0) ? m0_s2_wb_rd : 
                   (m0_wbd_tid_i == TARGET_SRAMG1) ? m0_s3_wb_rd : 
                    'h0;

assign  m1_wb_rd = (m1_wbd_tid_i == TARGET_SRAMG0) ? m1_s2_wb_rd : 
                   (m1_wbd_tid_i == TARGET_SRAMG1) ? m1_s3_wb_rd :
                   'h0;
assign  m2_wb_rd = (m2_wbd_tid_i == TARGET_SRAMG0) ? m2_s2_wb_rd :
                   (m2_wbd_tid_i == TARGET_SRAMG1) ? m2_s3_wb_rd : 
                   'h0;



// M0 (WB-HOST) only can access S0 (Pinmux/Glbl Reg)
// Stagging FF to break write and read timing path
wb_stagging u_s0(
         .clk_i            (clk_i                 ), 
         .rst_n            (rst_n                 ),
	     .cfg_slave_id     (TARGET_PINMUX         ),
         // WishBone Input master I/P
         .m_wbd_dat_i      (m0_wb_wr.wbd_dat      ),
         .m_wbd_adr_i      (m0_wb_wr.wbd_adr      ),
         .m_wbd_sel_i      (m0_wb_wr.wbd_sel      ),
         .m_wbd_we_i       (m0_wb_wr.wbd_we       ),
         .m_wbd_cyc_i      (m0_wb_wr.wbd_cyc      ),
         .m_wbd_stb_i      (m0_wb_wr.wbd_stb      ),
         .m_wbd_tid_i      (m0_wb_wr.wbd_tid      ),
         .m_wbd_dat_o      (m0_s0_wb_rd.wbd_dat   ),
         .m_wbd_ack_o      (m0_s0_wb_rd.wbd_ack   ),
         .m_wbd_err_o      (m0_s0_wb_rd.wbd_err   ),

         // Slave Interface
         .s_wbd_dat_i      (s0_wb_rd.wbd_dat      ),
         .s_wbd_ack_i      (s0_wb_rd.wbd_ack      ),
         .s_wbd_err_i      (s0_wb_rd.wbd_err      ),
         .s_wbd_dat_o      (s0_wb_wr.wbd_dat      ),
         .s_wbd_adr_o      (s0_wb_wr.wbd_adr      ),
         .s_wbd_sel_o      (s0_wb_wr.wbd_sel      ),
         .s_wbd_we_o       (s0_wb_wr.wbd_we       ),
         .s_wbd_cyc_o      (s0_wb_wr.wbd_cyc      ),
         .s_wbd_stb_o      (s0_wb_wr.wbd_stb      ),
         .s_wbd_tid_o      (s0_wb_wr.wbd_tid      )

);

// M0 (WB-HOST) only can access S1 (MAC)
// Stagging FF to break write and read timing path
wb_stagging u_s1(
         .clk_i            (clk_i                 ), 
         .rst_n            (rst_n                 ),
	     .cfg_slave_id     (TARGET_MAC            ),
         // WishBone Input master I/P
         .m_wbd_dat_i      (m0_wb_wr.wbd_dat      ),
         .m_wbd_adr_i      (m0_wb_wr.wbd_adr      ),
         .m_wbd_sel_i      (m0_wb_wr.wbd_sel      ),
         .m_wbd_we_i       (m0_wb_wr.wbd_we       ),
         .m_wbd_cyc_i      (m0_wb_wr.wbd_cyc      ),
         .m_wbd_stb_i      (m0_wb_wr.wbd_stb      ),
         .m_wbd_tid_i      (m0_wb_wr.wbd_tid      ),
         .m_wbd_dat_o      (m0_s1_wb_rd.wbd_dat   ),
         .m_wbd_ack_o      (m0_s1_wb_rd.wbd_ack   ),
         .m_wbd_err_o      (m0_s1_wb_rd.wbd_err   ),

         // Slave Interface
         .s_wbd_dat_i      (s1_wb_rd.wbd_dat   ),
         .s_wbd_ack_i      (s1_wb_rd.wbd_ack   ),
         .s_wbd_err_i      (s1_wb_rd.wbd_err   ),
         .s_wbd_dat_o      (s1_wb_wr.wbd_dat    ),
         .s_wbd_adr_o      (s1_wb_wr.wbd_adr    ),
         .s_wbd_sel_o      (s1_wb_wr.wbd_sel    ),
         .s_wbd_we_o       (s1_wb_wr.wbd_we     ),
         .s_wbd_cyc_o      (s1_wb_wr.wbd_cyc    ),
         .s_wbd_stb_o      (s1_wb_wr.wbd_stb    ),
         .s_wbd_tid_o      (s1_wb_wr.wbd_tid    )

);

// M0 (WB-HOST) M1 (MAC-TX) and M2 (MAC-RX) can access S2 (SRAM/MBIST WRAPPER)
// Target Port -0
// QCounter Inc/dec generation
// Ned to move this logic to wishbone interconnect
wire [31:0] s2_addr = s2_wb_wr.wbd_adr;
wire [31:0] s3_addr = s3_wb_wr.wbd_adr;
assign mac_tx_qcnt_inc = ((mac_tx_qbase_addr == s2_wb_wr.wbd_adr[15:6]) && s2_wb_wr.wbd_stb && s2_wb_wr.wbd_we  && s2_wb_rd.wbd_ack && (s2_wb_wr.wbd_sel[3] == 1'b1)) |
                         ((mac_tx_qbase_addr == s3_wb_wr.wbd_adr[15:6]) && s3_wb_wr.wbd_stb && s3_wb_wr.wbd_we  && s3_wb_rd.wbd_ack && (s3_wb_wr.wbd_sel[3] == 1'b1));
assign mac_tx_qcnt_dec = ((mac_tx_qbase_addr == s2_wb_wr.wbd_adr[15:6]) && s2_wb_wr.wbd_stb && !s2_wb_wr.wbd_we && s2_wb_rd.wbd_ack ) |
                         ((mac_tx_qbase_addr == s3_wb_wr.wbd_adr[15:6]) && s3_wb_wr.wbd_stb && !s3_wb_wr.wbd_we && s3_wb_rd.wbd_ack );
assign mac_rx_qcnt_inc = ((mac_rx_qbase_addr == s2_wb_wr.wbd_adr[15:6]) && s2_wb_wr.wbd_stb && s2_wb_wr.wbd_we  && s2_wb_rd.wbd_ack && (s2_wb_wr.wbd_sel[3] == 1'b1)) |
                         ((mac_rx_qbase_addr == s3_wb_wr.wbd_adr[15:6]) && s3_wb_wr.wbd_stb && s3_wb_wr.wbd_we  && s3_wb_rd.wbd_ack && (s3_wb_wr.wbd_sel[3] == 1'b1)) ;
assign mac_rx_qcnt_dec = ((mac_rx_qbase_addr == s2_wb_wr.wbd_adr[15:6]) && s2_wb_wr.wbd_stb && !s2_wb_wr.wbd_we && s2_wb_rd.wbd_ack) |
                         ((mac_rx_qbase_addr == s3_wb_wr.wbd_adr[15:6]) && s3_wb_wr.wbd_stb && !s3_wb_wr.wbd_we && s3_wb_rd.wbd_ack);

// 8KB SRAM GROUP-0
wb_slave_port  u_s2 (

          .clk_i                   (clk_i                  ), 
          .rst_n                   (rst_n                  ),
	      .cfg_slave_id            (TARGET_SRAMG0          ),

         // Master 0 Interface
          .m0_wbd_dat_i            (m0_wb_wr.wbd_dat       ),
          .m0_wbd_adr_i            (m0_wb_wr.wbd_adr       ),
          .m0_wbd_sel_i            (m0_wb_wr.wbd_sel       ),
          .m0_wbd_we_i             (m0_wb_wr.wbd_we        ),
          .m0_wbd_cyc_i            (m0_wb_wr.wbd_cyc       ),
          .m0_wbd_stb_i            (m0_wb_wr.wbd_stb       ),
	      .m0_wbd_tid_i            (m0_wb_wr.wbd_tid       ),
          .m0_wbd_dat_o            (m0_s2_wb_rd.wbd_dat    ),
          .m0_wbd_ack_o            (m0_s2_wb_rd.wbd_ack    ),
          .m0_wbd_lack_o           (m0_s2_wb_rd.wbd_lack   ),
          .m0_wbd_err_o            (m0_s2_wb_rd.wbd_err    ),
         
         // Master 1 Interface
          .m1_wbd_dat_i            (m1_wb_wr.wbd_dat       ),
          .m1_wbd_adr_i            (m1_wb_wr.wbd_adr       ),
          .m1_wbd_sel_i            (m1_wb_wr.wbd_sel       ),
          .m1_wbd_we_i             (m1_wb_wr.wbd_we        ),
          .m1_wbd_cyc_i            (m1_wb_wr.wbd_cyc       ),
          .m1_wbd_stb_i            (m1_wb_wr.wbd_stb       ),
	      .m1_wbd_tid_i            (m1_wb_wr.wbd_tid       ),
          .m1_wbd_dat_o            (m1_s2_wb_rd.wbd_dat    ),
          .m1_wbd_ack_o            (m1_s2_wb_rd.wbd_ack    ),
          .m1_wbd_lack_o           (m1_s2_wb_rd.wbd_lack   ),
          .m1_wbd_err_o            (m1_s2_wb_rd.wbd_err    ),
         
         // Master 2 Interface
          .m2_wbd_dat_i            (m2_wb_wr.wbd_dat       ),
          .m2_wbd_adr_i            (m2_wb_wr.wbd_adr       ),
          .m2_wbd_sel_i            (m2_wb_wr.wbd_sel       ),
          .m2_wbd_we_i             (m2_wb_wr.wbd_we        ),
          .m2_wbd_cyc_i            (m2_wb_wr.wbd_cyc       ),
          .m2_wbd_stb_i            (m2_wb_wr.wbd_stb       ),
	      .m2_wbd_tid_i            (m2_wb_wr.wbd_tid       ),
          .m2_wbd_dat_o            (m2_s2_wb_rd.wbd_dat    ),
          .m2_wbd_ack_o            (m2_s2_wb_rd.wbd_ack    ),
          .m2_wbd_lack_o           (m2_s2_wb_rd.wbd_lack   ),
          .m2_wbd_err_o            (m2_s2_wb_rd.wbd_err    ),

        
         
         // Slave  Interface
          .s_wbd_dat_i            (s2_wb_rd.wbd_dat        ),
          .s_wbd_ack_i            (s2_wb_rd.wbd_ack        ),
          .s_wbd_lack_i           (s2_wb_rd.wbd_ack        ),
          .s_wbd_dat_o            (s2_wb_wr.wbd_dat        ),
          .s_wbd_adr_o            (s2_wb_wr.wbd_adr        ),
          .s_wbd_sel_o            (s2_wb_wr.wbd_sel        ),
          .s_wbd_we_o             (s2_wb_wr.wbd_we         ),  
          .s_wbd_cyc_o            (s2_wb_wr.wbd_cyc        ),
          .s_wbd_stb_o            (s2_wb_wr.wbd_stb        )
        
	);

// 8KB SRAM GROUP-1
wb_slave_port  u_s3 (

          .clk_i                   (clk_i                  ), 
          .rst_n                   (rst_n                  ),
	      .cfg_slave_id            (TARGET_SRAMG1          ),

         // Master 0 Interface
          .m0_wbd_dat_i            (m0_wb_wr.wbd_dat       ),
          .m0_wbd_adr_i            (m0_wb_wr.wbd_adr       ),
          .m0_wbd_sel_i            (m0_wb_wr.wbd_sel       ),
          .m0_wbd_we_i             (m0_wb_wr.wbd_we        ),
          .m0_wbd_cyc_i            (m0_wb_wr.wbd_cyc       ),
          .m0_wbd_stb_i            (m0_wb_wr.wbd_stb       ),
	      .m0_wbd_tid_i            (m0_wb_wr.wbd_tid       ),
          .m0_wbd_dat_o            (m0_s3_wb_rd.wbd_dat    ),
          .m0_wbd_ack_o            (m0_s3_wb_rd.wbd_ack    ),
          .m0_wbd_lack_o           (m0_s3_wb_rd.wbd_lack   ),
          .m0_wbd_err_o            (m0_s3_wb_rd.wbd_err    ),
         
         // Master 1 Interface
          .m1_wbd_dat_i            (m1_wb_wr.wbd_dat       ),
          .m1_wbd_adr_i            (m1_wb_wr.wbd_adr       ),
          .m1_wbd_sel_i            (m1_wb_wr.wbd_sel       ),
          .m1_wbd_we_i             (m1_wb_wr.wbd_we        ),
          .m1_wbd_cyc_i            (m1_wb_wr.wbd_cyc       ),
          .m1_wbd_stb_i            (m1_wb_wr.wbd_stb       ),
	      .m1_wbd_tid_i            (m1_wb_wr.wbd_tid       ),
          .m1_wbd_dat_o            (m1_s3_wb_rd.wbd_dat    ),
          .m1_wbd_ack_o            (m1_s3_wb_rd.wbd_ack    ),
          .m1_wbd_lack_o           (m1_s3_wb_rd.wbd_lack   ),
          .m1_wbd_err_o            (m1_s3_wb_rd.wbd_err    ),
         
         // Master 2 Interface
          .m2_wbd_dat_i            (m2_wb_wr.wbd_dat       ),
          .m2_wbd_adr_i            (m2_wb_wr.wbd_adr       ),
          .m2_wbd_sel_i            (m2_wb_wr.wbd_sel       ),
          .m2_wbd_we_i             (m2_wb_wr.wbd_we        ),
          .m2_wbd_cyc_i            (m2_wb_wr.wbd_cyc       ),
          .m2_wbd_stb_i            (m2_wb_wr.wbd_stb       ),
	      .m2_wbd_tid_i            (m2_wb_wr.wbd_tid       ),
          .m2_wbd_dat_o            (m2_s3_wb_rd.wbd_dat    ),
          .m2_wbd_ack_o            (m2_s3_wb_rd.wbd_ack    ),
          .m2_wbd_lack_o           (m2_s3_wb_rd.wbd_lack   ),
          .m2_wbd_err_o            (m2_s3_wb_rd.wbd_err    ),

        
         
         // Slave  Interface
          .s_wbd_dat_i            (s3_wb_rd.wbd_dat        ),
          .s_wbd_ack_i            (s3_wb_rd.wbd_ack        ),
          .s_wbd_lack_i           (s3_wb_rd.wbd_ack        ),
          .s_wbd_dat_o            (s3_wb_wr.wbd_dat        ),
          .s_wbd_adr_o            (s3_wb_wr.wbd_adr        ),
          .s_wbd_sel_o            (s3_wb_wr.wbd_sel        ),
          .s_wbd_we_o             (s3_wb_wr.wbd_we         ),  
          .s_wbd_cyc_o            (s3_wb_wr.wbd_cyc        ),
          .s_wbd_stb_o            (s3_wb_wr.wbd_stb        )
        
	);


endmodule

