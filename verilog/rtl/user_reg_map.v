
// Note in caravel, 0x300X_XXXX only come to user interface
// So, using wb_host bank select we have changing MSB address [31:16] = 0x1000
//
`define ADDR_SPACE_CORE    32'h3000_0000
`define ADDR_SPACE_WBHOST  32'h3008_0000
`define ADDR_SPACE_LBIST   32'h300C_0000
`define ADDR_SPACE_GLBL    32'h3000_0000
`define ADDR_SPACE_MAC     32'h3000_0100
`define ADDR_SPACE_MBIST0  32'h3000_0200
`define ADDR_SPACE_MBIST1  32'h3000_0300
`define ADDR_SPACE_SRAM0   32'h3000_2000
`define ADDR_SPACE_SRAM1   32'h3000_2800
`define ADDR_SPACE_SRAM2   32'h3000_3000
`define ADDR_SPACE_SRAM3   32'h3000_3800
`define ADDR_SPACE_SRAM4   32'h3000_4000
`define ADDR_SPACE_SRAM5   32'h3000_4800
`define ADDR_SPACE_SRAM6   32'h3000_5000
`define ADDR_SPACE_SRAM7   32'h3000_5800

//--------------------------------------------------
//  WB Host Register
//--------------------------------------------------
`define WBHOST_GLBL_CFG    8'h00  // reg_0  - Global Config
`define WBHOST_BANK_SEL    8'h04  // reg_1  - Bank Select
`define WBHOST_CLK_CTRL1   8'h08  // reg_2  - Clock Control-1
`define WBHOST_CLK_CTRL2   8'h0C  // reg_3  - Clock Control-2

//--------------------------------------------------
//  LBIST Register
//--------------------------------------------------
`define LBIST_CTRL1      8'h00
`define LBIST_CTRL2      8'h04
`define LBIST_SIG        8'h08

//-------------------------------------------------
//  GLBL Register
//-------------------------------------------------

`define GLBL_BIST_SOFT1    'h24
`define GLBL_BIST_SOFT2    'h28
`define GLBL_BIST_SOFT3    'h2C

//-------------------------------------------------
//  MBIST Register
//-------------------------------------------------

`define MBIST_CFG_CTRL     'h00    
`define MBIST_CFG_STAT     'h04
`define MBIST_CFG_SRLDATA  'h08
`define MBIST_CFG_SRMDATA  'h0C

