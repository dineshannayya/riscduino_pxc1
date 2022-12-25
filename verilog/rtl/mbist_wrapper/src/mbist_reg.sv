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
////  MBIST REG register                                          ////
////                                                              ////
////                                                              ////
////  Description                                                 ////
////      This block holds mbist register                         ////
////                                                              ////
////  To Do:                                                      ////
////    nothing                                                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - Dinesh Annayya, dinesha@opencores.org                 ////
////                                                              ////
////  Revision :                                                  ////
////    0.1 - 20 Dec 2022  Dinesh A                               ////
////          Initial version                                     ////
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

module mbist_reg (

       input logic             mclk,
       input logic             reset_n,

        // Reg Bus Interface Signal
        input logic             reg_cs,
        input logic             reg_wr,
        input logic [3:0]       reg_addr,
        input logic [31:0]      reg_wdata,
        input logic [3:0]       reg_be,

       // Outputs
        output logic [31:0]     reg_rdata,
        output logic            reg_ack,

	    // BIST I/F
	    output logic            bist_en,
	    output logic            bist_run,
	    output logic            bist_load,

        output logic [1:0]      bist_serial_sel,
	    output logic            bist_sdi,
	    output logic            bist_shift,
	    input  logic            bist_sdo,

	    input logic             bist_done,
	    input logic [3:0]       bist_error,
	    input logic [3:0]       bist_correct,
	    input logic [3:0]       bist_error_cnt0,
	    input logic [3:0]       bist_error_cnt1,
	    input logic [3:0]       bist_error_cnt2,
	    input logic [3:0]       bist_error_cnt3

        );



//-----------------------------------------------------------------------
// Internal Wire Declarations
//-----------------------------------------------------------------------

logic           sw_rd_en    ;
logic           sw_wr_en    ;
logic  [1:0]    sw_addr     ; // addressing 16 registers
logic  [3:0]    wr_be       ;
logic  [31:0]   sw_reg_wdata;



logic [7:0]     cfg_bist_ctrl;    // BIST control
logic [31:0]    cfg_bist_status;  // BIST Status
logic [63:0]    serail_dout;      // BIST Serial Signature

logic [31:0]    reg_out;

//-----------------------------------------------------------------------
// Main code starts here
//-----------------------------------------------------------------------


//-----------------------------------------------------------------------
// register read enable and write enable decoding logic
//-----------------------------------------------------------------------

assign       sw_addr       = reg_addr [3:2];
assign       sw_rd_en      = reg_cs & !reg_wr;
assign       sw_wr_en      = reg_cs & reg_wr;
assign       wr_be         = reg_be;
assign       sw_reg_wdata  = reg_wdata;


