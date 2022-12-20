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
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  ser_rd_inf_64                                                  ////
////                                                              ////
////  This file is part of the mbist_ctrl cores project           ////
////  https://github.com/dineshannayya/mbist_ctrl.git             ////
////                                                              ////
////  Description                                                 ////
////   This block manages the serial to Parallel conversion       ////
////   This block usefull for Bist SDI/SDO access                 ////
////   Function:                                                  ////
////      1. When reg_rd=1, this block set shoft=1 and serial     ////
////         capture the sdo to reg_rdata for 64 cycles and       ////
////         asserts Reg Ack                                      ////
////                                                              ////
////  To Do:                                                      ////
////    nothing                                                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - Dinesh Annayya, dinesha@opencores.org                 ////
////                                                              ////
////  Revision :                                                  ////
////    0.0 - 20th Oct 2021, Dinesh A                             ////
////          Initial integration                                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

module ser_rd_inf_64b
       (

    // Master Port
       input   logic               rst_n       ,  // Regular Reset signal
       input   logic               clk         ,  // System clock
       input   logic               reg_rd      ,  // Read Request
       output  logic [63:0]        reg_rdata   ,  // data input
       output  logic               reg_ack     ,  // acknowlegement

    // Slave Port
       output  logic               shift       ,  // Shift Signal
       input   logic               sdo            // Serial SDO

    );


    parameter IDLE = 1'b0;
    parameter SHIFT_DATA = 1'b1;

    logic        state;
    logic [6:0]  bit_cnt;


always@(negedge rst_n or posedge clk)
begin
   if(rst_n == 0) begin
      state     <= IDLE;
      reg_rdata <= 'h0;
      reg_ack   <= 1'b0;
      bit_cnt   <= 'h0;
      shift     <= 'b0;
   end else begin
       case(state)
       IDLE: begin
           reg_ack <= 1'b0;
           bit_cnt    <= 6'h0;
           if(reg_rd) begin
              shift      <= 'b1;
	          state      <= SHIFT_DATA;
	       end
	     end
        SHIFT_DATA: begin 
		    reg_rdata  <= {sdo,reg_rdata[63:1]};
            if(bit_cnt < 63) begin
		       bit_cnt    <= bit_cnt +1;
	        end else begin
               reg_ack <= 1'b1;
               shift   <= 'b0;
               state   <= IDLE;
	        end
	     end
       endcase
   end
end




endmodule
