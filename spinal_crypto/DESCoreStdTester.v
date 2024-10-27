// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : DESCoreStdTester
// Git hash  : f2a4ae9db5e9434c5589d0651efec8719103498e

`timescale 1ns/1ps

module DESCoreStdTester (
  input  wire          io_cmd_valid,
  output wire          io_cmd_ready,
  input  wire [63:0]   io_cmd_payload_key,
  input  wire [63:0]   io_cmd_payload_block,
  input  wire          io_cmd_payload_enc,
  output wire          io_rsp_valid,
  output wire [63:0]   io_rsp_payload_block,
  input  wire          clk,
  input  wire          resetn
);

  wire                des_io_cmd_ready;
  wire                des_io_rsp_valid;
  wire       [63:0]   des_io_rsp_payload_block;

  DESCore_Std des (
    .io_cmd_valid         (io_cmd_valid                  ), //i
    .io_cmd_ready         (des_io_cmd_ready              ), //o
    .io_cmd_payload_key   (io_cmd_payload_key[63:0]      ), //i
    .io_cmd_payload_block (io_cmd_payload_block[63:0]    ), //i
    .io_cmd_payload_enc   (io_cmd_payload_enc            ), //i
    .io_rsp_valid         (des_io_rsp_valid              ), //o
    .io_rsp_payload_block (des_io_rsp_payload_block[63:0]), //o
    .clk                  (clk                           ), //i
    .resetn               (resetn                        )  //i
  );
  assign io_cmd_ready = des_io_cmd_ready;
  assign io_rsp_valid = des_io_rsp_valid;
  assign io_rsp_payload_block = des_io_rsp_payload_block;

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, DESCoreStdTester);
  end

endmodule

module DESCore_Std (
  input  wire          io_cmd_valid,
  output wire          io_cmd_ready,
  input  wire [63:0]   io_cmd_payload_key,
  input  wire [63:0]   io_cmd_payload_block,
  input  wire          io_cmd_payload_enc,
  output wire          io_rsp_valid,
  output wire [63:0]   io_rsp_payload_block,
  input  wire          clk,
  input  wire          resetn
);
  localparam DESCoreState_sInit = 2'd0;
  localparam DESCoreState_sProcessing = 2'd1;
  localparam DESCoreState_sRegister = 2'd2;
  localparam DESCoreState_sResult = 2'd3;

  wire       [3:0]    funcDES_sBox_0_spinal_port0;
  wire       [3:0]    funcDES_sBox_1_spinal_port0;
  wire       [3:0]    funcDES_sBox_2_spinal_port0;
  wire       [3:0]    funcDES_sBox_3_spinal_port0;
  wire       [3:0]    funcDES_sBox_4_spinal_port0;
  wire       [3:0]    funcDES_sBox_5_spinal_port0;
  wire       [3:0]    funcDES_sBox_6_spinal_port0;
  wire       [3:0]    funcDES_sBox_7_spinal_port0;
  wire       [4:0]    _zz_ctnRound_round;
  wire       [4:0]    _zz_ctnRound_round_1;
  wire                _zz_initialBlockPermutation_block;
  wire       [0:0]    _zz_initialBlockPermutation_block_1;
  wire       [54:0]   _zz_initialBlockPermutation_block_2;
  wire                _zz_initialBlockPermutation_block_3;
  wire       [0:0]    _zz_initialBlockPermutation_block_4;
  wire       [43:0]   _zz_initialBlockPermutation_block_5;
  wire                _zz_initialBlockPermutation_block_6;
  wire       [0:0]    _zz_initialBlockPermutation_block_7;
  wire       [32:0]   _zz_initialBlockPermutation_block_8;
  wire                _zz_initialBlockPermutation_block_9;
  wire       [0:0]    _zz_initialBlockPermutation_block_10;
  wire       [21:0]   _zz_initialBlockPermutation_block_11;
  wire                _zz_initialBlockPermutation_block_12;
  wire       [0:0]    _zz_initialBlockPermutation_block_13;
  wire       [10:0]   _zz_initialBlockPermutation_block_14;
  wire                _zz_initialBlockPermutation_block_15;
  wire                _zz_initialBlockPermutation_block_16;
  wire                _zz_keyScheduling_shiftKey;
  wire       [0:0]    _zz_keyScheduling_shiftKey_1;
  wire       [46:0]   _zz_keyScheduling_shiftKey_2;
  wire                _zz_keyScheduling_shiftKey_3;
  wire       [0:0]    _zz_keyScheduling_shiftKey_4;
  wire       [35:0]   _zz_keyScheduling_shiftKey_5;
  wire                _zz_keyScheduling_shiftKey_6;
  wire       [0:0]    _zz_keyScheduling_shiftKey_7;
  wire       [24:0]   _zz_keyScheduling_shiftKey_8;
  wire                _zz_keyScheduling_shiftKey_9;
  wire       [0:0]    _zz_keyScheduling_shiftKey_10;
  wire       [13:0]   _zz_keyScheduling_shiftKey_11;
  wire                _zz_keyScheduling_shiftKey_12;
  wire       [0:0]    _zz_keyScheduling_shiftKey_13;
  wire       [2:0]    _zz_keyScheduling_shiftKey_14;
  wire                _zz_keyScheduling_keyRound;
  wire       [0:0]    _zz_keyScheduling_keyRound_1;
  wire       [38:0]   _zz_keyScheduling_keyRound_2;
  wire                _zz_keyScheduling_keyRound_3;
  wire       [0:0]    _zz_keyScheduling_keyRound_4;
  wire       [27:0]   _zz_keyScheduling_keyRound_5;
  wire                _zz_keyScheduling_keyRound_6;
  wire       [0:0]    _zz_keyScheduling_keyRound_7;
  wire       [16:0]   _zz_keyScheduling_keyRound_8;
  wire                _zz_keyScheduling_keyRound_9;
  wire       [0:0]    _zz_keyScheduling_keyRound_10;
  wire       [5:0]    _zz_keyScheduling_keyRound_11;
  wire                _zz_funcDES_xorRes;
  wire       [0:0]    _zz_funcDES_xorRes_1;
  wire       [39:0]   _zz_funcDES_xorRes_2;
  wire                _zz_funcDES_xorRes_3;
  wire       [0:0]    _zz_funcDES_xorRes_4;
  wire       [28:0]   _zz_funcDES_xorRes_5;
  wire                _zz_funcDES_xorRes_6;
  wire       [0:0]    _zz_funcDES_xorRes_7;
  wire       [17:0]   _zz_funcDES_xorRes_8;
  wire                _zz_funcDES_xorRes_9;
  wire       [0:0]    _zz_funcDES_xorRes_10;
  wire       [6:0]    _zz_funcDES_xorRes_11;
  wire                _zz_funcDES_rResult_1;
  wire       [0:0]    _zz_funcDES_rResult_2;
  wire       [22:0]   _zz_funcDES_rResult_3;
  wire                _zz_funcDES_rResult_4;
  wire       [0:0]    _zz_funcDES_rResult_5;
  wire       [11:0]   _zz_funcDES_rResult_6;
  wire                _zz_funcDES_rResult_7;
  wire       [0:0]    _zz_funcDES_rResult_8;
  wire       [0:0]    _zz_funcDES_rResult_9;
  wire                _zz_finalBlockPermutation_block_1;
  wire       [0:0]    _zz_finalBlockPermutation_block_2;
  wire       [54:0]   _zz_finalBlockPermutation_block_3;
  wire                _zz_finalBlockPermutation_block_4;
  wire       [0:0]    _zz_finalBlockPermutation_block_5;
  wire       [43:0]   _zz_finalBlockPermutation_block_6;
  wire                _zz_finalBlockPermutation_block_7;
  wire       [0:0]    _zz_finalBlockPermutation_block_8;
  wire       [32:0]   _zz_finalBlockPermutation_block_9;
  wire                _zz_finalBlockPermutation_block_10;
  wire       [0:0]    _zz_finalBlockPermutation_block_11;
  wire       [21:0]   _zz_finalBlockPermutation_block_12;
  wire                _zz_finalBlockPermutation_block_13;
  wire       [0:0]    _zz_finalBlockPermutation_block_14;
  wire       [10:0]   _zz_finalBlockPermutation_block_15;
  wire                _zz_finalBlockPermutation_block_16;
  wire                _zz_finalBlockPermutation_block_17;
  wire       [4:0]    roundNbr;
  wire                lastRound;
  reg        [1:0]    sm_state;
  reg                 sm_isInit;
  reg                 sm_isProcessing;
  reg                 sm_isResult;
  wire                when_DESCoreStd_l80;
  reg        [4:0]    ctnRound_round;
  wire       [63:0]   initialBlockPermutation_block;
  reg        [55:0]   keyScheduling_shiftKey;
  reg        [55:0]   keyScheduling_shiftRes;
  wire                when_DESCoreStd_l167;
  wire       [27:0]   _zz_keyScheduling_shiftRes;
  wire       [27:0]   _zz_keyScheduling_shiftRes_1;
  wire       [27:0]   _zz_keyScheduling_shiftRes_2;
  wire       [27:0]   _zz_keyScheduling_shiftRes_3;
  wire       [27:0]   _zz_keyScheduling_shiftRes_4;
  wire       [27:0]   _zz_keyScheduling_shiftRes_5;
  wire       [27:0]   _zz_keyScheduling_shiftRes_6;
  wire       [27:0]   _zz_keyScheduling_shiftRes_7;
  wire                when_DESCoreStd_l180;
  wire       [47:0]   keyScheduling_keyRound;
  wire       [31:0]   funcDES_rightRound;
  wire       [47:0]   funcDES_xorRes;
  wire       [5:0]    funcDES_addrSBox_0;
  wire       [5:0]    funcDES_addrSBox_1;
  wire       [5:0]    funcDES_addrSBox_2;
  wire       [5:0]    funcDES_addrSBox_3;
  wire       [5:0]    funcDES_addrSBox_4;
  wire       [5:0]    funcDES_addrSBox_5;
  wire       [5:0]    funcDES_addrSBox_6;
  wire       [5:0]    funcDES_addrSBox_7;
  wire       [5:0]    _zz_funcDES_boxRes_0;
  wire       [3:0]    funcDES_boxRes_0;
  wire       [5:0]    _zz_funcDES_boxRes_1;
  wire       [3:0]    funcDES_boxRes_1;
  wire       [5:0]    _zz_funcDES_boxRes_2;
  wire       [3:0]    funcDES_boxRes_2;
  wire       [5:0]    _zz_funcDES_boxRes_3;
  wire       [3:0]    funcDES_boxRes_3;
  wire       [5:0]    _zz_funcDES_boxRes_4;
  wire       [3:0]    funcDES_boxRes_4;
  wire       [5:0]    _zz_funcDES_boxRes_5;
  wire       [3:0]    funcDES_boxRes_5;
  wire       [5:0]    _zz_funcDES_boxRes_6;
  wire       [3:0]    funcDES_boxRes_6;
  wire       [5:0]    _zz_funcDES_boxRes_7;
  wire       [3:0]    funcDES_boxRes_7;
  wire       [31:0]   _zz_funcDES_rResult;
  wire       [31:0]   funcDES_rResult;
  reg        [63:0]   feistelNetwork_inBlock;
  wire       [63:0]   feistelNetwork_outBlock;
  wire       [63:0]   _zz_finalBlockPermutation_block;
  wire       [63:0]   finalBlockPermutation_block;
  reg        [63:0]   finalBlockPermutation_block_regNext;
  `ifndef SYNTHESIS
  reg [87:0] sm_state_string;
  `endif

  reg [3:0] funcDES_sBox_0 [0:63];
  reg [3:0] funcDES_sBox_1 [0:63];
  reg [3:0] funcDES_sBox_2 [0:63];
  reg [3:0] funcDES_sBox_3 [0:63];
  reg [3:0] funcDES_sBox_4 [0:63];
  reg [3:0] funcDES_sBox_5 [0:63];
  reg [3:0] funcDES_sBox_6 [0:63];
  reg [3:0] funcDES_sBox_7 [0:63];

  assign _zz_ctnRound_round = (ctnRound_round + 5'h01);
  assign _zz_ctnRound_round_1 = (ctnRound_round - 5'h01);
  assign _zz_initialBlockPermutation_block = io_cmd_payload_block[62];
  assign _zz_initialBlockPermutation_block_1 = io_cmd_payload_block[4];
  assign _zz_initialBlockPermutation_block_2 = {io_cmd_payload_block[12],{io_cmd_payload_block[20],{io_cmd_payload_block[28],{io_cmd_payload_block[36],{io_cmd_payload_block[44],{io_cmd_payload_block[52],{io_cmd_payload_block[60],{io_cmd_payload_block[2],{io_cmd_payload_block[10],{_zz_initialBlockPermutation_block_3,{_zz_initialBlockPermutation_block_4,_zz_initialBlockPermutation_block_5}}}}}}}}}}};
  assign _zz_initialBlockPermutation_block_3 = io_cmd_payload_block[18];
  assign _zz_initialBlockPermutation_block_4 = io_cmd_payload_block[26];
  assign _zz_initialBlockPermutation_block_5 = {io_cmd_payload_block[34],{io_cmd_payload_block[42],{io_cmd_payload_block[50],{io_cmd_payload_block[58],{io_cmd_payload_block[0],{io_cmd_payload_block[8],{io_cmd_payload_block[16],{io_cmd_payload_block[24],{io_cmd_payload_block[32],{_zz_initialBlockPermutation_block_6,{_zz_initialBlockPermutation_block_7,_zz_initialBlockPermutation_block_8}}}}}}}}}}};
  assign _zz_initialBlockPermutation_block_6 = io_cmd_payload_block[40];
  assign _zz_initialBlockPermutation_block_7 = io_cmd_payload_block[48];
  assign _zz_initialBlockPermutation_block_8 = {io_cmd_payload_block[56],{io_cmd_payload_block[7],{io_cmd_payload_block[15],{io_cmd_payload_block[23],{io_cmd_payload_block[31],{io_cmd_payload_block[39],{io_cmd_payload_block[47],{io_cmd_payload_block[55],{io_cmd_payload_block[63],{_zz_initialBlockPermutation_block_9,{_zz_initialBlockPermutation_block_10,_zz_initialBlockPermutation_block_11}}}}}}}}}}};
  assign _zz_initialBlockPermutation_block_9 = io_cmd_payload_block[5];
  assign _zz_initialBlockPermutation_block_10 = io_cmd_payload_block[13];
  assign _zz_initialBlockPermutation_block_11 = {io_cmd_payload_block[21],{io_cmd_payload_block[29],{io_cmd_payload_block[37],{io_cmd_payload_block[45],{io_cmd_payload_block[53],{io_cmd_payload_block[61],{io_cmd_payload_block[3],{io_cmd_payload_block[11],{io_cmd_payload_block[19],{_zz_initialBlockPermutation_block_12,{_zz_initialBlockPermutation_block_13,_zz_initialBlockPermutation_block_14}}}}}}}}}}};
  assign _zz_initialBlockPermutation_block_12 = io_cmd_payload_block[27];
  assign _zz_initialBlockPermutation_block_13 = io_cmd_payload_block[35];
  assign _zz_initialBlockPermutation_block_14 = {io_cmd_payload_block[43],{io_cmd_payload_block[51],{io_cmd_payload_block[59],{io_cmd_payload_block[1],{io_cmd_payload_block[9],{io_cmd_payload_block[17],{io_cmd_payload_block[25],{io_cmd_payload_block[33],{io_cmd_payload_block[41],{_zz_initialBlockPermutation_block_15,_zz_initialBlockPermutation_block_16}}}}}}}}}};
  assign _zz_initialBlockPermutation_block_15 = io_cmd_payload_block[49];
  assign _zz_initialBlockPermutation_block_16 = io_cmd_payload_block[57];
  assign _zz_keyScheduling_shiftKey = io_cmd_payload_key[63];
  assign _zz_keyScheduling_shiftKey_1 = io_cmd_payload_key[6];
  assign _zz_keyScheduling_shiftKey_2 = {io_cmd_payload_key[14],{io_cmd_payload_key[22],{io_cmd_payload_key[30],{io_cmd_payload_key[38],{io_cmd_payload_key[46],{io_cmd_payload_key[54],{io_cmd_payload_key[62],{io_cmd_payload_key[5],{io_cmd_payload_key[13],{_zz_keyScheduling_shiftKey_3,{_zz_keyScheduling_shiftKey_4,_zz_keyScheduling_shiftKey_5}}}}}}}}}}};
  assign _zz_keyScheduling_shiftKey_3 = io_cmd_payload_key[21];
  assign _zz_keyScheduling_shiftKey_4 = io_cmd_payload_key[29];
  assign _zz_keyScheduling_shiftKey_5 = {io_cmd_payload_key[37],{io_cmd_payload_key[45],{io_cmd_payload_key[53],{io_cmd_payload_key[61],{io_cmd_payload_key[4],{io_cmd_payload_key[12],{io_cmd_payload_key[20],{io_cmd_payload_key[28],{io_cmd_payload_key[1],{_zz_keyScheduling_shiftKey_6,{_zz_keyScheduling_shiftKey_7,_zz_keyScheduling_shiftKey_8}}}}}}}}}}};
  assign _zz_keyScheduling_shiftKey_6 = io_cmd_payload_key[9];
  assign _zz_keyScheduling_shiftKey_7 = io_cmd_payload_key[17];
  assign _zz_keyScheduling_shiftKey_8 = {io_cmd_payload_key[25],{io_cmd_payload_key[33],{io_cmd_payload_key[41],{io_cmd_payload_key[49],{io_cmd_payload_key[57],{io_cmd_payload_key[2],{io_cmd_payload_key[10],{io_cmd_payload_key[18],{io_cmd_payload_key[26],{_zz_keyScheduling_shiftKey_9,{_zz_keyScheduling_shiftKey_10,_zz_keyScheduling_shiftKey_11}}}}}}}}}}};
  assign _zz_keyScheduling_shiftKey_9 = io_cmd_payload_key[34];
  assign _zz_keyScheduling_shiftKey_10 = io_cmd_payload_key[42];
  assign _zz_keyScheduling_shiftKey_11 = {io_cmd_payload_key[50],{io_cmd_payload_key[58],{io_cmd_payload_key[3],{io_cmd_payload_key[11],{io_cmd_payload_key[19],{io_cmd_payload_key[27],{io_cmd_payload_key[35],{io_cmd_payload_key[43],{io_cmd_payload_key[51],{_zz_keyScheduling_shiftKey_12,{_zz_keyScheduling_shiftKey_13,_zz_keyScheduling_shiftKey_14}}}}}}}}}}};
  assign _zz_keyScheduling_shiftKey_12 = io_cmd_payload_key[59];
  assign _zz_keyScheduling_shiftKey_13 = io_cmd_payload_key[36];
  assign _zz_keyScheduling_shiftKey_14 = {io_cmd_payload_key[44],{io_cmd_payload_key[52],io_cmd_payload_key[60]}};
  assign _zz_keyScheduling_keyRound = keyScheduling_shiftRes[28];
  assign _zz_keyScheduling_keyRound_1 = keyScheduling_shiftRes[41];
  assign _zz_keyScheduling_keyRound_2 = {keyScheduling_shiftRes[50],{keyScheduling_shiftRes[35],{keyScheduling_shiftRes[46],{keyScheduling_shiftRes[33],{keyScheduling_shiftRes[37],{keyScheduling_shiftRes[44],{keyScheduling_shiftRes[52],{keyScheduling_shiftRes[30],{keyScheduling_shiftRes[48],{_zz_keyScheduling_keyRound_3,{_zz_keyScheduling_keyRound_4,_zz_keyScheduling_keyRound_5}}}}}}}}}}};
  assign _zz_keyScheduling_keyRound_3 = keyScheduling_shiftRes[40];
  assign _zz_keyScheduling_keyRound_4 = keyScheduling_shiftRes[49];
  assign _zz_keyScheduling_keyRound_5 = {keyScheduling_shiftRes[29],{keyScheduling_shiftRes[36],{keyScheduling_shiftRes[43],{keyScheduling_shiftRes[54],{keyScheduling_shiftRes[15],{keyScheduling_shiftRes[4],{keyScheduling_shiftRes[25],{keyScheduling_shiftRes[19],{keyScheduling_shiftRes[9],{_zz_keyScheduling_keyRound_6,{_zz_keyScheduling_keyRound_7,_zz_keyScheduling_keyRound_8}}}}}}}}}}};
  assign _zz_keyScheduling_keyRound_6 = keyScheduling_shiftRes[1];
  assign _zz_keyScheduling_keyRound_7 = keyScheduling_shiftRes[26];
  assign _zz_keyScheduling_keyRound_8 = {keyScheduling_shiftRes[16],{keyScheduling_shiftRes[5],{keyScheduling_shiftRes[11],{keyScheduling_shiftRes[23],{keyScheduling_shiftRes[8],{keyScheduling_shiftRes[12],{keyScheduling_shiftRes[7],{keyScheduling_shiftRes[17],{keyScheduling_shiftRes[0],{_zz_keyScheduling_keyRound_9,{_zz_keyScheduling_keyRound_10,_zz_keyScheduling_keyRound_11}}}}}}}}}}};
  assign _zz_keyScheduling_keyRound_9 = keyScheduling_shiftRes[22];
  assign _zz_keyScheduling_keyRound_10 = keyScheduling_shiftRes[3];
  assign _zz_keyScheduling_keyRound_11 = {keyScheduling_shiftRes[10],{keyScheduling_shiftRes[14],{keyScheduling_shiftRes[6],{keyScheduling_shiftRes[20],{keyScheduling_shiftRes[27],keyScheduling_shiftRes[24]}}}}};
  assign _zz_funcDES_xorRes = funcDES_rightRound[28];
  assign _zz_funcDES_xorRes_1 = funcDES_rightRound[27];
  assign _zz_funcDES_xorRes_2 = {funcDES_rightRound[26],{funcDES_rightRound[25],{funcDES_rightRound[24],{funcDES_rightRound[23],{funcDES_rightRound[24],{funcDES_rightRound[23],{funcDES_rightRound[22],{funcDES_rightRound[21],{funcDES_rightRound[20],{_zz_funcDES_xorRes_3,{_zz_funcDES_xorRes_4,_zz_funcDES_xorRes_5}}}}}}}}}}};
  assign _zz_funcDES_xorRes_3 = funcDES_rightRound[19];
  assign _zz_funcDES_xorRes_4 = funcDES_rightRound[20];
  assign _zz_funcDES_xorRes_5 = {funcDES_rightRound[19],{funcDES_rightRound[18],{funcDES_rightRound[17],{funcDES_rightRound[16],{funcDES_rightRound[15],{funcDES_rightRound[16],{funcDES_rightRound[15],{funcDES_rightRound[14],{funcDES_rightRound[13],{_zz_funcDES_xorRes_6,{_zz_funcDES_xorRes_7,_zz_funcDES_xorRes_8}}}}}}}}}}};
  assign _zz_funcDES_xorRes_6 = funcDES_rightRound[12];
  assign _zz_funcDES_xorRes_7 = funcDES_rightRound[11];
  assign _zz_funcDES_xorRes_8 = {funcDES_rightRound[12],{funcDES_rightRound[11],{funcDES_rightRound[10],{funcDES_rightRound[9],{funcDES_rightRound[8],{funcDES_rightRound[7],{funcDES_rightRound[8],{funcDES_rightRound[7],{funcDES_rightRound[6],{_zz_funcDES_xorRes_9,{_zz_funcDES_xorRes_10,_zz_funcDES_xorRes_11}}}}}}}}}}};
  assign _zz_funcDES_xorRes_9 = funcDES_rightRound[5];
  assign _zz_funcDES_xorRes_10 = funcDES_rightRound[4];
  assign _zz_funcDES_xorRes_11 = {funcDES_rightRound[3],{funcDES_rightRound[4],{funcDES_rightRound[3],{funcDES_rightRound[2],{funcDES_rightRound[1],{funcDES_rightRound[0],funcDES_rightRound[31]}}}}}};
  assign _zz_funcDES_rResult_1 = _zz_funcDES_rResult[15];
  assign _zz_funcDES_rResult_2 = _zz_funcDES_rResult[31];
  assign _zz_funcDES_rResult_3 = {_zz_funcDES_rResult[17],{_zz_funcDES_rResult[9],{_zz_funcDES_rResult[6],{_zz_funcDES_rResult[27],{_zz_funcDES_rResult[14],{_zz_funcDES_rResult[1],{_zz_funcDES_rResult[22],{_zz_funcDES_rResult[30],{_zz_funcDES_rResult[24],{_zz_funcDES_rResult_4,{_zz_funcDES_rResult_5,_zz_funcDES_rResult_6}}}}}}}}}}};
  assign _zz_funcDES_rResult_4 = _zz_funcDES_rResult[8];
  assign _zz_funcDES_rResult_5 = _zz_funcDES_rResult[18];
  assign _zz_funcDES_rResult_6 = {_zz_funcDES_rResult[0],{_zz_funcDES_rResult[5],{_zz_funcDES_rResult[29],{_zz_funcDES_rResult[23],{_zz_funcDES_rResult[13],{_zz_funcDES_rResult[19],{_zz_funcDES_rResult[2],{_zz_funcDES_rResult[26],{_zz_funcDES_rResult[10],{_zz_funcDES_rResult_7,{_zz_funcDES_rResult_8,_zz_funcDES_rResult_9}}}}}}}}}}};
  assign _zz_funcDES_rResult_7 = _zz_funcDES_rResult[21];
  assign _zz_funcDES_rResult_8 = _zz_funcDES_rResult[28];
  assign _zz_funcDES_rResult_9 = _zz_funcDES_rResult[7];
  assign _zz_finalBlockPermutation_block_1 = _zz_finalBlockPermutation_block[32];
  assign _zz_finalBlockPermutation_block_2 = _zz_finalBlockPermutation_block[25];
  assign _zz_finalBlockPermutation_block_3 = {_zz_finalBlockPermutation_block[57],{_zz_finalBlockPermutation_block[17],{_zz_finalBlockPermutation_block[49],{_zz_finalBlockPermutation_block[9],{_zz_finalBlockPermutation_block[41],{_zz_finalBlockPermutation_block[1],{_zz_finalBlockPermutation_block[33],{_zz_finalBlockPermutation_block[26],{_zz_finalBlockPermutation_block[58],{_zz_finalBlockPermutation_block_4,{_zz_finalBlockPermutation_block_5,_zz_finalBlockPermutation_block_6}}}}}}}}}}};
  assign _zz_finalBlockPermutation_block_4 = _zz_finalBlockPermutation_block[18];
  assign _zz_finalBlockPermutation_block_5 = _zz_finalBlockPermutation_block[50];
  assign _zz_finalBlockPermutation_block_6 = {_zz_finalBlockPermutation_block[10],{_zz_finalBlockPermutation_block[42],{_zz_finalBlockPermutation_block[2],{_zz_finalBlockPermutation_block[34],{_zz_finalBlockPermutation_block[27],{_zz_finalBlockPermutation_block[59],{_zz_finalBlockPermutation_block[19],{_zz_finalBlockPermutation_block[51],{_zz_finalBlockPermutation_block[11],{_zz_finalBlockPermutation_block_7,{_zz_finalBlockPermutation_block_8,_zz_finalBlockPermutation_block_9}}}}}}}}}}};
  assign _zz_finalBlockPermutation_block_7 = _zz_finalBlockPermutation_block[43];
  assign _zz_finalBlockPermutation_block_8 = _zz_finalBlockPermutation_block[3];
  assign _zz_finalBlockPermutation_block_9 = {_zz_finalBlockPermutation_block[35],{_zz_finalBlockPermutation_block[28],{_zz_finalBlockPermutation_block[60],{_zz_finalBlockPermutation_block[20],{_zz_finalBlockPermutation_block[52],{_zz_finalBlockPermutation_block[12],{_zz_finalBlockPermutation_block[44],{_zz_finalBlockPermutation_block[4],{_zz_finalBlockPermutation_block[36],{_zz_finalBlockPermutation_block_10,{_zz_finalBlockPermutation_block_11,_zz_finalBlockPermutation_block_12}}}}}}}}}}};
  assign _zz_finalBlockPermutation_block_10 = _zz_finalBlockPermutation_block[29];
  assign _zz_finalBlockPermutation_block_11 = _zz_finalBlockPermutation_block[61];
  assign _zz_finalBlockPermutation_block_12 = {_zz_finalBlockPermutation_block[21],{_zz_finalBlockPermutation_block[53],{_zz_finalBlockPermutation_block[13],{_zz_finalBlockPermutation_block[45],{_zz_finalBlockPermutation_block[5],{_zz_finalBlockPermutation_block[37],{_zz_finalBlockPermutation_block[30],{_zz_finalBlockPermutation_block[62],{_zz_finalBlockPermutation_block[22],{_zz_finalBlockPermutation_block_13,{_zz_finalBlockPermutation_block_14,_zz_finalBlockPermutation_block_15}}}}}}}}}}};
  assign _zz_finalBlockPermutation_block_13 = _zz_finalBlockPermutation_block[54];
  assign _zz_finalBlockPermutation_block_14 = _zz_finalBlockPermutation_block[14];
  assign _zz_finalBlockPermutation_block_15 = {_zz_finalBlockPermutation_block[46],{_zz_finalBlockPermutation_block[6],{_zz_finalBlockPermutation_block[38],{_zz_finalBlockPermutation_block[31],{_zz_finalBlockPermutation_block[63],{_zz_finalBlockPermutation_block[23],{_zz_finalBlockPermutation_block[55],{_zz_finalBlockPermutation_block[15],{_zz_finalBlockPermutation_block[47],{_zz_finalBlockPermutation_block_16,_zz_finalBlockPermutation_block_17}}}}}}}}}};
  assign _zz_finalBlockPermutation_block_16 = _zz_finalBlockPermutation_block[7];
  assign _zz_finalBlockPermutation_block_17 = _zz_finalBlockPermutation_block[39];
  initial begin
    $readmemb("DESCoreStdTester.v_toplevel_des_funcDES_sBox_0.bin",funcDES_sBox_0);
  end
  assign funcDES_sBox_0_spinal_port0 = funcDES_sBox_0[_zz_funcDES_boxRes_0];
  initial begin
    $readmemb("DESCoreStdTester.v_toplevel_des_funcDES_sBox_1.bin",funcDES_sBox_1);
  end
  assign funcDES_sBox_1_spinal_port0 = funcDES_sBox_1[_zz_funcDES_boxRes_1];
  initial begin
    $readmemb("DESCoreStdTester.v_toplevel_des_funcDES_sBox_2.bin",funcDES_sBox_2);
  end
  assign funcDES_sBox_2_spinal_port0 = funcDES_sBox_2[_zz_funcDES_boxRes_2];
  initial begin
    $readmemb("DESCoreStdTester.v_toplevel_des_funcDES_sBox_3.bin",funcDES_sBox_3);
  end
  assign funcDES_sBox_3_spinal_port0 = funcDES_sBox_3[_zz_funcDES_boxRes_3];
  initial begin
    $readmemb("DESCoreStdTester.v_toplevel_des_funcDES_sBox_4.bin",funcDES_sBox_4);
  end
  assign funcDES_sBox_4_spinal_port0 = funcDES_sBox_4[_zz_funcDES_boxRes_4];
  initial begin
    $readmemb("DESCoreStdTester.v_toplevel_des_funcDES_sBox_5.bin",funcDES_sBox_5);
  end
  assign funcDES_sBox_5_spinal_port0 = funcDES_sBox_5[_zz_funcDES_boxRes_5];
  initial begin
    $readmemb("DESCoreStdTester.v_toplevel_des_funcDES_sBox_6.bin",funcDES_sBox_6);
  end
  assign funcDES_sBox_6_spinal_port0 = funcDES_sBox_6[_zz_funcDES_boxRes_6];
  initial begin
    $readmemb("DESCoreStdTester.v_toplevel_des_funcDES_sBox_7.bin",funcDES_sBox_7);
  end
  assign funcDES_sBox_7_spinal_port0 = funcDES_sBox_7[_zz_funcDES_boxRes_7];
  `ifndef SYNTHESIS
  always @(*) begin
    case(sm_state)
      DESCoreState_sInit : sm_state_string = "sInit      ";
      DESCoreState_sProcessing : sm_state_string = "sProcessing";
      DESCoreState_sRegister : sm_state_string = "sRegister  ";
      DESCoreState_sResult : sm_state_string = "sResult    ";
      default : sm_state_string = "???????????";
    endcase
  end
  `endif

  assign lastRound = (io_cmd_payload_enc ? (roundNbr == 5'h0e) : (roundNbr == 5'h02));
  always @(*) begin
    sm_isInit = 1'b0;
    case(sm_state)
      DESCoreState_sInit : begin
        sm_isInit = 1'b1;
      end
      DESCoreState_sProcessing : begin
      end
      DESCoreState_sRegister : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    sm_isProcessing = 1'b0;
    case(sm_state)
      DESCoreState_sInit : begin
      end
      DESCoreState_sProcessing : begin
        sm_isProcessing = 1'b1;
      end
      DESCoreState_sRegister : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    sm_isResult = 1'b0;
    case(sm_state)
      DESCoreState_sInit : begin
      end
      DESCoreState_sProcessing : begin
      end
      DESCoreState_sRegister : begin
      end
      default : begin
        sm_isResult = 1'b1;
      end
    endcase
  end

  assign when_DESCoreStd_l80 = (io_cmd_valid && (! io_cmd_ready));
  assign roundNbr = ctnRound_round;
  assign initialBlockPermutation_block = {io_cmd_payload_block[6],{io_cmd_payload_block[14],{io_cmd_payload_block[22],{io_cmd_payload_block[30],{io_cmd_payload_block[38],{io_cmd_payload_block[46],{io_cmd_payload_block[54],{_zz_initialBlockPermutation_block,{_zz_initialBlockPermutation_block_1,_zz_initialBlockPermutation_block_2}}}}}}}}};
  assign when_DESCoreStd_l167 = ((((ctnRound_round == 5'h0) || (ctnRound_round == 5'h01)) || (ctnRound_round == 5'h08)) || (ctnRound_round == 5'h0f));
  assign _zz_keyScheduling_shiftRes = keyScheduling_shiftKey[55 : 28];
  assign _zz_keyScheduling_shiftRes_1 = keyScheduling_shiftKey[27 : 0];
  always @(*) begin
    if(when_DESCoreStd_l167) begin
      if(io_cmd_payload_enc) begin
        keyScheduling_shiftRes = {{_zz_keyScheduling_shiftRes[26 : 0],_zz_keyScheduling_shiftRes[27 : 27]},{_zz_keyScheduling_shiftRes_1[26 : 0],_zz_keyScheduling_shiftRes_1[27 : 27]}};
      end else begin
        keyScheduling_shiftRes = {{_zz_keyScheduling_shiftRes_2[0 : 0],_zz_keyScheduling_shiftRes_2[27 : 1]},{_zz_keyScheduling_shiftRes_3[0 : 0],_zz_keyScheduling_shiftRes_3[27 : 1]}};
      end
    end else begin
      if(io_cmd_payload_enc) begin
        keyScheduling_shiftRes = {{_zz_keyScheduling_shiftRes_4[25 : 0],_zz_keyScheduling_shiftRes_4[27 : 26]},{_zz_keyScheduling_shiftRes_5[25 : 0],_zz_keyScheduling_shiftRes_5[27 : 26]}};
      end else begin
        keyScheduling_shiftRes = {{_zz_keyScheduling_shiftRes_6[1 : 0],_zz_keyScheduling_shiftRes_6[27 : 2]},{_zz_keyScheduling_shiftRes_7[1 : 0],_zz_keyScheduling_shiftRes_7[27 : 2]}};
        if(when_DESCoreStd_l180) begin
          keyScheduling_shiftRes = keyScheduling_shiftKey;
        end
      end
    end
  end

  assign _zz_keyScheduling_shiftRes_2 = keyScheduling_shiftKey[55 : 28];
  assign _zz_keyScheduling_shiftRes_3 = keyScheduling_shiftKey[27 : 0];
  assign _zz_keyScheduling_shiftRes_4 = keyScheduling_shiftKey[55 : 28];
  assign _zz_keyScheduling_shiftRes_5 = keyScheduling_shiftKey[27 : 0];
  assign _zz_keyScheduling_shiftRes_6 = keyScheduling_shiftKey[55 : 28];
  assign _zz_keyScheduling_shiftRes_7 = keyScheduling_shiftKey[27 : 0];
  assign when_DESCoreStd_l180 = (ctnRound_round == 5'h10);
  assign keyScheduling_keyRound = {keyScheduling_shiftRes[42],{keyScheduling_shiftRes[39],{keyScheduling_shiftRes[45],{keyScheduling_shiftRes[32],{keyScheduling_shiftRes[55],{keyScheduling_shiftRes[51],{keyScheduling_shiftRes[53],{_zz_keyScheduling_keyRound,{_zz_keyScheduling_keyRound_1,_zz_keyScheduling_keyRound_2}}}}}}}}};
  assign funcDES_xorRes = (keyScheduling_keyRound ^ {funcDES_rightRound[0],{funcDES_rightRound[31],{funcDES_rightRound[30],{funcDES_rightRound[29],{funcDES_rightRound[28],{funcDES_rightRound[27],{_zz_funcDES_xorRes,{_zz_funcDES_xorRes_1,_zz_funcDES_xorRes_2}}}}}}}});
  assign funcDES_addrSBox_0 = funcDES_xorRes[5 : 0];
  assign funcDES_addrSBox_1 = funcDES_xorRes[11 : 6];
  assign funcDES_addrSBox_2 = funcDES_xorRes[17 : 12];
  assign funcDES_addrSBox_3 = funcDES_xorRes[23 : 18];
  assign funcDES_addrSBox_4 = funcDES_xorRes[29 : 24];
  assign funcDES_addrSBox_5 = funcDES_xorRes[35 : 30];
  assign funcDES_addrSBox_6 = funcDES_xorRes[41 : 36];
  assign funcDES_addrSBox_7 = funcDES_xorRes[47 : 42];
  assign _zz_funcDES_boxRes_0 = {{funcDES_addrSBox_0[5],funcDES_addrSBox_0[0]},funcDES_addrSBox_0[4 : 1]};
  assign funcDES_boxRes_0 = funcDES_sBox_0_spinal_port0;
  assign _zz_funcDES_boxRes_1 = {{funcDES_addrSBox_1[5],funcDES_addrSBox_1[0]},funcDES_addrSBox_1[4 : 1]};
  assign funcDES_boxRes_1 = funcDES_sBox_1_spinal_port0;
  assign _zz_funcDES_boxRes_2 = {{funcDES_addrSBox_2[5],funcDES_addrSBox_2[0]},funcDES_addrSBox_2[4 : 1]};
  assign funcDES_boxRes_2 = funcDES_sBox_2_spinal_port0;
  assign _zz_funcDES_boxRes_3 = {{funcDES_addrSBox_3[5],funcDES_addrSBox_3[0]},funcDES_addrSBox_3[4 : 1]};
  assign funcDES_boxRes_3 = funcDES_sBox_3_spinal_port0;
  assign _zz_funcDES_boxRes_4 = {{funcDES_addrSBox_4[5],funcDES_addrSBox_4[0]},funcDES_addrSBox_4[4 : 1]};
  assign funcDES_boxRes_4 = funcDES_sBox_4_spinal_port0;
  assign _zz_funcDES_boxRes_5 = {{funcDES_addrSBox_5[5],funcDES_addrSBox_5[0]},funcDES_addrSBox_5[4 : 1]};
  assign funcDES_boxRes_5 = funcDES_sBox_5_spinal_port0;
  assign _zz_funcDES_boxRes_6 = {{funcDES_addrSBox_6[5],funcDES_addrSBox_6[0]},funcDES_addrSBox_6[4 : 1]};
  assign funcDES_boxRes_6 = funcDES_sBox_6_spinal_port0;
  assign _zz_funcDES_boxRes_7 = {{funcDES_addrSBox_7[5],funcDES_addrSBox_7[0]},funcDES_addrSBox_7[4 : 1]};
  assign funcDES_boxRes_7 = funcDES_sBox_7_spinal_port0;
  assign _zz_funcDES_rResult = {funcDES_boxRes_7,{funcDES_boxRes_6,{funcDES_boxRes_5,{funcDES_boxRes_4,{funcDES_boxRes_3,{funcDES_boxRes_2,{funcDES_boxRes_1,funcDES_boxRes_0}}}}}}};
  assign funcDES_rResult = {_zz_funcDES_rResult[16],{_zz_funcDES_rResult[25],{_zz_funcDES_rResult[12],{_zz_funcDES_rResult[11],{_zz_funcDES_rResult[3],{_zz_funcDES_rResult[20],{_zz_funcDES_rResult[4],{_zz_funcDES_rResult_1,{_zz_funcDES_rResult_2,_zz_funcDES_rResult_3}}}}}}}}};
  assign feistelNetwork_outBlock = {feistelNetwork_inBlock[31 : 0],(feistelNetwork_inBlock[63 : 32] ^ funcDES_rResult)};
  assign funcDES_rightRound = feistelNetwork_inBlock[31 : 0];
  assign _zz_finalBlockPermutation_block = {feistelNetwork_outBlock[31 : 0],feistelNetwork_outBlock[63 : 32]};
  assign finalBlockPermutation_block = {_zz_finalBlockPermutation_block[24],{_zz_finalBlockPermutation_block[56],{_zz_finalBlockPermutation_block[16],{_zz_finalBlockPermutation_block[48],{_zz_finalBlockPermutation_block[8],{_zz_finalBlockPermutation_block[40],{_zz_finalBlockPermutation_block[0],{_zz_finalBlockPermutation_block_1,{_zz_finalBlockPermutation_block_2,_zz_finalBlockPermutation_block_3}}}}}}}}};
  assign io_rsp_payload_block = finalBlockPermutation_block_regNext;
  assign io_rsp_valid = sm_isResult;
  assign io_cmd_ready = sm_isResult;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      sm_state <= DESCoreState_sInit;
      ctnRound_round <= 5'h0;
    end else begin
      case(sm_state)
        DESCoreState_sInit : begin
          if(when_DESCoreStd_l80) begin
            sm_state <= DESCoreState_sProcessing;
          end
        end
        DESCoreState_sProcessing : begin
          if(lastRound) begin
            sm_state <= DESCoreState_sRegister;
          end
        end
        DESCoreState_sRegister : begin
          sm_state <= DESCoreState_sResult;
        end
        default : begin
          sm_state <= DESCoreState_sInit;
        end
      endcase
      if(sm_isInit) begin
        ctnRound_round <= (io_cmd_payload_enc ? 5'h0 : 5'h10);
      end
      if(sm_isProcessing) begin
        ctnRound_round <= (io_cmd_payload_enc ? _zz_ctnRound_round : _zz_ctnRound_round_1);
      end
    end
  end

  always @(posedge clk) begin
    if(sm_isInit) begin
      keyScheduling_shiftKey <= {io_cmd_payload_key[7],{io_cmd_payload_key[15],{io_cmd_payload_key[23],{io_cmd_payload_key[31],{io_cmd_payload_key[39],{io_cmd_payload_key[47],{io_cmd_payload_key[55],{_zz_keyScheduling_shiftKey,{_zz_keyScheduling_shiftKey_1,_zz_keyScheduling_shiftKey_2}}}}}}}}};
    end
    if(sm_isProcessing) begin
      keyScheduling_shiftKey <= keyScheduling_shiftRes;
    end
    if(sm_isInit) begin
      feistelNetwork_inBlock <= initialBlockPermutation_block;
    end
    if(sm_isProcessing) begin
      feistelNetwork_inBlock <= feistelNetwork_outBlock;
    end
    finalBlockPermutation_block_regNext <= finalBlockPermutation_block;
  end


endmodule