wire   sw_wr_en_0 = sw_wr_en & (sw_addr == 2'h0);
wire   sw_rd_en_0 = sw_rd_en & (sw_addr == 2'h0);
wire   sw_wr_en_1 = sw_wr_en & (sw_addr == 2'h1);
wire   sw_rd_en_1 = sw_rd_en & (sw_addr == 2'h1);
wire   sw_wr_en_2 = sw_wr_en & (sw_addr == 2'h2);
wire   sw_rd_en_2 = sw_rd_en & (sw_addr == 2'h2);
wire   sw_wr_en_3 = sw_wr_en & (sw_addr == 2'h3);
wire   sw_rd_en_3 = sw_rd_en & (sw_addr == 2'h3);


logic wb_req;
logic wb_req_d;
logic wb_req_pedge;

always_ff @(negedge reset_n or posedge mclk) begin
    if ( reset_n == 1'b0 ) begin
        wb_req    <= '0;
	wb_req_d  <= '0;
   end else begin
       wb_req   <= reg_cs && (reg_ack == 0) ;
       wb_req_d <= wb_req;
   end
end

// Detect pos edge of request
assign wb_req_pedge = (wb_req_d ==0) && (wb_req==1'b1);
//-----------------------------------------------------------------
// Reg 2 are BIST Serial I/F register and it takes minimum 64
// cycle to respond ACK back
// ----------------------------------------------------------------
wire ser_acc     = sw_rd_en_2;
wire non_ser_acc = reg_cs ? !ser_acc : 1'b0;
wire serial_ack;

always @ (posedge mclk or negedge reset_n)
begin : preg_out_Seq
   if (reset_n == 1'b0) begin
      reg_rdata  <= 'h0;
      reg_ack    <= 1'b0;
   end else if (ser_acc && serial_ack)  begin
      reg_rdata <= reg_out ;
      reg_ack   <= 1'b1;
   end else if (non_ser_acc && !reg_ack) begin
      reg_rdata <= reg_out ;
      reg_ack   <= 1'b1;
   end else begin
      reg_ack        <= 1'b0;
   end
end

always @( *)
begin 
  reg_out [31:0] = 32'h0;

  case (sw_addr [1:0])
    2'b00 :   reg_out [31:0] = {24'h0,cfg_bist_ctrl};
    2'b01 :   reg_out [31:0] = cfg_bist_status [31:0];     
    2'b10 :   reg_out [31:0] = serail_dout[31:0];  // Lower Shift
    2'b11 :   reg_out [31:0] = serail_dout[63:32]; // Upper Shift 
    default : reg_out [31:0] = 'h0;
  endcase
end


//-----------------------------------------------------------------------
//   reg-0
//   -----------------------------------------------------------------
generic_register #(8,8'h0  ) u_reg0_be0 (
	      .we            ({8{sw_wr_en_0 & 
                                 wr_be[0]   }}  ),		 
	      .data_in       (sw_reg_wdata[7:0]     ),
	      .reset_n       (reset_n               ),
	      .clk           (mclk                  ),
	      
	      //List of Outs
	      .data_out      (cfg_bist_ctrl[7:0]    )
          );


assign bist_en          = cfg_bist_ctrl[0];
assign bist_run         = cfg_bist_ctrl[1];
assign bist_load        = cfg_bist_ctrl[2];
assign bist_serial_sel  = cfg_bist_ctrl[4:3];


//-----------------------------------------------------------------------
//   reg-1
//-----------------------------------------------------------------

assign cfg_bist_status = {  bist_error_cnt3, 1'b0, bist_correct[3], bist_error[3], bist_done,
	                        bist_error_cnt2, 1'b0, bist_correct[2], bist_error[2], bist_done,
	                        bist_error_cnt1, 1'b0, bist_correct[1], bist_error[1], bist_done,
	                        bist_error_cnt0, 1'b0, bist_correct[0], bist_error[0], bist_done
			             };

//-----------------------------------------------------------------------
//   reg-2 => 1st 32 BIST READ from Serial I/F
//   reg-3 => 2nd 32 Bist READ  from Serail I/F
//-----------------------------------------------------------------
wire   bist_sdi_int;
wire   bist_shift_int;
wire   bist_sdo_int;

assign bist_sdo_int = bist_sdo;
assign  bist_shift = bist_shift_int ;
assign  bist_sdi   = 1'b0 ; // Need fix - Dinesh A

/*** Need Fix for Serial Out 
ser_inf_32b u_ser_intf
       (

    // Master Port
       .rst_n       (reset_n),  // Regular Reset signal
       .clk         (mclk),  // System clock
       .reg_wr      (sw_wr_en_6 & wb_req_pedge),  // Write Request
       .reg_rd      (1;b0),  // Read Request
       .reg_wdata   (reg_wdata) ,  // data output
       .reg_rdata   (serail_dout),  // data input
       .reg_ack     (serial_ack),  // acknowlegement

    // Slave Port
       .sdi         (bist_sdi_int),    // Serial SDI
       .shift       (bist_shift_int),  // Shift Signal
       .sdo         (bist_sdo_int) // Serial SDO

    );
****/

ser_rd_inf_64b u_ser_intf
       (

    // Master Port
       .rst_n       (reset_n),  // Regular Reset signal
       .clk         (mclk),  // System clock
       .reg_rd      (sw_rd_en_2 & wb_req_pedge),  // Read Request
       .reg_rdata   (serail_dout),  // data input
       .reg_ack     (serial_ack),  // acknowlegement

    // Slave Port
       .shift       (bist_shift_int),  // Shift Signal
       .sdo         (bist_sdo_int) // Serial SDO

    );


endmodule
