//
// Generated by Bluespec Compiler, version 2019.05.beta2 (build a88bf40, 2019-05-24)
//
// On Sun Mar 22 00:26:23 UTC 2020
//
//
// Ports:
// Name                         I/O  size props
// slave_request_canPut           O     1 reg
// RDY_slave_request_put          O     1 reg
// slave_response_canGet          O     1 reg
// slave_response_peek            O    78
// RDY_slave_response_peek        O     1 reg
// slave_response_get             O    78
// RDY_slave_response_get         O     1 reg
// CLK                            I     1 clock
// RST_N                          I     1 reset
// slave_request_put_val          I   134
// EN_slave_request_put           I     1
// EN_slave_response_get          I     1
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkNullPerif(CLK,
		   RST_N,

		   slave_request_canPut,

		   slave_request_put_val,
		   EN_slave_request_put,
		   RDY_slave_request_put,

		   slave_response_canGet,

		   slave_response_peek,
		   RDY_slave_response_peek,

		   EN_slave_response_get,
		   slave_response_get,
		   RDY_slave_response_get);
  input  CLK;
  input  RST_N;

  // value method slave_request_canPut
  output slave_request_canPut;

  // action method slave_request_put
  input  [133 : 0] slave_request_put_val;
  input  EN_slave_request_put;
  output RDY_slave_request_put;

  // value method slave_response_canGet
  output slave_response_canGet;

  // value method slave_response_peek
  output [77 : 0] slave_response_peek;
  output RDY_slave_response_peek;

  // actionvalue method slave_response_get
  input  EN_slave_response_get;
  output [77 : 0] slave_response_get;
  output RDY_slave_response_get;

  // value method getIrqs

  // signals for module outputs
  wire [77 : 0] slave_response_get, slave_response_peek;
  wire RDY_slave_request_put,
       RDY_slave_response_get,
       RDY_slave_response_peek,
       slave_request_canPut,
       slave_response_canGet;

  // register count
  reg [15 : 0] count;
  wire [15 : 0] count$D_IN;
  wire count$EN;

  // ports of submodule req_fifo
  wire [133 : 0] req_fifo$D_IN, req_fifo$D_OUT;
  wire req_fifo$CLR,
       req_fifo$DEQ,
       req_fifo$EMPTY_N,
       req_fifo$ENQ,
       req_fifo$FULL_N;

  // ports of submodule resp_fifo
  wire [77 : 0] resp_fifo$D_IN, resp_fifo$D_OUT;
  wire resp_fifo$CLR,
       resp_fifo$DEQ,
       resp_fifo$EMPTY_N,
       resp_fifo$ENQ,
       resp_fifo$FULL_N;

  // remaining internal signals
  reg [2 : 0] CASE_resp_fifoD_OUT_BITS_67_TO_66_0_resp_fifo_ETC__q1;
  reg [1 : 0] CASE_slave_request_put_val_BITS_85_TO_84_0_sla_ETC__q2;

  // value method slave_request_canPut
  assign slave_request_canPut = req_fifo$FULL_N ;

  // action method slave_request_put
  assign RDY_slave_request_put = req_fifo$FULL_N ;

  // value method slave_response_canGet
  assign slave_response_canGet = resp_fifo$EMPTY_N ;

  // value method slave_response_peek
  assign slave_response_peek =
	     { resp_fifo$D_OUT[77:68],
	       CASE_resp_fifoD_OUT_BITS_67_TO_66_0_resp_fifo_ETC__q1,
	       resp_fifo$D_OUT[64:0] } ;
  assign RDY_slave_response_peek = resp_fifo$EMPTY_N ;

  // actionvalue method slave_response_get
  assign slave_response_get =
	     { resp_fifo$D_OUT[77:68],
	       CASE_resp_fifoD_OUT_BITS_67_TO_66_0_resp_fifo_ETC__q1,
	       resp_fifo$D_OUT[64:0] } ;
  assign RDY_slave_response_get = resp_fifo$EMPTY_N ;

  // submodule req_fifo
  FIFO1 #(.width(32'd134), .guarded(32'd1)) req_fifo(.RST(RST_N),
						     .CLK(CLK),
						     .D_IN(req_fifo$D_IN),
						     .ENQ(req_fifo$ENQ),
						     .DEQ(req_fifo$DEQ),
						     .CLR(req_fifo$CLR),
						     .D_OUT(req_fifo$D_OUT),
						     .FULL_N(req_fifo$FULL_N),
						     .EMPTY_N(req_fifo$EMPTY_N));

  // submodule resp_fifo
  FIFO1 #(.width(32'd78), .guarded(32'd1)) resp_fifo(.RST(RST_N),
						     .CLK(CLK),
						     .D_IN(resp_fifo$D_IN),
						     .ENQ(resp_fifo$ENQ),
						     .DEQ(resp_fifo$DEQ),
						     .CLR(resp_fifo$CLR),
						     .D_OUT(resp_fifo$D_OUT),
						     .FULL_N(resp_fifo$FULL_N),
						     .EMPTY_N(resp_fifo$EMPTY_N));

  // register count
  assign count$D_IN = 16'h0 ;
  assign count$EN = 1'b0 ;

  // submodule req_fifo
  assign req_fifo$D_IN =
	     { slave_request_put_val[133:86],
	       CASE_slave_request_put_val_BITS_85_TO_84_0_sla_ETC__q2,
	       slave_request_put_val[83:0] } ;
  assign req_fifo$ENQ = EN_slave_request_put ;
  assign req_fifo$DEQ = req_fifo$EMPTY_N && resp_fifo$FULL_N ;
  assign req_fifo$CLR = 1'b0 ;

  // submodule resp_fifo
  assign resp_fifo$D_IN =
	     { req_fifo$D_OUT[93:86],
	       2'd1,
	       (req_fifo$D_OUT[85:84] == 2'd0) ?
		 3'd1 :
		 { 2'd1, 1'bx /* unspecified value */  },
	       65'd0 } ;
  assign resp_fifo$ENQ = req_fifo$EMPTY_N && resp_fifo$FULL_N ;
  assign resp_fifo$DEQ = EN_slave_response_get ;
  assign resp_fifo$CLR = 1'b0 ;

  // remaining internal signals
  always@(resp_fifo$D_OUT)
  begin
    case (resp_fifo$D_OUT[67:66])
      2'd0, 2'd1:
	  CASE_resp_fifoD_OUT_BITS_67_TO_66_0_resp_fifo_ETC__q1 =
	      resp_fifo$D_OUT[67:65];
      default: CASE_resp_fifoD_OUT_BITS_67_TO_66_0_resp_fifo_ETC__q1 =
		   { 2'd2, resp_fifo$D_OUT[65] };
    endcase
  end
  always@(slave_request_put_val)
  begin
    case (slave_request_put_val[85:84])
      2'd0, 2'd1:
	  CASE_slave_request_put_val_BITS_85_TO_84_0_sla_ETC__q2 =
	      slave_request_put_val[85:84];
      default: CASE_slave_request_put_val_BITS_85_TO_84_0_sla_ETC__q2 = 2'd2;
    endcase
  end

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        count <= `BSV_ASSIGNMENT_DELAY 16'd0;
      end
    else
      begin
        if (count$EN) count <= `BSV_ASSIGNMENT_DELAY count$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    count = 16'hAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkNullPerif

