//
// Generated by Bluespec Compiler, version 2019.05.beta2 (build a88bf40, 2019-05-24)
//
// On Sun Mar 22 00:26:26 UTC 2020
//
//
// Ports:
// Name                         I/O  size props
// RDY_request_put                O     1
// response_get                   O    64
// RDY_response_get               O     1
// CLK                            I     1 clock
// RST_N                          I     1 reset
// request_put                    I    86
// EN_request_put                 I     1
// EN_response_get                I     1
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

module mkBeriBootMemServer(CLK,
			   RST_N,

			   request_put,
			   EN_request_put,
			   RDY_request_put,

			   EN_response_get,
			   response_get,
			   RDY_response_get);
  input  CLK;
  input  RST_N;

  // action method request_put
  input  [85 : 0] request_put;
  input  EN_request_put;
  output RDY_request_put;

  // actionvalue method response_get
  input  EN_response_get;
  output [63 : 0] response_get;
  output RDY_response_get;

  // signals for module outputs
  wire [63 : 0] response_get;
  wire RDY_request_put, RDY_response_get;

  // inlined wires
  wire [64 : 0] resp_rv$port0__write_1,
		resp_rv$port1__read,
		resp_rv$port1__write_1,
		resp_rv$port2__read;
  wire [63 : 0] mem_serverAdapterA_outData_outData$wget;
  wire mem_serverAdapterA_outData_deqCalled$whas,
       mem_serverAdapterA_outData_enqData$whas,
       mem_serverAdapterA_outData_outData$whas,
       mem_serverAdapterB_outData_enqData$whas;

  // register mem_serverAdapterA_cnt
  reg [2 : 0] mem_serverAdapterA_cnt;
  wire [2 : 0] mem_serverAdapterA_cnt$D_IN;
  wire mem_serverAdapterA_cnt$EN;

  // register mem_serverAdapterA_s1
  reg [1 : 0] mem_serverAdapterA_s1;
  wire [1 : 0] mem_serverAdapterA_s1$D_IN;
  wire mem_serverAdapterA_s1$EN;

  // register mem_serverAdapterB_cnt
  reg [2 : 0] mem_serverAdapterB_cnt;
  wire [2 : 0] mem_serverAdapterB_cnt$D_IN;
  wire mem_serverAdapterB_cnt$EN;

  // register mem_serverAdapterB_s1
  reg [1 : 0] mem_serverAdapterB_s1;
  wire [1 : 0] mem_serverAdapterB_s1$D_IN;
  wire mem_serverAdapterB_s1$EN;

  // register resp_rv
  reg [64 : 0] resp_rv;
  wire [64 : 0] resp_rv$D_IN;
  wire resp_rv$EN;

  // register state
  reg [1 : 0] state;
  wire [1 : 0] state$D_IN;
  wire state$EN;

  // ports of submodule mem_memory
  wire [63 : 0] mem_memory$DIA,
		mem_memory$DIB,
		mem_memory$DOA,
		mem_memory$DOB;
  wire [12 : 0] mem_memory$ADDRA, mem_memory$ADDRB;
  wire mem_memory$ENA, mem_memory$ENB, mem_memory$WEA, mem_memory$WEB;

  // ports of submodule mem_serverAdapterA_outDataCore
  wire [63 : 0] mem_serverAdapterA_outDataCore$D_IN,
		mem_serverAdapterA_outDataCore$D_OUT;
  wire mem_serverAdapterA_outDataCore$CLR,
       mem_serverAdapterA_outDataCore$DEQ,
       mem_serverAdapterA_outDataCore$EMPTY_N,
       mem_serverAdapterA_outDataCore$ENQ,
       mem_serverAdapterA_outDataCore$FULL_N;

  // ports of submodule mem_serverAdapterB_outDataCore
  wire [63 : 0] mem_serverAdapterB_outDataCore$D_IN;
  wire mem_serverAdapterB_outDataCore$CLR,
       mem_serverAdapterB_outDataCore$DEQ,
       mem_serverAdapterB_outDataCore$ENQ,
       mem_serverAdapterB_outDataCore$FULL_N;

  // ports of submodule req
  wire [85 : 0] req$D_IN, req$D_OUT;
  wire req$CLR, req$DEQ, req$EMPTY_N, req$ENQ, req$FULL_N;

  // rule scheduling signals
  wire WILL_FIRE_RL_mem_serverAdapterA_outData_enqAndDeq,
       WILL_FIRE_RL_mem_serverAdapterA_outData_setFirstEnq,
       WILL_FIRE_RL_readRam,
       WILL_FIRE_RL_writeRam;

  // inputs to muxes for submodule ports
  wire MUX_state$write_1__SEL_1;

  // remaining internal signals
  wire [2 : 0] mem_serverAdapterA_cnt_6_PLUS_IF_mem_serverAda_ETC___d32;
  wire mem_serverAdapterA_outDataCore_notEmpty_OR_mem_ETC___d131;

  // action method request_put
  assign RDY_request_put =
	     state == 2'd0 && (mem_serverAdapterA_cnt ^ 3'h4) < 3'd7 &&
	     req$FULL_N ;

  // actionvalue method response_get
  assign response_get = resp_rv$port1__read[63:0] ;
  assign RDY_response_get = resp_rv$port1__read[64] ;

  // submodule mem_memory
  BRAM2Load #(.FILENAME("mem64.hex"),
	      .PIPELINED(1'd0),
	      .ADDR_WIDTH(32'd13),
	      .DATA_WIDTH(32'd64),
	      .MEMSIZE(14'd8192),
	      .BINARY(1'd0)) mem_memory(.CLKA(CLK),
					.CLKB(CLK),
					.ADDRA(mem_memory$ADDRA),
					.ADDRB(mem_memory$ADDRB),
					.DIA(mem_memory$DIA),
					.DIB(mem_memory$DIB),
					.WEA(mem_memory$WEA),
					.WEB(mem_memory$WEB),
					.ENA(mem_memory$ENA),
					.ENB(mem_memory$ENB),
					.DOA(mem_memory$DOA),
					.DOB(mem_memory$DOB));

  // submodule mem_serverAdapterA_outDataCore
  SizedFIFO #(.p1width(32'd64),
	      .p2depth(32'd3),
	      .p3cntr_width(32'd1),
	      .guarded(32'd1)) mem_serverAdapterA_outDataCore(.RST(RST_N),
							      .CLK(CLK),
							      .D_IN(mem_serverAdapterA_outDataCore$D_IN),
							      .ENQ(mem_serverAdapterA_outDataCore$ENQ),
							      .DEQ(mem_serverAdapterA_outDataCore$DEQ),
							      .CLR(mem_serverAdapterA_outDataCore$CLR),
							      .D_OUT(mem_serverAdapterA_outDataCore$D_OUT),
							      .FULL_N(mem_serverAdapterA_outDataCore$FULL_N),
							      .EMPTY_N(mem_serverAdapterA_outDataCore$EMPTY_N));

  // submodule mem_serverAdapterB_outDataCore
  SizedFIFO #(.p1width(32'd64),
	      .p2depth(32'd3),
	      .p3cntr_width(32'd1),
	      .guarded(32'd1)) mem_serverAdapterB_outDataCore(.RST(RST_N),
							      .CLK(CLK),
							      .D_IN(mem_serverAdapterB_outDataCore$D_IN),
							      .ENQ(mem_serverAdapterB_outDataCore$ENQ),
							      .DEQ(mem_serverAdapterB_outDataCore$DEQ),
							      .CLR(mem_serverAdapterB_outDataCore$CLR),
							      .D_OUT(),
							      .FULL_N(mem_serverAdapterB_outDataCore$FULL_N),
							      .EMPTY_N());

  // submodule req
  FIFOL1 #(.width(32'd86)) req(.RST(RST_N),
			       .CLK(CLK),
			       .D_IN(req$D_IN),
			       .ENQ(req$ENQ),
			       .DEQ(req$DEQ),
			       .CLR(req$CLR),
			       .D_OUT(req$D_OUT),
			       .FULL_N(req$FULL_N),
			       .EMPTY_N(req$EMPTY_N));

  // rule RL_mem_serverAdapterA_outData_setFirstEnq
  assign WILL_FIRE_RL_mem_serverAdapterA_outData_setFirstEnq =
	     !mem_serverAdapterA_outDataCore$EMPTY_N &&
	     mem_serverAdapterA_outData_enqData$whas ;

  // rule RL_readRam
  assign WILL_FIRE_RL_readRam =
	     (mem_serverAdapterA_outDataCore$EMPTY_N ||
	      mem_serverAdapterA_outData_enqData$whas) &&
	     mem_serverAdapterA_outData_outData$whas &&
	     !resp_rv[64] &&
	     state == 2'd0 ;

  // rule RL_writeRam
  assign WILL_FIRE_RL_writeRam =
	     mem_serverAdapterA_outDataCore_notEmpty_OR_mem_ETC___d131 &&
	     state == 2'd2 ;

  // rule RL_mem_serverAdapterA_outData_enqAndDeq
  assign WILL_FIRE_RL_mem_serverAdapterA_outData_enqAndDeq =
	     mem_serverAdapterA_outDataCore$EMPTY_N &&
	     mem_serverAdapterA_outDataCore$FULL_N &&
	     mem_serverAdapterA_outData_deqCalled$whas &&
	     mem_serverAdapterA_outData_enqData$whas ;

  // inputs to muxes for submodule ports
  assign MUX_state$write_1__SEL_1 =
	     EN_request_put && request_put[85:78] != 8'd0 ;

  // inlined wires
  assign mem_serverAdapterA_outData_enqData$whas =
	     mem_serverAdapterA_outDataCore$FULL_N &&
	     mem_serverAdapterA_s1[1] &&
	     mem_serverAdapterA_s1[0] ;
  assign mem_serverAdapterA_outData_outData$wget =
	     WILL_FIRE_RL_mem_serverAdapterA_outData_setFirstEnq ?
	       mem_memory$DOA :
	       mem_serverAdapterA_outDataCore$D_OUT ;
  assign mem_serverAdapterA_outData_outData$whas =
	     WILL_FIRE_RL_mem_serverAdapterA_outData_setFirstEnq ||
	     mem_serverAdapterA_outDataCore$EMPTY_N ;
  assign mem_serverAdapterB_outData_enqData$whas =
	     mem_serverAdapterB_outDataCore$FULL_N &&
	     mem_serverAdapterB_s1[1] &&
	     mem_serverAdapterB_s1[0] ;
  assign mem_serverAdapterA_outData_deqCalled$whas =
	     WILL_FIRE_RL_writeRam || WILL_FIRE_RL_readRam ;
  assign resp_rv$port0__write_1 =
	     { 1'd1, mem_serverAdapterA_outData_outData$wget } ;
  assign resp_rv$port1__read =
	     WILL_FIRE_RL_readRam ? resp_rv$port0__write_1 : resp_rv ;
  assign resp_rv$port1__write_1 =
	     { 1'd0,
	       64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx /* unspecified value */  } ;
  assign resp_rv$port2__read =
	     EN_response_get ? resp_rv$port1__write_1 : resp_rv$port1__read ;

  // register mem_serverAdapterA_cnt
  assign mem_serverAdapterA_cnt$D_IN =
	     mem_serverAdapterA_cnt_6_PLUS_IF_mem_serverAda_ETC___d32 ;
  assign mem_serverAdapterA_cnt$EN =
	     EN_request_put || mem_serverAdapterA_outData_deqCalled$whas ;

  // register mem_serverAdapterA_s1
  assign mem_serverAdapterA_s1$D_IN = { EN_request_put, 1'b1 } ;
  assign mem_serverAdapterA_s1$EN = 1'd1 ;

  // register mem_serverAdapterB_cnt
  assign mem_serverAdapterB_cnt$D_IN = mem_serverAdapterB_cnt + 3'd0 + 3'd0 ;
  assign mem_serverAdapterB_cnt$EN = 1'b0 ;

  // register mem_serverAdapterB_s1
  assign mem_serverAdapterB_s1$D_IN = { WILL_FIRE_RL_writeRam, 1'b0 } ;
  assign mem_serverAdapterB_s1$EN = 1'd1 ;

  // register resp_rv
  assign resp_rv$D_IN = resp_rv$port2__read ;
  assign resp_rv$EN = 1'b1 ;

  // register state
  assign state$D_IN = MUX_state$write_1__SEL_1 ? 2'd2 : 2'd0 ;
  assign state$EN =
	     EN_request_put && request_put[85:78] != 8'd0 ||
	     WILL_FIRE_RL_writeRam ;

  // submodule mem_memory
  assign mem_memory$ADDRA = request_put[76:64] ;
  assign mem_memory$ADDRB = req$D_OUT[76:64] ;
  assign mem_memory$DIA =
	     64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx /* unspecified value */  ;
  assign mem_memory$DIB =
	     { req$D_OUT[85] ?
		 req$D_OUT[63:56] :
		 mem_serverAdapterA_outData_outData$wget[63:56],
	       req$D_OUT[84] ?
		 req$D_OUT[55:48] :
		 mem_serverAdapterA_outData_outData$wget[55:48],
	       req$D_OUT[83] ?
		 req$D_OUT[47:40] :
		 mem_serverAdapterA_outData_outData$wget[47:40],
	       req$D_OUT[82] ?
		 req$D_OUT[39:32] :
		 mem_serverAdapterA_outData_outData$wget[39:32],
	       req$D_OUT[81] ?
		 req$D_OUT[31:24] :
		 mem_serverAdapterA_outData_outData$wget[31:24],
	       req$D_OUT[80] ?
		 req$D_OUT[23:16] :
		 mem_serverAdapterA_outData_outData$wget[23:16],
	       req$D_OUT[79] ?
		 req$D_OUT[15:8] :
		 mem_serverAdapterA_outData_outData$wget[15:8],
	       req$D_OUT[78] ?
		 req$D_OUT[7:0] :
		 mem_serverAdapterA_outData_outData$wget[7:0] } ;
  assign mem_memory$WEA = 1'd0 ;
  assign mem_memory$WEB = 1'd1 ;
  assign mem_memory$ENA = EN_request_put ;
  assign mem_memory$ENB = WILL_FIRE_RL_writeRam ;

  // submodule mem_serverAdapterA_outDataCore
  assign mem_serverAdapterA_outDataCore$D_IN = mem_memory$DOA ;
  assign mem_serverAdapterA_outDataCore$ENQ =
	     WILL_FIRE_RL_mem_serverAdapterA_outData_enqAndDeq ||
	     mem_serverAdapterA_outDataCore$FULL_N &&
	     !mem_serverAdapterA_outData_deqCalled$whas &&
	     mem_serverAdapterA_outData_enqData$whas ;
  assign mem_serverAdapterA_outDataCore$DEQ =
	     WILL_FIRE_RL_mem_serverAdapterA_outData_enqAndDeq ||
	     mem_serverAdapterA_outDataCore$EMPTY_N &&
	     mem_serverAdapterA_outData_deqCalled$whas &&
	     !mem_serverAdapterA_outData_enqData$whas ;
  assign mem_serverAdapterA_outDataCore$CLR = 1'b0 ;

  // submodule mem_serverAdapterB_outDataCore
  assign mem_serverAdapterB_outDataCore$D_IN = mem_memory$DOB ;
  assign mem_serverAdapterB_outDataCore$ENQ =
	     mem_serverAdapterB_outDataCore$FULL_N &&
	     mem_serverAdapterB_outData_enqData$whas ;
  assign mem_serverAdapterB_outDataCore$DEQ = 1'b0 ;
  assign mem_serverAdapterB_outDataCore$CLR = 1'b0 ;

  // submodule req
  assign req$D_IN = request_put ;
  assign req$ENQ = EN_request_put && request_put[85:78] != 8'd0 ;
  assign req$DEQ =
	     mem_serverAdapterA_outDataCore_notEmpty_OR_mem_ETC___d131 &&
	     state == 2'd2 ;
  assign req$CLR = 1'b0 ;

  // remaining internal signals
  assign mem_serverAdapterA_cnt_6_PLUS_IF_mem_serverAda_ETC___d32 =
	     mem_serverAdapterA_cnt + (EN_request_put ? 3'd1 : 3'd0) +
	     (mem_serverAdapterA_outData_deqCalled$whas ? 3'd7 : 3'd0) ;
  assign mem_serverAdapterA_outDataCore_notEmpty_OR_mem_ETC___d131 =
	     (mem_serverAdapterA_outDataCore$EMPTY_N ||
	      mem_serverAdapterA_outData_enqData$whas) &&
	     (mem_serverAdapterB_cnt ^ 3'h4) < 3'd7 &&
	     req$EMPTY_N &&
	     mem_serverAdapterA_outData_outData$whas ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        mem_serverAdapterA_cnt <= `BSV_ASSIGNMENT_DELAY 3'd0;
	mem_serverAdapterA_s1 <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 1'bx /* unspecified value */  };
	mem_serverAdapterB_cnt <= `BSV_ASSIGNMENT_DELAY 3'd0;
	mem_serverAdapterB_s1 <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 1'bx /* unspecified value */  };
	resp_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0,
	      64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx /* unspecified value */  };
	state <= `BSV_ASSIGNMENT_DELAY 2'd0;
      end
    else
      begin
        if (mem_serverAdapterA_cnt$EN)
	  mem_serverAdapterA_cnt <= `BSV_ASSIGNMENT_DELAY
	      mem_serverAdapterA_cnt$D_IN;
	if (mem_serverAdapterA_s1$EN)
	  mem_serverAdapterA_s1 <= `BSV_ASSIGNMENT_DELAY
	      mem_serverAdapterA_s1$D_IN;
	if (mem_serverAdapterB_cnt$EN)
	  mem_serverAdapterB_cnt <= `BSV_ASSIGNMENT_DELAY
	      mem_serverAdapterB_cnt$D_IN;
	if (mem_serverAdapterB_s1$EN)
	  mem_serverAdapterB_s1 <= `BSV_ASSIGNMENT_DELAY
	      mem_serverAdapterB_s1$D_IN;
	if (resp_rv$EN) resp_rv <= `BSV_ASSIGNMENT_DELAY resp_rv$D_IN;
	if (state$EN) state <= `BSV_ASSIGNMENT_DELAY state$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    mem_serverAdapterA_cnt = 3'h2;
    mem_serverAdapterA_s1 = 2'h2;
    mem_serverAdapterB_cnt = 3'h2;
    mem_serverAdapterB_s1 = 2'h2;
    resp_rv = 65'h0AAAAAAAAAAAAAAAA;
    state = 2'h2;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      if (mem_serverAdapterA_s1[1] && !mem_serverAdapterA_outDataCore$FULL_N)
	$display("ERROR: %m: mkBRAMSeverAdapter overrun");
    if (RST_N != `BSV_RESET_VALUE)
      if (mem_serverAdapterB_s1[1] && !mem_serverAdapterB_outDataCore$FULL_N)
	$display("ERROR: %m: mkBRAMSeverAdapter overrun");
  end
  // synopsys translate_on
endmodule  // mkBeriBootMemServer
