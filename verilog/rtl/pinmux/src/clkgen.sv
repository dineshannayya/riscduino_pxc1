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
///
// Clock Generation Block
//
//////////////////////////////////////////////////////////////////////

module clkgen (

   // Global Reset/clok
      input logic        reset_n,
      input logic        mclk,

    // Clock from Pad
      input logic       pad_mac_tx_clk,
      input logic       pad_mac_rx_clk,

    // Configuration
      input logic [1:0] cfg_mac_tx_clk_sel,
      input logic [1:0] cfg_mac_rx_clk_sel,
      input logic [1:0] cfg_mac_mdio_refclk_sel,
      input logic [7:0] cfg_mdio_clk_div_ratio,

      output logic      mac_rx_clk,
      output logic      mac_tx_clk,
      output logic      mdio_clk

   );
      



//------------------------------------------------
//  GMAC Clock Generation
//  ----------------------------------------------

// wire mac_rx_clk_int =  (cfg_mac_rx_clk_sel == 2'b00) ? pad_mac_rx_clk :
//                        (cfg_mac_rx_clk_sel == 2'b01) ? pad_mac_tx_clk : mclk;

ctech_mux4x1 u_mac_rxclk_mux (.A00(pad_mac_rx_clk), 
                              .A01(pad_mac_tx_clk),
                              .A10(mclk),
                              .A11(mclk),
                              .S(cfg_mac_rx_clk_sel),
                              .X (mac_rx_clk)
                              );



//wire mac_tx_clk =  (cfg_mac_tx_clk_sel == 2'b00) ? pad_mac_tx_clk :
//                   (cfg_mac_tx_clk_sel == 2'b01) ? pad_mac_rx_clk : mclk;

ctech_mux4x1 u_mac_txclk_mux (.A00(pad_mac_tx_clk), 
                              .A01(pad_mac_rx_clk),
                              .A10(mclk),
                              .A11(mclk),
                              .S(cfg_mac_tx_clk_sel),
                              .X (mac_tx_clk)
                              );

//-----------------------------------
// MDIO Clock Generation
//-----------------------------------

wire mdio_clk_int,mdio_ref_clk;
//wire mdio_ref_clk =  (cfg_mac_tx_clk_sel == 2'b00) ? pad_mac_tx_clk :
//                     (cfg_mac_tx_clk_sel == 2'b01) ? pad_mac_rx_clk : mclk;
//
ctech_mux4x1 u_mdio_ref_mux (.A00(pad_mac_tx_clk), 
                             .A01(pad_mac_rx_clk),
                             .A10(mclk),
                             .A11(mclk),
                             .S(cfg_mac_mdio_refclk_sel),
                             .X (mdio_ref_clk)
                              );

ctech_clk_buf u_mdio_clkbuf (.A (mdio_clk_int), . X(mdio_clk));
clk_ctl #(.WD(7)) U_CLK_MDIO (
   // Outputs
       .clk_o         (mdio_clk_int             ),
   // Inputs
       .mclk          (mdio_ref_clk             ), 
       .reset_n       (reset_n                  ), 
       .clk_div_ratio (cfg_mdio_clk_div_ratio   )
   );

endmodule


