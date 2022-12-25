////////////////////////////////////////////////////////////////////////////
// SPDX-FileCopyrightText:  2021 , Dinesh Annayya
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
// SPDX-FileContributor: Modified by Dinesh Annayya <dinesha@opencores.org>
//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Standalone User validation Test bench                       ////
////                                                              ////
////                                                              ////
////  Description                                                 ////
////   This is a standalone test bench to validate the            ////
////   Digital core MBIST logic through External WB i/F.          ////
////   This test validate 8KB SRAM connected to mbist1 wrapper    ////
////                                                              ////
////  To Do:                                                      ////
////    nothing                                                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - Dinesh Annayya, dinesha@opencores.org                 ////
////                                                              ////
////  Revision :                                                  ////
////    0.1 - 18 Oct 2021, Dinesh A                               ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

`default_nettype wire

`timescale 1 ns / 1 ps

`include "./sram_macros/sky130_sram_2kbyte_1rw1r_32x512_8.v"
`include "user_reg_map.v"

`define NO_SRAM 4  // Number of SRAM connected to MBIST WRAPPER
`define SRAM_AD 9  // SRAM ADDRESS WIDTH

`define TB_TOP user_mbist_test2_tb
`define TB_GLBL         `TB_TOP.tb_glbl

`include "./tb_glbl.v"
module `TB_TOP;

	reg clock;
	reg wb_rst_i;
	reg power1, power2;
	reg power3, power4;

        reg        wbd_ext_cyc_i;  // strobe/request
        reg        wbd_ext_stb_i;  // strobe/request
        reg [31:0] wbd_ext_adr_i;  // address
        reg        wbd_ext_we_i;  // write
        reg [31:0] wbd_ext_dat_i;  // data output
        reg [3:0]  wbd_ext_sel_i;  // byte enable

        wire [31:0] wbd_ext_dat_o;  // data input
        wire        wbd_ext_ack_o;  // acknowlegement
        wire        wbd_ext_err_o;  // error

	// User I/O
	wire [37:0] io_oeb;
	wire [37:0] io_out;
	wire [37:0] io_in;

	wire gpio;
	wire [37:0] mprj_io;
	wire [7:0] mprj_io_0;
	reg [31:0] read_data;
    reg [31:0] writemem [0:511];
    reg [`SRAM_AD-1:0]  faultaddr [0:7];
        integer i;
        event      error_insert;


	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
                wbd_ext_cyc_i ='h0;  // strobe/request
                wbd_ext_stb_i ='h0;  // strobe/request
                wbd_ext_adr_i ='h0;  // address
                wbd_ext_we_i  ='h0;  // write
                wbd_ext_dat_i ='h0;  // data output
                wbd_ext_sel_i ='h0;  // byte enable
	end

	`ifdef WFDUMP
	   initial begin
	   	$dumpfile("simx.vcd");
	   	$dumpvars(0, `TB_TOP);
	   end
    `endif

	initial begin
		wb_rst_i <= 1'b1;
		#100;
		wb_rst_i <= 1'b0;	    	// Release reset
        tb_glbl.init;

		#200; // Wait for reset removal
	        repeat (10) @(posedge clock);
		$display("Monitor: Standalone User Test Started");

		// Remove Wb Reset
		wb_user_core_write(`ADDR_SPACE_WBHOST+`WBHOST_GLBL_CFG,'h1);
        

	    	$display("###################################################");
	    	$display(" MBIST Test with Without Address Failure");
	    	$display("###################################################");

		// Check Is there is any BIST Error
		// [0]   - Bist Done      - 1
		// [1]   - Bist Error     - 0
		// [2]   - Bist Correct   - 0
		// [3]   - Reserved       - 0
		// [7:4] - Bist Error Cnt - 4'h0
		insert_fault(0,0,32'h01010101);

          	if(`TB_GLBL.err_count == 0) begin
	    	    $display("Monitor: Step-1: BIST Test without any Memory Error insertion test Passed");
	        end else begin
	    	    $display("Monitor: Step-1: BIST Test without any Memory Error insertion test Failed");
		end
		$dumpon;
	    	$display("###################################################");
	    	$display(" MBIST Test with Single Address Failure");
	    	$display("###################################################");
		   // Check Is there is any BIST Error
		   // [0]   - Bist Done      - 1
		   // [1]   - Bist Error     - 0
		   // [2]   - Bist Correct   - 1
		   // [3]   - Reserved       - 0
		   // [7:4] - Bist Error Cnt - 4'h1
		   //if(read_data[6:0]  != 7'b0001101) test_fail = 1; // Bist correct = 1 and Bist Err Cnt - 0x1
		faultaddr[0] = 9'h10;
		insert_fault(1,1,32'h15151515);

          	if(`TB_GLBL.err_count == 0) begin
	    	    $display("Monitor: Step-2: BIST Test with One Memory Error insertion test Passed");
	        end else begin
	    	    $display("Monitor: Step-2: BIST Test with One Memory Error insertion test Failed");
		 end
	    	$display("###################################################");
	    	$display("###################################################");
	    	$display(" MBIST Test with Two Address Failure");
	    	$display("###################################################");
		// Check Is there is any BIST Error
		// [0]   - Bist Done      - 1
		// [1]   - Bist Error     - 0
		// [2]   - Bist Correct   - 1
		// [3]   - Reserved       - 0
		// [7:4] - Bist Error Cnt - 4'h2
		//if(read_data[6:0]  != 7'b0010101) test_fail = 1; // Bist correct = 1 and Bist Err Cnt - 0x2
		faultaddr[0] = 9'h10;
		faultaddr[1] = 9'h20;
		insert_fault(2,0,32'h25252525);

          	if(`TB_GLBL.err_count == 0) begin
	    	    $display("Monitor: Step-3: BIST Test with Two Memory Error insertion test Passed");
	        end else begin
	    	    $display("Monitor: Step-3: BIST Test with Two Memory Error insertion test Failed");
		 end
	    	$display("###################################################");
	    	$display(" MBIST Test with Three Address Failure");
	    	$display("###################################################");

		// Check Is there is any BIST Error
		// [0]   - Bist Done      - 1
		// [1]   - Bist Error     - 0
		// [2]   - Bist Correct   - 1
		// [3]   - Reserved       - 0
		// [7:4] - Bist Error Cnt - 4'h3
		//if(read_data[6:0]  != 7'b0011101) test_fail = 1; // Bist correct = 1 and Bist Err Cnt - 0x3
		faultaddr[0] = 9'h10;
		faultaddr[1] = 9'h20;
		faultaddr[2] = 9'h30;
		insert_fault(3,1,32'h35353535);

          	if(`TB_GLBL.err_count == 0) begin
	    	    $display("Monitor: Step-4: BIST Test with Three Memory Error insertion test Passed");
	        end else begin
	    	    $display("Monitor: Step-4: BIST Test with Three Memory Error insertion test Failed");
		 end
	    	$display("###################################################");
	    	$display(" MBIST Test with Fours Address Failure");
	    	$display("###################################################");
		// Check Is there is any BIST Error
		// [0]   - Bist Done      - 1
		// [1]   - Bist Error     - 0
		// [2]   - Bist Correct   - 1
		// [3]   - Reserved       - 0
		// [7:4] - Bist Error Cnt - 4'h4
		//if(read_data[6:0]  != 7'b0100101) test_fail = 1; // Bist correct = 1 and Bist Err Cnt - 0x4
		faultaddr[0] = 9'h10;
		faultaddr[1] = 9'h20;
		faultaddr[2] = 9'h30;
		faultaddr[3] = 9'h40;
		insert_fault(4,0,32'h45454545);

          	if(`TB_GLBL.err_count == 0) begin
	    	    $display("Monitor: Step-5: BIST Test with Four Memory Error insertion test Passed");
	        end else begin
	    	    $display("Monitor: Step-5: BIST Test with Four Memory Error insertion test Failed");
		end

		$dumpon;
	    	$display("###################################################");
	    	$display(" MBIST Test with Fours Address(Continous Starting Addrsess) Failure");
	    	$display("###################################################");
		// Check Is there is any BIST Error
		// [0]   - Bist Done      - 1
		// [1]   - Bist Error     - 0
		// [2]   - Bist Correct   - 1
		// [3]   - Reserved       - 0
		// [7:4] - Bist Error Cnt - 4'h4
		//if(read_data[6:0]  != 7'b0100101) test_fail = 1; // Bist correct = 1 and Bist Err Cnt - 0x4
		faultaddr[0] = 9'h0;
		faultaddr[1] = 9'h1;
		faultaddr[2] = 9'h2;
		faultaddr[3] = 9'h3;
		insert_fault(4,0,32'h45454545);

          	if(`TB_GLBL.err_count == 0) begin
	    	    $display("Monitor: Step-5.2: BIST Test with Four Memory Error insertion test Passed");
	        end else begin
	    	    $display("Monitor: Step-5.2: BIST Test with Four Memory Error insertion test Failed");
		end

	    	$display("###################################################");
	    	$display(" MBIST Test with Fours Address(Last Addrsess) Failure");
	    	$display("###################################################");
		// Check Is there is any BIST Error
		// [0]   - Bist Done      - 1
		// [1]   - Bist Error     - 0
		// [2]   - Bist Correct   - 1
		// [3]   - Reserved       - 0
		// [7:4] - Bist Error Cnt - 4'h4
		//if(read_data[6:0]  != 7'b0100101) test_fail = 1; // Bist correct = 1 and Bist Err Cnt - 0x4
		faultaddr[0] = 9'hF0;
		faultaddr[1] = 9'hF1;
		faultaddr[2] = 9'hF2;
		faultaddr[3] = 9'hF3;
		insert_fault(4,0,32'h45454545);

          	if(`TB_GLBL.err_count == 0) begin
	    	    $display("Monitor: Step-5.3: BIST Test with Four Memory Error insertion test Passed");
	        end else begin
	    	    $display("Monitor: Step-5.3: BIST Test with Four Memory Error insertion test Failed");
		end
		$dumpon;
	    	$display("###################################################");
	    	$display(" MBIST Test with Five Address Failure");
	    	$display("###################################################");
		// Check Is there is any BIST Error
		// [0]   - Bist Done      - 1
		// [1]   - Bist Error     - 1
		// [2]   - Bist Correct   - 1
		// [3]   - Reserved       - 0
		// [7:4] - Bist Error Cnt - 4'h4
		//if(read_data[6:0]  != 7'b0100101) test_fail = 1; // Bist correct = 1 and Bist Err Cnt - 0x4
		faultaddr[0] = 9'h10;
		faultaddr[1] = 9'h20;
		faultaddr[2] = 9'h30;
		faultaddr[3] = 9'h40;
		faultaddr[4] = 9'h50;
		insert_fault(5,1,32'h47474747);

          	if(`TB_GLBL.err_count == 0) begin
	    	    $display("Monitor: Step-5: BIST Test with Five Memory Error insertion test Passed");
	        end else begin
	    	    $display("Monitor: Step-5: BIST Test with Five Memory Error insertion test Failed");
		 end

		$dumpon;
	    	$display("###################################################");
	    	$display(" MBIST Test with Functional Access, continuation of previous MBIST Signature");
	    	$display("###################################################");
		$dumpon;
		fork
		begin
		    // Remove the Bist Enable and Bist Run
                    wb_user_core_write(`ADDR_SPACE_MBIST0+`MBIST_CFG_CTRL,'h000);
  
	            // Fill Random Data	
		    for (i=0; i< 9'h1FC; i=i+1) begin
   	                writemem[i] = $random;
                        wb_user_core_write(`ADDR_SPACE_SRAM4+(i*4),writemem[i]);
                        wb_user_core_write(`ADDR_SPACE_SRAM5+(i*4),writemem[i]);
                        wb_user_core_write(`ADDR_SPACE_SRAM6+(i*4),writemem[i]);
                        wb_user_core_write(`ADDR_SPACE_SRAM7+(i*4),writemem[i]);
		    end
		    // Read back data
		    for (i=0; i< 9'h1FC; i=i+1) begin
                        wb_user_core_read_check(`ADDR_SPACE_SRAM4+(i*4),read_data,writemem[i],32'hFFFFFFFF);
                        wb_user_core_read_check(`ADDR_SPACE_SRAM5+(i*4),read_data,writemem[i],32'hFFFFFFFF);
                        wb_user_core_read_check(`ADDR_SPACE_SRAM6+(i*4),read_data,writemem[i],32'hFFFFFFFF);
                        wb_user_core_read_check(`ADDR_SPACE_SRAM7+(i*4),read_data,writemem[i],32'hFFFFFFFF);
		    end

		    // Cross-check Reducency address hold the failure address data
		    // Is last Error inserted address are 0x10,0x20,0x30,0x40
		    // So Address 0x1FC = Data[0x10], 0x1FD = Data[0x20]
		    //    Address 0x1FE = Data[0x30], 0x1FF = Data[0x40]
		    // Check 2kb SRAM1
                    wb_user_core_read_check(`ADDR_SPACE_SRAM4 + (9'h1FC *4),read_data,writemem[9'h10],32'hFFFFFFFF);
                    wb_user_core_read_check(`ADDR_SPACE_SRAM4 + (9'h1FD *4),read_data,writemem[9'h20],32'hFFFFFFFF);
                    wb_user_core_read_check(`ADDR_SPACE_SRAM4 + (9'h1FE *4),read_data,writemem[9'h30],32'hFFFFFFFF);
                    wb_user_core_read_check(`ADDR_SPACE_SRAM4 + (9'h1FF *4),read_data,writemem[9'h40],32'hFFFFFFFF);

		    // Check 2kb SRAM2
                    wb_user_core_read_check(`ADDR_SPACE_SRAM5 + (9'h1FC *4),read_data,writemem[9'h11],32'hFFFFFFFF);
                    wb_user_core_read_check(`ADDR_SPACE_SRAM5 + (9'h1FD *4),read_data,writemem[9'h21],32'hFFFFFFFF);
                    wb_user_core_read_check(`ADDR_SPACE_SRAM5 + (9'h1FE *4),read_data,writemem[9'h31],32'hFFFFFFFF);
                    wb_user_core_read_check(`ADDR_SPACE_SRAM5 + (9'h1FF *4),read_data,writemem[9'h41],32'hFFFFFFFF);

		    // Check 2kb SRAM3
                    wb_user_core_read_check(`ADDR_SPACE_SRAM6 + (9'h1FC *4),read_data,writemem[9'h12],32'hFFFFFFFF);
                    wb_user_core_read_check(`ADDR_SPACE_SRAM6 + (9'h1FD *4),read_data,writemem[9'h22],32'hFFFFFFFF);
                    wb_user_core_read_check(`ADDR_SPACE_SRAM6 + (9'h1FE *4),read_data,writemem[9'h32],32'hFFFFFFFF);
                    wb_user_core_read_check(`ADDR_SPACE_SRAM6 + (9'h1FF *4),read_data,writemem[9'h42],32'hFFFFFFFF);

		    // Check 2kb SRAM4
                    wb_user_core_read_check(`ADDR_SPACE_SRAM7 + (9'h1FC *4),read_data,writemem[9'h13],32'hFFFFFFFF);
                    wb_user_core_read_check(`ADDR_SPACE_SRAM7 + (9'h1FD *4),read_data,writemem[9'h23],32'hFFFFFFFF);
                    wb_user_core_read_check(`ADDR_SPACE_SRAM7 + (9'h1FE *4),read_data,writemem[9'h33],32'hFFFFFFFF);
                    wb_user_core_read_check(`ADDR_SPACE_SRAM7 + (9'h1FF *4),read_data,writemem[9'h43],32'hFFFFFFFF);

                end
                begin
                   // Loop for BIST TimeOut
                   repeat (200000) @(posedge clock);
                		// $display("+1000 cycles");
                   `TB_GLBL.test_err;
                end
                join_any
                disable fork; //disable pending fork activity
          	if(`TB_GLBL.err_count == 0) begin
	    	    $display("Monitor: Step-5: BIST Test with Functional access test Passed");
	        end else begin
	    	    $display("Monitor: Step-5: BIST Test with Functional access test failed");
		 end


        $display("###################################################");
        if(`TB_GLBL.err_count == 0) begin
           `ifdef GL
               $display("Monitor: %m (GL) Passed");
           `else
               $display("Monitor: %m (RTL) Passed");
           `endif
        end else begin
            `ifdef GL
                $display("Monitor: %m (GL) Failed");
            `else
                $display("Monitor: %m (RTL) Failed");
            `endif
         end
        $display("###################################################");
        #100
        $finish;

	    	$display("###################################################");
	        $finish;
	end

wire USER_VDD1V8 = 1'b1;
wire VSS = 1'b0;


user_project_wrapper u_top(
`ifdef USE_POWER_PINS
    .vccd1(USER_VDD1V8),	// User area 1 1.8V supply
    .vssd1(VSS),	// User area 1 digital ground
`endif
    .wb_clk_i        (clock),  // System clock
    .user_clock2     (1'b1),  // Real-time clock
    .wb_rst_i        (wb_rst_i),  // Regular Reset signal

    .wbs_cyc_i   (wbd_ext_cyc_i),  // strobe/request
    .wbs_stb_i   (wbd_ext_stb_i),  // strobe/request
    .wbs_adr_i   (wbd_ext_adr_i),  // address
    .wbs_we_i    (wbd_ext_we_i),  // write
    .wbs_dat_i   (wbd_ext_dat_i),  // data output
    .wbs_sel_i   (wbd_ext_sel_i),  // byte enable

    .wbs_dat_o   (wbd_ext_dat_o),  // data input
    .wbs_ack_o   (wbd_ext_ack_o),  // acknowlegement

 
    // Logic Analyzer Signals
    .la_data_in      ('1) ,
    .la_data_out     (),
    .la_oenb         ('0),
 

    // IOs
    .io_in          (io_in)  ,
    .io_out         (io_out) ,
    .io_oeb         (io_oeb) ,

    .user_irq       () 

);

tb_glbl  tb_glbl ();

`ifndef GL // Drive Power for Hold Fix Buf
    // All standard cell need power hook-up for functionality work
    initial begin


    end
`endif    


//-------------------------------------
// Insert user defined number of fault 
// -----------------------------------

task insert_fault;
input [3:0]  num_fault;
input        fault_type; // 0 -> struck at 0 and 1 -> struck at 1
input [31:0]  mbist_signature;
reg [31:0] datain;
reg [`SRAM_AD-1:0]  fail_addr1;
reg [`SRAM_AD-1:0]  fail_addr2;
reg [`SRAM_AD-1:0]  fail_addr3;
reg [`SRAM_AD-1:0]  fail_addr4;
reg [7:0] j;
begin
   repeat (2) @(posedge clock);
   // Remove the Bist Enable and Bist Run
   wb_user_core_write(`ADDR_SPACE_MBIST1+`MBIST_CFG_CTRL,'h000);
   // Remove WB and BIST RESET
   wb_user_core_write(`ADDR_SPACE_WBHOST+`WBHOST_GLBL_CFG,'h001);
   // Set the Bist Enable and Bist Run
   wb_user_core_write(`ADDR_SPACE_MBIST1+`MBIST_CFG_CTRL,'h003);
   // Remove WB and BIST RESET
   wb_user_core_write(`ADDR_SPACE_WBHOST+`WBHOST_GLBL_CFG,'h003);
   fork
   begin
      // Check for MBIST Done
      read_data = 'h0;
      while (read_data[0] != 1'b1) begin
         wb_user_core_read(`ADDR_SPACE_MBIST1+`MBIST_CFG_STAT,read_data);
      end
      // wait for some time for all the BIST to complete
      repeat (1000) @(posedge clock);
      // Check Is there is any BIST Error
      // [0]   - Bist Done      
      // [1]   - Bist Error     
      // [2]   - Bist Correct   
      // [3]   - Reserved
      // [7:4] - Bist Error Cnt 
      wb_user_core_read_check(`ADDR_SPACE_MBIST1+`MBIST_CFG_STAT,read_data,mbist_signature[31:0],32'hFFFFFFFF);
   end
   // Insert  Error Insertion
   begin
      while(1) begin
         repeat (1) @(posedge clock);
         #1;

         if(u_top.u_sram4_2kb.web0 == 1'b0 && 
	   ((num_fault > 0 && u_top.u_sram4_2kb.addr0 == faultaddr[0]) ||
	    (num_fault > 1 && u_top.u_sram4_2kb.addr0 == faultaddr[1]) ||
	    (num_fault > 2 && u_top.u_sram4_2kb.addr0 == faultaddr[2]) ||
	    (num_fault > 3 && u_top.u_sram4_2kb.addr0 == faultaddr[3]) ||
	    (num_fault > 4 && u_top.u_sram4_2kb.addr0 == faultaddr[4]) ||
	    (num_fault > 5 && u_top.u_sram4_2kb.addr0 == faultaddr[5]) ||
	    (num_fault > 6 && u_top.u_sram4_2kb.addr0 == faultaddr[6]) ||
	    (num_fault > 7 && u_top.u_sram4_2kb.addr0 == faultaddr[7])))
             begin
	   if(fault_type == 0) // Struck at 0
	      force u_top.u_sram4_2kb.din0 = u_top.mem0_din_a  & 32'hFFFF_FFFE;
	   else
	      force u_top.u_sram4_2kb.din0 = u_top.mem0_din_a | 32'h1;
   	   -> error_insert;
         end else begin
            release u_top.u_sram4_2kb.din0;
         end

         if(u_top.u_sram5_2kb.web0 == 1'b0 && 
	   ((num_fault > 0 && u_top.u_sram5_2kb.addr0 == faultaddr[0]+1) ||
	    (num_fault > 1 && u_top.u_sram5_2kb.addr0 == faultaddr[1]+1) ||
	    (num_fault > 2 && u_top.u_sram5_2kb.addr0 == faultaddr[2]+1) ||
	    (num_fault > 3 && u_top.u_sram5_2kb.addr0 == faultaddr[3]+1) ||
	    (num_fault > 4 && u_top.u_sram5_2kb.addr0 == faultaddr[4]+1) ||
	    (num_fault > 5 && u_top.u_sram5_2kb.addr0 == faultaddr[5]+1) ||
	    (num_fault > 6 && u_top.u_sram5_2kb.addr0 == faultaddr[6]+1) ||
	    (num_fault > 7 && u_top.u_sram5_2kb.addr0 == faultaddr[7]+1)))
             begin
	   if(fault_type == 0) // Struck at 0
	      force u_top.u_sram5_2kb.din0 = u_top.mem1_din_a  & 32'hFFFF_FFFE;
	   else
	      force u_top.u_sram5_2kb.din0 = u_top.mem1_din_a | 32'h1;
   	   -> error_insert;
         end else begin
            release u_top.u_sram5_2kb.din0;
         end

         if(u_top.u_sram6_2kb.web0 == 1'b0 && 
	   ((num_fault > 0 && u_top.u_sram6_2kb.addr0 == faultaddr[0]+2) ||
	    (num_fault > 1 && u_top.u_sram6_2kb.addr0 == faultaddr[1]+2) ||
	    (num_fault > 2 && u_top.u_sram6_2kb.addr0 == faultaddr[2]+2) ||
	    (num_fault > 3 && u_top.u_sram6_2kb.addr0 == faultaddr[3]+2) ||
	    (num_fault > 4 && u_top.u_sram6_2kb.addr0 == faultaddr[4]+2) ||
	    (num_fault > 5 && u_top.u_sram6_2kb.addr0 == faultaddr[5]+2) ||
	    (num_fault > 6 && u_top.u_sram6_2kb.addr0 == faultaddr[6]+2) ||
	    (num_fault > 7 && u_top.u_sram6_2kb.addr0 == faultaddr[7]+2)))
             begin
	   if(fault_type == 0) // Struck at 0
	      force u_top.u_sram6_2kb.din0 = u_top.mem2_din_a  & 32'hFFFF_FFFE;
	   else
	      force u_top.u_sram6_2kb.din0 = u_top.mem2_din_a | 32'h1;
   	   -> error_insert;
         end else begin
            release u_top.u_sram6_2kb.din0;
         end

         if(u_top.u_sram7_2kb.web0 == 1'b0 && 
	   ((num_fault > 0 && u_top.u_sram7_2kb.addr0 == faultaddr[0]+3) ||
	    (num_fault > 1 && u_top.u_sram7_2kb.addr0 == faultaddr[1]+3) ||
	    (num_fault > 2 && u_top.u_sram7_2kb.addr0 == faultaddr[2]+3) ||
	    (num_fault > 3 && u_top.u_sram7_2kb.addr0 == faultaddr[3]+3) ||
	    (num_fault > 4 && u_top.u_sram7_2kb.addr0 == faultaddr[4]+3) ||
	    (num_fault > 5 && u_top.u_sram7_2kb.addr0 == faultaddr[5]+3) ||
	    (num_fault > 6 && u_top.u_sram7_2kb.addr0 == faultaddr[6]+3) ||
	    (num_fault > 7 && u_top.u_sram7_2kb.addr0 == faultaddr[7]+3)))
             begin
	   if(fault_type == 0) // Struck at 0
	      force u_top.u_sram7_2kb.din0 = u_top.mem3_din_a  & 32'hFFFF_FFFE;
	   else
	      force u_top.u_sram7_2kb.din0 = u_top.mem3_din_a | 32'h1;
   	   -> error_insert;
         end else begin
            release u_top.u_sram7_2kb.din0;
         end

      end
   end
   begin
      // Loop for BIST TimeOut
      repeat (200000) @(posedge clock);
   		// $display("+1000 cycles");
      `TB_GLBL.test_err;
   end
   join_any
   disable fork; //disable pending fork activity

   // Read Back the Failure Address and cross-check all the 4 MBIST
   for(j=0; j < `NO_SRAM; j=j+1) begin
      fail_addr1 = faultaddr[0]+j;
      fail_addr2 = faultaddr[1]+j;
      fail_addr3 = faultaddr[2]+j;
      fail_addr4 = faultaddr[3]+j;

      // Select the Serial SDI/SDO interface
      wb_user_core_write(`ADDR_SPACE_MBIST1+`MBIST_CFG_CTRL,{27'h0,j[1:0], 3'b0}); 
      if(num_fault == 1)
          wb_user_core_read_check(`ADDR_SPACE_MBIST1+`MBIST_CFG_SRLDATA,read_data,{16'h0,7'h0,fail_addr1},32'h0000_FFFF);
      if(num_fault == 2)
          wb_user_core_read_check(`ADDR_SPACE_MBIST1+`MBIST_CFG_SRLDATA,read_data,{7'h0,fail_addr2,7'h0,fail_addr1},32'hFFFF_FFFF);
      if(num_fault == 3) begin
          wb_user_core_read_check(`ADDR_SPACE_MBIST1+`MBIST_CFG_SRLDATA,read_data,{7'h0,fail_addr2,7'h0,fail_addr1},32'hFFFF_FFFF);
          wb_user_core_read_check(`ADDR_SPACE_MBIST1+`MBIST_CFG_SRMDATA,read_data,{16'h0,7'h0,fail_addr3},32'h0000_FFFF);
      end
      if(num_fault >= 4) begin
          wb_user_core_read_check(`ADDR_SPACE_MBIST1+`MBIST_CFG_SRLDATA,read_data,{7'h0,fail_addr2,7'h0,fail_addr1},32'hFFFF_FFFF);
          wb_user_core_read_check(`ADDR_SPACE_MBIST1+`MBIST_CFG_SRMDATA,read_data,{7'h0,faultaddr[3]+j,7'h0,fail_addr3},32'hFFFF_FFFF);
      end
   end
end
endtask


task wb_user_core_write;
input [31:0] address;
input [31:0] data;
begin
  repeat (1) @(posedge clock);
  #1;
  wbd_ext_adr_i =address;  // address
  wbd_ext_we_i  ='h1;  // write
  wbd_ext_dat_i =data;  // data output
  wbd_ext_sel_i ='hF;  // byte enable
  wbd_ext_cyc_i ='h1;  // strobe/request
  wbd_ext_stb_i ='h1;  // strobe/request
  wait(wbd_ext_ack_o == 1);
  repeat (1) @(posedge clock);
  #1;
  wbd_ext_cyc_i ='h0;  // strobe/request
  wbd_ext_stb_i ='h0;  // strobe/request
  wbd_ext_adr_i ='h0;  // address
  wbd_ext_we_i  ='h0;  // write
  wbd_ext_dat_i ='h0;  // data output
  wbd_ext_sel_i ='h0;  // byte enable
  $display("STATUS: WB USER ACCESS WRITE Address : 0x%x, Data : 0x%x",address,data);
  repeat (2) @(posedge clock);
end
endtask

task  wb_user_core_read;
input [31:0] address;
output [31:0] data;
reg    [31:0] data;
begin
  repeat (1) @(posedge clock);
  #1;
  wbd_ext_adr_i =address;  // address
  wbd_ext_we_i  ='h0;  // write
  wbd_ext_dat_i ='0;  // data output
  wbd_ext_sel_i ='hF;  // byte enable
  wbd_ext_cyc_i ='h1;  // strobe/request
  wbd_ext_stb_i ='h1;  // strobe/request
  wait(wbd_ext_ack_o == 1);
  #1;
  data  = wbd_ext_dat_o;  
  repeat (1) @(posedge clock);
  #1;
  wbd_ext_cyc_i ='h0;  // strobe/request
  wbd_ext_stb_i ='h0;  // strobe/request
  wbd_ext_adr_i ='h0;  // address
  wbd_ext_we_i  ='h0;  // write
  wbd_ext_dat_i ='h0;  // data output
  wbd_ext_sel_i ='h0;  // byte enable
  //$display("STATUS: WB USER ACCESS READ  Address : 0x%x, Data : 0x%x",address,data);
  repeat (2) @(posedge clock);
end
endtask

task  wb_user_core_read_check;
input [31:0] address;
output [31:0] data;
input [31:0] cmp_data;
input [31:0] cmp_mask;
reg    [31:0] data;
begin
  repeat (1) @(posedge clock);
  #1;
  wbd_ext_adr_i =address;  // address
  wbd_ext_we_i  ='h0;  // write
  wbd_ext_dat_i ='0;  // data output
  wbd_ext_sel_i ='hF;  // byte enable
  wbd_ext_cyc_i ='h1;  // strobe/request
  wbd_ext_stb_i ='h1;  // strobe/request
  wait(wbd_ext_ack_o == 1);
  #1;
  data  = wbd_ext_dat_o;  
  repeat (1) @(posedge clock);
  #1;
  wbd_ext_cyc_i ='h0;  // strobe/request
  wbd_ext_stb_i ='h0;  // strobe/request
  wbd_ext_adr_i ='h0;  // address
  wbd_ext_we_i  ='h0;  // write
  wbd_ext_dat_i ='h0;  // data output
  wbd_ext_sel_i ='h0;  // byte enable
  if((data & cmp_mask) !== (cmp_data & cmp_mask) ) begin
     $display("ERROR : WB USER ACCESS READ  Address : 0x%x, Exd: 0x%x Rxd: 0x%x ",address,(cmp_data & cmp_mask),(data & cmp_mask));
     `TB_GLBL.test_err;
  end else begin
     $display("STATUS: WB USER ACCESS READ  Address : 0x%x, Data : 0x%x",address,(data & cmp_mask));
  end
  repeat (2) @(posedge clock);
end
endtask


endmodule
`default_nettype wire
