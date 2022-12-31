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
////  Global confg register                                       ////
////                                                              ////
////  This file is part of the mbist_ctrl  project                ////
////  https://github.com/dineshannayya/mbist_ctrl.git             ////
////                                                              ////
////  Description                                                 ////
////      This block generate all the global config and status    ////
////                                                              ////
////  To Do:                                                      ////
////    nothing                                                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - Dinesh Annayya, dinesha@opencores.org                 ////
////                                                              ////
////  Revision :                                                  ////
////    0.1 - 18 Nov 2021  Dinesh A                               ////
////          Initial version                                     ////
////   0.2  - 27 Nov 2021, Dinesh A                               ////
////          Scan Ports added & Chip ID change to LBST           ////
////                                                              ////
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

module glbl_cfg (

`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

       input logic             mclk,
       input logic             reset_n,

        // Reg Bus Interface Signal
        input logic             reg_cs,
        input logic             reg_wr,
        input logic [7:0]       reg_addr,
        input logic [31:0]      reg_wdata,
        input logic [3:0]       reg_be,

       // Outputs
        output logic [31:0]     reg_rdata,
        output logic            reg_ack,

        output logic [31:0]     cfg_mac_clk_ctrl


        );



//-----------------------------------------------------------------------
// Internal Wire Declarations
//-----------------------------------------------------------------------

logic           sw_rd_en    ;
logic           sw_wr_en    ;
logic  [3:0]    sw_addr     ; // addressing 16 registers
logic  [3:0]    wr_be       ;
logic  [31:0]   sw_reg_wdata;



logic [31:0]    reg_0;            // Software_Reg 0
logic [31:0]    reg_1;            // Software Reg 1
logic [31:0]    reg_8;            // Software Reg 1
logic [31:0]    reg_9;            // Software_Reg 9
logic [31:0]    reg_10;           // Software Reg 10
logic [31:0]    reg_11;           // Software Reg 11

logic [31:0]    reg_out;

//-----------------------------------------------------------------------
// Main code starts here
//-----------------------------------------------------------------------



//-----------------------------------------------------------------------
// register read enable and write enable decoding logic
//-----------------------------------------------------------------------

assign       sw_addr       = reg_addr [5:2];
assign       sw_rd_en      = reg_cs & !reg_wr;
assign       sw_wr_en      = reg_cs & reg_wr;
assign       wr_be         = reg_be;
assign       sw_reg_wdata  = reg_wdata;


wire   sw_wr_en_0 = sw_wr_en & (sw_addr == 4'h0);
wire   sw_rd_en_0 = sw_rd_en & (sw_addr == 4'h0);
wire   sw_wr_en_1 = sw_wr_en & (sw_addr == 4'h1);
wire   sw_rd_en_1 = sw_rd_en & (sw_addr == 4'h1);
wire   sw_wr_en_2 = sw_wr_en & (sw_addr == 4'h2);
wire   sw_rd_en_2 = sw_rd_en & (sw_addr == 4'h2);
wire   sw_wr_en_3 = sw_wr_en & (sw_addr == 4'h3);
wire   sw_rd_en_3 = sw_rd_en & (sw_addr == 4'h3);
wire   sw_wr_en_4 = sw_wr_en & (sw_addr == 4'h4);
wire   sw_rd_en_4 = sw_rd_en & (sw_addr == 4'h4);
wire   sw_wr_en_5 = sw_wr_en & (sw_addr == 4'h5);
wire   sw_rd_en_5 = sw_rd_en & (sw_addr == 4'h5);
wire   sw_wr_en_6 = sw_wr_en & (sw_addr == 4'h6);
wire   sw_rd_en_6 = sw_rd_en & (sw_addr == 4'h6);
wire   sw_wr_en_7 = sw_wr_en & (sw_addr == 4'h7);
wire   sw_rd_en_7 = sw_rd_en & (sw_addr == 4'h7);
wire   sw_wr_en_8 = sw_wr_en & (sw_addr == 4'h8);
wire   sw_wr_en_9 = sw_wr_en & (sw_addr == 4'h9);
wire   sw_wr_en_10 = sw_wr_en & (sw_addr == 4'hA);
wire   sw_wr_en_11 = sw_wr_en & (sw_addr == 4'hB);


always @ (posedge mclk or negedge reset_n)
begin : preg_out_Seq
   if (reset_n == 1'b0) begin
      reg_rdata  <= 'h0;
      reg_ack    <= 1'b0;
   end else if (reg_cs && !reg_ack) begin
      reg_rdata <= reg_out ;
      reg_ack   <= 1'b1;
   end else begin
      reg_ack        <= 1'b0;
   end
end

always @( *)
begin 
  reg_out [31:0] = 32'h0;

  case (sw_addr [3:0])
    4'b0000 :   reg_out [31:0] = reg_0;
    4'b0001 :   reg_out [31:0] = reg_1;
    4'b1000 :   reg_out [31:0] = reg_8; // Software Reg1
    4'b1001 :   reg_out [31:0] = reg_9; // Software Reg1
    4'b1010 :   reg_out [31:0] = reg_10; // Software Reg2
    4'b1011 :   reg_out [31:0] = reg_11; // Software Reg3
    default : reg_out [31:0] = 'h0;
  endcase
end


//-----------------------------------------------------------------------
// Individual register assignments
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//   reg-0
//   -----------------------------------------------------------------
generic_register #(8,8'h11  ) u_reg0_be0 (
	      .we            ({8{sw_wr_en_0 & 
                                 wr_be[0]   }}  ),		 
	      .data_in       (sw_reg_wdata[7:0]    ),
	      .reset_n       (reset_n           ),
	      .clk           (mclk              ),
	      
	      //List of Outs
	      .data_out      (reg_0[7:0]        )
          );

generic_register #(8,8'h22  ) u_reg0_be1 (
	      .we            ({8{sw_wr_en_0 & 
                                 wr_be[1]   }}  ),		 
	      .data_in       (sw_reg_wdata[15:8]    ),
	      .reset_n       (reset_n           ),
	      .clk           (mclk              ),
	      
	      //List of Outs
	      .data_out      (reg_0[15:8]        )
          );
generic_register #(8,8'h33  ) u_reg0_be2 (
	      .we            ({8{sw_wr_en_0 & 
                                 wr_be[2]   }}  ),		 
	      .data_in       (sw_reg_wdata[23:16]    ),
	      .reset_n       (reset_n           ),
	      .clk           (mclk              ),
	      
	      //List of Outs
	      .data_out      (reg_0[23:16]        )
          );

generic_register #(8,8'h44  ) u_reg0_be3 (
	      .we            ({8{sw_wr_en_0 & 
                                 wr_be[3]   }}  ),		 
	      .data_in       (sw_reg_wdata[31:24]    ),
	      .reset_n       (reset_n           ),
	      .clk           (mclk              ),
	      
	      //List of Outs
	      .data_out      (reg_0[31:24]        )
          );

//-----------------------------------------------------------------------
//   reg-1
//   -----------------------------------------------------------------
generic_register #(8,8'hAA  ) u_reg1_be0 (
	      .we            ({8{sw_wr_en_1 & 
                                 wr_be[0]   }}  ),		 
	      .data_in       (sw_reg_wdata[7:0]    ),
	      .reset_n       (reset_n           ),
	      .clk           (mclk              ),
	      
	      //List of Outs
	      .data_out      (reg_1[7:0]        )
          );

generic_register #(8,8'hBB  ) u_reg1_be1 (
	      .we            ({8{sw_wr_en_1 & 
                                 wr_be[1]   }}  ),		 
	      .data_in       (sw_reg_wdata[15:8]    ),
	      .reset_n       (reset_n           ),
	      .clk           (mclk              ),
	      
	      //List of Outs
	      .data_out      (reg_1[15:8]        )
          );
generic_register #(8,8'hCC  ) u_reg1_be2 (
	      .we            ({8{sw_wr_en_1 & 
                                 wr_be[2]   }}  ),		 
	      .data_in       (sw_reg_wdata[23:16]    ),
	      .reset_n       (reset_n           ),
	      .clk           (mclk              ),
	      
	      //List of Outs
	      .data_out      (reg_1[23:16]        )
          );

generic_register #(8,8'hDD  ) u_reg1_be3 (
	      .we            ({8{sw_wr_en_1 & 
                                 wr_be[3]   }}  ),		 
	      .data_in       (sw_reg_wdata[31:24]    ),
	      .reset_n       (reset_n           ),
	      .clk           (mclk              ),
	      
	      //List of Outs
	      .data_out      (reg_1[31:24]        )
          );


//---------------------------------------------
// Reg-8: Mac clock control
//---------------------------------------------
gen_32b_reg  #(32'h0) u_reg_8	(
	      //List of Inputs
	      .reset_n    (reset_n       ),
	      .clk        (mclk          ),
	      .cs         (sw_wr_en_8    ),
	      .we         (wr_be         ),		 
	      .data_in    (sw_reg_wdata  ),
	      
	      //List of Outs
	      .data_out   (reg_8       )
	      );

assign cfg_mac_clk_ctrl = reg_8;

//-----------------------------------------
// Software Reg-1 : Signature
// ----------------------------------------
gen_32b_reg  #(CHIP_SIGNATURE) u_reg_9	(
	      //List of Inputs
	      .reset_n    (reset_n       ),
	      .clk        (mclk          ),
	      .cs         (sw_wr_en_9    ),
	      .we         (wr_be         ),		 
	      .data_in    (sw_reg_wdata  ),
	      
	      //List of Outs
	      .data_out   (reg_9       )
	      );

//-----------------------------------------
// Software Reg-2, Release date: <DAY><MONTH><YEAR>
// ----------------------------------------
gen_32b_reg  #(CHIP_RELEASE_DATE) u_reg_10	(
	      //List of Inputs
	      .reset_n    (reset_n       ),
	      .clk        (mclk          ),
	      .cs         (sw_wr_en_10   ),
	      .we         (wr_be         ),		 
	      .data_in    (sw_reg_wdata  ),
	      
	      //List of Outs
	      .data_out   (reg_10       )
	      );

//-----------------------------------------
// Software Reg-3: Poject Revison 1.6 = 0001600
// ----------------------------------------
gen_32b_reg  #(CHIP_REVISION) u_reg_11	(
	      //List of Inputs
	      .reset_n    (reset_n       ),
	      .clk        (mclk          ),
	      .cs         (sw_wr_en_11   ),
	      .we         (wr_be         ),		 
	      .data_in    (sw_reg_wdata  ),
	      
	      //List of Outs
	      .data_out   (reg_11       )
	      );

endmodule
