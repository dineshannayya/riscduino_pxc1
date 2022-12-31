
module ctech_mux2x1 #(parameter WB = 1) (
	input  logic [WB-1:0] A0,
	input  logic [WB-1:0] A1,
	input  logic S ,
	output logic [WB-1:0] X);

`ifndef SYNTHESIS
assign X = (S) ? A1 : A0;
`else 
    generate
       if (WB > 1)
       begin : bus_
         genvar tcnt;
         for (tcnt = 0; $unsigned(tcnt) < WB; tcnt=tcnt+1) begin : bit_
             sky130_fd_sc_hd__mux2_8 u_mux (.A0 (A0[tcnt]), .A1 (A1[tcnt]), .S  (S), .X (X[tcnt]));
         end
       end else begin
          sky130_fd_sc_hd__mux2_8 u_mux (.A0 (A0), .A1 (A1), .S  (S), .X (X));
       end
    endgenerate
`endif

endmodule

module ctech_mux2x1_2 #(parameter WB = 1) (
	input  logic [WB-1:0] A0,
	input  logic [WB-1:0] A1,
	input  logic S ,
	output logic [WB-1:0] X);

`ifndef SYNTHESIS
assign X = (S) ? A1 : A0;
`else 
    generate
       if (WB > 1)
       begin : bus_
         genvar tcnt;
         for (tcnt = 0; $unsigned(tcnt) < WB; tcnt=tcnt+1) begin : bit_
             sky130_fd_sc_hd__mux2_2 u_mux (.A0 (A0[tcnt]), .A1 (A1[tcnt]), .S  (S), .X (X[tcnt]));
         end
       end else begin 
          sky130_fd_sc_hd__mux2_2 u_mux (.A0 (A0), .A1 (A1), .S  (S), .X (X));
       end
    endgenerate
`endif

endmodule

module ctech_mux2x1_4 #(parameter WB = 1) (
	input  logic [WB-1:0] A0,
	input  logic [WB-1:0] A1,
	input  logic S ,
	output logic [WB-1:0] X);

`ifndef SYNTHESIS
assign X = (S) ? A1 : A0;
`else 
    generate
       if (WB > 1)
       begin : bus_
         genvar tcnt;
         for (tcnt = 0; $unsigned(tcnt) < WB; tcnt=tcnt+1) begin : bit_
             sky130_fd_sc_hd__mux2_4 u_mux (.A0 (A0[tcnt]), .A1 (A1[tcnt]), .S  (S), .X (X[tcnt]));
         end
       end else begin
          sky130_fd_sc_hd__mux2_4 u_mux (.A0 (A0), .A1 (A1), .S  (S), .X (X));
       end
    endgenerate
`endif

endmodule

module ctech_mux4x1 (
	input  logic       A00,
	input  logic       A01,
	input  logic       A10,
	input  logic       A11,
	input  logic [1:0] S ,
	output logic  X);

`ifndef SYNTHESIS
assign X = (S == 2'b00) ? A00 : 
           (S == 2'b01) ? A01 :
           (S == 2'b10) ? A10 :
           (S == 2'b11) ? A11 : 'h0;
`else 
     logic X0,X1;
     sky130_fd_sc_hd__mux2_4 u_mux_l00 (.A0 (A00), .A1 (A01), .S  (S[0]), .X (X0));
     sky130_fd_sc_hd__mux2_4 u_mux_l01 (.A0 (A10), .A1 (A11), .S  (S[0]), .X (X1));
     sky130_fd_sc_hd__mux2_4 u_mux_l10 (.A0 (X0),  .A1 (X1),  .S  (S[1]), .X (X));
`endif

endmodule

module ctech_buf (
	input  logic A,
	output logic X);

`ifndef SYNTHESIS
assign X = A;
`else
    sky130_fd_sc_hd__bufbuf_8 u_buf  (.A(A),.X(X));
`endif

endmodule

module ctech_clk_buf (
	input  logic A,
	output logic X);

`ifndef SYNTHESIS
assign X = A;
`else
    sky130_fd_sc_hd__clkbuf_8 u_buf  (.A(A),.X(X));
`endif

endmodule

module ctech_delay_buf (
	input  logic A,
	output logic X);

`ifndef SYNTHESIS
    assign X = A;
`else
     sky130_fd_sc_hd__dlygate4sd3_1 u_dly (.X(X),.A(A));
`endif

endmodule

module ctech_delay_clkbuf (
	input  logic A,
	output logic X);

wire X1;
`ifndef SYNTHESIS
    assign X = A;
`else
     sky130_fd_sc_hd__clkbuf_1 u_dly0 (.X(X1),.A(A));
     sky130_fd_sc_hd__clkbuf_1 u_dly1 (.X(X),.A(X1));
`endif

endmodule

module ctech_clk_gate (
	input  logic GATE  ,
	input  logic CLK   ,
	output logic GCLK
     );

`ifndef SYNTHESIS
   assign GCLK = CLK & GATE;
`else
    sky130_fd_sc_hd__dlclkp_2 u_gate(
                                   .GATE    (GATE     ), 
                                   .CLK     (CLK      ), 
                                   .GCLK    (GCLK     )
                                  );
`endif

endmodule

