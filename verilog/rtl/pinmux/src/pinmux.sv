module pinmux(

    //-----------------------------------------------------------------------
    // MAC-Tx Signal
    //-----------------------------------------------------------------------
    output logic	     mac_tx_clk     ,
    input  logic         mac_tx_en      ,
    input  logic         mac_tx_er      ,
    input  logic [7:0]   mac_txd        ,
                   
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
    input   logic [37:0] io_in           ,
    output  logic [37:0] io_out          ,
    output  logic [37:0] io_oeb

);

/***********************************************************
            PinMux Structure

   digital_io[5]   - MAC-TX_CLK       -   IN - Need cross-check spec
   digital_io[6]   - MAC-TX_EN        -   OUT
   digital_io[7]   - MAC-TX_ER        -   OUT
   digital_io[8]   - MAC-TX_DATA[0]   -   OUT
   digital_io[9]   - MAC-TX_DATA[1]   -   OUT
   digital_io[10]  - MAC-TX_DATA[2]   -   OUT
   digital_io[11]  - MAC-TX_DATA[3]   -   OUT

   digital_io[12]  - MAC-RX_CLK       -   IN
   digital_io[13]  - MAC-RX_DV        -   IN
   digital_io[14]  - MAC-RX_ER        -   IN
   digital_io[15]  - MAC-RX_CRS       -   IN
   digital_io[16]  - MAC-RX_DATA[0]   -   IN
   digital_io[17]  - MAC-RX_DATA[1]   -   IN
   digital_io[18]  - MAC-RX_DATA[2]   -   IN
   digital_io[19]  - MAC-RX_DATA[3]   -   IN
   digital_io[20]  - MAC-MDIC         -   OUT
   digital_io[21]  - MAC-MDID         -   IO

   digital_io[35] -  UARTM-TXD        -   OUT
   digital_io[36] -  UARTM-RXD        -   IN

***********************************************************/

// digitial_in* mapping
always_comb
begin
   
    mac_rxd    = 'b0; 

    // digital_io[5]  - MAC-TX_CLK
    mac_tx_clk  = io_in[5];

    // digital_io[12]  - MAC-RX_CLK
    mac_rx_clk  = io_in[12];

    // digital_io[13]  - MAC-RX_DV
    mac_rx_dv  = io_in[13];

    // digital_io[14]  - MAC-RX_ER
    mac_rx_er  = io_in[14];
   
    // digital_io[15]  - MAC-RX_CRS
    mac_crs  = io_in[15];

    // digital_io[16]  - MAC-RX_DATA[0]
    mac_rxd[0]= io_in[16];
    
    // digital_io[17]  - MAC-RX_DATA[1]
    mac_rxd[1]= io_in[17];

    // digital_io[18]  - MAC-RX_DATA[2]
    mac_rxd[2]= io_in[18];

    // digital_io[19]  - MAC-RX_DATA[3]
    mac_rxd[3]= io_in[19];

    // digital_io[20]  - MAC-MDIC
    mdio_clk   = io_in[20];

    // digital_io[21]  - MAC-MDID
    mdio_in    = io_in[21];

    // digital_io[36] -  UARTM-RXD
    uartm_rxd = io_in[36];

end

// digitial_out* mapping
always_comb
begin

    io_out = 'h0;

    // digital_io[6]   - MAC-TX_EN 
    io_out[6] = mac_tx_en;

    // digital_io[7]   - MAC-TX_ER
    io_out[7] = mac_tx_er;

    // digital_io[8]   - MAC-TX_DATA[0]
    io_out[8] = mac_txd[0];

   // digital_io[9]   - MAC-TX_DATA[1]
    io_out[9] = mac_txd[1];

   // digital_io[10]  - MAC-TX_DATA[2]
    io_out[10] = mac_txd[2];

   // digital_io[11]  - MAC-TX_DATA[3]
    io_out[11] = mac_txd[3];

   
   // digital_io[21]  - MAC-MDID
    io_out[21] = mdio_out;

   // digital_io[35] -  UARTM-TXD
     io_out[35] = uartm_txd;
end

// digitial_oeb* mapping
always_comb
begin
   io_oeb = {38{1'b1}};

   // digital_io[5]   - MAC-TX_CLK       -   IN - Need cross-check spec
   io_oeb[5] = 1'b1;

   // digital_io[6]   - MAC-TX_EN        -   OUT
   io_oeb[6] = 1'b0;

   // digital_io[7]   - MAC-TX_ER        -   OUT
   io_oeb[7] = 1'b0;

   // digital_io[8]   - MAC-TX_DATA[0]   -   OUT
   io_oeb[8] = 1'b0;

   //digital_io[9]   - MAC-TX_DATA[1]   -   OUT
   io_oeb[9] = 1'b0;

   //digital_io[10]  - MAC-TX_DATA[2]   -   OUT
   io_oeb[10] = 1'b0;

   //digital_io[11]  - MAC-TX_DATA[3]   -   OUT
   io_oeb[11] = 1'b0;

   //digital_io[12]  - MAC-RX_CLK       -   IN
   io_oeb[12] = 1'b1;

   //digital_io[13]  - MAC-RX_DV        -   IN
   io_oeb[13] = 1'b1;

   //digital_io[14]  - MAC-RX_ER        -   IN
   io_oeb[14] = 1'b1;

   //digital_io[15]  - MAC-RX_CRS       -   IN
   io_oeb[15] = 1'b1;

   //digital_io[16]  - MAC-RX_DATA[0]   -   IN
   io_oeb[16] = 1'b1;

   //digital_io[17]  - MAC-RX_DATA[1]   -   IN
   io_oeb[17] = 1'b1;

   //digital_io[18]  - MAC-RX_DATA[2]   -   IN
   io_oeb[18] = 1'b1;

   //digital_io[19]  - MAC-RX_DATA[3]   -   IN
   io_oeb[19] = 1'b1;

   //digital_io[20]  - MAC-MDIC         -   OUT
   io_oeb[20] = 1'b0;

   //digital_io[21]  - MAC-MDID         -   IO
   io_oeb[21] = mdio_out_en;

   //digital_io[35] -  UARTM-TXD        -   OUT
   io_oeb[35] = 1'b0;

   //digital_io[36] -  UARTM-RXD        -   IN
   io_oeb[36] = 1'b1;

end

endmodule
