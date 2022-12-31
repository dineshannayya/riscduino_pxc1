`ifndef USER_PARMS
`define USER_PARMS

// ASCI Representation of RPT1 = 32'h5250_5331
parameter CHIP_SIGNATURE = 32'h5250_5331;
// Software Reg-1, Release date: <DAY><MONTH><YEAR>
parameter CHIP_RELEASE_DATE = 32'h3112_2022;
// Software Reg-2: Poject Revison 5.1 = 0005200
parameter CHIP_REVISION   = 32'h0006_5000;

parameter CLK_SKEW1_RESET_VAL = 32'b0110_0000_0100_0111_1001_1100_1000_0101;
parameter CLK_SKEW2_RESET_VAL = 32'b1000_1000_1000_1000_1000_0110_1000_1110;

`endif // USER_PARMS

