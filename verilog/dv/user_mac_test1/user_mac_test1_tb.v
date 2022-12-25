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
////   Digital core MAC logic through External WB i/F.            ////
////                                                              ////
////  To Do:                                                      ////
////    nothing                                                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - Dinesh Annayya, dinesha@opencores.org                 ////
////                                                              ////
////  Revision :                                                  ////
////    0.1 - 20 Dec 2022, Dinesh A                               ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

`default_nettype wire

`timescale 1 ns / 1 ps

`define TB_TOP user_mac_test1_tb
`define TB_AGENTS_GMAC  `TB_TOP.u_tb_eth
`define TB_GLBL         `TB_TOP.tb_glbl

`include "./sram_macros/sky130_sram_2kbyte_1rw1r_32x512_8.v"
`include "user_reg_map.v"
`include "./tb_eth_top.v"
`include "./tb_mii.v" 
`include "./tb_rmii.v"
`include "./tb_glbl.v"


`define NO_SRAM 4  // Number of SRAM connected to MBIST WRAPPER
`define SRAM_AD 9  // SRAM ADDRESS WIDTH

module `TB_TOP;
parameter REF_CLK_125_PERIOD = 8;
parameter REF_CLK_50_PERIOD = 20;

	reg clock;
    reg ref_clk_125;
    reg ref_clk_50;
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

    reg[31:0] events_log;
    reg[31:0] outfile;


	// User I/O
	wire [37:0] io_oeb;
	wire [37:0] io_out;
	wire [37:0] io_in;

	wire gpio;
	wire [37:0] mprj_io;
	wire [7:0] mprj_io_0;
	reg        test_fail;
	reg [31:0] read_data;
    reg [31:0] writemem [0:511];
    reg [`SRAM_AD-1:0]  faultaddr [0:7];

    
    wire [3:0] phy_rxd;
    wire       phy_rx_clk;
    wire       phy_crs;
    wire       phy_rx_dv;
    wire [3:0] phy_txd;
    wire       phy_tx_en;
    wire       phy_tx_clk;
    wire       MDC;
    reg [3:0]  desc_ptr;


    integer i;
    event      error_insert;


	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #12.5 clock <= (clock === 1'b0);

    initial begin
      ref_clk_125 = 1'b0;
      forever #(REF_CLK_125_PERIOD/2.0) ref_clk_125 = ~ref_clk_125;
    end
    
    initial begin
      ref_clk_50 = 1'b0;
      forever #(REF_CLK_50_PERIOD/2.0) ref_clk_50 = ~ref_clk_50;
    end


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

		#200; // Wait for reset removal
	        repeat (10) @(posedge clock);
		$display("Monitor: Standalone User Test Started");

		test_fail = 0;
		// Remove Wb Reset
		wb_user_core_write(`ADDR_SPACE_WBHOST+`WBHOST_GLBL_CFG,'h7);
        gmac_test2();
        
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

`ifndef GL // Drive Power for Hold Fix Buf
    // All standard cell need power hook-up for functionality work
    initial begin


    end
`endif    


assign  io_in[5]     = phy_tx_clk;
assign  io_in[12]    = phy_rx_clk;
assign  io_in[13]    = phy_rx_dv;
assign  io_in[14]    = 1'b0;
assign  io_in[15]    = phy_crs;
assign  io_in[19:16] = phy_rxd[3:0];

assign  phy_tx_en  = (io_oeb[6]    == 1'b0) ? io_out[6]: 1'b0;
assign  phy_txd   =  (io_oeb[11:8] == 4'b0) ? io_out[11:8]: 4'b0;


tb_eth_top u_tb_eth (

               . REFCLK_50_MHz     (ref_clk_50         ), // 50 MHz Reference clock input
               . REFCLK_125_MHz    (ref_clk_125        ), // 125 MHz reference clock
               . transmit_enable   (1'b1               ), // transmit enable for testbench
              
          // Separate interfaces for each MII port type

          // Full MII, 4-bit interface
          // Transmit interface
               . MII_RXD           (phy_rxd[3:0]       ), // Receive data (output)
               . MII_RX_CLK        (phy_rx_clk         ), // Receive clock for MII (output)
               . MII_CRS           (phy_crs            ), // carrier sense (output)
               . MII_COL           (                   ), // Collision signal for MII (output)
               . MII_RX_DV         (phy_rx_dv          ), // Receive data valid for MII (output)

          // Receive interface
               . MII_TXD           (phy_txd[3:0]       ), // Transmit data (input)
               . MII_TX_EN         (phy_tx_en          ), // Tx enable (input)
               . MII_TX_CLK        (phy_tx_clk         ), // Transmit clock (output)

          // Reduced MII, 2-bit interface
          // Transmit interface
               . RMII_RXD          (                   ), // Receive data (output)
               . RMII_CRS_DV       (                   ), // carrier sense (output)
          // Receive interface
               . RMII_TXD          (                   ), // Transmit data (input)
               . RMII_TX_EN        (                   ), // Tx enable (input)

          // Serial MII interface
               . SMII_RXD          (                   ), // Receive data (output)
               . SMII_TXD          (                   ), // Transmit data (input)
               . SMII_SYNC         (                   ), // SMII SYNC signal (input)                
                     
          // GMII, 8-bit/10-bit interface
          // Transmit interface
               . GMII_RXD          (                   ), // Receive data (output)
               . GMII_RX_CLK       (                   ), // Receive clock for MII (output)
               . GMII_CRS          (                   ), // carrier sense (output)
               . GMII_COL          (                   ), // Collision signal for MII (output)
               . GMII_RX_DV        (                   ), // Receive data valid for MII (output)

          // Receive interface
               . GMII_TXD          (                   ), // Transmit data (input)
               . GMII_TX_EN        (                   ), // Tx enable (input)
               . GMII_TX_CLK       (                   ), // Transmit clock (output)
               . GMII_GTX_CLK      (                   ), // Gigabit Tx clock (input), 125 MHz

              // MII management interface
               .MDIO               (MDC                ), // serial I/O data
               .MDC                (MDC                )  // clock




      );

always @(phy_tx_clk)
begin

end

tb_glbl  tb_glbl ();



task gmac_test2;
reg [31:0] read_data;
reg [3:0]  desc_ptr;
reg [9:0]  desc_rx_qbase;
reg [9:0]  desc_tx_qbase;
reg [7:0]  iFrmCnt;

begin
  //--------------------------
  // Data Memory MAP
  //-------------------------
  // 0x2000 to 0x27FF - 2K - Gmac Rx Data Memory
  // 0x2800 to 0x2FFF - 2K - Gmac Tx Data Memory
  // 0x3000 to 0x303F - 64 - Rx Descriptor
  // 0x3040 to 0x307F - 64 - Tx Descripto

   tb_glbl.init;

   events_log = $fopen("./test_log_files/test_events.log");
   `TB_TOP.u_tb_eth.event_file = events_log;
   outfile = $fopen("./test_log_files/test_outfile.log");
   `TB_TOP.u_tb_eth.outfile = outfile;



   desc_ptr = 0;
   desc_rx_qbase = 10'h100; // 0x4000
   desc_tx_qbase = 10'h101; // 0x4040
   iFrmCnt  = 0;
   `TB_TOP.u_tb_eth.init_port(3'b1, 3'b1, 1'b1, 0);

   `TB_TOP.wb_user_core_write(`ADDR_SPACE_MAC+8'h0,{4'h2,4'h2,8'h45,8'h01});  // tx/rx-control
   `TB_TOP.wb_user_core_write(`ADDR_SPACE_MAC+8'h8,{16'h0,8'd22,8'd22}); // Tx/Rx IFG
   `TB_TOP.wb_user_core_write(`ADDR_SPACE_MAC+8'h24,{desc_tx_qbase,desc_ptr,2'b00,
                               desc_rx_qbase,desc_ptr,2'b00}); // Tx/Rx Descriptor

   `TB_TOP.u_tb_eth.set_flow_type(0);//L2 unicast 
   `TB_TOP.u_tb_eth.set_L2_frame_size(1, 64, 84, 1); //, 1, 17, 33, 49, 64
   `TB_TOP.u_tb_eth.set_payload_type(2, 5000,0); //make sure frame size is honored
   `TB_TOP.u_tb_eth.set_L2_protocol(0); // Untagged frame
   `TB_TOP.u_tb_eth.set_L2_source_address(0, 48'h12_34_56_78_9a_bc, 0,0);
   `TB_TOP.u_tb_eth.set_L2_destination_address(0, 48'h16_22_33_44_55_66, 0,0);
   `TB_TOP.u_tb_eth.set_L3_protocol(4); // IPV4
   `TB_TOP.u_tb_eth.set_crc_option(0,0);
   
   fork
     begin
     `TB_TOP.u_tb_eth.transmit_packet_sequence(100, 96, 1, 5000);
         $display("Status: End of Transmission Loop");
         `TB_TOP.u_tb_eth.wait_for_event(3, 0);
         `TB_TOP.u_tb_eth.wait_for_event(3, 0);
         $display("Status: End of Waiting Event Loop");
     end
     begin
        desc_ptr = 0;
        while(`TB_AGENTS_GMAC.full_mii.receive_packet_count != 100) begin
           // Read the RX Q Occpancy
           `TB_TOP.wb_user_core_read(`ADDR_SPACE_MAC+8'h30,read_data);
           if(read_data[7:0] != 0) begin
              // Read the Descrptor data and write back to tx path
              `TB_TOP.wb_user_core_read(`ADDR_SPACE_CORE+{desc_rx_qbase,desc_ptr[3:0],2'b00},read_data);
              `TB_TOP.wb_user_core_write(`ADDR_SPACE_CORE+{desc_tx_qbase,desc_ptr[3:0],2'b00},read_data);
               desc_ptr = desc_ptr+1;
           end
        end
     end
   join_any

  #100000;
  $display("Status: End of Waiting Delay Loop");

  `TB_AGENTS_GMAC.full_mii.status; // test status

  // Check the Transmitted & Received Frame cnt
  if(`TB_AGENTS_GMAC.full_mii.transmitted_packet_count != `TB_AGENTS_GMAC.full_mii.receive_packet_count)
       `TB_GLBL.test_err;

  // Check the Transmitted & Received Byte cnt
  if(`TB_AGENTS_GMAC.full_mii.transmitted_packet_byte_count != `TB_AGENTS_GMAC.full_mii.receive_packet_byte_count)
       `TB_GLBL.test_err;

  if(`TB_AGENTS_GMAC.full_mii.receive_crc_err_count)
       `TB_GLBL.test_err;

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
     test_fail = 1;
  end else begin
     $display("STATUS: WB USER ACCESS READ  Address : 0x%x, Data : 0x%x",address,(data & cmp_mask));
  end
  repeat (2) @(posedge clock);
end
endtask


endmodule
`default_nettype wire
