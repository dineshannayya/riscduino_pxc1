

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
	input logic [3:0]       bist_error_cnt3,


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
    input   logic      mdio_out        



        );


//-----------------------------------------------------------------------
// Main code starts here
//-----------------------------------------------------------------------


assign scan_en_o = scan_en;
assign scan_mode_o = scan_mode;


// wb_host clock skew control
clk_skew_adjust u_skew_glbl
       (
`ifdef USE_POWER_PINS
               .vccd1      (vccd1                      ),// User area 1 1.8V supply
               .vssd1      (vssd1                      ),// User area 1 digital ground
`endif
	       .clk_in     (wbd_clk_int                ), 
	       .sel        (cfg_cska_pinmux            ), 
	       .clk_out    (wbd_clk_skew               ) 
       );



glbl_cfg u_glbl(
`ifdef USE_POWER_PINS
          .vccd1              (vccd1                ),// User area 1 1.8V supply
          .vssd1              (vssd1                ),// User area 1 digital ground
`endif

          .mclk               (mclk                 ),
          .reset_n            (reset_n              ),

        // Reg Bus Interface Signal
          .reg_cs             (reg_cs               ),
          .reg_wr             (reg_wr               ),
          .reg_addr           (reg_addr             ),
          .reg_wdata          (reg_wdata            ),
          .reg_be             (reg_be               ),

       // Outputs
          .reg_rdata          (reg_rdata            ),
          .reg_ack            (reg_ack              ),


       // BIST I/F
          .bist_en            (bist_en              ),
          .bist_run           (bist_run             ),
          .bist_load          (bist_load            ),
        
          .bist_serial_sel    (bist_serial_sel      ),
          .bist_sdi           (bist_sdi             ),
          .bist_shift         (bist_shift           ),
          .bist_sdo           (bist_sdo             ),
        
          .bist_done          (bist_done            ),
          .bist_error         (bist_error           ),
          .bist_correct       (bist_correct         ),
          .bist_error_cnt0    (bist_error_cnt0      ),
          .bist_error_cnt1    (bist_error_cnt1      ),
          .bist_error_cnt2    (bist_error_cnt2      ),
          .bist_error_cnt3    (bist_error_cnt3      )
    );




endmodule

