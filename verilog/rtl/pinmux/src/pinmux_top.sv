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
////  Pinmux                                                      ////
////                                                              ////
////                                                              ////
////  Description                                                 ////
////      PinMux Manages all the pin multiplexing                 ////
////                                                              ////
////  To Do:                                                      ////
////    nothing                                                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - Dinesh Annayya, dinesha@opencores.org                 ////
////                                                              ////
////  Revision :                                                  ////
////    0.1 - 31th Dec 2022, Dinesh A                             ////
////          initial version                                     ////
////    0.2 - 03 Jan 2023, Dinesh A                               ////
////          Stepper Motor Integrated                            ////
//////////////////////////////////////////////////////////////////////
`include "user_params.svh"

module pinmux_top #(parameter SCW = 8   // SCAN CHAIN WIDTH
     ) (

`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

       input logic             mclk,
       input logic             reset_n,

       // Scan I/F
       input logic             scan_en,
       input logic             scan_mode,
       input logic [SCW-1:0]   scan_si,
       output logic [SCW-1:0]  scan_so,
       output logic            scan_en_o,
       output logic            scan_mode_o,

	// Clock Skew Adjust
       input   logic           wbd_clk_int      , 
       input  logic [3:0]      cfg_cska_pinmux,
       output  logic           wbd_clk_skew     , // clock skew adjust for web host


        // Reg Bus Interface Signal
        input logic             reg_cs,
        input logic             reg_wr,
        input logic [7:0]       reg_addr,
        input logic [31:0]      reg_wdata,
        input logic [3:0]       reg_be,

       // Outputs
        output logic [31:0]     reg_rdata,
        output logic            reg_ack,


    //-----------------------------------------------------------------------
    // MAC-Tx Signal
    //-----------------------------------------------------------------------
    input  logic         mac_tx_en      ,
    input  logic         mac_tx_er      ,
    input  logic [7:0]   mac_txd        ,
    output logic	     mac_tx_clk     ,
                   
    //-----------------------------------------------------------------------
    // MAC-Rx Signal
    //-----------------------------------------------------------------------
    output  logic	    mac_rx_clk     ,
    output  logic	    mac_rx_er      ,
    output  logic	    mac_rx_dv      ,
    output  logic [7:0] mac_rxd        ,
    output  logic	    mac_crs        ,
                   
                   
    //-----------------------------------------------------------------------
    // MDIO Signal
    //-----------------------------------------------------------------------
    output  logic	   mdio_clk        ,
    output  logic      mdio_in         ,
    input   logic      mdio_out_en     ,
    input   logic      mdio_out        ,
    //-------------------------------------
    // Master UART TXD
    //-------------------------------------
    output  logic      uartm_rxd       ,
    input   logic      uartm_txd       ,
 
    //-------------------------------------
    // SPI SLAVE
    //-------------------------------------
    output   logic     spis_sck,
    output   logic     spis_ssn,
    input    logic     spis_miso,
    output   logic     spis_mosi,


    //-------------------------------------
    // External IO
    //-------------------------------------
    input  [37:0]      io_in           ,
    output [37:0]      io_out          ,
    output [37:0]      io_oeb


        );


`define SEL_GLBL  2'b00
`define SEL_SM    2'b01

logic [1:0]  cfg_mac_tx_clk_sel;
logic [1:0]  cfg_mac_rx_clk_sel;
logic [1:0]  cfg_mac_mdio_refclk_sel;
logic [7:0]  cfg_mdio_clk_div_ratio;
logic        pad_mac_tx_clk;
logic        pad_mac_rx_clk;
logic [31:0] cfg_mac_clk_ctrl;
logic        reset_ssn;

//----------------------------------------
//  Register Response Path Mux
//  --------------------------------------
logic         reg_glbl_cs ;
logic [31:0]  reg_glbl_rdata;
logic         reg_glbl_ack;

logic         reg_sm_cs ;
logic [31:0]  reg_sm_rdata;
logic         reg_sm_ack;


//------------------------------
// Stepper Motor Variable
//------------------------------
logic sm_a1              ;  
logic sm_a2              ;  
logic sm_b1              ;  
logic sm_b2              ;  
//-----------------------------------------------------------------------
// Main code starts here
//-----------------------------------------------------------------------


assign scan_en_o = scan_en;
assign scan_mode_o = scan_mode;

//--------------------------------------
// wb_host clock skew control
//--------------------------------------
clk_skew_adjust u_skew_glbl
       (
`ifdef USE_POWER_PINS
          .vccd1              (vccd1              ),// User area 1 1.8V supply
          .vssd1              (vssd1              ),// User area 1 digital ground
`endif
          .clk_in             (wbd_clk_int        ), 
          .sel                (cfg_cska_pinmux    ), 
          .clk_out            (wbd_clk_skew       ) 
       );

