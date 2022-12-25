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
//   
//   MBIST wishbone Burst access to SRAM Write and Read access
//   Note: BUSRT crossing the SRAM boundary is not supported due to sram
//   2 cycle pipe line delay
//////////////////////////////////////////////////////////////////////

module mbist_wb
     #(  
     parameter BIST_NO_SRAM           = 4,
	 parameter BIST_ADDR_WD           = 9,
	 parameter BIST_DATA_WD           = 32) (

`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif


	input  logic                            rst_n,


    // WB I/F
    input   logic                          wb_clk_i,  // System clock
    input   logic                          wb_stb_i,  // strobe/request
    input   logic [14:0]                   wb_adr_i,  // address
    input   logic                          wb_we_i ,  // write
    input   logic [31:0]                   wb_dat_i,  // data output
    input   logic [3:0]                    wb_sel_i,  // byte enable
    input   logic [9:0]                    wb_bl_i,   // Burst Length
    input   logic                          wb_bry_i,  // Burst Ready
    output  logic [31:0]                   wb_dat_o,  // data input
    output  logic                          wb_ack_o,  // acknowlegement
    output  logic                          wb_lack_o, // acknowlegement
    output  logic                          wb_err_o,  // error

    // SRAM I/F
	output  logic                          mem_req,
	output  logic [(BIST_NO_SRAM+1)/2-1:0] mem_cs,
	output  logic [BIST_ADDR_WD-1:0]       mem_addr,
	output  logic [31:0]                   mem_wdata,
	output  logic                          mem_we,
	output  logic [3:0]                    mem_wmask,
	input   logic [31:0]                   mem_rdata,

    // Reg Interface
	output  logic                          reg_cs,
	output  logic [4:0]                    reg_addr,
	output  logic [31:0]                   reg_wdata,
	output  logic                          reg_wr,
	output  logic [3:0]                    reg_be,
    input   logic                          reg_ack,
	input   logic [31:0]                   reg_rdata

);

parameter IDLE              = 3'b000;
parameter MEM_WRITE_ACTION  = 3'b001;
parameter MEM_READ_ACTION1  = 3'b010;
parameter MEM_READ_ACTION2  = 3'b011;
parameter REG_ACTION        = 3'b100;


logic [9:0]                mem_bl_cnt     ;
logic                      wb_ack_l       ;
logic [BIST_ADDR_WD-1:0]   mem_next_addr;
logic [2:0]                state;
logic                      mem_hval;   // Mem Hold Data valid
logic [31:0]               mem_hdata;  // Mem Hold Data

// 0x0000_2000 to 0x0000_27FF  - SRAM-2KB - 0
// 0x0000_2800 to 0x0000_2FFF  - SRAM-2KB - 1
// 0x0000_3000 to 0x0000_37FF  - SRAM-2KB - 2
// 0x0000_3800 to 0x0000_3FFF  - SRAM-2KB - 3
// 0x0000_4000 to 0x0000_4FFF  - MBIST REG



always @(negedge rst_n, posedge wb_clk_i) begin
    if (~rst_n) begin
       mem_bl_cnt       <= 'h0;
       mem_addr         <= 'h0;
       mem_next_addr    <= 'h0;
	   wb_ack_o         <= 'b0;
       wb_ack_l         <= 'b0;
       wb_dat_o         <= 'h0;
	   wb_lack_o        <=  'b0;

       reg_cs           <= 'b0;
	   reg_addr         <=  'h0;
	   reg_wr           <=  'b0;
       reg_be           <=  'h0;
       reg_wdata        <=  'h0;

       mem_req          <= 'b0;
       mem_cs           <= 'b0;
       mem_wdata        <= 'h0; 
       mem_wmask        <= 'h0;
       mem_we           <= 'h0;
       mem_hval         <= 'b0;
       mem_hdata        <= 'h0;
       state            <= IDLE;
    end else begin
	case(state)
	 IDLE: begin
	       mem_bl_cnt  <=  'h1;
	       wb_ack_o    <=  'b0;
	       wb_lack_o   <=  'b0;
	       if(wb_stb_i && wb_adr_i[14:12] == 3'b0 && wb_bry_i && ~wb_we_i && !wb_lack_o) begin
           // REG READ
              reg_cs       <= 'b1;
	          reg_addr     <=  wb_adr_i[4:0];
		      reg_wr       <=  'b0;
	          state        <=  REG_ACTION;
	       end else if(wb_stb_i && wb_adr_i[14:12] == 3'b0 && wb_bry_i && wb_we_i && !wb_lack_o) begin
           // REG WRITE
              reg_cs       <= 'b1;
	          reg_addr     <=  wb_adr_i[4:0];
		      reg_wr       <=  'b1;
              reg_be       <=  wb_sel_i;
              reg_wdata    <=  wb_dat_i;
	          state        <=  REG_ACTION;
	       end else if(wb_stb_i && wb_adr_i[14:12] != 3'b0 && wb_bry_i && ~wb_we_i && !wb_lack_o) begin
           // MEM WRITE
	          mem_cs       <=  wb_adr_i[12:11];
	          mem_addr     <=  wb_adr_i[10:2];
              mem_wdata    <=  wb_dat_i; 
	          mem_req      <=  'b1;
		      mem_we       <=  'b0;
	          state        <=  MEM_READ_ACTION1;
	       end else if(wb_stb_i && wb_adr_i[14:12] != 3'b0 && wb_bry_i && wb_we_i && !wb_lack_o) begin
           // MEM READ
	          mem_cs       <=  wb_adr_i[12:11];
	          mem_next_addr<=  wb_adr_i[10:2];
		      mem_we       <=  'b1;
              mem_wmask    <=  wb_sel_i;
	          state        <=  MEM_WRITE_ACTION;
	       end else begin
	          mem_req      <=  1'b0;
               end
	    end

        REG_ACTION: begin
           if(reg_ack) begin
              reg_cs     <= 'b0;
		      wb_ack_o   <= 1'b1;
		      wb_lack_o  <= 1'b1;
              wb_dat_o   <= reg_rdata;
	          state      <= IDLE;
           end
        end

         MEM_WRITE_ACTION: begin
	    if (wb_stb_i && wb_bry_i ) begin
	       wb_ack_o     <=  'b1;
	       mem_req      <=  1'b1;
	       mem_addr     <=  mem_next_addr;
           mem_wdata    <=  wb_dat_i; 
	       if((wb_stb_i && wb_bry_i ) && (wb_bl_i == mem_bl_cnt)) begin
	           wb_lack_o   <=  'b1;
	           state       <= IDLE;
	       end else begin
	          mem_bl_cnt   <= mem_bl_cnt+1;
	          mem_next_addr<=  mem_next_addr+1;
	       end
            end else begin 
	       wb_ack_o     <=  'b0;
	       mem_req      <=  1'b0;
            end
         end
       MEM_READ_ACTION1: begin
	   mem_addr   <=  mem_addr +1;
       mem_hval   <= 1'b0;
	   wb_ack_l   <=  'b1;
	   mem_bl_cnt <=  'h1;
	   state      <=  MEM_READ_ACTION2;
       end

       // Wait for Ack from application layer
       MEM_READ_ACTION2: begin
           // If the not the last ack, update memory pointer
           // accordingly
	      wb_ack_l    <= wb_ack_o;
	      if (wb_stb_i && wb_bry_i ) begin
	         wb_ack_o   <= 1'b1;
	         mem_bl_cnt <= mem_bl_cnt+1;
	         mem_addr   <=  mem_addr +1;
	         if(wb_ack_l || wb_ack_o ) begin // If back to back ack 
                wb_dat_o     <= mem_rdata;
                mem_hval     <= 1'b0;
	         end else begin // Pick from previous holding data
                mem_hval     <= 1'b1;
                wb_dat_o     <= mem_hdata;
                mem_hdata    <= mem_rdata;
	         end
	         if((wb_stb_i && wb_bry_i ) && (wb_bl_i == mem_bl_cnt)) begin
	            wb_lack_o   <= 1'b1;
	            state       <= IDLE;
	         end
          end else begin
	         wb_ack_o   <= 1'b0;
	         if(!mem_hval) begin
                    mem_hdata  <= mem_rdata;
                    mem_hval   <= 1'b1;
	         end
          end
       end
       endcase
   end
end

endmodule
