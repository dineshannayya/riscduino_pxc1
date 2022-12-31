

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
    // External IO
    //-------------------------------------
    input  [37:0]      io_in           ,
    output [37:0]      io_out          ,
    output [37:0]      io_oeb

    



        );


logic [1:0]  cfg_mac_tx_clk_sel;
logic [1:0]  cfg_mac_rx_clk_sel;
logic [1:0]  cfg_mac_mdio_refclk_sel;
logic [7:0]  cfg_mdio_clk_div_ratio;
logic        pad_mac_tx_clk;
logic        pad_mac_rx_clk;
logic [31:0] cfg_mac_clk_ctrl;

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

           .cfg_mac_clk_ctrl  (cfg_mac_clk_ctrl     )

    );


assign cfg_mac_tx_clk_sel      = cfg_mac_clk_ctrl[1:0];
assign cfg_mac_rx_clk_sel      = cfg_mac_clk_ctrl[3:2];
assign cfg_mac_mdio_refclk_sel = cfg_mac_clk_ctrl[5:4];
assign cfg_mdio_clk_div_ratio  = cfg_mac_clk_ctrl[15:8];


clkgen u_clkgen ( 

   // Global Reset/clok
      .reset_n                 (reset_n                 ),
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



pinmux u_pinmux(

    //-----------------------------------------------------------------------
    // MAC-Tx Signal
    //-----------------------------------------------------------------------
    .mac_tx_clk              (pad_mac_tx_clk  ),
    .mac_tx_en               (mac_tx_en       ),
    .mac_tx_er               (mac_tx_er       ),
    .mac_txd                 (mac_txd         ),
                   
    //-----------------------------------------------------------------------
    // MAC-Rx Signal
    //-----------------------------------------------------------------------
    .mac_rx_clk              (pad_mac_rx_clk  ),
    .mac_rx_er               (mac_rx_er       ),
    .mac_rx_dv               (mac_rx_dv       ),
    .mac_rxd                 (mac_rxd         ),
    .mac_crs                 (mac_crs         ),
                   
                   
    //-----------------------------------------------------------------------
    // MDIO Signal
    //-----------------------------------------------------------------------
    .mdio_clk               (mdio_clk     ),
    .mdio_in                (mdio_in      ),
    .mdio_out_en            (mdio_out_en  ),
    .mdio_out               (mdio_out     ),

    //-------------------------------------
    // Master UART TXD
    //-------------------------------------
    .uartm_rxd              (uartm_rxd   ),
    .uartm_txd              (uartm_txd   ),

    //-------------------------------------
    // External IO
    //-------------------------------------
    .io_in                  (io_in      ),
    .io_out                 (io_out     ),
    .io_oeb                 (io_oeb     )




);




endmodule