reset_sync  u_rst_sync (
          .scan_mode          (1'b0               ),
          .dclk               (mclk               ), // Destination clock domain
          .arst_n             (reset_n            ), // active low async reset
          .srst_n             (reset_ssn          )
          );

//--------------------------------------
// Global Register
//-------------------------------------
glbl_cfg u_glbl(
`ifdef USE_POWER_PINS
          .vccd1              (vccd1              ),// User area 1 1.8V supply
          .vssd1              (vssd1              ),// User area 1 digital ground
`endif

          .mclk               (mclk               ),
          .reset_n            (reset_ssn          ),

        // Reg Bus Interface Signal
          .reg_cs             (reg_glbl_cs        ),
          .reg_wr             (reg_wr             ),
          .reg_addr           (reg_addr[5:0]      ),
          .reg_wdata          (reg_wdata          ),
          .reg_be             (reg_be             ),

       // Outputs
          .reg_rdata          (reg_glbl_rdata     ),
          .reg_ack            (reg_glbl_ack       ),

          .cfg_mac_clk_ctrl   (cfg_mac_clk_ctrl   )

    );



assign cfg_mac_tx_clk_sel      = cfg_mac_clk_ctrl[1:0];
assign cfg_mac_rx_clk_sel      = cfg_mac_clk_ctrl[3:2];
assign cfg_mac_mdio_refclk_sel = cfg_mac_clk_ctrl[5:4];
assign cfg_mdio_clk_div_ratio  = cfg_mac_clk_ctrl[15:8];

//-------------------------------------------------------
// Stepper Motor Controller
//-------------------------------------------------------

sm_ctrl u_sm (

          .rst_n              (reset_ssn          ),            
          .clk                (mclk               ),            

  // Wishbone bus
          .wbs_cyc_i          (reg_sm_cs          ),            
          .wbs_stb_i          (reg_sm_cs          ),            
          .wbs_adr_i          (reg_addr[4:0]      ), 
          .wbs_we_i           (reg_wr             ), 
          .wbs_dat_i          (reg_wdata          ), 
          .wbs_sel_i          (reg_be             ), 
          .wbs_dat_o          (reg_sm_rdata       ), 
          .wbs_ack_o          (reg_sm_ack         ), 

  // Motor outputs
          .motor_a1           (sm_a1              ),  
          .motor_a2           (sm_a2              ),  
          .motor_b1           (sm_b1              ),  
          .motor_b2           (sm_b2              )   

);


//------------------------------------------
// clock gen
//-----------------------------------------

clkgen u_clkgen ( 

   // Global Reset/clok
      .reset_n                 (reset_ssn               ),
      .mclk                    (mclk                    ),

    // Clock from Pad
      .pad_mac_tx_clk          (pad_mac_tx_clk          ),
      .pad_mac_rx_clk          (pad_mac_rx_clk          ),

    // Configuration
      .cfg_mac_tx_clk_sel      (cfg_mac_tx_clk_sel      ),
      .cfg_mac_rx_clk_sel      (cfg_mac_rx_clk_sel      ),
      .cfg_mac_mdio_refclk_sel (cfg_mac_mdio_refclk_sel ),
      .cfg_mdio_clk_div_ratio  (cfg_mdio_clk_div_ratio  ),

      .mac_rx_clk              (mac_rx_clk              ),
      .mac_tx_clk              (mac_tx_clk              ),
      .mdio_clk                (mdio_clk                )

   );


//----------------------------------------
// pinmux
//---------------------------------------

pinmux u_pinmux(

    //-----------------------------------------------------------------------
    // MAC-Tx Signal
    //-----------------------------------------------------------------------
          .mac_tx_clk         (pad_mac_tx_clk     ),
          .mac_tx_en          (mac_tx_en          ),
          .mac_tx_er          (mac_tx_er          ),
          .mac_txd            (mac_txd            ),
                   
    //-----------------------------------------------------------------------
    // MAC-Rx Signal
    //-----------------------------------------------------------------------
          .mac_rx_clk         (pad_mac_rx_clk     ),
          .mac_rx_er          (mac_rx_er          ),
          .mac_rx_dv          (mac_rx_dv          ),
          .mac_rxd            (mac_rxd            ),
          .mac_crs            (mac_crs            ),
                   
                   
    //-----------------------------------------------------------------------
    // MDIO Signal
    //-----------------------------------------------------------------------
          .mdio_clk           (mdio_clk           ),
          .mdio_in            (mdio_in            ),
          .mdio_out_en        (mdio_out_en        ),
          .mdio_out           (mdio_out           ),

    //-------------------------------------
    // Master UART TXD
    //-------------------------------------
          .uartm_rxd          (uartm_rxd          ),
          .uartm_txd          (uartm_txd          ),

    //-------------------------------------
    // SPI SLAVE
    //-------------------------------------
          .spis_sck           (spis_sck           ),
          .spis_ssn           (spis_ssn           ),
          .spis_miso          (spis_miso          ),
          .spis_mosi          (spis_mosi          ),


    //-------------------------------------
    // External IO
    //-------------------------------------
          .io_in              (io_in              ),
          .io_out             (io_out             ),
          .io_oeb             (io_oeb             ),
                                
    //-------------------------------------
    // Stpper Motor outputs
    //-------------------------------------
          .sm_a1              (sm_a1              ),  
          .sm_a2              (sm_a2              ),  
          .sm_b1              (sm_b1              ),  
          .sm_b2              (sm_b2              )   



);

//-------------------------------------------------
// Register Block Selection Logic
//-------------------------------------------------
reg [1:0] reg_blk_sel;

always @(posedge mclk or negedge reset_ssn)
begin
   if(reset_ssn == 1'b0) begin
     reg_blk_sel <= 'h0;
   end
   else begin
      if(reg_cs) reg_blk_sel <= reg_addr[7:6];
   end
end

assign reg_rdata = (reg_blk_sel    == `SEL_GLBL)  ? {reg_glbl_rdata} : 
	               (reg_blk_sel    == `SEL_SM)    ? {reg_sm_rdata} :
	               'h0;

assign reg_ack   = (reg_blk_sel    == `SEL_GLBL)  ? reg_glbl_ack   : 
	               (reg_blk_sel    == `SEL_SM)    ? reg_sm_ack   : 
	               1'b0;

assign reg_glbl_cs  = (reg_addr[7:6] == `SEL_GLBL) ? reg_cs : 1'b0;
assign reg_sm_cs    = (reg_addr[7:6] == `SEL_SM)   ? reg_cs : 1'b0;






endmodule

