task init;
begin
   //#1 - Apply Reset
   #1000 RSTB = 1; 
   repeat (10) @(posedge clock);
   #1000 RSTB = 0; 

   //#3 - Remove Reset
   #1000 RSTB = 1; 
   repeat (10) @(posedge clock);
end
endtask


 /*************************************************************************
 * This is Baud Rate to clock divider conversion for Test Bench
 * Note: DUT uses 16x baud clock, where are test bench uses directly
 * baud clock, Due to 16x Baud clock requirement at RTL, there will be
 * some resolution loss, we expect at lower baud rate this resolution
 * loss will be less. For Quick simulation perpose higher baud rate used
 * *************************************************************************/
 task tb_set_uart_baud;
 input [31:0] ref_clk;
 input [31:0] baud_rate;
 output [31:0] baud_div;
 reg   [31:0] baud_div;
 begin
// for 230400 Baud = (50Mhz/230400) = 216.7
baud_div = ref_clk/baud_rate; // Get the Bit Baud rate
// Baud 16x = 216/16 = 13
    baud_div = baud_div/16; // To find the RTL baud 16x div value to find similar resolution loss in test bench
// Test bench baud clock , 16x of above value
// 13 * 16 = 208,  
// (Note if you see original value was 216, now it's 208 )
    baud_div = baud_div * 16;
// Test bench half cycle counter to toggle it 
// 208/2 = 104
     baud_div = baud_div/2;
//As counter run's from 0 , substract from 1
 baud_div = baud_div-1;
 end
 endtask


