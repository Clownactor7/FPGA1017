// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : AESCore_Std
// Git hash  : f2a4ae9db5e9434c5589d0651efec8719103498e

`timescale 1ns/1ps

module AESCore_Std (
  input  wire          io_cmd_valid,
  output wire          io_cmd_ready,
  input  wire [127:0]  io_cmd_payload_key,
  input  wire [127:0]  io_cmd_payload_block,
  input  wire          io_cmd_payload_enc,
  output wire          io_rsp_valid,
  output wire [127:0]  io_rsp_payload_block,
  input  wire          clk,
  input  wire          reset
);
  localparam AESKeyScheduleCmdMode_Std_INIT = 1'd0;
  localparam AESKeyScheduleCmdMode_Std_NEXT_1 = 1'd1;

  wire                engine_io_engine_cmd_ready;
  wire                engine_io_engine_rsp_valid;
  wire       [127:0]  engine_io_engine_rsp_payload_block;
  wire                engine_io_keySchedule_cmd_valid;
  wire       [0:0]    engine_io_keySchedule_cmd_payload_mode;
  wire       [3:0]    engine_io_keySchedule_cmd_payload_round;
  wire       [127:0]  engine_io_keySchedule_cmd_payload_key;
  wire                keySchedule_io_cmd_ready;
  wire       [127:0]  keySchedule_io_key_i;

  AESEngine_Std engine (
    .io_engine_cmd_valid              (io_cmd_valid                                ), //i
    .io_engine_cmd_ready              (engine_io_engine_cmd_ready                  ), //o
    .io_engine_cmd_payload_key        (io_cmd_payload_key[127:0]                   ), //i
    .io_engine_cmd_payload_block      (io_cmd_payload_block[127:0]                 ), //i
    .io_engine_cmd_payload_enc        (io_cmd_payload_enc                          ), //i
    .io_engine_rsp_valid              (engine_io_engine_rsp_valid                  ), //o
    .io_engine_rsp_payload_block      (engine_io_engine_rsp_payload_block[127:0]   ), //o
    .io_keySchedule_cmd_valid         (engine_io_keySchedule_cmd_valid             ), //o
    .io_keySchedule_cmd_ready         (keySchedule_io_cmd_ready                    ), //i
    .io_keySchedule_cmd_payload_mode  (engine_io_keySchedule_cmd_payload_mode      ), //o
    .io_keySchedule_cmd_payload_round (engine_io_keySchedule_cmd_payload_round[3:0]), //o
    .io_keySchedule_cmd_payload_key   (engine_io_keySchedule_cmd_payload_key[127:0]), //o
    .io_keySchedule_key_i             (keySchedule_io_key_i[127:0]                 ), //i
    .clk                              (clk                                         ), //i
    .reset                            (reset                                       )  //i
  );
  AESKeyScheduleCore_Std keySchedule (
    .io_cmd_valid         (engine_io_keySchedule_cmd_valid             ), //i
    .io_cmd_ready         (keySchedule_io_cmd_ready                    ), //o
    .io_cmd_payload_mode  (engine_io_keySchedule_cmd_payload_mode      ), //i
    .io_cmd_payload_round (engine_io_keySchedule_cmd_payload_round[3:0]), //i
    .io_cmd_payload_key   (engine_io_keySchedule_cmd_payload_key[127:0]), //i
    .io_key_i             (keySchedule_io_key_i[127:0]                 ), //o
    .clk                  (clk                                         ), //i
    .reset                (reset                                       )  //i
  );
  assign io_cmd_ready = engine_io_engine_cmd_ready;
  assign io_rsp_valid = engine_io_engine_rsp_valid;
  assign io_rsp_payload_block = engine_io_engine_rsp_payload_block;

endmodule

module AESKeyScheduleCore_Std (
  input  wire          io_cmd_valid,
  output wire          io_cmd_ready,
  input  wire [0:0]    io_cmd_payload_mode,
  input  wire [3:0]    io_cmd_payload_round,
  input  wire [127:0]  io_cmd_payload_key,
  output wire [127:0]  io_key_i,
  input  wire          clk,
  input  wire          reset
);
  localparam AESKeyScheduleCmdMode_Std_INIT = 1'd0;
  localparam AESKeyScheduleCmdMode_Std_NEXT_1 = 1'd1;

  wire       [7:0]    rconMem_spinal_port0;
  wire       [7:0]    sBoxMem_spinal_port0;
  wire       [7:0]    sBoxMem_spinal_port1;
  wire       [7:0]    sBoxMem_spinal_port2;
  wire       [7:0]    sBoxMem_spinal_port3;
  wire       [3:0]    _zz_when_AESKeyScheduleCoreStd_l231;
  reg        [31:0]   stateKey_0;
  reg        [31:0]   stateKey_1;
  reg        [31:0]   stateKey_2;
  reg        [31:0]   stateKey_3;
  wire       [31:0]   stateKey_tmp_0;
  wire       [31:0]   stateKey_tmp_1;
  wire       [31:0]   stateKey_tmp_2;
  wire       [31:0]   stateKey_tmp_3;
  reg        [3:0]    cntRound;
  wire       [31:0]   _zz_stateKey_3;
  wire       [31:0]   _zz_stateKey_2;
  wire       [31:0]   _zz_stateKey_1;
  wire       [31:0]   _zz_stateKey_0;
  reg                 autoUpdate;
  reg                 cmdready;
  reg        [3:0]    cntStage;
  reg        [1:0]    selKey;
  wire                when_AESKeyScheduleCoreStd_l128;
  wire                when_AESKeyScheduleCoreStd_l133;
  reg        [31:0]   _zz_stateKey_tmp_0;
  wire       [7:0]    _zz_stateKey_tmp_0_1;
  wire       [7:0]    _zz_stateKey_tmp_0_2;
  wire       [7:0]    _zz_stateKey_tmp_0_3;
  wire       [7:0]    _zz_stateKey_tmp_0_4;
  reg                 updateKey_storeKey;
  wire                when_AESKeyScheduleCoreStd_l202;
  wire                when_AESKeyScheduleCoreStd_l204;
  wire                when_AESKeyScheduleCoreStd_l213;
  wire                when_AESKeyScheduleCoreStd_l231;
  wire                when_AESKeyScheduleCoreStd_l240;
  `ifndef SYNTHESIS
  reg [47:0] io_cmd_payload_mode_string;
  `endif

  reg [7:0] rconMem [0:10];
  reg [7:0] sBoxMem [0:255];

  assign _zz_when_AESKeyScheduleCoreStd_l231 = (io_cmd_payload_round - 4'b0001);
  initial begin
    rconMem[0] = 8'b10001101;
    rconMem[1] = 8'b00000001;
    rconMem[2] = 8'b00000010;
    rconMem[3] = 8'b00000100;
    rconMem[4] = 8'b00001000;
    rconMem[5] = 8'b00010000;
    rconMem[6] = 8'b00100000;
    rconMem[7] = 8'b01000000;
    rconMem[8] = 8'b10000000;
    rconMem[9] = 8'b00011011;
    rconMem[10] = 8'b00110110;
  end
  assign rconMem_spinal_port0 = rconMem[cntRound];
  initial begin
    sBoxMem[0] = 8'b01100011;
    sBoxMem[1] = 8'b01111100;
    sBoxMem[2] = 8'b01110111;
    sBoxMem[3] = 8'b01111011;
    sBoxMem[4] = 8'b11110010;
    sBoxMem[5] = 8'b01101011;
    sBoxMem[6] = 8'b01101111;
    sBoxMem[7] = 8'b11000101;
    sBoxMem[8] = 8'b00110000;
    sBoxMem[9] = 8'b00000001;
    sBoxMem[10] = 8'b01100111;
    sBoxMem[11] = 8'b00101011;
    sBoxMem[12] = 8'b11111110;
    sBoxMem[13] = 8'b11010111;
    sBoxMem[14] = 8'b10101011;
    sBoxMem[15] = 8'b01110110;
    sBoxMem[16] = 8'b11001010;
    sBoxMem[17] = 8'b10000010;
    sBoxMem[18] = 8'b11001001;
    sBoxMem[19] = 8'b01111101;
    sBoxMem[20] = 8'b11111010;
    sBoxMem[21] = 8'b01011001;
    sBoxMem[22] = 8'b01000111;
    sBoxMem[23] = 8'b11110000;
    sBoxMem[24] = 8'b10101101;
    sBoxMem[25] = 8'b11010100;
    sBoxMem[26] = 8'b10100010;
    sBoxMem[27] = 8'b10101111;
    sBoxMem[28] = 8'b10011100;
    sBoxMem[29] = 8'b10100100;
    sBoxMem[30] = 8'b01110010;
    sBoxMem[31] = 8'b11000000;
    sBoxMem[32] = 8'b10110111;
    sBoxMem[33] = 8'b11111101;
    sBoxMem[34] = 8'b10010011;
    sBoxMem[35] = 8'b00100110;
    sBoxMem[36] = 8'b00110110;
    sBoxMem[37] = 8'b00111111;
    sBoxMem[38] = 8'b11110111;
    sBoxMem[39] = 8'b11001100;
    sBoxMem[40] = 8'b00110100;
    sBoxMem[41] = 8'b10100101;
    sBoxMem[42] = 8'b11100101;
    sBoxMem[43] = 8'b11110001;
    sBoxMem[44] = 8'b01110001;
    sBoxMem[45] = 8'b11011000;
    sBoxMem[46] = 8'b00110001;
    sBoxMem[47] = 8'b00010101;
    sBoxMem[48] = 8'b00000100;
    sBoxMem[49] = 8'b11000111;
    sBoxMem[50] = 8'b00100011;
    sBoxMem[51] = 8'b11000011;
    sBoxMem[52] = 8'b00011000;
    sBoxMem[53] = 8'b10010110;
    sBoxMem[54] = 8'b00000101;
    sBoxMem[55] = 8'b10011010;
    sBoxMem[56] = 8'b00000111;
    sBoxMem[57] = 8'b00010010;
    sBoxMem[58] = 8'b10000000;
    sBoxMem[59] = 8'b11100010;
    sBoxMem[60] = 8'b11101011;
    sBoxMem[61] = 8'b00100111;
    sBoxMem[62] = 8'b10110010;
    sBoxMem[63] = 8'b01110101;
    sBoxMem[64] = 8'b00001001;
    sBoxMem[65] = 8'b10000011;
    sBoxMem[66] = 8'b00101100;
    sBoxMem[67] = 8'b00011010;
    sBoxMem[68] = 8'b00011011;
    sBoxMem[69] = 8'b01101110;
    sBoxMem[70] = 8'b01011010;
    sBoxMem[71] = 8'b10100000;
    sBoxMem[72] = 8'b01010010;
    sBoxMem[73] = 8'b00111011;
    sBoxMem[74] = 8'b11010110;
    sBoxMem[75] = 8'b10110011;
    sBoxMem[76] = 8'b00101001;
    sBoxMem[77] = 8'b11100011;
    sBoxMem[78] = 8'b00101111;
    sBoxMem[79] = 8'b10000100;
    sBoxMem[80] = 8'b01010011;
    sBoxMem[81] = 8'b11010001;
    sBoxMem[82] = 8'b00000000;
    sBoxMem[83] = 8'b11101101;
    sBoxMem[84] = 8'b00100000;
    sBoxMem[85] = 8'b11111100;
    sBoxMem[86] = 8'b10110001;
    sBoxMem[87] = 8'b01011011;
    sBoxMem[88] = 8'b01101010;
    sBoxMem[89] = 8'b11001011;
    sBoxMem[90] = 8'b10111110;
    sBoxMem[91] = 8'b00111001;
    sBoxMem[92] = 8'b01001010;
    sBoxMem[93] = 8'b01001100;
    sBoxMem[94] = 8'b01011000;
    sBoxMem[95] = 8'b11001111;
    sBoxMem[96] = 8'b11010000;
    sBoxMem[97] = 8'b11101111;
    sBoxMem[98] = 8'b10101010;
    sBoxMem[99] = 8'b11111011;
    sBoxMem[100] = 8'b01000011;
    sBoxMem[101] = 8'b01001101;
    sBoxMem[102] = 8'b00110011;
    sBoxMem[103] = 8'b10000101;
    sBoxMem[104] = 8'b01000101;
    sBoxMem[105] = 8'b11111001;
    sBoxMem[106] = 8'b00000010;
    sBoxMem[107] = 8'b01111111;
    sBoxMem[108] = 8'b01010000;
    sBoxMem[109] = 8'b00111100;
    sBoxMem[110] = 8'b10011111;
    sBoxMem[111] = 8'b10101000;
    sBoxMem[112] = 8'b01010001;
    sBoxMem[113] = 8'b10100011;
    sBoxMem[114] = 8'b01000000;
    sBoxMem[115] = 8'b10001111;
    sBoxMem[116] = 8'b10010010;
    sBoxMem[117] = 8'b10011101;
    sBoxMem[118] = 8'b00111000;
    sBoxMem[119] = 8'b11110101;
    sBoxMem[120] = 8'b10111100;
    sBoxMem[121] = 8'b10110110;
    sBoxMem[122] = 8'b11011010;
    sBoxMem[123] = 8'b00100001;
    sBoxMem[124] = 8'b00010000;
    sBoxMem[125] = 8'b11111111;
    sBoxMem[126] = 8'b11110011;
    sBoxMem[127] = 8'b11010010;
    sBoxMem[128] = 8'b11001101;
    sBoxMem[129] = 8'b00001100;
    sBoxMem[130] = 8'b00010011;
    sBoxMem[131] = 8'b11101100;
    sBoxMem[132] = 8'b01011111;
    sBoxMem[133] = 8'b10010111;
    sBoxMem[134] = 8'b01000100;
    sBoxMem[135] = 8'b00010111;
    sBoxMem[136] = 8'b11000100;
    sBoxMem[137] = 8'b10100111;
    sBoxMem[138] = 8'b01111110;
    sBoxMem[139] = 8'b00111101;
    sBoxMem[140] = 8'b01100100;
    sBoxMem[141] = 8'b01011101;
    sBoxMem[142] = 8'b00011001;
    sBoxMem[143] = 8'b01110011;
    sBoxMem[144] = 8'b01100000;
    sBoxMem[145] = 8'b10000001;
    sBoxMem[146] = 8'b01001111;
    sBoxMem[147] = 8'b11011100;
    sBoxMem[148] = 8'b00100010;
    sBoxMem[149] = 8'b00101010;
    sBoxMem[150] = 8'b10010000;
    sBoxMem[151] = 8'b10001000;
    sBoxMem[152] = 8'b01000110;
    sBoxMem[153] = 8'b11101110;
    sBoxMem[154] = 8'b10111000;
    sBoxMem[155] = 8'b00010100;
    sBoxMem[156] = 8'b11011110;
    sBoxMem[157] = 8'b01011110;
    sBoxMem[158] = 8'b00001011;
    sBoxMem[159] = 8'b11011011;
    sBoxMem[160] = 8'b11100000;
    sBoxMem[161] = 8'b00110010;
    sBoxMem[162] = 8'b00111010;
    sBoxMem[163] = 8'b00001010;
    sBoxMem[164] = 8'b01001001;
    sBoxMem[165] = 8'b00000110;
    sBoxMem[166] = 8'b00100100;
    sBoxMem[167] = 8'b01011100;
    sBoxMem[168] = 8'b11000010;
    sBoxMem[169] = 8'b11010011;
    sBoxMem[170] = 8'b10101100;
    sBoxMem[171] = 8'b01100010;
    sBoxMem[172] = 8'b10010001;
    sBoxMem[173] = 8'b10010101;
    sBoxMem[174] = 8'b11100100;
    sBoxMem[175] = 8'b01111001;
    sBoxMem[176] = 8'b11100111;
    sBoxMem[177] = 8'b11001000;
    sBoxMem[178] = 8'b00110111;
    sBoxMem[179] = 8'b01101101;
    sBoxMem[180] = 8'b10001101;
    sBoxMem[181] = 8'b11010101;
    sBoxMem[182] = 8'b01001110;
    sBoxMem[183] = 8'b10101001;
    sBoxMem[184] = 8'b01101100;
    sBoxMem[185] = 8'b01010110;
    sBoxMem[186] = 8'b11110100;
    sBoxMem[187] = 8'b11101010;
    sBoxMem[188] = 8'b01100101;
    sBoxMem[189] = 8'b01111010;
    sBoxMem[190] = 8'b10101110;
    sBoxMem[191] = 8'b00001000;
    sBoxMem[192] = 8'b10111010;
    sBoxMem[193] = 8'b01111000;
    sBoxMem[194] = 8'b00100101;
    sBoxMem[195] = 8'b00101110;
    sBoxMem[196] = 8'b00011100;
    sBoxMem[197] = 8'b10100110;
    sBoxMem[198] = 8'b10110100;
    sBoxMem[199] = 8'b11000110;
    sBoxMem[200] = 8'b11101000;
    sBoxMem[201] = 8'b11011101;
    sBoxMem[202] = 8'b01110100;
    sBoxMem[203] = 8'b00011111;
    sBoxMem[204] = 8'b01001011;
    sBoxMem[205] = 8'b10111101;
    sBoxMem[206] = 8'b10001011;
    sBoxMem[207] = 8'b10001010;
    sBoxMem[208] = 8'b01110000;
    sBoxMem[209] = 8'b00111110;
    sBoxMem[210] = 8'b10110101;
    sBoxMem[211] = 8'b01100110;
    sBoxMem[212] = 8'b01001000;
    sBoxMem[213] = 8'b00000011;
    sBoxMem[214] = 8'b11110110;
    sBoxMem[215] = 8'b00001110;
    sBoxMem[216] = 8'b01100001;
    sBoxMem[217] = 8'b00110101;
    sBoxMem[218] = 8'b01010111;
    sBoxMem[219] = 8'b10111001;
    sBoxMem[220] = 8'b10000110;
    sBoxMem[221] = 8'b11000001;
    sBoxMem[222] = 8'b00011101;
    sBoxMem[223] = 8'b10011110;
    sBoxMem[224] = 8'b11100001;
    sBoxMem[225] = 8'b11111000;
    sBoxMem[226] = 8'b10011000;
    sBoxMem[227] = 8'b00010001;
    sBoxMem[228] = 8'b01101001;
    sBoxMem[229] = 8'b11011001;
    sBoxMem[230] = 8'b10001110;
    sBoxMem[231] = 8'b10010100;
    sBoxMem[232] = 8'b10011011;
    sBoxMem[233] = 8'b00011110;
    sBoxMem[234] = 8'b10000111;
    sBoxMem[235] = 8'b11101001;
    sBoxMem[236] = 8'b11001110;
    sBoxMem[237] = 8'b01010101;
    sBoxMem[238] = 8'b00101000;
    sBoxMem[239] = 8'b11011111;
    sBoxMem[240] = 8'b10001100;
    sBoxMem[241] = 8'b10100001;
    sBoxMem[242] = 8'b10001001;
    sBoxMem[243] = 8'b00001101;
    sBoxMem[244] = 8'b10111111;
    sBoxMem[245] = 8'b11100110;
    sBoxMem[246] = 8'b01000010;
    sBoxMem[247] = 8'b01101000;
    sBoxMem[248] = 8'b01000001;
    sBoxMem[249] = 8'b10011001;
    sBoxMem[250] = 8'b00101101;
    sBoxMem[251] = 8'b00001111;
    sBoxMem[252] = 8'b10110000;
    sBoxMem[253] = 8'b01010100;
    sBoxMem[254] = 8'b10111011;
    sBoxMem[255] = 8'b00010110;
  end
  assign sBoxMem_spinal_port0 = sBoxMem[_zz_stateKey_tmp_0_1];
  assign sBoxMem_spinal_port1 = sBoxMem[_zz_stateKey_tmp_0_2];
  assign sBoxMem_spinal_port2 = sBoxMem[_zz_stateKey_tmp_0_3];
  assign sBoxMem_spinal_port3 = sBoxMem[_zz_stateKey_tmp_0_4];
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_cmd_payload_mode)
      AESKeyScheduleCmdMode_Std_INIT : io_cmd_payload_mode_string = "INIT  ";
      AESKeyScheduleCmdMode_Std_NEXT_1 : io_cmd_payload_mode_string = "NEXT_1";
      default : io_cmd_payload_mode_string = "??????";
    endcase
  end
  `endif

  assign _zz_stateKey_3 = io_cmd_payload_key[31 : 0];
  assign _zz_stateKey_2 = io_cmd_payload_key[63 : 32];
  assign _zz_stateKey_1 = io_cmd_payload_key[95 : 64];
  assign _zz_stateKey_0 = io_cmd_payload_key[127 : 96];
  assign io_cmd_ready = cmdready;
  assign io_key_i = {stateKey_0,{stateKey_1,{stateKey_2,stateKey_3}}};
  assign when_AESKeyScheduleCoreStd_l128 = (((io_cmd_valid && (io_cmd_payload_mode == AESKeyScheduleCmdMode_Std_INIT)) && (! cmdready)) && (! autoUpdate));
  assign when_AESKeyScheduleCoreStd_l133 = (io_cmd_payload_round == 4'b1011);
  assign _zz_stateKey_tmp_0_1 = stateKey_3[23 : 16];
  always @(*) begin
    _zz_stateKey_tmp_0[31 : 24] = (sBoxMem_spinal_port0 ^ rconMem_spinal_port0);
    _zz_stateKey_tmp_0[23 : 16] = sBoxMem_spinal_port1;
    _zz_stateKey_tmp_0[15 : 8] = sBoxMem_spinal_port2;
    _zz_stateKey_tmp_0[7 : 0] = sBoxMem_spinal_port3;
  end

  assign _zz_stateKey_tmp_0_2 = stateKey_3[15 : 8];
  assign _zz_stateKey_tmp_0_3 = stateKey_3[7 : 0];
  assign _zz_stateKey_tmp_0_4 = stateKey_3[31 : 24];
  assign stateKey_tmp_0 = (stateKey_0 ^ _zz_stateKey_tmp_0);
  assign stateKey_tmp_1 = (stateKey_tmp_0 ^ stateKey_1);
  assign stateKey_tmp_2 = (stateKey_tmp_1 ^ stateKey_2);
  assign stateKey_tmp_3 = (stateKey_tmp_2 ^ stateKey_3);
  always @(*) begin
    updateKey_storeKey = 1'b0;
    if(when_AESKeyScheduleCoreStd_l202) begin
      if(when_AESKeyScheduleCoreStd_l204) begin
        updateKey_storeKey = 1'b1;
      end
    end
    if(autoUpdate) begin
      updateKey_storeKey = 1'b1;
    end
  end

  assign when_AESKeyScheduleCoreStd_l202 = ((((io_cmd_valid && (io_cmd_payload_mode == AESKeyScheduleCmdMode_Std_NEXT_1)) && (! cmdready)) && (! autoUpdate)) && (! cmdready));
  assign when_AESKeyScheduleCoreStd_l204 = (cntRound == io_cmd_payload_round);
  assign when_AESKeyScheduleCoreStd_l213 = (io_cmd_payload_round == 4'b0001);
  assign when_AESKeyScheduleCoreStd_l231 = (cntRound == _zz_when_AESKeyScheduleCoreStd_l231);
  assign when_AESKeyScheduleCoreStd_l240 = (selKey == 2'b10);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      autoUpdate <= 1'b0;
      cmdready <= 1'b0;
    end else begin
      if(cmdready) begin
        cmdready <= 1'b0;
      end
      if(when_AESKeyScheduleCoreStd_l128) begin
        if(when_AESKeyScheduleCoreStd_l133) begin
          autoUpdate <= 1'b1;
        end else begin
          cmdready <= 1'b1;
        end
      end
      if(when_AESKeyScheduleCoreStd_l202) begin
        if(when_AESKeyScheduleCoreStd_l204) begin
          cmdready <= 1'b1;
          autoUpdate <= 1'b0;
        end else begin
          if(when_AESKeyScheduleCoreStd_l213) begin
            cmdready <= 1'b1;
          end else begin
            autoUpdate <= 1'b1;
          end
        end
      end
      if(autoUpdate) begin
        if(when_AESKeyScheduleCoreStd_l231) begin
          cmdready <= 1'b1;
          autoUpdate <= 1'b0;
        end
      end
    end
  end

  always @(posedge clk) begin
    if(when_AESKeyScheduleCoreStd_l128) begin
      stateKey_0 <= _zz_stateKey_0;
      stateKey_1 <= _zz_stateKey_1;
      stateKey_2 <= _zz_stateKey_2;
      stateKey_3 <= _zz_stateKey_3;
      if(when_AESKeyScheduleCoreStd_l133) begin
        cntRound <= 4'b0001;
      end else begin
        cntRound <= 4'b0001;
      end
      cntStage <= 4'b0001;
      selKey <= 2'b00;
    end
    if(when_AESKeyScheduleCoreStd_l202) begin
      if(when_AESKeyScheduleCoreStd_l204) begin
        cntRound <= (cntRound + 4'b0001);
        selKey <= (selKey + 2'b01);
      end else begin
        cntRound <= 4'b0001;
        cntStage <= 4'b0001;
        selKey <= 2'b00;
        stateKey_0 <= _zz_stateKey_0;
        stateKey_1 <= _zz_stateKey_1;
        stateKey_2 <= _zz_stateKey_2;
        stateKey_3 <= _zz_stateKey_3;
      end
    end
    if(autoUpdate) begin
      cntRound <= (cntRound + 4'b0001);
      selKey <= (selKey + 2'b01);
    end
    if(updateKey_storeKey) begin
      if(when_AESKeyScheduleCoreStd_l240) begin
        selKey <= 2'b00;
      end
      stateKey_0 <= stateKey_tmp_0;
      stateKey_1 <= stateKey_tmp_1;
      stateKey_2 <= stateKey_tmp_2;
      stateKey_3 <= stateKey_tmp_3;
    end
  end


endmodule

module AESEngine_Std (
  input  wire          io_engine_cmd_valid,
  output wire          io_engine_cmd_ready,
  input  wire [127:0]  io_engine_cmd_payload_key,
  input  wire [127:0]  io_engine_cmd_payload_block,
  input  wire          io_engine_cmd_payload_enc,
  output wire          io_engine_rsp_valid,
  output wire [127:0]  io_engine_rsp_payload_block,
  output wire          io_keySchedule_cmd_valid,
  input  wire          io_keySchedule_cmd_ready,
  output wire [0:0]    io_keySchedule_cmd_payload_mode,
  output wire [3:0]    io_keySchedule_cmd_payload_round,
  output wire [127:0]  io_keySchedule_cmd_payload_key,
  input  wire [127:0]  io_keySchedule_key_i,
  input  wire          clk,
  input  wire          reset
);
  localparam AESKeyScheduleCmdMode_Std_INIT = 1'd0;
  localparam AESKeyScheduleCmdMode_Std_NEXT_1 = 1'd1;
  localparam sm_enumDef_BOOT = 3'd0;
  localparam sm_enumDef_sIdle = 3'd1;
  localparam sm_enumDef_sKeyAdd = 3'd2;
  localparam sm_enumDef_sByteSub = 3'd3;
  localparam sm_enumDef_sShiftRow = 3'd4;
  localparam sm_enumDef_sMixColumn = 3'd5;

  wire       [7:0]    sBoxMem_spinal_port0;
  wire       [7:0]    sBoxMemInv_spinal_port0;
  wire       [3:0]    _zz_byteSubstitution_cntByte_valueNext;
  wire       [0:0]    _zz_byteSubstitution_cntByte_valueNext_1;
  reg        [7:0]    _zz__zz_dataState_0_1;
  wire       [3:0]    _zz__zz_20;
  reg        [7:0]    _zz__zz_dataState_0_6;
  wire       [3:0]    _zz__zz_dataState_0_6_1;
  reg        [7:0]    _zz__zz_dataState_0_8;
  wire       [3:0]    _zz__zz_dataState_0_8_1;
  reg        [7:0]    _zz__zz_dataState_0_17;
  wire       [3:0]    _zz__zz_dataState_0_17_1;
  reg        [7:0]    _zz__zz_dataState_0_18;
  wire       [3:0]    _zz__zz_dataState_0_18_1;
  wire                _zz__zz_dataState_0_19;
  wire       [0:0]    _zz__zz_dataState_0_19_1;
  wire       [5:0]    _zz__zz_dataState_0_19_2;
  wire                _zz__zz_dataState_0_19_3;
  wire       [0:0]    _zz__zz_dataState_0_19_4;
  wire       [2:0]    _zz__zz_dataState_0_19_5;
  wire                _zz__zz_dataState_0_19_6;
  wire                _zz__zz_dataState_0_19_7;
  wire       [0:0]    _zz__zz_dataState_0_19_8;
  wire       [5:0]    _zz__zz_dataState_0_19_9;
  wire                _zz__zz_dataState_0_19_10;
  wire       [0:0]    _zz__zz_dataState_0_19_11;
  wire       [2:0]    _zz__zz_dataState_0_19_12;
  wire                _zz__zz_dataState_0_19_13;
  wire                _zz__zz_dataState_0_19_14;
  wire                _zz__zz_dataState_0_19_15;
  wire       [0:0]    _zz__zz_dataState_0_19_16;
  wire       [4:0]    _zz__zz_dataState_0_19_17;
  wire                _zz__zz_dataState_0_19_18;
  wire       [0:0]    _zz__zz_dataState_0_19_19;
  wire       [1:0]    _zz__zz_dataState_0_19_20;
  wire                _zz__zz_dataState_0_19_21;
  wire       [0:0]    _zz__zz_dataState_0_19_22;
  wire       [3:0]    _zz__zz_dataState_0_19_23;
  wire                _zz__zz_dataState_0_19_24;
  wire       [0:0]    _zz__zz_dataState_0_19_25;
  wire       [0:0]    _zz__zz_dataState_0_19_26;
  wire       [3:0]    _zz__zz_21;
  reg        [7:0]    _zz__zz_dataState_0_20;
  wire       [3:0]    _zz__zz_dataState_0_20_1;
  reg        [7:0]    _zz__zz_dataState_0_21;
  wire       [3:0]    _zz__zz_dataState_0_21_1;
  reg        [7:0]    _zz__zz_dataState_0_23;
  wire       [3:0]    _zz__zz_dataState_0_23_1;
  reg        [7:0]    _zz__zz_dataState_0_32;
  wire       [3:0]    _zz__zz_dataState_0_32_1;
  wire                _zz__zz_dataState_0_33;
  wire       [0:0]    _zz__zz_dataState_0_33_1;
  wire       [5:0]    _zz__zz_dataState_0_33_2;
  wire                _zz__zz_dataState_0_33_3;
  wire       [0:0]    _zz__zz_dataState_0_33_4;
  wire       [2:0]    _zz__zz_dataState_0_33_5;
  wire                _zz__zz_dataState_0_33_6;
  wire                _zz__zz_dataState_0_33_7;
  wire                _zz__zz_dataState_0_33_8;
  wire       [0:0]    _zz__zz_dataState_0_33_9;
  wire       [5:0]    _zz__zz_dataState_0_33_10;
  wire                _zz__zz_dataState_0_33_11;
  wire       [0:0]    _zz__zz_dataState_0_33_12;
  wire       [2:0]    _zz__zz_dataState_0_33_13;
  wire                _zz__zz_dataState_0_33_14;
  wire                _zz__zz_dataState_0_33_15;
  wire       [0:0]    _zz__zz_dataState_0_33_16;
  wire       [4:0]    _zz__zz_dataState_0_33_17;
  wire                _zz__zz_dataState_0_33_18;
  wire                _zz__zz_dataState_0_33_19;
  wire       [0:0]    _zz__zz_dataState_0_33_20;
  wire       [1:0]    _zz__zz_dataState_0_33_21;
  wire                _zz__zz_dataState_0_33_22;
  wire                _zz__zz_dataState_0_33_23;
  wire       [0:0]    _zz__zz_dataState_0_33_24;
  wire       [3:0]    _zz__zz_dataState_0_33_25;
  wire                _zz__zz_dataState_0_33_26;
  wire       [0:0]    _zz__zz_dataState_0_33_27;
  wire       [0:0]    _zz__zz_dataState_0_33_28;
  wire       [3:0]    _zz__zz_22;
  reg        [7:0]    _zz__zz_dataState_0_34;
  wire       [3:0]    _zz__zz_dataState_0_34_1;
  reg        [7:0]    _zz__zz_dataState_0_35;
  wire       [3:0]    _zz__zz_dataState_0_35_1;
  reg        [7:0]    _zz__zz_dataState_0_36;
  wire       [3:0]    _zz__zz_dataState_0_36_1;
  reg        [7:0]    _zz__zz_dataState_0_38;
  wire       [3:0]    _zz__zz_dataState_0_38_1;
  wire                _zz__zz_dataState_0_47;
  wire       [0:0]    _zz__zz_dataState_0_47_1;
  wire       [5:0]    _zz__zz_dataState_0_47_2;
  wire                _zz__zz_dataState_0_47_3;
  wire       [0:0]    _zz__zz_dataState_0_47_4;
  wire       [2:0]    _zz__zz_dataState_0_47_5;
  wire                _zz__zz_dataState_0_47_6;
  wire       [0:0]    _zz__zz_dataState_0_47_7;
  wire       [5:0]    _zz__zz_dataState_0_47_8;
  wire                _zz__zz_dataState_0_47_9;
  wire       [0:0]    _zz__zz_dataState_0_47_10;
  wire       [2:0]    _zz__zz_dataState_0_47_11;
  wire                _zz__zz_dataState_0_47_12;
  wire       [0:0]    _zz__zz_dataState_0_47_13;
  wire       [4:0]    _zz__zz_dataState_0_47_14;
  wire                _zz__zz_dataState_0_47_15;
  wire                _zz__zz_dataState_0_47_16;
  wire       [0:0]    _zz__zz_dataState_0_47_17;
  wire       [1:0]    _zz__zz_dataState_0_47_18;
  wire                _zz__zz_dataState_0_47_19;
  wire       [0:0]    _zz__zz_dataState_0_47_20;
  wire       [3:0]    _zz__zz_dataState_0_47_21;
  wire                _zz__zz_dataState_0_47_22;
  wire                _zz__zz_dataState_0_47_23;
  wire       [0:0]    _zz__zz_dataState_0_47_24;
  wire       [0:0]    _zz__zz_dataState_0_47_25;
  wire       [3:0]    _zz__zz_23;
  reg        [7:0]    _zz__zz_dataState_0_48;
  wire       [3:0]    _zz__zz_dataState_0_48_1;
  reg        [7:0]    _zz__zz_dataState_0_57;
  wire       [3:0]    _zz__zz_dataState_0_57_1;
  reg        [7:0]    _zz__zz_dataState_0_58;
  wire       [3:0]    _zz__zz_dataState_0_58_1;
  reg        [7:0]    _zz__zz_dataState_0_59;
  wire       [3:0]    _zz__zz_dataState_0_59_1;
  wire                _zz__zz_dataState_0_61;
  wire       [0:0]    _zz__zz_dataState_0_61_1;
  wire       [5:0]    _zz__zz_dataState_0_61_2;
  wire                _zz__zz_dataState_0_61_3;
  wire       [0:0]    _zz__zz_dataState_0_61_4;
  wire       [3:0]    _zz__zz_dataState_0_61_5;
  wire                _zz__zz_dataState_0_61_6;
  wire                _zz__zz_dataState_0_61_7;
  wire       [0:0]    _zz__zz_dataState_0_61_8;
  wire       [0:0]    _zz__zz_dataState_0_61_9;
  wire                _zz__zz_dataState_0_61_10;
  wire       [0:0]    _zz__zz_dataState_0_61_11;
  wire       [5:0]    _zz__zz_dataState_0_61_12;
  wire                _zz__zz_dataState_0_61_13;
  wire       [0:0]    _zz__zz_dataState_0_61_14;
  wire       [3:0]    _zz__zz_dataState_0_61_15;
  wire                _zz__zz_dataState_0_61_16;
  wire       [0:0]    _zz__zz_dataState_0_61_17;
  wire       [0:0]    _zz__zz_dataState_0_61_18;
  wire                _zz__zz_dataState_0_61_19;
  wire       [0:0]    _zz__zz_dataState_0_61_20;
  wire       [4:0]    _zz__zz_dataState_0_61_21;
  wire                _zz__zz_dataState_0_61_22;
  wire       [0:0]    _zz__zz_dataState_0_61_23;
  wire       [2:0]    _zz__zz_dataState_0_61_24;
  wire                _zz__zz_dataState_0_61_25;
  wire                _zz__zz_dataState_0_61_26;
  wire                _zz__zz_dataState_0_61_27;
  wire       [0:0]    _zz__zz_dataState_0_61_28;
  wire                _zz__zz_dataState_0_61_29;
  wire       [3:0]    _zz__zz_dataState_0_61_30;
  wire                _zz__zz_dataState_0_61_31;
  wire       [0:0]    _zz__zz_dataState_0_61_32;
  wire       [1:0]    _zz__zz_dataState_0_61_33;
  wire                _zz__zz_dataState_0_61_34;
  wire       [3:0]    _zz__zz_24;
  reg        [7:0]    _zz__zz_dataState_0_62;
  wire       [3:0]    _zz__zz_dataState_0_62_1;
  reg        [7:0]    _zz__zz_dataState_0_71;
  wire       [3:0]    _zz__zz_dataState_0_71_1;
  reg        [7:0]    _zz__zz_dataState_0_80;
  wire       [3:0]    _zz__zz_dataState_0_80_1;
  reg        [7:0]    _zz__zz_dataState_0_89;
  wire       [3:0]    _zz__zz_dataState_0_89_1;
  wire                _zz__zz_dataState_0_98;
  wire       [0:0]    _zz__zz_dataState_0_98_1;
  wire                _zz__zz_dataState_0_98_2;
  wire       [5:0]    _zz__zz_dataState_0_98_3;
  wire                _zz__zz_dataState_0_98_4;
  wire                _zz__zz_dataState_0_98_5;
  wire       [0:0]    _zz__zz_dataState_0_98_6;
  wire                _zz__zz_dataState_0_98_7;
  wire       [3:0]    _zz__zz_dataState_0_98_8;
  wire                _zz__zz_dataState_0_98_9;
  wire                _zz__zz_dataState_0_98_10;
  wire       [0:0]    _zz__zz_dataState_0_98_11;
  wire                _zz__zz_dataState_0_98_12;
  wire       [1:0]    _zz__zz_dataState_0_98_13;
  wire                _zz__zz_dataState_0_98_14;
  wire                _zz__zz_dataState_0_98_15;
  wire                _zz__zz_dataState_0_98_16;
  wire       [0:0]    _zz__zz_dataState_0_98_17;
  wire                _zz__zz_dataState_0_98_18;
  wire       [5:0]    _zz__zz_dataState_0_98_19;
  wire                _zz__zz_dataState_0_98_20;
  wire                _zz__zz_dataState_0_98_21;
  wire       [0:0]    _zz__zz_dataState_0_98_22;
  wire                _zz__zz_dataState_0_98_23;
  wire                _zz__zz_dataState_0_98_24;
  wire       [3:0]    _zz__zz_dataState_0_98_25;
  wire                _zz__zz_dataState_0_98_26;
  wire                _zz__zz_dataState_0_98_27;
  wire       [0:0]    _zz__zz_dataState_0_98_28;
  wire                _zz__zz_dataState_0_98_29;
  wire       [1:0]    _zz__zz_dataState_0_98_30;
  wire                _zz__zz_dataState_0_98_31;
  wire                _zz__zz_dataState_0_98_32;
  wire                _zz__zz_dataState_0_98_33;
  wire                _zz__zz_dataState_0_98_34;
  wire                _zz__zz_dataState_0_98_35;
  wire       [0:0]    _zz__zz_dataState_0_98_36;
  wire                _zz__zz_dataState_0_98_37;
  wire       [4:0]    _zz__zz_dataState_0_98_38;
  wire                _zz__zz_dataState_0_98_39;
  wire                _zz__zz_dataState_0_98_40;
  wire       [0:0]    _zz__zz_dataState_0_98_41;
  wire                _zz__zz_dataState_0_98_42;
  wire                _zz__zz_dataState_0_98_43;
  wire       [2:0]    _zz__zz_dataState_0_98_44;
  wire                _zz__zz_dataState_0_98_45;
  wire       [0:0]    _zz__zz_dataState_0_98_46;
  wire                _zz__zz_dataState_0_98_47;
  wire       [0:0]    _zz__zz_dataState_0_98_48;
  wire                _zz__zz_dataState_0_98_49;
  wire                _zz__zz_dataState_0_98_50;
  wire                _zz__zz_dataState_0_98_51;
  wire                _zz__zz_dataState_0_98_52;
  wire       [0:0]    _zz__zz_dataState_0_98_53;
  wire                _zz__zz_dataState_0_98_54;
  wire       [3:0]    _zz__zz_dataState_0_98_55;
  wire                _zz__zz_dataState_0_98_56;
  wire                _zz__zz_dataState_0_98_57;
  wire       [0:0]    _zz__zz_dataState_0_98_58;
  wire                _zz__zz_dataState_0_98_59;
  wire       [1:0]    _zz__zz_dataState_0_98_60;
  wire                _zz__zz_dataState_0_98_61;
  wire                _zz__zz_dataState_0_98_62;
  wire       [3:0]    _zz__zz_25;
  reg        [7:0]    _zz__zz_dataState_0_99;
  wire       [3:0]    _zz__zz_dataState_0_99_1;
  reg        [7:0]    _zz__zz_dataState_0_108;
  wire       [3:0]    _zz__zz_dataState_0_108_1;
  reg        [7:0]    _zz__zz_dataState_0_117;
  wire       [3:0]    _zz__zz_dataState_0_117_1;
  reg        [7:0]    _zz__zz_dataState_0_126;
  wire       [3:0]    _zz__zz_dataState_0_126_1;
  wire                _zz__zz_dataState_0_135;
  wire       [0:0]    _zz__zz_dataState_0_135_1;
  wire                _zz__zz_dataState_0_135_2;
  wire       [5:0]    _zz__zz_dataState_0_135_3;
  wire                _zz__zz_dataState_0_135_4;
  wire                _zz__zz_dataState_0_135_5;
  wire       [0:0]    _zz__zz_dataState_0_135_6;
  wire                _zz__zz_dataState_0_135_7;
  wire                _zz__zz_dataState_0_135_8;
  wire       [3:0]    _zz__zz_dataState_0_135_9;
  wire                _zz__zz_dataState_0_135_10;
  wire                _zz__zz_dataState_0_135_11;
  wire       [0:0]    _zz__zz_dataState_0_135_12;
  wire                _zz__zz_dataState_0_135_13;
  wire       [1:0]    _zz__zz_dataState_0_135_14;
  wire       [0:0]    _zz__zz_dataState_0_135_15;
  wire       [0:0]    _zz__zz_dataState_0_135_16;
  wire                _zz__zz_dataState_0_135_17;
  wire       [0:0]    _zz__zz_dataState_0_135_18;
  wire                _zz__zz_dataState_0_135_19;
  wire       [5:0]    _zz__zz_dataState_0_135_20;
  wire                _zz__zz_dataState_0_135_21;
  wire                _zz__zz_dataState_0_135_22;
  wire       [0:0]    _zz__zz_dataState_0_135_23;
  wire                _zz__zz_dataState_0_135_24;
  wire                _zz__zz_dataState_0_135_25;
  wire       [3:0]    _zz__zz_dataState_0_135_26;
  wire                _zz__zz_dataState_0_135_27;
  wire                _zz__zz_dataState_0_135_28;
  wire       [0:0]    _zz__zz_dataState_0_135_29;
  wire                _zz__zz_dataState_0_135_30;
  wire       [1:0]    _zz__zz_dataState_0_135_31;
  wire       [0:0]    _zz__zz_dataState_0_135_32;
  wire       [0:0]    _zz__zz_dataState_0_135_33;
  wire                _zz__zz_dataState_0_135_34;
  wire                _zz__zz_dataState_0_135_35;
  wire                _zz__zz_dataState_0_135_36;
  wire       [0:0]    _zz__zz_dataState_0_135_37;
  wire                _zz__zz_dataState_0_135_38;
  wire                _zz__zz_dataState_0_135_39;
  wire       [4:0]    _zz__zz_dataState_0_135_40;
  wire                _zz__zz_dataState_0_135_41;
  wire                _zz__zz_dataState_0_135_42;
  wire                _zz__zz_dataState_0_135_43;
  wire       [0:0]    _zz__zz_dataState_0_135_44;
  wire                _zz__zz_dataState_0_135_45;
  wire                _zz__zz_dataState_0_135_46;
  wire       [2:0]    _zz__zz_dataState_0_135_47;
  wire                _zz__zz_dataState_0_135_48;
  wire                _zz__zz_dataState_0_135_49;
  wire       [0:0]    _zz__zz_dataState_0_135_50;
  wire                _zz__zz_dataState_0_135_51;
  wire                _zz__zz_dataState_0_135_52;
  wire       [0:0]    _zz__zz_dataState_0_135_53;
  wire                _zz__zz_dataState_0_135_54;
  wire                _zz__zz_dataState_0_135_55;
  wire                _zz__zz_dataState_0_135_56;
  wire                _zz__zz_dataState_0_135_57;
  wire       [0:0]    _zz__zz_dataState_0_135_58;
  wire                _zz__zz_dataState_0_135_59;
  wire                _zz__zz_dataState_0_135_60;
  wire       [3:0]    _zz__zz_dataState_0_135_61;
  wire                _zz__zz_dataState_0_135_62;
  wire                _zz__zz_dataState_0_135_63;
  wire                _zz__zz_dataState_0_135_64;
  wire       [0:0]    _zz__zz_dataState_0_135_65;
  wire                _zz__zz_dataState_0_135_66;
  wire       [1:0]    _zz__zz_dataState_0_135_67;
  wire                _zz__zz_dataState_0_135_68;
  wire                _zz__zz_dataState_0_135_69;
  wire                _zz__zz_dataState_0_135_70;
  wire                _zz__zz_dataState_0_135_71;
  wire       [3:0]    _zz__zz_26;
  reg        [7:0]    _zz__zz_dataState_0_136;
  wire       [3:0]    _zz__zz_dataState_0_136_1;
  reg        [7:0]    _zz__zz_dataState_0_145;
  wire       [3:0]    _zz__zz_dataState_0_145_1;
  reg        [7:0]    _zz__zz_dataState_0_154;
  wire       [3:0]    _zz__zz_dataState_0_154_1;
  reg        [7:0]    _zz__zz_dataState_0_163;
  wire       [3:0]    _zz__zz_dataState_0_163_1;
  wire                _zz__zz_dataState_0_172;
  wire       [0:0]    _zz__zz_dataState_0_172_1;
  wire                _zz__zz_dataState_0_172_2;
  wire       [5:0]    _zz__zz_dataState_0_172_3;
  wire                _zz__zz_dataState_0_172_4;
  wire                _zz__zz_dataState_0_172_5;
  wire       [0:0]    _zz__zz_dataState_0_172_6;
  wire                _zz__zz_dataState_0_172_7;
  wire                _zz__zz_dataState_0_172_8;
  wire       [3:0]    _zz__zz_dataState_0_172_9;
  wire                _zz__zz_dataState_0_172_10;
  wire                _zz__zz_dataState_0_172_11;
  wire       [0:0]    _zz__zz_dataState_0_172_12;
  wire                _zz__zz_dataState_0_172_13;
  wire       [1:0]    _zz__zz_dataState_0_172_14;
  wire       [0:0]    _zz__zz_dataState_0_172_15;
  wire       [0:0]    _zz__zz_dataState_0_172_16;
  wire                _zz__zz_dataState_0_172_17;
  wire       [0:0]    _zz__zz_dataState_0_172_18;
  wire                _zz__zz_dataState_0_172_19;
  wire       [5:0]    _zz__zz_dataState_0_172_20;
  wire                _zz__zz_dataState_0_172_21;
  wire                _zz__zz_dataState_0_172_22;
  wire       [0:0]    _zz__zz_dataState_0_172_23;
  wire                _zz__zz_dataState_0_172_24;
  wire                _zz__zz_dataState_0_172_25;
  wire       [3:0]    _zz__zz_dataState_0_172_26;
  wire                _zz__zz_dataState_0_172_27;
  wire                _zz__zz_dataState_0_172_28;
  wire       [0:0]    _zz__zz_dataState_0_172_29;
  wire                _zz__zz_dataState_0_172_30;
  wire       [1:0]    _zz__zz_dataState_0_172_31;
  wire       [0:0]    _zz__zz_dataState_0_172_32;
  wire       [0:0]    _zz__zz_dataState_0_172_33;
  wire                _zz__zz_dataState_0_172_34;
  wire                _zz__zz_dataState_0_172_35;
  wire                _zz__zz_dataState_0_172_36;
  wire       [0:0]    _zz__zz_dataState_0_172_37;
  wire                _zz__zz_dataState_0_172_38;
  wire       [4:0]    _zz__zz_dataState_0_172_39;
  wire                _zz__zz_dataState_0_172_40;
  wire                _zz__zz_dataState_0_172_41;
  wire       [0:0]    _zz__zz_dataState_0_172_42;
  wire                _zz__zz_dataState_0_172_43;
  wire                _zz__zz_dataState_0_172_44;
  wire       [2:0]    _zz__zz_dataState_0_172_45;
  wire                _zz__zz_dataState_0_172_46;
  wire                _zz__zz_dataState_0_172_47;
  wire       [0:0]    _zz__zz_dataState_0_172_48;
  wire                _zz__zz_dataState_0_172_49;
  wire       [0:0]    _zz__zz_dataState_0_172_50;
  wire                _zz__zz_dataState_0_172_51;
  wire                _zz__zz_dataState_0_172_52;
  wire                _zz__zz_dataState_0_172_53;
  wire                _zz__zz_dataState_0_172_54;
  wire       [0:0]    _zz__zz_dataState_0_172_55;
  wire                _zz__zz_dataState_0_172_56;
  wire                _zz__zz_dataState_0_172_57;
  wire                _zz__zz_dataState_0_172_58;
  wire       [3:0]    _zz__zz_dataState_0_172_59;
  wire                _zz__zz_dataState_0_172_60;
  wire                _zz__zz_dataState_0_172_61;
  wire       [0:0]    _zz__zz_dataState_0_172_62;
  wire                _zz__zz_dataState_0_172_63;
  wire                _zz__zz_dataState_0_172_64;
  wire       [1:0]    _zz__zz_dataState_0_172_65;
  wire                _zz__zz_dataState_0_172_66;
  wire                _zz__zz_dataState_0_172_67;
  wire                _zz__zz_dataState_0_172_68;
  wire                _zz__zz_dataState_0_172_69;
  wire       [3:0]    _zz__zz_27;
  reg        [7:0]    _zz__zz_dataState_0_173;
  wire       [3:0]    _zz__zz_dataState_0_173_1;
  reg        [7:0]    _zz__zz_dataState_0_182;
  wire       [3:0]    _zz__zz_dataState_0_182_1;
  reg        [7:0]    _zz__zz_dataState_0_191;
  wire       [3:0]    _zz__zz_dataState_0_191_1;
  reg        [7:0]    _zz__zz_dataState_0_200;
  wire       [3:0]    _zz__zz_dataState_0_200_1;
  wire                _zz__zz_dataState_0_209;
  wire       [0:0]    _zz__zz_dataState_0_209_1;
  wire                _zz__zz_dataState_0_209_2;
  wire       [5:0]    _zz__zz_dataState_0_209_3;
  wire                _zz__zz_dataState_0_209_4;
  wire                _zz__zz_dataState_0_209_5;
  wire       [0:0]    _zz__zz_dataState_0_209_6;
  wire                _zz__zz_dataState_0_209_7;
  wire                _zz__zz_dataState_0_209_8;
  wire       [3:0]    _zz__zz_dataState_0_209_9;
  wire                _zz__zz_dataState_0_209_10;
  wire                _zz__zz_dataState_0_209_11;
  wire       [0:0]    _zz__zz_dataState_0_209_12;
  wire                _zz__zz_dataState_0_209_13;
  wire       [1:0]    _zz__zz_dataState_0_209_14;
  wire                _zz__zz_dataState_0_209_15;
  wire                _zz__zz_dataState_0_209_16;
  wire                _zz__zz_dataState_0_209_17;
  wire       [0:0]    _zz__zz_dataState_0_209_18;
  wire                _zz__zz_dataState_0_209_19;
  wire       [5:0]    _zz__zz_dataState_0_209_20;
  wire                _zz__zz_dataState_0_209_21;
  wire                _zz__zz_dataState_0_209_22;
  wire       [0:0]    _zz__zz_dataState_0_209_23;
  wire                _zz__zz_dataState_0_209_24;
  wire                _zz__zz_dataState_0_209_25;
  wire       [3:0]    _zz__zz_dataState_0_209_26;
  wire                _zz__zz_dataState_0_209_27;
  wire                _zz__zz_dataState_0_209_28;
  wire       [0:0]    _zz__zz_dataState_0_209_29;
  wire                _zz__zz_dataState_0_209_30;
  wire       [1:0]    _zz__zz_dataState_0_209_31;
  wire                _zz__zz_dataState_0_209_32;
  wire                _zz__zz_dataState_0_209_33;
  wire                _zz__zz_dataState_0_209_34;
  wire       [0:0]    _zz__zz_dataState_0_209_35;
  wire                _zz__zz_dataState_0_209_36;
  wire       [4:0]    _zz__zz_dataState_0_209_37;
  wire                _zz__zz_dataState_0_209_38;
  wire                _zz__zz_dataState_0_209_39;
  wire       [0:0]    _zz__zz_dataState_0_209_40;
  wire                _zz__zz_dataState_0_209_41;
  wire       [2:0]    _zz__zz_dataState_0_209_42;
  wire                _zz__zz_dataState_0_209_43;
  wire       [0:0]    _zz__zz_dataState_0_209_44;
  wire                _zz__zz_dataState_0_209_45;
  wire       [0:0]    _zz__zz_dataState_0_209_46;
  wire                _zz__zz_dataState_0_209_47;
  wire                _zz__zz_dataState_0_209_48;
  wire                _zz__zz_dataState_0_209_49;
  wire       [0:0]    _zz__zz_dataState_0_209_50;
  wire                _zz__zz_dataState_0_209_51;
  wire       [3:0]    _zz__zz_dataState_0_209_52;
  wire                _zz__zz_dataState_0_209_53;
  wire                _zz__zz_dataState_0_209_54;
  wire       [0:0]    _zz__zz_dataState_0_209_55;
  wire                _zz__zz_dataState_0_209_56;
  wire       [1:0]    _zz__zz_dataState_0_209_57;
  wire                _zz__zz_dataState_0_209_58;
  wire                _zz__zz_dataState_0_209_59;
  reg        [7:0]    dataState_0;
  reg        [7:0]    dataState_1;
  reg        [7:0]    dataState_2;
  reg        [7:0]    dataState_3;
  reg        [7:0]    dataState_4;
  reg        [7:0]    dataState_5;
  reg        [7:0]    dataState_6;
  reg        [7:0]    dataState_7;
  reg        [7:0]    dataState_8;
  reg        [7:0]    dataState_9;
  reg        [7:0]    dataState_10;
  reg        [7:0]    dataState_11;
  reg        [7:0]    dataState_12;
  reg        [7:0]    dataState_13;
  reg        [7:0]    dataState_14;
  reg        [7:0]    dataState_15;
  reg        [3:0]    cntRound;
  reg                 keyValid;
  reg        [0:0]    keyMode;
  reg                 smDone;
  reg                 smDone_regNext;
  wire       [7:0]    _zz_dataState_15;
  wire       [7:0]    _zz_dataState_14;
  wire       [7:0]    _zz_dataState_13;
  wire       [7:0]    _zz_dataState_12;
  wire       [7:0]    _zz_dataState_11;
  wire       [7:0]    _zz_dataState_10;
  wire       [7:0]    _zz_dataState_9;
  wire       [7:0]    _zz_dataState_8;
  wire       [7:0]    _zz_dataState_7;
  wire       [7:0]    _zz_dataState_6;
  wire       [7:0]    _zz_dataState_5;
  wire       [7:0]    _zz_dataState_4;
  wire       [7:0]    _zz_dataState_3;
  wire       [7:0]    _zz_dataState_2;
  wire       [7:0]    _zz_dataState_1;
  wire       [7:0]    _zz_dataState_0;
  wire                sm_wantExit;
  reg                 sm_wantStart;
  wire                sm_wantKill;
  reg                 sm_keyAddition_cmd;
  reg                 sm_byteSub_cmd_valid;
  wire                sm_byteSub_cmd_ready;
  reg                 sm_shiftRow_cmd;
  reg                 sm_mixCol_cmd_valid;
  wire                sm_mixCol_cmd_ready;
  wire                when_AESCoreStd_l260;
  reg                 byteSubstitution_cntByte_willIncrement;
  reg                 byteSubstitution_cntByte_willClear;
  reg        [3:0]    byteSubstitution_cntByte_valueNext;
  reg        [3:0]    byteSubstitution_cntByte_value;
  wire                byteSubstitution_cntByte_willOverflowIfInc;
  wire                byteSubstitution_cntByte_willOverflow;
  wire       [7:0]    _zz_dataState_0_1;
  wire       [15:0]   _zz_1;
  wire                _zz_2;
  wire                _zz_3;
  wire                _zz_4;
  wire                _zz_5;
  wire                _zz_6;
  wire                _zz_7;
  wire                _zz_8;
  wire                _zz_9;
  wire                _zz_10;
  wire                _zz_11;
  wire                _zz_12;
  wire                _zz_13;
  wire                _zz_14;
  wire                _zz_15;
  wire                _zz_16;
  wire                _zz_17;
  wire       [7:0]    _zz_dataState_0_2;
  wire       [7:0]    _zz_dataState_0_3;
  wire       [7:0]    _zz_dataState_0_4;
  wire       [7:0]    _zz_dataState_0_5;
  reg        [3:0]    mixColumn_cntColumn;
  wire       [15:0]   _zz_20;
  wire       [7:0]    _zz_dataState_0_6;
  wire                _zz_dataState_0_7;
  wire       [7:0]    _zz_dataState_0_8;
  wire                _zz_dataState_0_9;
  wire                _zz_dataState_0_10;
  wire                _zz_dataState_0_11;
  wire                _zz_dataState_0_12;
  wire                _zz_dataState_0_13;
  wire                _zz_dataState_0_14;
  wire                _zz_dataState_0_15;
  wire                _zz_dataState_0_16;
  wire       [7:0]    _zz_dataState_0_17;
  wire       [7:0]    _zz_dataState_0_18;
  wire       [7:0]    _zz_dataState_0_19;
  wire       [15:0]   _zz_21;
  wire       [7:0]    _zz_dataState_0_20;
  wire       [7:0]    _zz_dataState_0_21;
  wire                _zz_dataState_0_22;
  wire       [7:0]    _zz_dataState_0_23;
  wire                _zz_dataState_0_24;
  wire                _zz_dataState_0_25;
  wire                _zz_dataState_0_26;
  wire                _zz_dataState_0_27;
  wire                _zz_dataState_0_28;
  wire                _zz_dataState_0_29;
  wire                _zz_dataState_0_30;
  wire                _zz_dataState_0_31;
  wire       [7:0]    _zz_dataState_0_32;
  wire       [7:0]    _zz_dataState_0_33;
  wire       [15:0]   _zz_22;
  wire       [7:0]    _zz_dataState_0_34;
  wire       [7:0]    _zz_dataState_0_35;
  wire       [7:0]    _zz_dataState_0_36;
  wire                _zz_dataState_0_37;
  wire       [7:0]    _zz_dataState_0_38;
  wire                _zz_dataState_0_39;
  wire                _zz_dataState_0_40;
  wire                _zz_dataState_0_41;
  wire                _zz_dataState_0_42;
  wire                _zz_dataState_0_43;
  wire                _zz_dataState_0_44;
  wire                _zz_dataState_0_45;
  wire                _zz_dataState_0_46;
  wire       [7:0]    _zz_dataState_0_47;
  wire       [15:0]   _zz_23;
  wire       [7:0]    _zz_dataState_0_48;
  wire                _zz_dataState_0_49;
  wire                _zz_dataState_0_50;
  wire                _zz_dataState_0_51;
  wire                _zz_dataState_0_52;
  wire                _zz_dataState_0_53;
  wire                _zz_dataState_0_54;
  wire                _zz_dataState_0_55;
  wire                _zz_dataState_0_56;
  wire       [7:0]    _zz_dataState_0_57;
  wire       [7:0]    _zz_dataState_0_58;
  wire       [7:0]    _zz_dataState_0_59;
  wire                _zz_dataState_0_60;
  wire       [7:0]    _zz_dataState_0_61;
  wire       [15:0]   _zz_24;
  wire       [7:0]    _zz_dataState_0_62;
  wire                _zz_dataState_0_63;
  wire                _zz_dataState_0_64;
  wire                _zz_dataState_0_65;
  wire                _zz_dataState_0_66;
  wire                _zz_dataState_0_67;
  wire                _zz_dataState_0_68;
  wire                _zz_dataState_0_69;
  wire                _zz_dataState_0_70;
  wire       [7:0]    _zz_dataState_0_71;
  wire                _zz_dataState_0_72;
  wire                _zz_dataState_0_73;
  wire                _zz_dataState_0_74;
  wire                _zz_dataState_0_75;
  wire                _zz_dataState_0_76;
  wire                _zz_dataState_0_77;
  wire                _zz_dataState_0_78;
  wire                _zz_dataState_0_79;
  wire       [7:0]    _zz_dataState_0_80;
  wire                _zz_dataState_0_81;
  wire                _zz_dataState_0_82;
  wire                _zz_dataState_0_83;
  wire                _zz_dataState_0_84;
  wire                _zz_dataState_0_85;
  wire                _zz_dataState_0_86;
  wire                _zz_dataState_0_87;
  wire                _zz_dataState_0_88;
  wire       [7:0]    _zz_dataState_0_89;
  wire                _zz_dataState_0_90;
  wire                _zz_dataState_0_91;
  wire                _zz_dataState_0_92;
  wire                _zz_dataState_0_93;
  wire                _zz_dataState_0_94;
  wire                _zz_dataState_0_95;
  wire                _zz_dataState_0_96;
  wire                _zz_dataState_0_97;
  wire       [7:0]    _zz_dataState_0_98;
  wire       [15:0]   _zz_25;
  wire       [7:0]    _zz_dataState_0_99;
  wire                _zz_dataState_0_100;
  wire                _zz_dataState_0_101;
  wire                _zz_dataState_0_102;
  wire                _zz_dataState_0_103;
  wire                _zz_dataState_0_104;
  wire                _zz_dataState_0_105;
  wire                _zz_dataState_0_106;
  wire                _zz_dataState_0_107;
  wire       [7:0]    _zz_dataState_0_108;
  wire                _zz_dataState_0_109;
  wire                _zz_dataState_0_110;
  wire                _zz_dataState_0_111;
  wire                _zz_dataState_0_112;
  wire                _zz_dataState_0_113;
  wire                _zz_dataState_0_114;
  wire                _zz_dataState_0_115;
  wire                _zz_dataState_0_116;
  wire       [7:0]    _zz_dataState_0_117;
  wire                _zz_dataState_0_118;
  wire                _zz_dataState_0_119;
  wire                _zz_dataState_0_120;
  wire                _zz_dataState_0_121;
  wire                _zz_dataState_0_122;
  wire                _zz_dataState_0_123;
  wire                _zz_dataState_0_124;
  wire                _zz_dataState_0_125;
  wire       [7:0]    _zz_dataState_0_126;
  wire                _zz_dataState_0_127;
  wire                _zz_dataState_0_128;
  wire                _zz_dataState_0_129;
  wire                _zz_dataState_0_130;
  wire                _zz_dataState_0_131;
  wire                _zz_dataState_0_132;
  wire                _zz_dataState_0_133;
  wire                _zz_dataState_0_134;
  wire       [7:0]    _zz_dataState_0_135;
  wire       [15:0]   _zz_26;
  wire       [7:0]    _zz_dataState_0_136;
  wire                _zz_dataState_0_137;
  wire                _zz_dataState_0_138;
  wire                _zz_dataState_0_139;
  wire                _zz_dataState_0_140;
  wire                _zz_dataState_0_141;
  wire                _zz_dataState_0_142;
  wire                _zz_dataState_0_143;
  wire                _zz_dataState_0_144;
  wire       [7:0]    _zz_dataState_0_145;
  wire                _zz_dataState_0_146;
  wire                _zz_dataState_0_147;
  wire                _zz_dataState_0_148;
  wire                _zz_dataState_0_149;
  wire                _zz_dataState_0_150;
  wire                _zz_dataState_0_151;
  wire                _zz_dataState_0_152;
  wire                _zz_dataState_0_153;
  wire       [7:0]    _zz_dataState_0_154;
  wire                _zz_dataState_0_155;
  wire                _zz_dataState_0_156;
  wire                _zz_dataState_0_157;
  wire                _zz_dataState_0_158;
  wire                _zz_dataState_0_159;
  wire                _zz_dataState_0_160;
  wire                _zz_dataState_0_161;
  wire                _zz_dataState_0_162;
  wire       [7:0]    _zz_dataState_0_163;
  wire                _zz_dataState_0_164;
  wire                _zz_dataState_0_165;
  wire                _zz_dataState_0_166;
  wire                _zz_dataState_0_167;
  wire                _zz_dataState_0_168;
  wire                _zz_dataState_0_169;
  wire                _zz_dataState_0_170;
  wire                _zz_dataState_0_171;
  wire       [7:0]    _zz_dataState_0_172;
  wire       [15:0]   _zz_27;
  wire       [7:0]    _zz_dataState_0_173;
  wire                _zz_dataState_0_174;
  wire                _zz_dataState_0_175;
  wire                _zz_dataState_0_176;
  wire                _zz_dataState_0_177;
  wire                _zz_dataState_0_178;
  wire                _zz_dataState_0_179;
  wire                _zz_dataState_0_180;
  wire                _zz_dataState_0_181;
  wire       [7:0]    _zz_dataState_0_182;
  wire                _zz_dataState_0_183;
  wire                _zz_dataState_0_184;
  wire                _zz_dataState_0_185;
  wire                _zz_dataState_0_186;
  wire                _zz_dataState_0_187;
  wire                _zz_dataState_0_188;
  wire                _zz_dataState_0_189;
  wire                _zz_dataState_0_190;
  wire       [7:0]    _zz_dataState_0_191;
  wire                _zz_dataState_0_192;
  wire                _zz_dataState_0_193;
  wire                _zz_dataState_0_194;
  wire                _zz_dataState_0_195;
  wire                _zz_dataState_0_196;
  wire                _zz_dataState_0_197;
  wire                _zz_dataState_0_198;
  wire                _zz_dataState_0_199;
  wire       [7:0]    _zz_dataState_0_200;
  wire                _zz_dataState_0_201;
  wire                _zz_dataState_0_202;
  wire                _zz_dataState_0_203;
  wire                _zz_dataState_0_204;
  wire                _zz_dataState_0_205;
  wire                _zz_dataState_0_206;
  wire                _zz_dataState_0_207;
  wire                _zz_dataState_0_208;
  wire       [7:0]    _zz_dataState_0_209;
  reg        [2:0]    sm_stateReg;
  reg        [2:0]    sm_stateNext;
  wire                when_AESCoreStd_l160;
  wire                when_AESCoreStd_l175;
  wire                when_AESCoreStd_l179;
  wire                when_AESCoreStd_l191;
  wire                when_AESCoreStd_l196;
  wire                when_AESCoreStd_l198;
  wire                when_AESCoreStd_l227;
  `ifndef SYNTHESIS
  reg [47:0] io_keySchedule_cmd_payload_mode_string;
  reg [47:0] keyMode_string;
  reg [79:0] sm_stateReg_string;
  reg [79:0] sm_stateNext_string;
  `endif

  reg [7:0] sBoxMem [0:255];
  reg [7:0] sBoxMemInv [0:255];

  assign _zz_byteSubstitution_cntByte_valueNext_1 = byteSubstitution_cntByte_willIncrement;
  assign _zz_byteSubstitution_cntByte_valueNext = {3'd0, _zz_byteSubstitution_cntByte_valueNext_1};
  assign _zz__zz_20 = (4'b0000 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_6_1 = (4'b0000 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_8_1 = (4'b0001 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_17_1 = (4'b0010 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_18_1 = (4'b0011 + mixColumn_cntColumn);
  assign _zz__zz_21 = (4'b0001 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_20_1 = (4'b0000 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_21_1 = (4'b0001 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_23_1 = (4'b0010 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_32_1 = (4'b0011 + mixColumn_cntColumn);
  assign _zz__zz_22 = (4'b0010 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_34_1 = (4'b0000 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_35_1 = (4'b0001 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_36_1 = (4'b0010 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_38_1 = (4'b0011 + mixColumn_cntColumn);
  assign _zz__zz_23 = (4'b0011 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_48_1 = (4'b0000 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_57_1 = (4'b0001 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_58_1 = (4'b0010 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_59_1 = (4'b0011 + mixColumn_cntColumn);
  assign _zz__zz_24 = (4'b0000 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_62_1 = (4'b0000 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_71_1 = (4'b0001 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_80_1 = (4'b0010 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_89_1 = (4'b0011 + mixColumn_cntColumn);
  assign _zz__zz_25 = (4'b0001 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_99_1 = (4'b0000 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_108_1 = (4'b0001 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_117_1 = (4'b0010 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_126_1 = (4'b0011 + mixColumn_cntColumn);
  assign _zz__zz_26 = (4'b0010 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_136_1 = (4'b0000 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_145_1 = (4'b0001 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_154_1 = (4'b0010 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_163_1 = (4'b0011 + mixColumn_cntColumn);
  assign _zz__zz_27 = (4'b0011 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_173_1 = (4'b0000 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_182_1 = (4'b0001 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_191_1 = (4'b0010 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_200_1 = (4'b0011 + mixColumn_cntColumn);
  assign _zz__zz_dataState_0_19 = _zz_dataState_0_6[6];
  assign _zz__zz_dataState_0_19_1 = _zz_dataState_0_6[5];
  assign _zz__zz_dataState_0_19_2 = {_zz_dataState_0_6[4],{_zz__zz_dataState_0_19_3,{_zz__zz_dataState_0_19_4,_zz__zz_dataState_0_19_5}}};
  assign _zz__zz_dataState_0_19_7 = (_zz_dataState_0_15 ^ _zz_dataState_0_16);
  assign _zz__zz_dataState_0_19_8 = (_zz_dataState_0_14 ^ _zz_dataState_0_15);
  assign _zz__zz_dataState_0_19_9 = {(_zz_dataState_0_13 ^ _zz_dataState_0_14),{_zz__zz_dataState_0_19_10,{_zz__zz_dataState_0_19_11,_zz__zz_dataState_0_19_12}}};
  assign _zz__zz_dataState_0_19_15 = _zz_dataState_0_17[6];
  assign _zz__zz_dataState_0_19_16 = _zz_dataState_0_17[5];
  assign _zz__zz_dataState_0_19_17 = {_zz_dataState_0_17[4],{_zz__zz_dataState_0_19_18,{_zz__zz_dataState_0_19_19,_zz__zz_dataState_0_19_20}}};
  assign _zz__zz_dataState_0_19_21 = _zz_dataState_0_18[5];
  assign _zz__zz_dataState_0_19_22 = _zz_dataState_0_18[4];
  assign _zz__zz_dataState_0_19_23 = {_zz_dataState_0_18[3],{_zz__zz_dataState_0_19_24,{_zz__zz_dataState_0_19_25,_zz__zz_dataState_0_19_26}}};
  assign _zz__zz_dataState_0_19_3 = (_zz_dataState_0_6[3] ^ _zz_dataState_0_7);
  assign _zz__zz_dataState_0_19_4 = (_zz_dataState_0_6[2] ^ _zz_dataState_0_7);
  assign _zz__zz_dataState_0_19_5 = {_zz_dataState_0_6[1],{_zz__zz_dataState_0_19_6,_zz_dataState_0_7}};
  assign _zz__zz_dataState_0_19_10 = ((_zz_dataState_0_12 ^ _zz_dataState_0_16) ^ _zz_dataState_0_13);
  assign _zz__zz_dataState_0_19_11 = ((_zz_dataState_0_11 ^ _zz_dataState_0_16) ^ _zz_dataState_0_12);
  assign _zz__zz_dataState_0_19_12 = {(_zz_dataState_0_10 ^ _zz_dataState_0_11),{_zz__zz_dataState_0_19_13,_zz__zz_dataState_0_19_14}};
  assign _zz__zz_dataState_0_19_18 = _zz_dataState_0_17[3];
  assign _zz__zz_dataState_0_19_19 = _zz_dataState_0_17[2];
  assign _zz__zz_dataState_0_19_20 = {_zz_dataState_0_17[1],_zz_dataState_0_17[0]};
  assign _zz__zz_dataState_0_19_24 = _zz_dataState_0_18[2];
  assign _zz__zz_dataState_0_19_25 = _zz_dataState_0_18[1];
  assign _zz__zz_dataState_0_19_26 = _zz_dataState_0_18[0];
  assign _zz__zz_dataState_0_19_6 = (_zz_dataState_0_6[0] ^ _zz_dataState_0_7);
  assign _zz__zz_dataState_0_19_13 = ((_zz_dataState_0_9 ^ _zz_dataState_0_16) ^ _zz_dataState_0_10);
  assign _zz__zz_dataState_0_19_14 = (_zz_dataState_0_16 ^ _zz_dataState_0_9);
  assign _zz__zz_dataState_0_33 = _zz_dataState_0_20[7];
  assign _zz__zz_dataState_0_33_1 = _zz_dataState_0_20[6];
  assign _zz__zz_dataState_0_33_2 = {_zz_dataState_0_20[5],{_zz__zz_dataState_0_33_3,{_zz__zz_dataState_0_33_4,_zz__zz_dataState_0_33_5}}};
  assign _zz__zz_dataState_0_33_8 = _zz_dataState_0_21[6];
  assign _zz__zz_dataState_0_33_9 = _zz_dataState_0_21[5];
  assign _zz__zz_dataState_0_33_10 = {_zz_dataState_0_21[4],{_zz__zz_dataState_0_33_11,{_zz__zz_dataState_0_33_12,_zz__zz_dataState_0_33_13}}};
  assign _zz__zz_dataState_0_33_15 = (_zz_dataState_0_29 ^ _zz_dataState_0_30);
  assign _zz__zz_dataState_0_33_16 = (_zz_dataState_0_28 ^ _zz_dataState_0_29);
  assign _zz__zz_dataState_0_33_17 = {(_zz__zz_dataState_0_33_18 ^ _zz_dataState_0_28),{_zz__zz_dataState_0_33_19,{_zz__zz_dataState_0_33_20,_zz__zz_dataState_0_33_21}}};
  assign _zz__zz_dataState_0_33_23 = _zz_dataState_0_32[5];
  assign _zz__zz_dataState_0_33_24 = _zz_dataState_0_32[4];
  assign _zz__zz_dataState_0_33_25 = {_zz_dataState_0_32[3],{_zz__zz_dataState_0_33_26,{_zz__zz_dataState_0_33_27,_zz__zz_dataState_0_33_28}}};
  assign _zz__zz_dataState_0_33_3 = _zz_dataState_0_20[4];
  assign _zz__zz_dataState_0_33_4 = _zz_dataState_0_20[3];
  assign _zz__zz_dataState_0_33_5 = {_zz_dataState_0_20[2],{_zz__zz_dataState_0_33_6,_zz__zz_dataState_0_33_7}};
  assign _zz__zz_dataState_0_33_11 = (_zz_dataState_0_21[3] ^ _zz_dataState_0_22);
  assign _zz__zz_dataState_0_33_12 = (_zz_dataState_0_21[2] ^ _zz_dataState_0_22);
  assign _zz__zz_dataState_0_33_13 = {_zz_dataState_0_21[1],{_zz__zz_dataState_0_33_14,_zz_dataState_0_22}};
  assign _zz__zz_dataState_0_33_18 = (_zz_dataState_0_27 ^ _zz_dataState_0_31);
  assign _zz__zz_dataState_0_33_19 = ((_zz_dataState_0_26 ^ _zz_dataState_0_31) ^ _zz_dataState_0_27);
  assign _zz__zz_dataState_0_33_20 = (_zz_dataState_0_25 ^ _zz_dataState_0_26);
  assign _zz__zz_dataState_0_33_21 = {(_zz__zz_dataState_0_33_22 ^ _zz_dataState_0_25),(_zz_dataState_0_31 ^ _zz_dataState_0_24)};
  assign _zz__zz_dataState_0_33_26 = _zz_dataState_0_32[2];
  assign _zz__zz_dataState_0_33_27 = _zz_dataState_0_32[1];
  assign _zz__zz_dataState_0_33_28 = _zz_dataState_0_32[0];
  assign _zz__zz_dataState_0_33_6 = _zz_dataState_0_20[1];
  assign _zz__zz_dataState_0_33_7 = _zz_dataState_0_20[0];
  assign _zz__zz_dataState_0_33_14 = (_zz_dataState_0_21[0] ^ _zz_dataState_0_22);
  assign _zz__zz_dataState_0_33_22 = (_zz_dataState_0_24 ^ _zz_dataState_0_31);
  assign _zz__zz_dataState_0_47 = _zz_dataState_0_34[7];
  assign _zz__zz_dataState_0_47_1 = _zz_dataState_0_34[6];
  assign _zz__zz_dataState_0_47_2 = {_zz_dataState_0_34[5],{_zz__zz_dataState_0_47_3,{_zz__zz_dataState_0_47_4,_zz__zz_dataState_0_47_5}}};
  assign _zz__zz_dataState_0_47_6 = _zz_dataState_0_35[7];
  assign _zz__zz_dataState_0_47_7 = _zz_dataState_0_35[6];
  assign _zz__zz_dataState_0_47_8 = {_zz_dataState_0_35[5],{_zz__zz_dataState_0_47_9,{_zz__zz_dataState_0_47_10,_zz__zz_dataState_0_47_11}}};
  assign _zz__zz_dataState_0_47_12 = _zz_dataState_0_36[5];
  assign _zz__zz_dataState_0_47_13 = _zz_dataState_0_36[4];
  assign _zz__zz_dataState_0_47_14 = {(_zz__zz_dataState_0_47_15 ^ _zz_dataState_0_37),{_zz__zz_dataState_0_47_16,{_zz__zz_dataState_0_47_17,_zz__zz_dataState_0_47_18}}};
  assign _zz__zz_dataState_0_47_19 = (_zz_dataState_0_43 ^ _zz_dataState_0_44);
  assign _zz__zz_dataState_0_47_20 = ((_zz_dataState_0_42 ^ _zz_dataState_0_46) ^ _zz_dataState_0_43);
  assign _zz__zz_dataState_0_47_21 = {(_zz__zz_dataState_0_47_22 ^ _zz_dataState_0_42),{_zz__zz_dataState_0_47_23,{_zz__zz_dataState_0_47_24,_zz__zz_dataState_0_47_25}}};
  assign _zz__zz_dataState_0_47_3 = _zz_dataState_0_34[4];
  assign _zz__zz_dataState_0_47_4 = _zz_dataState_0_34[3];
  assign _zz__zz_dataState_0_47_5 = {_zz_dataState_0_34[2],{_zz_dataState_0_34[1],_zz_dataState_0_34[0]}};
  assign _zz__zz_dataState_0_47_9 = _zz_dataState_0_35[4];
  assign _zz__zz_dataState_0_47_10 = _zz_dataState_0_35[3];
  assign _zz__zz_dataState_0_47_11 = {_zz_dataState_0_35[2],{_zz_dataState_0_35[1],_zz_dataState_0_35[0]}};
  assign _zz__zz_dataState_0_47_15 = _zz_dataState_0_36[3];
  assign _zz__zz_dataState_0_47_16 = (_zz_dataState_0_36[2] ^ _zz_dataState_0_37);
  assign _zz__zz_dataState_0_47_17 = _zz_dataState_0_36[1];
  assign _zz__zz_dataState_0_47_18 = {(_zz_dataState_0_36[0] ^ _zz_dataState_0_37),_zz_dataState_0_37};
  assign _zz__zz_dataState_0_47_22 = (_zz_dataState_0_41 ^ _zz_dataState_0_46);
  assign _zz__zz_dataState_0_47_23 = (_zz_dataState_0_40 ^ _zz_dataState_0_41);
  assign _zz__zz_dataState_0_47_24 = ((_zz_dataState_0_39 ^ _zz_dataState_0_46) ^ _zz_dataState_0_40);
  assign _zz__zz_dataState_0_47_25 = (_zz_dataState_0_46 ^ _zz_dataState_0_39);
  assign _zz__zz_dataState_0_61 = (_zz_dataState_0_55 ^ _zz_dataState_0_56);
  assign _zz__zz_dataState_0_61_1 = (_zz_dataState_0_54 ^ _zz_dataState_0_55);
  assign _zz__zz_dataState_0_61_2 = {_zz__zz_dataState_0_61_3,{_zz__zz_dataState_0_61_4,_zz__zz_dataState_0_61_5}};
  assign _zz__zz_dataState_0_61_10 = _zz_dataState_0_57[7];
  assign _zz__zz_dataState_0_61_11 = _zz_dataState_0_57[6];
  assign _zz__zz_dataState_0_61_12 = {_zz__zz_dataState_0_61_13,{_zz__zz_dataState_0_61_14,_zz__zz_dataState_0_61_15}};
  assign _zz__zz_dataState_0_61_19 = _zz_dataState_0_58[6];
  assign _zz__zz_dataState_0_61_20 = _zz_dataState_0_58[5];
  assign _zz__zz_dataState_0_61_21 = {_zz__zz_dataState_0_61_22,{_zz__zz_dataState_0_61_23,_zz__zz_dataState_0_61_24}};
  assign _zz__zz_dataState_0_61_27 = _zz_dataState_0_59[4];
  assign _zz__zz_dataState_0_61_28 = (_zz__zz_dataState_0_61_29 ^ _zz_dataState_0_60);
  assign _zz__zz_dataState_0_61_30 = {_zz__zz_dataState_0_61_31,{_zz__zz_dataState_0_61_32,_zz__zz_dataState_0_61_33}};
  assign _zz__zz_dataState_0_61_3 = (_zz_dataState_0_53 ^ _zz_dataState_0_54);
  assign _zz__zz_dataState_0_61_4 = ((_zz_dataState_0_52 ^ _zz_dataState_0_56) ^ _zz_dataState_0_53);
  assign _zz__zz_dataState_0_61_5 = {(_zz__zz_dataState_0_61_6 ^ _zz_dataState_0_52),{_zz__zz_dataState_0_61_7,{_zz__zz_dataState_0_61_8,_zz__zz_dataState_0_61_9}}};
  assign _zz__zz_dataState_0_61_13 = _zz_dataState_0_57[5];
  assign _zz__zz_dataState_0_61_14 = _zz_dataState_0_57[4];
  assign _zz__zz_dataState_0_61_15 = {_zz_dataState_0_57[3],{_zz__zz_dataState_0_61_16,{_zz__zz_dataState_0_61_17,_zz__zz_dataState_0_61_18}}};
  assign _zz__zz_dataState_0_61_22 = _zz_dataState_0_58[4];
  assign _zz__zz_dataState_0_61_23 = _zz_dataState_0_58[3];
  assign _zz__zz_dataState_0_61_24 = {_zz_dataState_0_58[2],{_zz__zz_dataState_0_61_25,_zz__zz_dataState_0_61_26}};
  assign _zz__zz_dataState_0_61_29 = _zz_dataState_0_59[3];
  assign _zz__zz_dataState_0_61_31 = (_zz_dataState_0_59[2] ^ _zz_dataState_0_60);
  assign _zz__zz_dataState_0_61_32 = _zz_dataState_0_59[1];
  assign _zz__zz_dataState_0_61_33 = {(_zz__zz_dataState_0_61_34 ^ _zz_dataState_0_60),_zz_dataState_0_60};
  assign _zz__zz_dataState_0_61_6 = (_zz_dataState_0_51 ^ _zz_dataState_0_56);
  assign _zz__zz_dataState_0_61_7 = (_zz_dataState_0_50 ^ _zz_dataState_0_51);
  assign _zz__zz_dataState_0_61_8 = ((_zz_dataState_0_49 ^ _zz_dataState_0_56) ^ _zz_dataState_0_50);
  assign _zz__zz_dataState_0_61_9 = (_zz_dataState_0_56 ^ _zz_dataState_0_49);
  assign _zz__zz_dataState_0_61_16 = _zz_dataState_0_57[2];
  assign _zz__zz_dataState_0_61_17 = _zz_dataState_0_57[1];
  assign _zz__zz_dataState_0_61_18 = _zz_dataState_0_57[0];
  assign _zz__zz_dataState_0_61_25 = _zz_dataState_0_58[1];
  assign _zz__zz_dataState_0_61_26 = _zz_dataState_0_58[0];
  assign _zz__zz_dataState_0_61_34 = _zz_dataState_0_59[0];
  assign _zz__zz_dataState_0_98 = ((_zz_dataState_0_67 ^ _zz_dataState_0_68) ^ _zz_dataState_0_69);
  assign _zz__zz_dataState_0_98_1 = (_zz__zz_dataState_0_98_2 ^ _zz_dataState_0_68);
  assign _zz__zz_dataState_0_98_3 = {_zz__zz_dataState_0_98_4,{_zz__zz_dataState_0_98_6,_zz__zz_dataState_0_98_8}};
  assign _zz__zz_dataState_0_98_16 = ((_zz_dataState_0_76 ^ _zz_dataState_0_78) ^ _zz_dataState_0_79);
  assign _zz__zz_dataState_0_98_17 = (_zz__zz_dataState_0_98_18 ^ _zz_dataState_0_78);
  assign _zz__zz_dataState_0_98_19 = {_zz__zz_dataState_0_98_20,{_zz__zz_dataState_0_98_22,_zz__zz_dataState_0_98_25}};
  assign _zz__zz_dataState_0_98_33 = (_zz_dataState_0_85 ^ _zz_dataState_0_86);
  assign _zz__zz_dataState_0_98_34 = ((_zz__zz_dataState_0_98_35 ^ _zz_dataState_0_85) ^ _zz_dataState_0_87);
  assign _zz__zz_dataState_0_98_36 = (_zz__zz_dataState_0_98_37 ^ _zz_dataState_0_86);
  assign _zz__zz_dataState_0_98_38 = {_zz__zz_dataState_0_98_39,{_zz__zz_dataState_0_98_41,_zz__zz_dataState_0_98_44}};
  assign _zz__zz_dataState_0_98_50 = (_zz_dataState_0_93 ^ _zz_dataState_0_97);
  assign _zz__zz_dataState_0_98_51 = ((_zz__zz_dataState_0_98_52 ^ _zz_dataState_0_96) ^ _zz_dataState_0_95);
  assign _zz__zz_dataState_0_98_53 = (_zz__zz_dataState_0_98_54 ^ _zz_dataState_0_94);
  assign _zz__zz_dataState_0_98_55 = {_zz__zz_dataState_0_98_56,{_zz__zz_dataState_0_98_58,_zz__zz_dataState_0_98_60}};
  assign _zz__zz_dataState_0_98_2 = ((_zz_dataState_0_66 ^ _zz_dataState_0_70) ^ _zz_dataState_0_67);
  assign _zz__zz_dataState_0_98_4 = ((_zz__zz_dataState_0_98_5 ^ _zz_dataState_0_66) ^ _zz_dataState_0_67);
  assign _zz__zz_dataState_0_98_6 = (_zz__zz_dataState_0_98_7 ^ _zz_dataState_0_66);
  assign _zz__zz_dataState_0_98_8 = {_zz__zz_dataState_0_98_9,{_zz__zz_dataState_0_98_11,_zz__zz_dataState_0_98_13}};
  assign _zz__zz_dataState_0_98_18 = ((_zz_dataState_0_75 ^ _zz_dataState_0_79) ^ _zz_dataState_0_77);
  assign _zz__zz_dataState_0_98_20 = ((_zz__zz_dataState_0_98_21 ^ _zz_dataState_0_76) ^ _zz_dataState_0_77);
  assign _zz__zz_dataState_0_98_22 = (_zz__zz_dataState_0_98_23 ^ _zz_dataState_0_76);
  assign _zz__zz_dataState_0_98_25 = {_zz__zz_dataState_0_98_26,{_zz__zz_dataState_0_98_28,_zz__zz_dataState_0_98_30}};
  assign _zz__zz_dataState_0_98_35 = (_zz_dataState_0_84 ^ _zz_dataState_0_88);
  assign _zz__zz_dataState_0_98_37 = ((_zz_dataState_0_83 ^ _zz_dataState_0_87) ^ _zz_dataState_0_84);
  assign _zz__zz_dataState_0_98_39 = ((_zz__zz_dataState_0_98_40 ^ _zz_dataState_0_88) ^ _zz_dataState_0_85);
  assign _zz__zz_dataState_0_98_41 = (_zz__zz_dataState_0_98_42 ^ _zz_dataState_0_84);
  assign _zz__zz_dataState_0_98_44 = {_zz__zz_dataState_0_98_45,{_zz__zz_dataState_0_98_46,_zz__zz_dataState_0_98_48}};
  assign _zz__zz_dataState_0_98_52 = (_zz_dataState_0_92 ^ _zz_dataState_0_97);
  assign _zz__zz_dataState_0_98_54 = ((_zz_dataState_0_91 ^ _zz_dataState_0_96) ^ _zz_dataState_0_95);
  assign _zz__zz_dataState_0_98_56 = ((_zz__zz_dataState_0_98_57 ^ _zz_dataState_0_95) ^ _zz_dataState_0_93);
  assign _zz__zz_dataState_0_98_58 = (_zz__zz_dataState_0_98_59 ^ _zz_dataState_0_92);
  assign _zz__zz_dataState_0_98_60 = {_zz__zz_dataState_0_98_61,_zz__zz_dataState_0_98_62};
  assign _zz__zz_dataState_0_98_5 = (_zz_dataState_0_65 ^ _zz_dataState_0_69);
  assign _zz__zz_dataState_0_98_7 = ((_zz_dataState_0_64 ^ _zz_dataState_0_68) ^ _zz_dataState_0_65);
  assign _zz__zz_dataState_0_98_9 = ((_zz__zz_dataState_0_98_10 ^ _zz_dataState_0_69) ^ _zz_dataState_0_65);
  assign _zz__zz_dataState_0_98_11 = (_zz__zz_dataState_0_98_12 ^ _zz_dataState_0_64);
  assign _zz__zz_dataState_0_98_13 = {_zz__zz_dataState_0_98_14,_zz__zz_dataState_0_98_15};
  assign _zz__zz_dataState_0_98_21 = ((_zz_dataState_0_74 ^ _zz_dataState_0_79) ^ _zz_dataState_0_78);
  assign _zz__zz_dataState_0_98_23 = ((_zz__zz_dataState_0_98_24 ^ _zz_dataState_0_75) ^ _zz_dataState_0_79);
  assign _zz__zz_dataState_0_98_26 = ((_zz__zz_dataState_0_98_27 ^ _zz_dataState_0_74) ^ _zz_dataState_0_75);
  assign _zz__zz_dataState_0_98_28 = (_zz__zz_dataState_0_98_29 ^ _zz_dataState_0_74);
  assign _zz__zz_dataState_0_98_30 = {_zz__zz_dataState_0_98_31,_zz__zz_dataState_0_98_32};
  assign _zz__zz_dataState_0_98_40 = ((_zz_dataState_0_82 ^ _zz_dataState_0_86) ^ _zz_dataState_0_83);
  assign _zz__zz_dataState_0_98_42 = ((_zz__zz_dataState_0_98_43 ^ _zz_dataState_0_82) ^ _zz_dataState_0_87);
  assign _zz__zz_dataState_0_98_45 = ((_zz_dataState_0_87 ^ _zz_dataState_0_81) ^ _zz_dataState_0_83);
  assign _zz__zz_dataState_0_98_46 = (_zz__zz_dataState_0_98_47 ^ _zz_dataState_0_82);
  assign _zz__zz_dataState_0_98_48 = (_zz__zz_dataState_0_98_49 ^ _zz_dataState_0_81);
  assign _zz__zz_dataState_0_98_57 = (_zz_dataState_0_90 ^ _zz_dataState_0_97);
  assign _zz__zz_dataState_0_98_59 = (_zz_dataState_0_97 ^ _zz_dataState_0_96);
  assign _zz__zz_dataState_0_98_61 = ((_zz_dataState_0_96 ^ _zz_dataState_0_95) ^ _zz_dataState_0_91);
  assign _zz__zz_dataState_0_98_62 = (_zz_dataState_0_95 ^ _zz_dataState_0_90);
  assign _zz__zz_dataState_0_98_10 = ((_zz_dataState_0_63 ^ _zz_dataState_0_68) ^ _zz_dataState_0_64);
  assign _zz__zz_dataState_0_98_12 = (_zz_dataState_0_69 ^ _zz_dataState_0_63);
  assign _zz__zz_dataState_0_98_14 = (_zz_dataState_0_68 ^ _zz_dataState_0_63);
  assign _zz__zz_dataState_0_98_15 = ((_zz_dataState_0_68 ^ _zz_dataState_0_69) ^ _zz_dataState_0_70);
  assign _zz__zz_dataState_0_98_24 = ((_zz_dataState_0_73 ^ _zz_dataState_0_78) ^ _zz_dataState_0_77);
  assign _zz__zz_dataState_0_98_27 = (_zz_dataState_0_72 ^ _zz_dataState_0_77);
  assign _zz__zz_dataState_0_98_29 = ((_zz_dataState_0_79 ^ _zz_dataState_0_78) ^ _zz_dataState_0_73);
  assign _zz__zz_dataState_0_98_31 = ((((_zz_dataState_0_78 ^ _zz_dataState_0_77) ^ _zz_dataState_0_72) ^ _zz_dataState_0_79) ^ _zz_dataState_0_73);
  assign _zz__zz_dataState_0_98_32 = ((_zz_dataState_0_77 ^ _zz_dataState_0_79) ^ _zz_dataState_0_72);
  assign _zz__zz_dataState_0_98_43 = ((_zz_dataState_0_81 ^ _zz_dataState_0_88) ^ _zz_dataState_0_86);
  assign _zz__zz_dataState_0_98_47 = (_zz_dataState_0_86 ^ _zz_dataState_0_88);
  assign _zz__zz_dataState_0_98_49 = (_zz_dataState_0_86 ^ _zz_dataState_0_87);
  assign _zz__zz_dataState_0_135 = (_zz_dataState_0_104 ^ _zz_dataState_0_107);
  assign _zz__zz_dataState_0_135_1 = (_zz__zz_dataState_0_135_2 ^ _zz_dataState_0_106);
  assign _zz__zz_dataState_0_135_3 = {_zz__zz_dataState_0_135_4,{_zz__zz_dataState_0_135_6,_zz__zz_dataState_0_135_9}};
  assign _zz__zz_dataState_0_135_17 = ((_zz_dataState_0_113 ^ _zz_dataState_0_114) ^ _zz_dataState_0_115);
  assign _zz__zz_dataState_0_135_18 = (_zz__zz_dataState_0_135_19 ^ _zz_dataState_0_114);
  assign _zz__zz_dataState_0_135_20 = {_zz__zz_dataState_0_135_21,{_zz__zz_dataState_0_135_23,_zz__zz_dataState_0_135_26}};
  assign _zz__zz_dataState_0_135_34 = (_zz_dataState_0_122 ^ _zz_dataState_0_124);
  assign _zz__zz_dataState_0_135_35 = ((_zz__zz_dataState_0_135_36 ^ _zz_dataState_0_123) ^ _zz_dataState_0_124);
  assign _zz__zz_dataState_0_135_37 = (_zz__zz_dataState_0_135_38 ^ _zz_dataState_0_123);
  assign _zz__zz_dataState_0_135_40 = {_zz__zz_dataState_0_135_41,{_zz__zz_dataState_0_135_44,_zz__zz_dataState_0_135_47}};
  assign _zz__zz_dataState_0_135_55 = ((_zz_dataState_0_130 ^ _zz_dataState_0_134) ^ _zz_dataState_0_131);
  assign _zz__zz_dataState_0_135_56 = ((_zz__zz_dataState_0_135_57 ^ _zz_dataState_0_130) ^ _zz_dataState_0_132);
  assign _zz__zz_dataState_0_135_58 = (_zz__zz_dataState_0_135_59 ^ _zz_dataState_0_131);
  assign _zz__zz_dataState_0_135_61 = {_zz__zz_dataState_0_135_62,{_zz__zz_dataState_0_135_65,_zz__zz_dataState_0_135_67}};
  assign _zz__zz_dataState_0_135_2 = (_zz_dataState_0_103 ^ _zz_dataState_0_107);
  assign _zz__zz_dataState_0_135_4 = ((_zz__zz_dataState_0_135_5 ^ _zz_dataState_0_106) ^ _zz_dataState_0_105);
  assign _zz__zz_dataState_0_135_6 = (_zz__zz_dataState_0_135_7 ^ _zz_dataState_0_104);
  assign _zz__zz_dataState_0_135_9 = {_zz__zz_dataState_0_135_10,{_zz__zz_dataState_0_135_12,_zz__zz_dataState_0_135_14}};
  assign _zz__zz_dataState_0_135_19 = ((_zz_dataState_0_112 ^ _zz_dataState_0_116) ^ _zz_dataState_0_113);
  assign _zz__zz_dataState_0_135_21 = ((_zz__zz_dataState_0_135_22 ^ _zz_dataState_0_112) ^ _zz_dataState_0_113);
  assign _zz__zz_dataState_0_135_23 = (_zz__zz_dataState_0_135_24 ^ _zz_dataState_0_112);
  assign _zz__zz_dataState_0_135_26 = {_zz__zz_dataState_0_135_27,{_zz__zz_dataState_0_135_29,_zz__zz_dataState_0_135_31}};
  assign _zz__zz_dataState_0_135_36 = (_zz_dataState_0_121 ^ _zz_dataState_0_125);
  assign _zz__zz_dataState_0_135_38 = ((_zz__zz_dataState_0_135_39 ^ _zz_dataState_0_124) ^ _zz_dataState_0_122);
  assign _zz__zz_dataState_0_135_41 = ((_zz__zz_dataState_0_135_42 ^ _zz_dataState_0_125) ^ _zz_dataState_0_122);
  assign _zz__zz_dataState_0_135_44 = (_zz__zz_dataState_0_135_45 ^ _zz_dataState_0_121);
  assign _zz__zz_dataState_0_135_47 = {_zz__zz_dataState_0_135_48,{_zz__zz_dataState_0_135_50,_zz__zz_dataState_0_135_53}};
  assign _zz__zz_dataState_0_135_57 = (_zz_dataState_0_129 ^ _zz_dataState_0_133);
  assign _zz__zz_dataState_0_135_59 = ((_zz__zz_dataState_0_135_60 ^ _zz_dataState_0_129) ^ _zz_dataState_0_134);
  assign _zz__zz_dataState_0_135_62 = ((_zz__zz_dataState_0_135_63 ^ _zz_dataState_0_133) ^ _zz_dataState_0_130);
  assign _zz__zz_dataState_0_135_65 = (_zz__zz_dataState_0_135_66 ^ _zz_dataState_0_129);
  assign _zz__zz_dataState_0_135_67 = {_zz__zz_dataState_0_135_68,_zz__zz_dataState_0_135_70};
  assign _zz__zz_dataState_0_135_5 = (_zz_dataState_0_102 ^ _zz_dataState_0_107);
  assign _zz__zz_dataState_0_135_7 = (_zz__zz_dataState_0_135_8 ^ _zz_dataState_0_105);
  assign _zz__zz_dataState_0_135_10 = (_zz__zz_dataState_0_135_11 ^ _zz_dataState_0_103);
  assign _zz__zz_dataState_0_135_12 = _zz__zz_dataState_0_135_13;
  assign _zz__zz_dataState_0_135_14 = {_zz__zz_dataState_0_135_15,_zz__zz_dataState_0_135_16};
  assign _zz__zz_dataState_0_135_22 = (_zz_dataState_0_111 ^ _zz_dataState_0_115);
  assign _zz__zz_dataState_0_135_24 = (_zz__zz_dataState_0_135_25 ^ _zz_dataState_0_111);
  assign _zz__zz_dataState_0_135_27 = (_zz__zz_dataState_0_135_28 ^ _zz_dataState_0_111);
  assign _zz__zz_dataState_0_135_29 = _zz__zz_dataState_0_135_30;
  assign _zz__zz_dataState_0_135_31 = {_zz__zz_dataState_0_135_32,_zz__zz_dataState_0_135_33};
  assign _zz__zz_dataState_0_135_39 = (_zz_dataState_0_120 ^ _zz_dataState_0_125);
  assign _zz__zz_dataState_0_135_42 = (_zz__zz_dataState_0_135_43 ^ _zz_dataState_0_121);
  assign _zz__zz_dataState_0_135_45 = (_zz__zz_dataState_0_135_46 ^ _zz_dataState_0_120);
  assign _zz__zz_dataState_0_135_48 = (_zz__zz_dataState_0_135_49 ^ _zz_dataState_0_120);
  assign _zz__zz_dataState_0_135_50 = _zz__zz_dataState_0_135_51;
  assign _zz__zz_dataState_0_135_53 = _zz__zz_dataState_0_135_54;
  assign _zz__zz_dataState_0_135_60 = (_zz_dataState_0_128 ^ _zz_dataState_0_132);
  assign _zz__zz_dataState_0_135_63 = (_zz__zz_dataState_0_135_64 ^ _zz_dataState_0_128);
  assign _zz__zz_dataState_0_135_66 = (_zz_dataState_0_133 ^ _zz_dataState_0_127);
  assign _zz__zz_dataState_0_135_68 = (_zz__zz_dataState_0_135_69 ^ _zz_dataState_0_128);
  assign _zz__zz_dataState_0_135_70 = (_zz__zz_dataState_0_135_71 ^ _zz_dataState_0_127);
  assign _zz__zz_dataState_0_135_8 = (_zz_dataState_0_101 ^ _zz_dataState_0_106);
  assign _zz__zz_dataState_0_135_11 = ((_zz_dataState_0_100 ^ _zz_dataState_0_107) ^ _zz_dataState_0_105);
  assign _zz__zz_dataState_0_135_13 = ((_zz_dataState_0_107 ^ _zz_dataState_0_106) ^ _zz_dataState_0_102);
  assign _zz__zz_dataState_0_135_15 = ((_zz_dataState_0_106 ^ _zz_dataState_0_105) ^ _zz_dataState_0_101);
  assign _zz__zz_dataState_0_135_16 = (_zz_dataState_0_105 ^ _zz_dataState_0_100);
  assign _zz__zz_dataState_0_135_25 = (_zz_dataState_0_110 ^ _zz_dataState_0_114);
  assign _zz__zz_dataState_0_135_28 = (((_zz_dataState_0_109 ^ _zz_dataState_0_114) ^ _zz_dataState_0_110) ^ _zz_dataState_0_115);
  assign _zz__zz_dataState_0_135_30 = ((_zz_dataState_0_115 ^ _zz_dataState_0_109) ^ _zz_dataState_0_110);
  assign _zz__zz_dataState_0_135_32 = (_zz_dataState_0_114 ^ _zz_dataState_0_109);
  assign _zz__zz_dataState_0_135_33 = ((_zz_dataState_0_114 ^ _zz_dataState_0_115) ^ _zz_dataState_0_116);
  assign _zz__zz_dataState_0_135_43 = ((_zz_dataState_0_119 ^ _zz_dataState_0_124) ^ _zz_dataState_0_123);
  assign _zz__zz_dataState_0_135_46 = (_zz_dataState_0_118 ^ _zz_dataState_0_123);
  assign _zz__zz_dataState_0_135_49 = ((_zz_dataState_0_125 ^ _zz_dataState_0_124) ^ _zz_dataState_0_119);
  assign _zz__zz_dataState_0_135_51 = (((_zz__zz_dataState_0_135_52 ^ _zz_dataState_0_118) ^ _zz_dataState_0_125) ^ _zz_dataState_0_119);
  assign _zz__zz_dataState_0_135_54 = ((_zz_dataState_0_123 ^ _zz_dataState_0_125) ^ _zz_dataState_0_118);
  assign _zz__zz_dataState_0_135_64 = ((_zz_dataState_0_127 ^ _zz_dataState_0_134) ^ _zz_dataState_0_132);
  assign _zz__zz_dataState_0_135_69 = (_zz_dataState_0_132 ^ _zz_dataState_0_134);
  assign _zz__zz_dataState_0_135_71 = (_zz_dataState_0_132 ^ _zz_dataState_0_133);
  assign _zz__zz_dataState_0_135_52 = (_zz_dataState_0_124 ^ _zz_dataState_0_123);
  assign _zz__zz_dataState_0_172 = ((_zz_dataState_0_141 ^ _zz_dataState_0_142) ^ _zz_dataState_0_144);
  assign _zz__zz_dataState_0_172_1 = (_zz__zz_dataState_0_172_2 ^ _zz_dataState_0_143);
  assign _zz__zz_dataState_0_172_3 = {_zz__zz_dataState_0_172_4,{_zz__zz_dataState_0_172_6,_zz__zz_dataState_0_172_9}};
  assign _zz__zz_dataState_0_172_17 = (_zz_dataState_0_150 ^ _zz_dataState_0_153);
  assign _zz__zz_dataState_0_172_18 = (_zz__zz_dataState_0_172_19 ^ _zz_dataState_0_152);
  assign _zz__zz_dataState_0_172_20 = {_zz__zz_dataState_0_172_21,{_zz__zz_dataState_0_172_23,_zz__zz_dataState_0_172_26}};
  assign _zz__zz_dataState_0_172_34 = (_zz_dataState_0_159 ^ _zz_dataState_0_160);
  assign _zz__zz_dataState_0_172_35 = ((_zz__zz_dataState_0_172_36 ^ _zz_dataState_0_159) ^ _zz_dataState_0_160);
  assign _zz__zz_dataState_0_172_37 = (_zz__zz_dataState_0_172_38 ^ _zz_dataState_0_159);
  assign _zz__zz_dataState_0_172_39 = {_zz__zz_dataState_0_172_40,{_zz__zz_dataState_0_172_42,_zz__zz_dataState_0_172_45}};
  assign _zz__zz_dataState_0_172_52 = ((_zz_dataState_0_167 ^ _zz_dataState_0_171) ^ _zz_dataState_0_169);
  assign _zz__zz_dataState_0_172_53 = ((_zz__zz_dataState_0_172_54 ^ _zz_dataState_0_168) ^ _zz_dataState_0_169);
  assign _zz__zz_dataState_0_172_55 = (_zz__zz_dataState_0_172_56 ^ _zz_dataState_0_168);
  assign _zz__zz_dataState_0_172_59 = {_zz__zz_dataState_0_172_60,{_zz__zz_dataState_0_172_62,_zz__zz_dataState_0_172_65}};
  assign _zz__zz_dataState_0_172_2 = ((_zz_dataState_0_140 ^ _zz_dataState_0_144) ^ _zz_dataState_0_141);
  assign _zz__zz_dataState_0_172_4 = ((_zz__zz_dataState_0_172_5 ^ _zz_dataState_0_140) ^ _zz_dataState_0_142);
  assign _zz__zz_dataState_0_172_6 = (_zz__zz_dataState_0_172_7 ^ _zz_dataState_0_141);
  assign _zz__zz_dataState_0_172_9 = {_zz__zz_dataState_0_172_10,{_zz__zz_dataState_0_172_12,_zz__zz_dataState_0_172_14}};
  assign _zz__zz_dataState_0_172_19 = (_zz_dataState_0_149 ^ _zz_dataState_0_153);
  assign _zz__zz_dataState_0_172_21 = ((_zz__zz_dataState_0_172_22 ^ _zz_dataState_0_152) ^ _zz_dataState_0_151);
  assign _zz__zz_dataState_0_172_23 = (_zz__zz_dataState_0_172_24 ^ _zz_dataState_0_150);
  assign _zz__zz_dataState_0_172_26 = {_zz__zz_dataState_0_172_27,{_zz__zz_dataState_0_172_29,_zz__zz_dataState_0_172_31}};
  assign _zz__zz_dataState_0_172_36 = (_zz_dataState_0_158 ^ _zz_dataState_0_162);
  assign _zz__zz_dataState_0_172_38 = ((_zz_dataState_0_157 ^ _zz_dataState_0_161) ^ _zz_dataState_0_158);
  assign _zz__zz_dataState_0_172_40 = ((_zz__zz_dataState_0_172_41 ^ _zz_dataState_0_157) ^ _zz_dataState_0_158);
  assign _zz__zz_dataState_0_172_42 = (_zz__zz_dataState_0_172_43 ^ _zz_dataState_0_157);
  assign _zz__zz_dataState_0_172_45 = {_zz__zz_dataState_0_172_46,{_zz__zz_dataState_0_172_48,_zz__zz_dataState_0_172_50}};
  assign _zz__zz_dataState_0_172_54 = ((_zz_dataState_0_166 ^ _zz_dataState_0_171) ^ _zz_dataState_0_170);
  assign _zz__zz_dataState_0_172_56 = ((_zz__zz_dataState_0_172_57 ^ _zz_dataState_0_167) ^ _zz_dataState_0_171);
  assign _zz__zz_dataState_0_172_60 = ((_zz__zz_dataState_0_172_61 ^ _zz_dataState_0_166) ^ _zz_dataState_0_167);
  assign _zz__zz_dataState_0_172_62 = (_zz__zz_dataState_0_172_63 ^ _zz_dataState_0_166);
  assign _zz__zz_dataState_0_172_65 = {_zz__zz_dataState_0_172_66,_zz__zz_dataState_0_172_68};
  assign _zz__zz_dataState_0_172_5 = (_zz_dataState_0_139 ^ _zz_dataState_0_143);
  assign _zz__zz_dataState_0_172_7 = (_zz__zz_dataState_0_172_8 ^ _zz_dataState_0_144);
  assign _zz__zz_dataState_0_172_10 = (_zz__zz_dataState_0_172_11 ^ _zz_dataState_0_140);
  assign _zz__zz_dataState_0_172_12 = _zz__zz_dataState_0_172_13;
  assign _zz__zz_dataState_0_172_14 = {_zz__zz_dataState_0_172_15,_zz__zz_dataState_0_172_16};
  assign _zz__zz_dataState_0_172_22 = (_zz_dataState_0_148 ^ _zz_dataState_0_153);
  assign _zz__zz_dataState_0_172_24 = (_zz__zz_dataState_0_172_25 ^ _zz_dataState_0_151);
  assign _zz__zz_dataState_0_172_27 = (_zz__zz_dataState_0_172_28 ^ _zz_dataState_0_149);
  assign _zz__zz_dataState_0_172_29 = _zz__zz_dataState_0_172_30;
  assign _zz__zz_dataState_0_172_31 = {_zz__zz_dataState_0_172_32,_zz__zz_dataState_0_172_33};
  assign _zz__zz_dataState_0_172_41 = (_zz_dataState_0_156 ^ _zz_dataState_0_160);
  assign _zz__zz_dataState_0_172_43 = (_zz__zz_dataState_0_172_44 ^ _zz_dataState_0_161);
  assign _zz__zz_dataState_0_172_46 = (_zz__zz_dataState_0_172_47 ^ _zz_dataState_0_156);
  assign _zz__zz_dataState_0_172_48 = _zz__zz_dataState_0_172_49;
  assign _zz__zz_dataState_0_172_50 = _zz__zz_dataState_0_172_51;
  assign _zz__zz_dataState_0_172_57 = (_zz__zz_dataState_0_172_58 ^ _zz_dataState_0_169);
  assign _zz__zz_dataState_0_172_61 = (_zz_dataState_0_164 ^ _zz_dataState_0_169);
  assign _zz__zz_dataState_0_172_63 = (_zz__zz_dataState_0_172_64 ^ _zz_dataState_0_165);
  assign _zz__zz_dataState_0_172_66 = (_zz__zz_dataState_0_172_67 ^ _zz_dataState_0_165);
  assign _zz__zz_dataState_0_172_68 = (_zz__zz_dataState_0_172_69 ^ _zz_dataState_0_164);
  assign _zz__zz_dataState_0_172_8 = ((_zz_dataState_0_138 ^ _zz_dataState_0_142) ^ _zz_dataState_0_139);
  assign _zz__zz_dataState_0_172_11 = ((((_zz_dataState_0_137 ^ _zz_dataState_0_144) ^ _zz_dataState_0_142) ^ _zz_dataState_0_138) ^ _zz_dataState_0_143);
  assign _zz__zz_dataState_0_172_13 = ((_zz_dataState_0_143 ^ _zz_dataState_0_137) ^ _zz_dataState_0_139);
  assign _zz__zz_dataState_0_172_15 = ((_zz_dataState_0_142 ^ _zz_dataState_0_144) ^ _zz_dataState_0_138);
  assign _zz__zz_dataState_0_172_16 = ((_zz_dataState_0_142 ^ _zz_dataState_0_143) ^ _zz_dataState_0_137);
  assign _zz__zz_dataState_0_172_25 = (_zz_dataState_0_147 ^ _zz_dataState_0_152);
  assign _zz__zz_dataState_0_172_28 = ((_zz_dataState_0_146 ^ _zz_dataState_0_153) ^ _zz_dataState_0_151);
  assign _zz__zz_dataState_0_172_30 = ((_zz_dataState_0_153 ^ _zz_dataState_0_152) ^ _zz_dataState_0_148);
  assign _zz__zz_dataState_0_172_32 = ((_zz_dataState_0_152 ^ _zz_dataState_0_151) ^ _zz_dataState_0_147);
  assign _zz__zz_dataState_0_172_33 = (_zz_dataState_0_151 ^ _zz_dataState_0_146);
  assign _zz__zz_dataState_0_172_44 = ((_zz_dataState_0_155 ^ _zz_dataState_0_160) ^ _zz_dataState_0_156);
  assign _zz__zz_dataState_0_172_47 = (_zz_dataState_0_161 ^ _zz_dataState_0_155);
  assign _zz__zz_dataState_0_172_49 = (_zz_dataState_0_160 ^ _zz_dataState_0_155);
  assign _zz__zz_dataState_0_172_51 = ((_zz_dataState_0_160 ^ _zz_dataState_0_161) ^ _zz_dataState_0_162);
  assign _zz__zz_dataState_0_172_58 = (_zz_dataState_0_165 ^ _zz_dataState_0_170);
  assign _zz__zz_dataState_0_172_64 = (_zz_dataState_0_171 ^ _zz_dataState_0_170);
  assign _zz__zz_dataState_0_172_67 = (((_zz_dataState_0_170 ^ _zz_dataState_0_169) ^ _zz_dataState_0_164) ^ _zz_dataState_0_171);
  assign _zz__zz_dataState_0_172_69 = (_zz_dataState_0_169 ^ _zz_dataState_0_171);
  assign _zz__zz_dataState_0_209 = ((_zz_dataState_0_178 ^ _zz_dataState_0_180) ^ _zz_dataState_0_181);
  assign _zz__zz_dataState_0_209_1 = (_zz__zz_dataState_0_209_2 ^ _zz_dataState_0_180);
  assign _zz__zz_dataState_0_209_3 = {_zz__zz_dataState_0_209_4,{_zz__zz_dataState_0_209_6,_zz__zz_dataState_0_209_9}};
  assign _zz__zz_dataState_0_209_17 = ((_zz_dataState_0_187 ^ _zz_dataState_0_188) ^ _zz_dataState_0_190);
  assign _zz__zz_dataState_0_209_18 = (_zz__zz_dataState_0_209_19 ^ _zz_dataState_0_189);
  assign _zz__zz_dataState_0_209_20 = {_zz__zz_dataState_0_209_21,{_zz__zz_dataState_0_209_23,_zz__zz_dataState_0_209_26}};
  assign _zz__zz_dataState_0_209_34 = ((_zz_dataState_0_195 ^ _zz_dataState_0_199) ^ _zz_dataState_0_198);
  assign _zz__zz_dataState_0_209_35 = (_zz__zz_dataState_0_209_36 ^ _zz_dataState_0_197);
  assign _zz__zz_dataState_0_209_37 = {_zz__zz_dataState_0_209_38,{_zz__zz_dataState_0_209_40,_zz__zz_dataState_0_209_42}};
  assign _zz__zz_dataState_0_209_47 = ((_zz_dataState_0_204 ^ _zz_dataState_0_208) ^ _zz_dataState_0_205);
  assign _zz__zz_dataState_0_209_48 = ((_zz__zz_dataState_0_209_49 ^ _zz_dataState_0_204) ^ _zz_dataState_0_205);
  assign _zz__zz_dataState_0_209_50 = (_zz__zz_dataState_0_209_51 ^ _zz_dataState_0_204);
  assign _zz__zz_dataState_0_209_52 = {_zz__zz_dataState_0_209_53,{_zz__zz_dataState_0_209_55,_zz__zz_dataState_0_209_57}};
  assign _zz__zz_dataState_0_209_2 = ((_zz_dataState_0_177 ^ _zz_dataState_0_181) ^ _zz_dataState_0_179);
  assign _zz__zz_dataState_0_209_4 = ((_zz__zz_dataState_0_209_5 ^ _zz_dataState_0_178) ^ _zz_dataState_0_179);
  assign _zz__zz_dataState_0_209_6 = (_zz__zz_dataState_0_209_7 ^ _zz_dataState_0_178);
  assign _zz__zz_dataState_0_209_9 = {_zz__zz_dataState_0_209_10,{_zz__zz_dataState_0_209_12,_zz__zz_dataState_0_209_14}};
  assign _zz__zz_dataState_0_209_19 = ((_zz_dataState_0_186 ^ _zz_dataState_0_190) ^ _zz_dataState_0_187);
  assign _zz__zz_dataState_0_209_21 = ((_zz__zz_dataState_0_209_22 ^ _zz_dataState_0_186) ^ _zz_dataState_0_188);
  assign _zz__zz_dataState_0_209_23 = (_zz__zz_dataState_0_209_24 ^ _zz_dataState_0_187);
  assign _zz__zz_dataState_0_209_26 = {_zz__zz_dataState_0_209_27,{_zz__zz_dataState_0_209_29,_zz__zz_dataState_0_209_31}};
  assign _zz__zz_dataState_0_209_36 = ((_zz_dataState_0_194 ^ _zz_dataState_0_199) ^ _zz_dataState_0_198);
  assign _zz__zz_dataState_0_209_38 = ((_zz__zz_dataState_0_209_39 ^ _zz_dataState_0_197) ^ _zz_dataState_0_196);
  assign _zz__zz_dataState_0_209_40 = (_zz__zz_dataState_0_209_41 ^ _zz_dataState_0_195);
  assign _zz__zz_dataState_0_209_42 = {_zz__zz_dataState_0_209_43,{_zz__zz_dataState_0_209_44,_zz__zz_dataState_0_209_46}};
  assign _zz__zz_dataState_0_209_49 = (_zz_dataState_0_203 ^ _zz_dataState_0_207);
  assign _zz__zz_dataState_0_209_51 = ((_zz_dataState_0_202 ^ _zz_dataState_0_206) ^ _zz_dataState_0_203);
  assign _zz__zz_dataState_0_209_53 = ((_zz__zz_dataState_0_209_54 ^ _zz_dataState_0_207) ^ _zz_dataState_0_203);
  assign _zz__zz_dataState_0_209_55 = (_zz__zz_dataState_0_209_56 ^ _zz_dataState_0_202);
  assign _zz__zz_dataState_0_209_57 = {_zz__zz_dataState_0_209_58,_zz__zz_dataState_0_209_59};
  assign _zz__zz_dataState_0_209_5 = ((_zz_dataState_0_176 ^ _zz_dataState_0_181) ^ _zz_dataState_0_180);
  assign _zz__zz_dataState_0_209_7 = ((_zz__zz_dataState_0_209_8 ^ _zz_dataState_0_177) ^ _zz_dataState_0_181);
  assign _zz__zz_dataState_0_209_10 = ((_zz__zz_dataState_0_209_11 ^ _zz_dataState_0_176) ^ _zz_dataState_0_177);
  assign _zz__zz_dataState_0_209_12 = (_zz__zz_dataState_0_209_13 ^ _zz_dataState_0_176);
  assign _zz__zz_dataState_0_209_14 = {_zz__zz_dataState_0_209_15,_zz__zz_dataState_0_209_16};
  assign _zz__zz_dataState_0_209_22 = (_zz_dataState_0_185 ^ _zz_dataState_0_189);
  assign _zz__zz_dataState_0_209_24 = ((_zz__zz_dataState_0_209_25 ^ _zz_dataState_0_185) ^ _zz_dataState_0_190);
  assign _zz__zz_dataState_0_209_27 = ((_zz__zz_dataState_0_209_28 ^ _zz_dataState_0_189) ^ _zz_dataState_0_186);
  assign _zz__zz_dataState_0_209_29 = (_zz__zz_dataState_0_209_30 ^ _zz_dataState_0_185);
  assign _zz__zz_dataState_0_209_31 = {_zz__zz_dataState_0_209_32,_zz__zz_dataState_0_209_33};
  assign _zz__zz_dataState_0_209_39 = (_zz_dataState_0_193 ^ _zz_dataState_0_198);
  assign _zz__zz_dataState_0_209_41 = ((_zz_dataState_0_192 ^ _zz_dataState_0_199) ^ _zz_dataState_0_197);
  assign _zz__zz_dataState_0_209_43 = ((_zz_dataState_0_199 ^ _zz_dataState_0_198) ^ _zz_dataState_0_194);
  assign _zz__zz_dataState_0_209_44 = (_zz__zz_dataState_0_209_45 ^ _zz_dataState_0_193);
  assign _zz__zz_dataState_0_209_46 = (_zz_dataState_0_197 ^ _zz_dataState_0_192);
  assign _zz__zz_dataState_0_209_54 = ((_zz_dataState_0_201 ^ _zz_dataState_0_206) ^ _zz_dataState_0_202);
  assign _zz__zz_dataState_0_209_56 = (_zz_dataState_0_207 ^ _zz_dataState_0_201);
  assign _zz__zz_dataState_0_209_58 = (_zz_dataState_0_206 ^ _zz_dataState_0_201);
  assign _zz__zz_dataState_0_209_59 = ((_zz_dataState_0_206 ^ _zz_dataState_0_207) ^ _zz_dataState_0_208);
  assign _zz__zz_dataState_0_209_8 = ((_zz_dataState_0_175 ^ _zz_dataState_0_180) ^ _zz_dataState_0_179);
  assign _zz__zz_dataState_0_209_11 = (_zz_dataState_0_174 ^ _zz_dataState_0_179);
  assign _zz__zz_dataState_0_209_13 = ((_zz_dataState_0_181 ^ _zz_dataState_0_180) ^ _zz_dataState_0_175);
  assign _zz__zz_dataState_0_209_15 = ((((_zz_dataState_0_180 ^ _zz_dataState_0_179) ^ _zz_dataState_0_174) ^ _zz_dataState_0_181) ^ _zz_dataState_0_175);
  assign _zz__zz_dataState_0_209_16 = ((_zz_dataState_0_179 ^ _zz_dataState_0_181) ^ _zz_dataState_0_174);
  assign _zz__zz_dataState_0_209_25 = (_zz_dataState_0_184 ^ _zz_dataState_0_188);
  assign _zz__zz_dataState_0_209_28 = (((_zz_dataState_0_183 ^ _zz_dataState_0_190) ^ _zz_dataState_0_188) ^ _zz_dataState_0_184);
  assign _zz__zz_dataState_0_209_30 = (_zz_dataState_0_189 ^ _zz_dataState_0_183);
  assign _zz__zz_dataState_0_209_32 = ((_zz_dataState_0_188 ^ _zz_dataState_0_190) ^ _zz_dataState_0_184);
  assign _zz__zz_dataState_0_209_33 = ((_zz_dataState_0_188 ^ _zz_dataState_0_189) ^ _zz_dataState_0_183);
  assign _zz__zz_dataState_0_209_45 = (_zz_dataState_0_198 ^ _zz_dataState_0_197);
  initial begin
    sBoxMem[0] = 8'b01100011;
    sBoxMem[1] = 8'b01111100;
    sBoxMem[2] = 8'b01110111;
    sBoxMem[3] = 8'b01111011;
    sBoxMem[4] = 8'b11110010;
    sBoxMem[5] = 8'b01101011;
    sBoxMem[6] = 8'b01101111;
    sBoxMem[7] = 8'b11000101;
    sBoxMem[8] = 8'b00110000;
    sBoxMem[9] = 8'b00000001;
    sBoxMem[10] = 8'b01100111;
    sBoxMem[11] = 8'b00101011;
    sBoxMem[12] = 8'b11111110;
    sBoxMem[13] = 8'b11010111;
    sBoxMem[14] = 8'b10101011;
    sBoxMem[15] = 8'b01110110;
    sBoxMem[16] = 8'b11001010;
    sBoxMem[17] = 8'b10000010;
    sBoxMem[18] = 8'b11001001;
    sBoxMem[19] = 8'b01111101;
    sBoxMem[20] = 8'b11111010;
    sBoxMem[21] = 8'b01011001;
    sBoxMem[22] = 8'b01000111;
    sBoxMem[23] = 8'b11110000;
    sBoxMem[24] = 8'b10101101;
    sBoxMem[25] = 8'b11010100;
    sBoxMem[26] = 8'b10100010;
    sBoxMem[27] = 8'b10101111;
    sBoxMem[28] = 8'b10011100;
    sBoxMem[29] = 8'b10100100;
    sBoxMem[30] = 8'b01110010;
    sBoxMem[31] = 8'b11000000;
    sBoxMem[32] = 8'b10110111;
    sBoxMem[33] = 8'b11111101;
    sBoxMem[34] = 8'b10010011;
    sBoxMem[35] = 8'b00100110;
    sBoxMem[36] = 8'b00110110;
    sBoxMem[37] = 8'b00111111;
    sBoxMem[38] = 8'b11110111;
    sBoxMem[39] = 8'b11001100;
    sBoxMem[40] = 8'b00110100;
    sBoxMem[41] = 8'b10100101;
    sBoxMem[42] = 8'b11100101;
    sBoxMem[43] = 8'b11110001;
    sBoxMem[44] = 8'b01110001;
    sBoxMem[45] = 8'b11011000;
    sBoxMem[46] = 8'b00110001;
    sBoxMem[47] = 8'b00010101;
    sBoxMem[48] = 8'b00000100;
    sBoxMem[49] = 8'b11000111;
    sBoxMem[50] = 8'b00100011;
    sBoxMem[51] = 8'b11000011;
    sBoxMem[52] = 8'b00011000;
    sBoxMem[53] = 8'b10010110;
    sBoxMem[54] = 8'b00000101;
    sBoxMem[55] = 8'b10011010;
    sBoxMem[56] = 8'b00000111;
    sBoxMem[57] = 8'b00010010;
    sBoxMem[58] = 8'b10000000;
    sBoxMem[59] = 8'b11100010;
    sBoxMem[60] = 8'b11101011;
    sBoxMem[61] = 8'b00100111;
    sBoxMem[62] = 8'b10110010;
    sBoxMem[63] = 8'b01110101;
    sBoxMem[64] = 8'b00001001;
    sBoxMem[65] = 8'b10000011;
    sBoxMem[66] = 8'b00101100;
    sBoxMem[67] = 8'b00011010;
    sBoxMem[68] = 8'b00011011;
    sBoxMem[69] = 8'b01101110;
    sBoxMem[70] = 8'b01011010;
    sBoxMem[71] = 8'b10100000;
    sBoxMem[72] = 8'b01010010;
    sBoxMem[73] = 8'b00111011;
    sBoxMem[74] = 8'b11010110;
    sBoxMem[75] = 8'b10110011;
    sBoxMem[76] = 8'b00101001;
    sBoxMem[77] = 8'b11100011;
    sBoxMem[78] = 8'b00101111;
    sBoxMem[79] = 8'b10000100;
    sBoxMem[80] = 8'b01010011;
    sBoxMem[81] = 8'b11010001;
    sBoxMem[82] = 8'b00000000;
    sBoxMem[83] = 8'b11101101;
    sBoxMem[84] = 8'b00100000;
    sBoxMem[85] = 8'b11111100;
    sBoxMem[86] = 8'b10110001;
    sBoxMem[87] = 8'b01011011;
    sBoxMem[88] = 8'b01101010;
    sBoxMem[89] = 8'b11001011;
    sBoxMem[90] = 8'b10111110;
    sBoxMem[91] = 8'b00111001;
    sBoxMem[92] = 8'b01001010;
    sBoxMem[93] = 8'b01001100;
    sBoxMem[94] = 8'b01011000;
    sBoxMem[95] = 8'b11001111;
    sBoxMem[96] = 8'b11010000;
    sBoxMem[97] = 8'b11101111;
    sBoxMem[98] = 8'b10101010;
    sBoxMem[99] = 8'b11111011;
    sBoxMem[100] = 8'b01000011;
    sBoxMem[101] = 8'b01001101;
    sBoxMem[102] = 8'b00110011;
    sBoxMem[103] = 8'b10000101;
    sBoxMem[104] = 8'b01000101;
    sBoxMem[105] = 8'b11111001;
    sBoxMem[106] = 8'b00000010;
    sBoxMem[107] = 8'b01111111;
    sBoxMem[108] = 8'b01010000;
    sBoxMem[109] = 8'b00111100;
    sBoxMem[110] = 8'b10011111;
    sBoxMem[111] = 8'b10101000;
    sBoxMem[112] = 8'b01010001;
    sBoxMem[113] = 8'b10100011;
    sBoxMem[114] = 8'b01000000;
    sBoxMem[115] = 8'b10001111;
    sBoxMem[116] = 8'b10010010;
    sBoxMem[117] = 8'b10011101;
    sBoxMem[118] = 8'b00111000;
    sBoxMem[119] = 8'b11110101;
    sBoxMem[120] = 8'b10111100;
    sBoxMem[121] = 8'b10110110;
    sBoxMem[122] = 8'b11011010;
    sBoxMem[123] = 8'b00100001;
    sBoxMem[124] = 8'b00010000;
    sBoxMem[125] = 8'b11111111;
    sBoxMem[126] = 8'b11110011;
    sBoxMem[127] = 8'b11010010;
    sBoxMem[128] = 8'b11001101;
    sBoxMem[129] = 8'b00001100;
    sBoxMem[130] = 8'b00010011;
    sBoxMem[131] = 8'b11101100;
    sBoxMem[132] = 8'b01011111;
    sBoxMem[133] = 8'b10010111;
    sBoxMem[134] = 8'b01000100;
    sBoxMem[135] = 8'b00010111;
    sBoxMem[136] = 8'b11000100;
    sBoxMem[137] = 8'b10100111;
    sBoxMem[138] = 8'b01111110;
    sBoxMem[139] = 8'b00111101;
    sBoxMem[140] = 8'b01100100;
    sBoxMem[141] = 8'b01011101;
    sBoxMem[142] = 8'b00011001;
    sBoxMem[143] = 8'b01110011;
    sBoxMem[144] = 8'b01100000;
    sBoxMem[145] = 8'b10000001;
    sBoxMem[146] = 8'b01001111;
    sBoxMem[147] = 8'b11011100;
    sBoxMem[148] = 8'b00100010;
    sBoxMem[149] = 8'b00101010;
    sBoxMem[150] = 8'b10010000;
    sBoxMem[151] = 8'b10001000;
    sBoxMem[152] = 8'b01000110;
    sBoxMem[153] = 8'b11101110;
    sBoxMem[154] = 8'b10111000;
    sBoxMem[155] = 8'b00010100;
    sBoxMem[156] = 8'b11011110;
    sBoxMem[157] = 8'b01011110;
    sBoxMem[158] = 8'b00001011;
    sBoxMem[159] = 8'b11011011;
    sBoxMem[160] = 8'b11100000;
    sBoxMem[161] = 8'b00110010;
    sBoxMem[162] = 8'b00111010;
    sBoxMem[163] = 8'b00001010;
    sBoxMem[164] = 8'b01001001;
    sBoxMem[165] = 8'b00000110;
    sBoxMem[166] = 8'b00100100;
    sBoxMem[167] = 8'b01011100;
    sBoxMem[168] = 8'b11000010;
    sBoxMem[169] = 8'b11010011;
    sBoxMem[170] = 8'b10101100;
    sBoxMem[171] = 8'b01100010;
    sBoxMem[172] = 8'b10010001;
    sBoxMem[173] = 8'b10010101;
    sBoxMem[174] = 8'b11100100;
    sBoxMem[175] = 8'b01111001;
    sBoxMem[176] = 8'b11100111;
    sBoxMem[177] = 8'b11001000;
    sBoxMem[178] = 8'b00110111;
    sBoxMem[179] = 8'b01101101;
    sBoxMem[180] = 8'b10001101;
    sBoxMem[181] = 8'b11010101;
    sBoxMem[182] = 8'b01001110;
    sBoxMem[183] = 8'b10101001;
    sBoxMem[184] = 8'b01101100;
    sBoxMem[185] = 8'b01010110;
    sBoxMem[186] = 8'b11110100;
    sBoxMem[187] = 8'b11101010;
    sBoxMem[188] = 8'b01100101;
    sBoxMem[189] = 8'b01111010;
    sBoxMem[190] = 8'b10101110;
    sBoxMem[191] = 8'b00001000;
    sBoxMem[192] = 8'b10111010;
    sBoxMem[193] = 8'b01111000;
    sBoxMem[194] = 8'b00100101;
    sBoxMem[195] = 8'b00101110;
    sBoxMem[196] = 8'b00011100;
    sBoxMem[197] = 8'b10100110;
    sBoxMem[198] = 8'b10110100;
    sBoxMem[199] = 8'b11000110;
    sBoxMem[200] = 8'b11101000;
    sBoxMem[201] = 8'b11011101;
    sBoxMem[202] = 8'b01110100;
    sBoxMem[203] = 8'b00011111;
    sBoxMem[204] = 8'b01001011;
    sBoxMem[205] = 8'b10111101;
    sBoxMem[206] = 8'b10001011;
    sBoxMem[207] = 8'b10001010;
    sBoxMem[208] = 8'b01110000;
    sBoxMem[209] = 8'b00111110;
    sBoxMem[210] = 8'b10110101;
    sBoxMem[211] = 8'b01100110;
    sBoxMem[212] = 8'b01001000;
    sBoxMem[213] = 8'b00000011;
    sBoxMem[214] = 8'b11110110;
    sBoxMem[215] = 8'b00001110;
    sBoxMem[216] = 8'b01100001;
    sBoxMem[217] = 8'b00110101;
    sBoxMem[218] = 8'b01010111;
    sBoxMem[219] = 8'b10111001;
    sBoxMem[220] = 8'b10000110;
    sBoxMem[221] = 8'b11000001;
    sBoxMem[222] = 8'b00011101;
    sBoxMem[223] = 8'b10011110;
    sBoxMem[224] = 8'b11100001;
    sBoxMem[225] = 8'b11111000;
    sBoxMem[226] = 8'b10011000;
    sBoxMem[227] = 8'b00010001;
    sBoxMem[228] = 8'b01101001;
    sBoxMem[229] = 8'b11011001;
    sBoxMem[230] = 8'b10001110;
    sBoxMem[231] = 8'b10010100;
    sBoxMem[232] = 8'b10011011;
    sBoxMem[233] = 8'b00011110;
    sBoxMem[234] = 8'b10000111;
    sBoxMem[235] = 8'b11101001;
    sBoxMem[236] = 8'b11001110;
    sBoxMem[237] = 8'b01010101;
    sBoxMem[238] = 8'b00101000;
    sBoxMem[239] = 8'b11011111;
    sBoxMem[240] = 8'b10001100;
    sBoxMem[241] = 8'b10100001;
    sBoxMem[242] = 8'b10001001;
    sBoxMem[243] = 8'b00001101;
    sBoxMem[244] = 8'b10111111;
    sBoxMem[245] = 8'b11100110;
    sBoxMem[246] = 8'b01000010;
    sBoxMem[247] = 8'b01101000;
    sBoxMem[248] = 8'b01000001;
    sBoxMem[249] = 8'b10011001;
    sBoxMem[250] = 8'b00101101;
    sBoxMem[251] = 8'b00001111;
    sBoxMem[252] = 8'b10110000;
    sBoxMem[253] = 8'b01010100;
    sBoxMem[254] = 8'b10111011;
    sBoxMem[255] = 8'b00010110;
  end
  assign sBoxMem_spinal_port0 = sBoxMem[_zz_dataState_0_2];
  initial begin
    sBoxMemInv[0] = 8'b01010010;
    sBoxMemInv[1] = 8'b00001001;
    sBoxMemInv[2] = 8'b01101010;
    sBoxMemInv[3] = 8'b11010101;
    sBoxMemInv[4] = 8'b00110000;
    sBoxMemInv[5] = 8'b00110110;
    sBoxMemInv[6] = 8'b10100101;
    sBoxMemInv[7] = 8'b00111000;
    sBoxMemInv[8] = 8'b10111111;
    sBoxMemInv[9] = 8'b01000000;
    sBoxMemInv[10] = 8'b10100011;
    sBoxMemInv[11] = 8'b10011110;
    sBoxMemInv[12] = 8'b10000001;
    sBoxMemInv[13] = 8'b11110011;
    sBoxMemInv[14] = 8'b11010111;
    sBoxMemInv[15] = 8'b11111011;
    sBoxMemInv[16] = 8'b01111100;
    sBoxMemInv[17] = 8'b11100011;
    sBoxMemInv[18] = 8'b00111001;
    sBoxMemInv[19] = 8'b10000010;
    sBoxMemInv[20] = 8'b10011011;
    sBoxMemInv[21] = 8'b00101111;
    sBoxMemInv[22] = 8'b11111111;
    sBoxMemInv[23] = 8'b10000111;
    sBoxMemInv[24] = 8'b00110100;
    sBoxMemInv[25] = 8'b10001110;
    sBoxMemInv[26] = 8'b01000011;
    sBoxMemInv[27] = 8'b01000100;
    sBoxMemInv[28] = 8'b11000100;
    sBoxMemInv[29] = 8'b11011110;
    sBoxMemInv[30] = 8'b11101001;
    sBoxMemInv[31] = 8'b11001011;
    sBoxMemInv[32] = 8'b01010100;
    sBoxMemInv[33] = 8'b01111011;
    sBoxMemInv[34] = 8'b10010100;
    sBoxMemInv[35] = 8'b00110010;
    sBoxMemInv[36] = 8'b10100110;
    sBoxMemInv[37] = 8'b11000010;
    sBoxMemInv[38] = 8'b00100011;
    sBoxMemInv[39] = 8'b00111101;
    sBoxMemInv[40] = 8'b11101110;
    sBoxMemInv[41] = 8'b01001100;
    sBoxMemInv[42] = 8'b10010101;
    sBoxMemInv[43] = 8'b00001011;
    sBoxMemInv[44] = 8'b01000010;
    sBoxMemInv[45] = 8'b11111010;
    sBoxMemInv[46] = 8'b11000011;
    sBoxMemInv[47] = 8'b01001110;
    sBoxMemInv[48] = 8'b00001000;
    sBoxMemInv[49] = 8'b00101110;
    sBoxMemInv[50] = 8'b10100001;
    sBoxMemInv[51] = 8'b01100110;
    sBoxMemInv[52] = 8'b00101000;
    sBoxMemInv[53] = 8'b11011001;
    sBoxMemInv[54] = 8'b00100100;
    sBoxMemInv[55] = 8'b10110010;
    sBoxMemInv[56] = 8'b01110110;
    sBoxMemInv[57] = 8'b01011011;
    sBoxMemInv[58] = 8'b10100010;
    sBoxMemInv[59] = 8'b01001001;
    sBoxMemInv[60] = 8'b01101101;
    sBoxMemInv[61] = 8'b10001011;
    sBoxMemInv[62] = 8'b11010001;
    sBoxMemInv[63] = 8'b00100101;
    sBoxMemInv[64] = 8'b01110010;
    sBoxMemInv[65] = 8'b11111000;
    sBoxMemInv[66] = 8'b11110110;
    sBoxMemInv[67] = 8'b01100100;
    sBoxMemInv[68] = 8'b10000110;
    sBoxMemInv[69] = 8'b01101000;
    sBoxMemInv[70] = 8'b10011000;
    sBoxMemInv[71] = 8'b00010110;
    sBoxMemInv[72] = 8'b11010100;
    sBoxMemInv[73] = 8'b10100100;
    sBoxMemInv[74] = 8'b01011100;
    sBoxMemInv[75] = 8'b11001100;
    sBoxMemInv[76] = 8'b01011101;
    sBoxMemInv[77] = 8'b01100101;
    sBoxMemInv[78] = 8'b10110110;
    sBoxMemInv[79] = 8'b10010010;
    sBoxMemInv[80] = 8'b01101100;
    sBoxMemInv[81] = 8'b01110000;
    sBoxMemInv[82] = 8'b01001000;
    sBoxMemInv[83] = 8'b01010000;
    sBoxMemInv[84] = 8'b11111101;
    sBoxMemInv[85] = 8'b11101101;
    sBoxMemInv[86] = 8'b10111001;
    sBoxMemInv[87] = 8'b11011010;
    sBoxMemInv[88] = 8'b01011110;
    sBoxMemInv[89] = 8'b00010101;
    sBoxMemInv[90] = 8'b01000110;
    sBoxMemInv[91] = 8'b01010111;
    sBoxMemInv[92] = 8'b10100111;
    sBoxMemInv[93] = 8'b10001101;
    sBoxMemInv[94] = 8'b10011101;
    sBoxMemInv[95] = 8'b10000100;
    sBoxMemInv[96] = 8'b10010000;
    sBoxMemInv[97] = 8'b11011000;
    sBoxMemInv[98] = 8'b10101011;
    sBoxMemInv[99] = 8'b00000000;
    sBoxMemInv[100] = 8'b10001100;
    sBoxMemInv[101] = 8'b10111100;
    sBoxMemInv[102] = 8'b11010011;
    sBoxMemInv[103] = 8'b00001010;
    sBoxMemInv[104] = 8'b11110111;
    sBoxMemInv[105] = 8'b11100100;
    sBoxMemInv[106] = 8'b01011000;
    sBoxMemInv[107] = 8'b00000101;
    sBoxMemInv[108] = 8'b10111000;
    sBoxMemInv[109] = 8'b10110011;
    sBoxMemInv[110] = 8'b01000101;
    sBoxMemInv[111] = 8'b00000110;
    sBoxMemInv[112] = 8'b11010000;
    sBoxMemInv[113] = 8'b00101100;
    sBoxMemInv[114] = 8'b00011110;
    sBoxMemInv[115] = 8'b10001111;
    sBoxMemInv[116] = 8'b11001010;
    sBoxMemInv[117] = 8'b00111111;
    sBoxMemInv[118] = 8'b00001111;
    sBoxMemInv[119] = 8'b00000010;
    sBoxMemInv[120] = 8'b11000001;
    sBoxMemInv[121] = 8'b10101111;
    sBoxMemInv[122] = 8'b10111101;
    sBoxMemInv[123] = 8'b00000011;
    sBoxMemInv[124] = 8'b00000001;
    sBoxMemInv[125] = 8'b00010011;
    sBoxMemInv[126] = 8'b10001010;
    sBoxMemInv[127] = 8'b01101011;
    sBoxMemInv[128] = 8'b00111010;
    sBoxMemInv[129] = 8'b10010001;
    sBoxMemInv[130] = 8'b00010001;
    sBoxMemInv[131] = 8'b01000001;
    sBoxMemInv[132] = 8'b01001111;
    sBoxMemInv[133] = 8'b01100111;
    sBoxMemInv[134] = 8'b11011100;
    sBoxMemInv[135] = 8'b11101010;
    sBoxMemInv[136] = 8'b10010111;
    sBoxMemInv[137] = 8'b11110010;
    sBoxMemInv[138] = 8'b11001111;
    sBoxMemInv[139] = 8'b11001110;
    sBoxMemInv[140] = 8'b11110000;
    sBoxMemInv[141] = 8'b10110100;
    sBoxMemInv[142] = 8'b11100110;
    sBoxMemInv[143] = 8'b01110011;
    sBoxMemInv[144] = 8'b10010110;
    sBoxMemInv[145] = 8'b10101100;
    sBoxMemInv[146] = 8'b01110100;
    sBoxMemInv[147] = 8'b00100010;
    sBoxMemInv[148] = 8'b11100111;
    sBoxMemInv[149] = 8'b10101101;
    sBoxMemInv[150] = 8'b00110101;
    sBoxMemInv[151] = 8'b10000101;
    sBoxMemInv[152] = 8'b11100010;
    sBoxMemInv[153] = 8'b11111001;
    sBoxMemInv[154] = 8'b00110111;
    sBoxMemInv[155] = 8'b11101000;
    sBoxMemInv[156] = 8'b00011100;
    sBoxMemInv[157] = 8'b01110101;
    sBoxMemInv[158] = 8'b11011111;
    sBoxMemInv[159] = 8'b01101110;
    sBoxMemInv[160] = 8'b01000111;
    sBoxMemInv[161] = 8'b11110001;
    sBoxMemInv[162] = 8'b00011010;
    sBoxMemInv[163] = 8'b01110001;
    sBoxMemInv[164] = 8'b00011101;
    sBoxMemInv[165] = 8'b00101001;
    sBoxMemInv[166] = 8'b11000101;
    sBoxMemInv[167] = 8'b10001001;
    sBoxMemInv[168] = 8'b01101111;
    sBoxMemInv[169] = 8'b10110111;
    sBoxMemInv[170] = 8'b01100010;
    sBoxMemInv[171] = 8'b00001110;
    sBoxMemInv[172] = 8'b10101010;
    sBoxMemInv[173] = 8'b00011000;
    sBoxMemInv[174] = 8'b10111110;
    sBoxMemInv[175] = 8'b00011011;
    sBoxMemInv[176] = 8'b11111100;
    sBoxMemInv[177] = 8'b01010110;
    sBoxMemInv[178] = 8'b00111110;
    sBoxMemInv[179] = 8'b01001011;
    sBoxMemInv[180] = 8'b11000110;
    sBoxMemInv[181] = 8'b11010010;
    sBoxMemInv[182] = 8'b01111001;
    sBoxMemInv[183] = 8'b00100000;
    sBoxMemInv[184] = 8'b10011010;
    sBoxMemInv[185] = 8'b11011011;
    sBoxMemInv[186] = 8'b11000000;
    sBoxMemInv[187] = 8'b11111110;
    sBoxMemInv[188] = 8'b01111000;
    sBoxMemInv[189] = 8'b11001101;
    sBoxMemInv[190] = 8'b01011010;
    sBoxMemInv[191] = 8'b11110100;
    sBoxMemInv[192] = 8'b00011111;
    sBoxMemInv[193] = 8'b11011101;
    sBoxMemInv[194] = 8'b10101000;
    sBoxMemInv[195] = 8'b00110011;
    sBoxMemInv[196] = 8'b10001000;
    sBoxMemInv[197] = 8'b00000111;
    sBoxMemInv[198] = 8'b11000111;
    sBoxMemInv[199] = 8'b00110001;
    sBoxMemInv[200] = 8'b10110001;
    sBoxMemInv[201] = 8'b00010010;
    sBoxMemInv[202] = 8'b00010000;
    sBoxMemInv[203] = 8'b01011001;
    sBoxMemInv[204] = 8'b00100111;
    sBoxMemInv[205] = 8'b10000000;
    sBoxMemInv[206] = 8'b11101100;
    sBoxMemInv[207] = 8'b01011111;
    sBoxMemInv[208] = 8'b01100000;
    sBoxMemInv[209] = 8'b01010001;
    sBoxMemInv[210] = 8'b01111111;
    sBoxMemInv[211] = 8'b10101001;
    sBoxMemInv[212] = 8'b00011001;
    sBoxMemInv[213] = 8'b10110101;
    sBoxMemInv[214] = 8'b01001010;
    sBoxMemInv[215] = 8'b00001101;
    sBoxMemInv[216] = 8'b00101101;
    sBoxMemInv[217] = 8'b11100101;
    sBoxMemInv[218] = 8'b01111010;
    sBoxMemInv[219] = 8'b10011111;
    sBoxMemInv[220] = 8'b10010011;
    sBoxMemInv[221] = 8'b11001001;
    sBoxMemInv[222] = 8'b10011100;
    sBoxMemInv[223] = 8'b11101111;
    sBoxMemInv[224] = 8'b10100000;
    sBoxMemInv[225] = 8'b11100000;
    sBoxMemInv[226] = 8'b00111011;
    sBoxMemInv[227] = 8'b01001101;
    sBoxMemInv[228] = 8'b10101110;
    sBoxMemInv[229] = 8'b00101010;
    sBoxMemInv[230] = 8'b11110101;
    sBoxMemInv[231] = 8'b10110000;
    sBoxMemInv[232] = 8'b11001000;
    sBoxMemInv[233] = 8'b11101011;
    sBoxMemInv[234] = 8'b10111011;
    sBoxMemInv[235] = 8'b00111100;
    sBoxMemInv[236] = 8'b10000011;
    sBoxMemInv[237] = 8'b01010011;
    sBoxMemInv[238] = 8'b10011001;
    sBoxMemInv[239] = 8'b01100001;
    sBoxMemInv[240] = 8'b00010111;
    sBoxMemInv[241] = 8'b00101011;
    sBoxMemInv[242] = 8'b00000100;
    sBoxMemInv[243] = 8'b01111110;
    sBoxMemInv[244] = 8'b10111010;
    sBoxMemInv[245] = 8'b01110111;
    sBoxMemInv[246] = 8'b11010110;
    sBoxMemInv[247] = 8'b00100110;
    sBoxMemInv[248] = 8'b11100001;
    sBoxMemInv[249] = 8'b01101001;
    sBoxMemInv[250] = 8'b00010100;
    sBoxMemInv[251] = 8'b01100011;
    sBoxMemInv[252] = 8'b01010101;
    sBoxMemInv[253] = 8'b00100001;
    sBoxMemInv[254] = 8'b00001100;
    sBoxMemInv[255] = 8'b01111101;
  end
  assign sBoxMemInv_spinal_port0 = sBoxMemInv[_zz_dataState_0_4];
  always @(*) begin
    case(byteSubstitution_cntByte_value)
      4'b0000 : _zz__zz_dataState_0_1 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_1 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_1 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_1 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_1 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_1 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_1 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_1 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_1 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_1 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_1 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_1 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_1 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_1 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_1 = dataState_14;
      default : _zz__zz_dataState_0_1 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_6_1)
      4'b0000 : _zz__zz_dataState_0_6 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_6 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_6 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_6 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_6 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_6 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_6 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_6 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_6 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_6 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_6 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_6 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_6 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_6 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_6 = dataState_14;
      default : _zz__zz_dataState_0_6 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_8_1)
      4'b0000 : _zz__zz_dataState_0_8 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_8 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_8 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_8 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_8 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_8 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_8 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_8 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_8 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_8 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_8 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_8 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_8 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_8 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_8 = dataState_14;
      default : _zz__zz_dataState_0_8 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_17_1)
      4'b0000 : _zz__zz_dataState_0_17 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_17 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_17 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_17 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_17 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_17 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_17 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_17 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_17 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_17 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_17 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_17 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_17 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_17 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_17 = dataState_14;
      default : _zz__zz_dataState_0_17 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_18_1)
      4'b0000 : _zz__zz_dataState_0_18 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_18 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_18 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_18 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_18 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_18 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_18 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_18 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_18 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_18 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_18 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_18 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_18 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_18 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_18 = dataState_14;
      default : _zz__zz_dataState_0_18 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_20_1)
      4'b0000 : _zz__zz_dataState_0_20 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_20 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_20 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_20 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_20 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_20 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_20 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_20 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_20 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_20 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_20 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_20 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_20 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_20 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_20 = dataState_14;
      default : _zz__zz_dataState_0_20 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_21_1)
      4'b0000 : _zz__zz_dataState_0_21 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_21 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_21 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_21 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_21 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_21 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_21 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_21 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_21 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_21 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_21 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_21 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_21 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_21 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_21 = dataState_14;
      default : _zz__zz_dataState_0_21 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_23_1)
      4'b0000 : _zz__zz_dataState_0_23 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_23 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_23 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_23 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_23 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_23 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_23 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_23 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_23 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_23 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_23 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_23 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_23 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_23 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_23 = dataState_14;
      default : _zz__zz_dataState_0_23 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_32_1)
      4'b0000 : _zz__zz_dataState_0_32 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_32 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_32 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_32 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_32 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_32 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_32 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_32 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_32 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_32 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_32 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_32 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_32 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_32 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_32 = dataState_14;
      default : _zz__zz_dataState_0_32 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_34_1)
      4'b0000 : _zz__zz_dataState_0_34 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_34 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_34 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_34 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_34 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_34 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_34 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_34 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_34 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_34 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_34 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_34 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_34 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_34 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_34 = dataState_14;
      default : _zz__zz_dataState_0_34 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_35_1)
      4'b0000 : _zz__zz_dataState_0_35 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_35 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_35 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_35 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_35 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_35 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_35 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_35 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_35 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_35 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_35 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_35 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_35 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_35 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_35 = dataState_14;
      default : _zz__zz_dataState_0_35 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_36_1)
      4'b0000 : _zz__zz_dataState_0_36 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_36 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_36 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_36 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_36 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_36 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_36 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_36 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_36 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_36 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_36 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_36 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_36 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_36 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_36 = dataState_14;
      default : _zz__zz_dataState_0_36 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_38_1)
      4'b0000 : _zz__zz_dataState_0_38 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_38 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_38 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_38 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_38 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_38 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_38 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_38 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_38 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_38 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_38 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_38 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_38 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_38 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_38 = dataState_14;
      default : _zz__zz_dataState_0_38 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_48_1)
      4'b0000 : _zz__zz_dataState_0_48 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_48 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_48 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_48 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_48 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_48 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_48 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_48 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_48 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_48 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_48 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_48 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_48 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_48 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_48 = dataState_14;
      default : _zz__zz_dataState_0_48 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_57_1)
      4'b0000 : _zz__zz_dataState_0_57 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_57 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_57 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_57 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_57 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_57 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_57 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_57 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_57 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_57 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_57 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_57 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_57 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_57 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_57 = dataState_14;
      default : _zz__zz_dataState_0_57 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_58_1)
      4'b0000 : _zz__zz_dataState_0_58 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_58 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_58 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_58 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_58 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_58 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_58 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_58 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_58 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_58 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_58 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_58 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_58 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_58 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_58 = dataState_14;
      default : _zz__zz_dataState_0_58 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_59_1)
      4'b0000 : _zz__zz_dataState_0_59 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_59 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_59 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_59 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_59 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_59 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_59 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_59 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_59 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_59 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_59 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_59 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_59 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_59 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_59 = dataState_14;
      default : _zz__zz_dataState_0_59 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_62_1)
      4'b0000 : _zz__zz_dataState_0_62 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_62 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_62 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_62 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_62 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_62 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_62 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_62 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_62 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_62 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_62 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_62 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_62 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_62 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_62 = dataState_14;
      default : _zz__zz_dataState_0_62 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_71_1)
      4'b0000 : _zz__zz_dataState_0_71 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_71 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_71 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_71 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_71 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_71 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_71 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_71 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_71 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_71 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_71 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_71 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_71 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_71 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_71 = dataState_14;
      default : _zz__zz_dataState_0_71 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_80_1)
      4'b0000 : _zz__zz_dataState_0_80 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_80 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_80 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_80 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_80 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_80 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_80 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_80 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_80 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_80 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_80 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_80 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_80 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_80 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_80 = dataState_14;
      default : _zz__zz_dataState_0_80 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_89_1)
      4'b0000 : _zz__zz_dataState_0_89 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_89 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_89 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_89 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_89 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_89 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_89 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_89 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_89 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_89 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_89 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_89 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_89 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_89 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_89 = dataState_14;
      default : _zz__zz_dataState_0_89 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_99_1)
      4'b0000 : _zz__zz_dataState_0_99 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_99 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_99 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_99 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_99 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_99 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_99 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_99 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_99 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_99 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_99 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_99 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_99 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_99 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_99 = dataState_14;
      default : _zz__zz_dataState_0_99 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_108_1)
      4'b0000 : _zz__zz_dataState_0_108 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_108 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_108 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_108 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_108 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_108 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_108 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_108 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_108 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_108 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_108 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_108 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_108 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_108 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_108 = dataState_14;
      default : _zz__zz_dataState_0_108 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_117_1)
      4'b0000 : _zz__zz_dataState_0_117 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_117 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_117 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_117 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_117 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_117 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_117 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_117 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_117 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_117 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_117 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_117 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_117 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_117 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_117 = dataState_14;
      default : _zz__zz_dataState_0_117 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_126_1)
      4'b0000 : _zz__zz_dataState_0_126 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_126 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_126 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_126 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_126 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_126 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_126 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_126 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_126 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_126 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_126 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_126 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_126 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_126 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_126 = dataState_14;
      default : _zz__zz_dataState_0_126 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_136_1)
      4'b0000 : _zz__zz_dataState_0_136 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_136 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_136 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_136 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_136 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_136 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_136 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_136 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_136 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_136 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_136 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_136 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_136 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_136 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_136 = dataState_14;
      default : _zz__zz_dataState_0_136 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_145_1)
      4'b0000 : _zz__zz_dataState_0_145 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_145 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_145 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_145 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_145 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_145 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_145 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_145 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_145 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_145 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_145 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_145 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_145 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_145 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_145 = dataState_14;
      default : _zz__zz_dataState_0_145 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_154_1)
      4'b0000 : _zz__zz_dataState_0_154 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_154 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_154 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_154 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_154 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_154 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_154 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_154 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_154 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_154 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_154 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_154 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_154 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_154 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_154 = dataState_14;
      default : _zz__zz_dataState_0_154 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_163_1)
      4'b0000 : _zz__zz_dataState_0_163 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_163 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_163 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_163 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_163 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_163 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_163 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_163 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_163 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_163 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_163 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_163 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_163 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_163 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_163 = dataState_14;
      default : _zz__zz_dataState_0_163 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_173_1)
      4'b0000 : _zz__zz_dataState_0_173 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_173 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_173 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_173 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_173 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_173 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_173 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_173 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_173 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_173 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_173 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_173 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_173 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_173 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_173 = dataState_14;
      default : _zz__zz_dataState_0_173 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_182_1)
      4'b0000 : _zz__zz_dataState_0_182 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_182 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_182 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_182 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_182 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_182 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_182 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_182 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_182 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_182 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_182 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_182 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_182 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_182 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_182 = dataState_14;
      default : _zz__zz_dataState_0_182 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_191_1)
      4'b0000 : _zz__zz_dataState_0_191 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_191 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_191 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_191 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_191 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_191 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_191 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_191 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_191 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_191 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_191 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_191 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_191 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_191 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_191 = dataState_14;
      default : _zz__zz_dataState_0_191 = dataState_15;
    endcase
  end

  always @(*) begin
    case(_zz__zz_dataState_0_200_1)
      4'b0000 : _zz__zz_dataState_0_200 = dataState_0;
      4'b0001 : _zz__zz_dataState_0_200 = dataState_1;
      4'b0010 : _zz__zz_dataState_0_200 = dataState_2;
      4'b0011 : _zz__zz_dataState_0_200 = dataState_3;
      4'b0100 : _zz__zz_dataState_0_200 = dataState_4;
      4'b0101 : _zz__zz_dataState_0_200 = dataState_5;
      4'b0110 : _zz__zz_dataState_0_200 = dataState_6;
      4'b0111 : _zz__zz_dataState_0_200 = dataState_7;
      4'b1000 : _zz__zz_dataState_0_200 = dataState_8;
      4'b1001 : _zz__zz_dataState_0_200 = dataState_9;
      4'b1010 : _zz__zz_dataState_0_200 = dataState_10;
      4'b1011 : _zz__zz_dataState_0_200 = dataState_11;
      4'b1100 : _zz__zz_dataState_0_200 = dataState_12;
      4'b1101 : _zz__zz_dataState_0_200 = dataState_13;
      4'b1110 : _zz__zz_dataState_0_200 = dataState_14;
      default : _zz__zz_dataState_0_200 = dataState_15;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(io_keySchedule_cmd_payload_mode)
      AESKeyScheduleCmdMode_Std_INIT : io_keySchedule_cmd_payload_mode_string = "INIT  ";
      AESKeyScheduleCmdMode_Std_NEXT_1 : io_keySchedule_cmd_payload_mode_string = "NEXT_1";
      default : io_keySchedule_cmd_payload_mode_string = "??????";
    endcase
  end
  always @(*) begin
    case(keyMode)
      AESKeyScheduleCmdMode_Std_INIT : keyMode_string = "INIT  ";
      AESKeyScheduleCmdMode_Std_NEXT_1 : keyMode_string = "NEXT_1";
      default : keyMode_string = "??????";
    endcase
  end
  always @(*) begin
    case(sm_stateReg)
      sm_enumDef_BOOT : sm_stateReg_string = "BOOT      ";
      sm_enumDef_sIdle : sm_stateReg_string = "sIdle     ";
      sm_enumDef_sKeyAdd : sm_stateReg_string = "sKeyAdd   ";
      sm_enumDef_sByteSub : sm_stateReg_string = "sByteSub  ";
      sm_enumDef_sShiftRow : sm_stateReg_string = "sShiftRow ";
      sm_enumDef_sMixColumn : sm_stateReg_string = "sMixColumn";
      default : sm_stateReg_string = "??????????";
    endcase
  end
  always @(*) begin
    case(sm_stateNext)
      sm_enumDef_BOOT : sm_stateNext_string = "BOOT      ";
      sm_enumDef_sIdle : sm_stateNext_string = "sIdle     ";
      sm_enumDef_sKeyAdd : sm_stateNext_string = "sKeyAdd   ";
      sm_enumDef_sByteSub : sm_stateNext_string = "sByteSub  ";
      sm_enumDef_sShiftRow : sm_stateNext_string = "sShiftRow ";
      sm_enumDef_sMixColumn : sm_stateNext_string = "sMixColumn";
      default : sm_stateNext_string = "??????????";
    endcase
  end
  `endif

  assign io_keySchedule_cmd_valid = keyValid;
  assign io_keySchedule_cmd_payload_round = (cntRound + 4'b0001);
  assign io_keySchedule_cmd_payload_key = io_engine_cmd_payload_key;
  assign io_keySchedule_cmd_payload_mode = keyMode;
  always @(*) begin
    smDone = 1'b0;
    case(sm_stateReg)
      sm_enumDef_sIdle : begin
      end
      sm_enumDef_sKeyAdd : begin
        if(when_AESCoreStd_l175) begin
          if(io_engine_cmd_payload_enc) begin
            if(when_AESCoreStd_l179) begin
              smDone = 1'b1;
            end
          end else begin
            if(!when_AESCoreStd_l196) begin
              if(when_AESCoreStd_l198) begin
                smDone = 1'b1;
              end
            end
          end
        end
      end
      sm_enumDef_sByteSub : begin
      end
      sm_enumDef_sShiftRow : begin
      end
      sm_enumDef_sMixColumn : begin
      end
      default : begin
      end
    endcase
  end

  assign io_engine_cmd_ready = smDone_regNext;
  assign io_engine_rsp_valid = io_engine_cmd_ready;
  assign io_engine_rsp_payload_block = {dataState_0,{dataState_1,{dataState_2,{dataState_3,{dataState_4,{dataState_5,{dataState_6,{dataState_7,{dataState_8,{dataState_9,{dataState_10,{dataState_11,{dataState_12,{dataState_13,{dataState_14,dataState_15}}}}}}}}}}}}}}};
  assign _zz_dataState_15 = io_keySchedule_key_i[7 : 0];
  assign _zz_dataState_14 = io_keySchedule_key_i[15 : 8];
  assign _zz_dataState_13 = io_keySchedule_key_i[23 : 16];
  assign _zz_dataState_12 = io_keySchedule_key_i[31 : 24];
  assign _zz_dataState_11 = io_keySchedule_key_i[39 : 32];
  assign _zz_dataState_10 = io_keySchedule_key_i[47 : 40];
  assign _zz_dataState_9 = io_keySchedule_key_i[55 : 48];
  assign _zz_dataState_8 = io_keySchedule_key_i[63 : 56];
  assign _zz_dataState_7 = io_keySchedule_key_i[71 : 64];
  assign _zz_dataState_6 = io_keySchedule_key_i[79 : 72];
  assign _zz_dataState_5 = io_keySchedule_key_i[87 : 80];
  assign _zz_dataState_4 = io_keySchedule_key_i[95 : 88];
  assign _zz_dataState_3 = io_keySchedule_key_i[103 : 96];
  assign _zz_dataState_2 = io_keySchedule_key_i[111 : 104];
  assign _zz_dataState_1 = io_keySchedule_key_i[119 : 112];
  assign _zz_dataState_0 = io_keySchedule_key_i[127 : 120];
  assign sm_wantExit = 1'b0;
  always @(*) begin
    sm_wantStart = 1'b0;
    case(sm_stateReg)
      sm_enumDef_sIdle : begin
      end
      sm_enumDef_sKeyAdd : begin
      end
      sm_enumDef_sByteSub : begin
      end
      sm_enumDef_sShiftRow : begin
      end
      sm_enumDef_sMixColumn : begin
      end
      default : begin
        sm_wantStart = 1'b1;
      end
    endcase
  end

  assign sm_wantKill = 1'b0;
  always @(*) begin
    sm_keyAddition_cmd = 1'b0;
    case(sm_stateReg)
      sm_enumDef_sIdle : begin
      end
      sm_enumDef_sKeyAdd : begin
        if(when_AESCoreStd_l175) begin
          sm_keyAddition_cmd = 1'b1;
        end
      end
      sm_enumDef_sByteSub : begin
      end
      sm_enumDef_sShiftRow : begin
      end
      sm_enumDef_sMixColumn : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    sm_byteSub_cmd_valid = 1'b0;
    case(sm_stateReg)
      sm_enumDef_sIdle : begin
      end
      sm_enumDef_sKeyAdd : begin
      end
      sm_enumDef_sByteSub : begin
        sm_byteSub_cmd_valid = 1'b1;
      end
      sm_enumDef_sShiftRow : begin
      end
      sm_enumDef_sMixColumn : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    sm_shiftRow_cmd = 1'b0;
    case(sm_stateReg)
      sm_enumDef_sIdle : begin
      end
      sm_enumDef_sKeyAdd : begin
      end
      sm_enumDef_sByteSub : begin
      end
      sm_enumDef_sShiftRow : begin
        sm_shiftRow_cmd = 1'b1;
      end
      sm_enumDef_sMixColumn : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    sm_mixCol_cmd_valid = 1'b0;
    case(sm_stateReg)
      sm_enumDef_sIdle : begin
      end
      sm_enumDef_sKeyAdd : begin
      end
      sm_enumDef_sByteSub : begin
      end
      sm_enumDef_sShiftRow : begin
      end
      sm_enumDef_sMixColumn : begin
        sm_mixCol_cmd_valid = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign when_AESCoreStd_l260 = (((cntRound == 4'b0000) && io_engine_cmd_payload_enc) || ((cntRound == 4'b1010) && (! io_engine_cmd_payload_enc)));
  always @(*) begin
    byteSubstitution_cntByte_willIncrement = 1'b0;
    if(sm_byteSub_cmd_valid) begin
      byteSubstitution_cntByte_willIncrement = 1'b1;
    end
  end

  always @(*) begin
    byteSubstitution_cntByte_willClear = 1'b0;
    if(!sm_byteSub_cmd_valid) begin
      byteSubstitution_cntByte_willClear = 1'b1;
    end
  end

  assign byteSubstitution_cntByte_willOverflowIfInc = (byteSubstitution_cntByte_value == 4'b1111);
  assign byteSubstitution_cntByte_willOverflow = (byteSubstitution_cntByte_willOverflowIfInc && byteSubstitution_cntByte_willIncrement);
  always @(*) begin
    byteSubstitution_cntByte_valueNext = (byteSubstitution_cntByte_value + _zz_byteSubstitution_cntByte_valueNext);
    if(byteSubstitution_cntByte_willClear) begin
      byteSubstitution_cntByte_valueNext = 4'b0000;
    end
  end

  assign sm_byteSub_cmd_ready = byteSubstitution_cntByte_willOverflowIfInc;
  assign _zz_dataState_0_1 = _zz__zz_dataState_0_1;
  assign _zz_1 = ({15'd0,1'b1} <<< byteSubstitution_cntByte_value);
  assign _zz_2 = _zz_1[0];
  assign _zz_3 = _zz_1[1];
  assign _zz_4 = _zz_1[2];
  assign _zz_5 = _zz_1[3];
  assign _zz_6 = _zz_1[4];
  assign _zz_7 = _zz_1[5];
  assign _zz_8 = _zz_1[6];
  assign _zz_9 = _zz_1[7];
  assign _zz_10 = _zz_1[8];
  assign _zz_11 = _zz_1[9];
  assign _zz_12 = _zz_1[10];
  assign _zz_13 = _zz_1[11];
  assign _zz_14 = _zz_1[12];
  assign _zz_15 = _zz_1[13];
  assign _zz_16 = _zz_1[14];
  assign _zz_17 = _zz_1[15];
  assign _zz_dataState_0_2 = _zz_dataState_0_1;
  assign _zz_dataState_0_3 = sBoxMem_spinal_port0;
  assign _zz_dataState_0_4 = _zz_dataState_0_1;
  assign _zz_dataState_0_5 = sBoxMemInv_spinal_port0;
  assign sm_mixCol_cmd_ready = (mixColumn_cntColumn == 4'b1100);
  assign _zz_20 = ({15'd0,1'b1} <<< _zz__zz_20);
  assign _zz_dataState_0_6 = _zz__zz_dataState_0_6;
  assign _zz_dataState_0_7 = _zz_dataState_0_6[7];
  assign _zz_dataState_0_8 = _zz__zz_dataState_0_8;
  assign _zz_dataState_0_9 = _zz_dataState_0_8[0];
  assign _zz_dataState_0_10 = _zz_dataState_0_8[1];
  assign _zz_dataState_0_11 = _zz_dataState_0_8[2];
  assign _zz_dataState_0_12 = _zz_dataState_0_8[3];
  assign _zz_dataState_0_13 = _zz_dataState_0_8[4];
  assign _zz_dataState_0_14 = _zz_dataState_0_8[5];
  assign _zz_dataState_0_15 = _zz_dataState_0_8[6];
  assign _zz_dataState_0_16 = _zz_dataState_0_8[7];
  assign _zz_dataState_0_17 = _zz__zz_dataState_0_17;
  assign _zz_dataState_0_18 = _zz__zz_dataState_0_18;
  assign _zz_dataState_0_19 = ((({_zz__zz_dataState_0_19,{_zz__zz_dataState_0_19_1,_zz__zz_dataState_0_19_2}} ^ {_zz__zz_dataState_0_19_7,{_zz__zz_dataState_0_19_8,_zz__zz_dataState_0_19_9}}) ^ {_zz_dataState_0_17[7],{_zz__zz_dataState_0_19_15,{_zz__zz_dataState_0_19_16,_zz__zz_dataState_0_19_17}}}) ^ {_zz_dataState_0_18[7],{_zz_dataState_0_18[6],{_zz__zz_dataState_0_19_21,{_zz__zz_dataState_0_19_22,_zz__zz_dataState_0_19_23}}}});
  assign _zz_21 = ({15'd0,1'b1} <<< _zz__zz_21);
  assign _zz_dataState_0_20 = _zz__zz_dataState_0_20;
  assign _zz_dataState_0_21 = _zz__zz_dataState_0_21;
  assign _zz_dataState_0_22 = _zz_dataState_0_21[7];
  assign _zz_dataState_0_23 = _zz__zz_dataState_0_23;
  assign _zz_dataState_0_24 = _zz_dataState_0_23[0];
  assign _zz_dataState_0_25 = _zz_dataState_0_23[1];
  assign _zz_dataState_0_26 = _zz_dataState_0_23[2];
  assign _zz_dataState_0_27 = _zz_dataState_0_23[3];
  assign _zz_dataState_0_28 = _zz_dataState_0_23[4];
  assign _zz_dataState_0_29 = _zz_dataState_0_23[5];
  assign _zz_dataState_0_30 = _zz_dataState_0_23[6];
  assign _zz_dataState_0_31 = _zz_dataState_0_23[7];
  assign _zz_dataState_0_32 = _zz__zz_dataState_0_32;
  assign _zz_dataState_0_33 = ((({_zz__zz_dataState_0_33,{_zz__zz_dataState_0_33_1,_zz__zz_dataState_0_33_2}} ^ {_zz__zz_dataState_0_33_8,{_zz__zz_dataState_0_33_9,_zz__zz_dataState_0_33_10}}) ^ {(_zz_dataState_0_30 ^ _zz_dataState_0_31),{_zz__zz_dataState_0_33_15,{_zz__zz_dataState_0_33_16,_zz__zz_dataState_0_33_17}}}) ^ {_zz_dataState_0_32[7],{_zz_dataState_0_32[6],{_zz__zz_dataState_0_33_23,{_zz__zz_dataState_0_33_24,_zz__zz_dataState_0_33_25}}}});
  assign _zz_22 = ({15'd0,1'b1} <<< _zz__zz_22);
  assign _zz_dataState_0_34 = _zz__zz_dataState_0_34;
  assign _zz_dataState_0_35 = _zz__zz_dataState_0_35;
  assign _zz_dataState_0_36 = _zz__zz_dataState_0_36;
  assign _zz_dataState_0_37 = _zz_dataState_0_36[7];
  assign _zz_dataState_0_38 = _zz__zz_dataState_0_38;
  assign _zz_dataState_0_39 = _zz_dataState_0_38[0];
  assign _zz_dataState_0_40 = _zz_dataState_0_38[1];
  assign _zz_dataState_0_41 = _zz_dataState_0_38[2];
  assign _zz_dataState_0_42 = _zz_dataState_0_38[3];
  assign _zz_dataState_0_43 = _zz_dataState_0_38[4];
  assign _zz_dataState_0_44 = _zz_dataState_0_38[5];
  assign _zz_dataState_0_45 = _zz_dataState_0_38[6];
  assign _zz_dataState_0_46 = _zz_dataState_0_38[7];
  assign _zz_dataState_0_47 = ((({_zz__zz_dataState_0_47,{_zz__zz_dataState_0_47_1,_zz__zz_dataState_0_47_2}} ^ {_zz__zz_dataState_0_47_6,{_zz__zz_dataState_0_47_7,_zz__zz_dataState_0_47_8}}) ^ {_zz_dataState_0_36[6],{_zz__zz_dataState_0_47_12,{_zz__zz_dataState_0_47_13,_zz__zz_dataState_0_47_14}}}) ^ {(_zz_dataState_0_45 ^ _zz_dataState_0_46),{(_zz_dataState_0_44 ^ _zz_dataState_0_45),{_zz__zz_dataState_0_47_19,{_zz__zz_dataState_0_47_20,_zz__zz_dataState_0_47_21}}}});
  assign _zz_23 = ({15'd0,1'b1} <<< _zz__zz_23);
  assign _zz_dataState_0_48 = _zz__zz_dataState_0_48;
  assign _zz_dataState_0_49 = _zz_dataState_0_48[0];
  assign _zz_dataState_0_50 = _zz_dataState_0_48[1];
  assign _zz_dataState_0_51 = _zz_dataState_0_48[2];
  assign _zz_dataState_0_52 = _zz_dataState_0_48[3];
  assign _zz_dataState_0_53 = _zz_dataState_0_48[4];
  assign _zz_dataState_0_54 = _zz_dataState_0_48[5];
  assign _zz_dataState_0_55 = _zz_dataState_0_48[6];
  assign _zz_dataState_0_56 = _zz_dataState_0_48[7];
  assign _zz_dataState_0_57 = _zz__zz_dataState_0_57;
  assign _zz_dataState_0_58 = _zz__zz_dataState_0_58;
  assign _zz_dataState_0_59 = _zz__zz_dataState_0_59;
  assign _zz_dataState_0_60 = _zz_dataState_0_59[7];
  assign _zz_dataState_0_61 = ((({_zz__zz_dataState_0_61,{_zz__zz_dataState_0_61_1,_zz__zz_dataState_0_61_2}} ^ {_zz__zz_dataState_0_61_10,{_zz__zz_dataState_0_61_11,_zz__zz_dataState_0_61_12}}) ^ {_zz_dataState_0_58[7],{_zz__zz_dataState_0_61_19,{_zz__zz_dataState_0_61_20,_zz__zz_dataState_0_61_21}}}) ^ {_zz_dataState_0_59[6],{_zz_dataState_0_59[5],{_zz__zz_dataState_0_61_27,{_zz__zz_dataState_0_61_28,_zz__zz_dataState_0_61_30}}}});
  assign _zz_24 = ({15'd0,1'b1} <<< _zz__zz_24);
  assign _zz_dataState_0_62 = _zz__zz_dataState_0_62;
  assign _zz_dataState_0_63 = _zz_dataState_0_62[0];
  assign _zz_dataState_0_64 = _zz_dataState_0_62[1];
  assign _zz_dataState_0_65 = _zz_dataState_0_62[2];
  assign _zz_dataState_0_66 = _zz_dataState_0_62[3];
  assign _zz_dataState_0_67 = _zz_dataState_0_62[4];
  assign _zz_dataState_0_68 = _zz_dataState_0_62[5];
  assign _zz_dataState_0_69 = _zz_dataState_0_62[6];
  assign _zz_dataState_0_70 = _zz_dataState_0_62[7];
  assign _zz_dataState_0_71 = _zz__zz_dataState_0_71;
  assign _zz_dataState_0_72 = _zz_dataState_0_71[0];
  assign _zz_dataState_0_73 = _zz_dataState_0_71[1];
  assign _zz_dataState_0_74 = _zz_dataState_0_71[2];
  assign _zz_dataState_0_75 = _zz_dataState_0_71[3];
  assign _zz_dataState_0_76 = _zz_dataState_0_71[4];
  assign _zz_dataState_0_77 = _zz_dataState_0_71[5];
  assign _zz_dataState_0_78 = _zz_dataState_0_71[6];
  assign _zz_dataState_0_79 = _zz_dataState_0_71[7];
  assign _zz_dataState_0_80 = _zz__zz_dataState_0_80;
  assign _zz_dataState_0_81 = _zz_dataState_0_80[0];
  assign _zz_dataState_0_82 = _zz_dataState_0_80[1];
  assign _zz_dataState_0_83 = _zz_dataState_0_80[2];
  assign _zz_dataState_0_84 = _zz_dataState_0_80[3];
  assign _zz_dataState_0_85 = _zz_dataState_0_80[4];
  assign _zz_dataState_0_86 = _zz_dataState_0_80[5];
  assign _zz_dataState_0_87 = _zz_dataState_0_80[6];
  assign _zz_dataState_0_88 = _zz_dataState_0_80[7];
  assign _zz_dataState_0_89 = _zz__zz_dataState_0_89;
  assign _zz_dataState_0_90 = _zz_dataState_0_89[0];
  assign _zz_dataState_0_91 = _zz_dataState_0_89[1];
  assign _zz_dataState_0_92 = _zz_dataState_0_89[2];
  assign _zz_dataState_0_93 = _zz_dataState_0_89[3];
  assign _zz_dataState_0_94 = _zz_dataState_0_89[4];
  assign _zz_dataState_0_95 = _zz_dataState_0_89[5];
  assign _zz_dataState_0_96 = _zz_dataState_0_89[6];
  assign _zz_dataState_0_97 = _zz_dataState_0_89[7];
  assign _zz_dataState_0_98 = ((({_zz__zz_dataState_0_98,{_zz__zz_dataState_0_98_1,_zz__zz_dataState_0_98_3}} ^ {_zz__zz_dataState_0_98_16,{_zz__zz_dataState_0_98_17,_zz__zz_dataState_0_98_19}}) ^ {(_zz__zz_dataState_0_98_33 ^ _zz_dataState_0_88),{_zz__zz_dataState_0_98_34,{_zz__zz_dataState_0_98_36,_zz__zz_dataState_0_98_38}}}) ^ {(_zz_dataState_0_94 ^ _zz_dataState_0_97),{(_zz__zz_dataState_0_98_50 ^ _zz_dataState_0_96),{_zz__zz_dataState_0_98_51,{_zz__zz_dataState_0_98_53,_zz__zz_dataState_0_98_55}}}});
  assign _zz_25 = ({15'd0,1'b1} <<< _zz__zz_25);
  assign _zz_dataState_0_99 = _zz__zz_dataState_0_99;
  assign _zz_dataState_0_100 = _zz_dataState_0_99[0];
  assign _zz_dataState_0_101 = _zz_dataState_0_99[1];
  assign _zz_dataState_0_102 = _zz_dataState_0_99[2];
  assign _zz_dataState_0_103 = _zz_dataState_0_99[3];
  assign _zz_dataState_0_104 = _zz_dataState_0_99[4];
  assign _zz_dataState_0_105 = _zz_dataState_0_99[5];
  assign _zz_dataState_0_106 = _zz_dataState_0_99[6];
  assign _zz_dataState_0_107 = _zz_dataState_0_99[7];
  assign _zz_dataState_0_108 = _zz__zz_dataState_0_108;
  assign _zz_dataState_0_109 = _zz_dataState_0_108[0];
  assign _zz_dataState_0_110 = _zz_dataState_0_108[1];
  assign _zz_dataState_0_111 = _zz_dataState_0_108[2];
  assign _zz_dataState_0_112 = _zz_dataState_0_108[3];
  assign _zz_dataState_0_113 = _zz_dataState_0_108[4];
  assign _zz_dataState_0_114 = _zz_dataState_0_108[5];
  assign _zz_dataState_0_115 = _zz_dataState_0_108[6];
  assign _zz_dataState_0_116 = _zz_dataState_0_108[7];
  assign _zz_dataState_0_117 = _zz__zz_dataState_0_117;
  assign _zz_dataState_0_118 = _zz_dataState_0_117[0];
  assign _zz_dataState_0_119 = _zz_dataState_0_117[1];
  assign _zz_dataState_0_120 = _zz_dataState_0_117[2];
  assign _zz_dataState_0_121 = _zz_dataState_0_117[3];
  assign _zz_dataState_0_122 = _zz_dataState_0_117[4];
  assign _zz_dataState_0_123 = _zz_dataState_0_117[5];
  assign _zz_dataState_0_124 = _zz_dataState_0_117[6];
  assign _zz_dataState_0_125 = _zz_dataState_0_117[7];
  assign _zz_dataState_0_126 = _zz__zz_dataState_0_126;
  assign _zz_dataState_0_127 = _zz_dataState_0_126[0];
  assign _zz_dataState_0_128 = _zz_dataState_0_126[1];
  assign _zz_dataState_0_129 = _zz_dataState_0_126[2];
  assign _zz_dataState_0_130 = _zz_dataState_0_126[3];
  assign _zz_dataState_0_131 = _zz_dataState_0_126[4];
  assign _zz_dataState_0_132 = _zz_dataState_0_126[5];
  assign _zz_dataState_0_133 = _zz_dataState_0_126[6];
  assign _zz_dataState_0_134 = _zz_dataState_0_126[7];
  assign _zz_dataState_0_135 = ((({_zz__zz_dataState_0_135,{_zz__zz_dataState_0_135_1,_zz__zz_dataState_0_135_3}} ^ {_zz__zz_dataState_0_135_17,{_zz__zz_dataState_0_135_18,_zz__zz_dataState_0_135_20}}) ^ {(_zz__zz_dataState_0_135_34 ^ _zz_dataState_0_125),{_zz__zz_dataState_0_135_35,{_zz__zz_dataState_0_135_37,_zz__zz_dataState_0_135_40}}}) ^ {((_zz_dataState_0_131 ^ _zz_dataState_0_132) ^ _zz_dataState_0_134),{(_zz__zz_dataState_0_135_55 ^ _zz_dataState_0_133),{_zz__zz_dataState_0_135_56,{_zz__zz_dataState_0_135_58,_zz__zz_dataState_0_135_61}}}});
  assign _zz_26 = ({15'd0,1'b1} <<< _zz__zz_26);
  assign _zz_dataState_0_136 = _zz__zz_dataState_0_136;
  assign _zz_dataState_0_137 = _zz_dataState_0_136[0];
  assign _zz_dataState_0_138 = _zz_dataState_0_136[1];
  assign _zz_dataState_0_139 = _zz_dataState_0_136[2];
  assign _zz_dataState_0_140 = _zz_dataState_0_136[3];
  assign _zz_dataState_0_141 = _zz_dataState_0_136[4];
  assign _zz_dataState_0_142 = _zz_dataState_0_136[5];
  assign _zz_dataState_0_143 = _zz_dataState_0_136[6];
  assign _zz_dataState_0_144 = _zz_dataState_0_136[7];
  assign _zz_dataState_0_145 = _zz__zz_dataState_0_145;
  assign _zz_dataState_0_146 = _zz_dataState_0_145[0];
  assign _zz_dataState_0_147 = _zz_dataState_0_145[1];
  assign _zz_dataState_0_148 = _zz_dataState_0_145[2];
  assign _zz_dataState_0_149 = _zz_dataState_0_145[3];
  assign _zz_dataState_0_150 = _zz_dataState_0_145[4];
  assign _zz_dataState_0_151 = _zz_dataState_0_145[5];
  assign _zz_dataState_0_152 = _zz_dataState_0_145[6];
  assign _zz_dataState_0_153 = _zz_dataState_0_145[7];
  assign _zz_dataState_0_154 = _zz__zz_dataState_0_154;
  assign _zz_dataState_0_155 = _zz_dataState_0_154[0];
  assign _zz_dataState_0_156 = _zz_dataState_0_154[1];
  assign _zz_dataState_0_157 = _zz_dataState_0_154[2];
  assign _zz_dataState_0_158 = _zz_dataState_0_154[3];
  assign _zz_dataState_0_159 = _zz_dataState_0_154[4];
  assign _zz_dataState_0_160 = _zz_dataState_0_154[5];
  assign _zz_dataState_0_161 = _zz_dataState_0_154[6];
  assign _zz_dataState_0_162 = _zz_dataState_0_154[7];
  assign _zz_dataState_0_163 = _zz__zz_dataState_0_163;
  assign _zz_dataState_0_164 = _zz_dataState_0_163[0];
  assign _zz_dataState_0_165 = _zz_dataState_0_163[1];
  assign _zz_dataState_0_166 = _zz_dataState_0_163[2];
  assign _zz_dataState_0_167 = _zz_dataState_0_163[3];
  assign _zz_dataState_0_168 = _zz_dataState_0_163[4];
  assign _zz_dataState_0_169 = _zz_dataState_0_163[5];
  assign _zz_dataState_0_170 = _zz_dataState_0_163[6];
  assign _zz_dataState_0_171 = _zz_dataState_0_163[7];
  assign _zz_dataState_0_172 = ((({_zz__zz_dataState_0_172,{_zz__zz_dataState_0_172_1,_zz__zz_dataState_0_172_3}} ^ {_zz__zz_dataState_0_172_17,{_zz__zz_dataState_0_172_18,_zz__zz_dataState_0_172_20}}) ^ {(_zz__zz_dataState_0_172_34 ^ _zz_dataState_0_161),{_zz__zz_dataState_0_172_35,{_zz__zz_dataState_0_172_37,_zz__zz_dataState_0_172_39}}}) ^ {((_zz_dataState_0_168 ^ _zz_dataState_0_170) ^ _zz_dataState_0_171),{(_zz__zz_dataState_0_172_52 ^ _zz_dataState_0_170),{_zz__zz_dataState_0_172_53,{_zz__zz_dataState_0_172_55,_zz__zz_dataState_0_172_59}}}});
  assign _zz_27 = ({15'd0,1'b1} <<< _zz__zz_27);
  assign _zz_dataState_0_173 = _zz__zz_dataState_0_173;
  assign _zz_dataState_0_174 = _zz_dataState_0_173[0];
  assign _zz_dataState_0_175 = _zz_dataState_0_173[1];
  assign _zz_dataState_0_176 = _zz_dataState_0_173[2];
  assign _zz_dataState_0_177 = _zz_dataState_0_173[3];
  assign _zz_dataState_0_178 = _zz_dataState_0_173[4];
  assign _zz_dataState_0_179 = _zz_dataState_0_173[5];
  assign _zz_dataState_0_180 = _zz_dataState_0_173[6];
  assign _zz_dataState_0_181 = _zz_dataState_0_173[7];
  assign _zz_dataState_0_182 = _zz__zz_dataState_0_182;
  assign _zz_dataState_0_183 = _zz_dataState_0_182[0];
  assign _zz_dataState_0_184 = _zz_dataState_0_182[1];
  assign _zz_dataState_0_185 = _zz_dataState_0_182[2];
  assign _zz_dataState_0_186 = _zz_dataState_0_182[3];
  assign _zz_dataState_0_187 = _zz_dataState_0_182[4];
  assign _zz_dataState_0_188 = _zz_dataState_0_182[5];
  assign _zz_dataState_0_189 = _zz_dataState_0_182[6];
  assign _zz_dataState_0_190 = _zz_dataState_0_182[7];
  assign _zz_dataState_0_191 = _zz__zz_dataState_0_191;
  assign _zz_dataState_0_192 = _zz_dataState_0_191[0];
  assign _zz_dataState_0_193 = _zz_dataState_0_191[1];
  assign _zz_dataState_0_194 = _zz_dataState_0_191[2];
  assign _zz_dataState_0_195 = _zz_dataState_0_191[3];
  assign _zz_dataState_0_196 = _zz_dataState_0_191[4];
  assign _zz_dataState_0_197 = _zz_dataState_0_191[5];
  assign _zz_dataState_0_198 = _zz_dataState_0_191[6];
  assign _zz_dataState_0_199 = _zz_dataState_0_191[7];
  assign _zz_dataState_0_200 = _zz__zz_dataState_0_200;
  assign _zz_dataState_0_201 = _zz_dataState_0_200[0];
  assign _zz_dataState_0_202 = _zz_dataState_0_200[1];
  assign _zz_dataState_0_203 = _zz_dataState_0_200[2];
  assign _zz_dataState_0_204 = _zz_dataState_0_200[3];
  assign _zz_dataState_0_205 = _zz_dataState_0_200[4];
  assign _zz_dataState_0_206 = _zz_dataState_0_200[5];
  assign _zz_dataState_0_207 = _zz_dataState_0_200[6];
  assign _zz_dataState_0_208 = _zz_dataState_0_200[7];
  assign _zz_dataState_0_209 = ((({_zz__zz_dataState_0_209,{_zz__zz_dataState_0_209_1,_zz__zz_dataState_0_209_3}} ^ {_zz__zz_dataState_0_209_17,{_zz__zz_dataState_0_209_18,_zz__zz_dataState_0_209_20}}) ^ {(_zz_dataState_0_196 ^ _zz_dataState_0_199),{_zz__zz_dataState_0_209_34,{_zz__zz_dataState_0_209_35,_zz__zz_dataState_0_209_37}}}) ^ {((_zz_dataState_0_205 ^ _zz_dataState_0_206) ^ _zz_dataState_0_207),{(_zz__zz_dataState_0_209_47 ^ _zz_dataState_0_206),{_zz__zz_dataState_0_209_48,{_zz__zz_dataState_0_209_50,_zz__zz_dataState_0_209_52}}}});
  always @(*) begin
    sm_stateNext = sm_stateReg;
    case(sm_stateReg)
      sm_enumDef_sIdle : begin
        if(io_keySchedule_cmd_ready) begin
          sm_stateNext = sm_enumDef_sKeyAdd;
        end
      end
      sm_enumDef_sKeyAdd : begin
        if(when_AESCoreStd_l175) begin
          if(io_engine_cmd_payload_enc) begin
            if(when_AESCoreStd_l179) begin
              sm_stateNext = sm_enumDef_sIdle;
            end else begin
              sm_stateNext = sm_enumDef_sByteSub;
            end
          end else begin
            if(when_AESCoreStd_l196) begin
              sm_stateNext = sm_enumDef_sShiftRow;
            end else begin
              if(when_AESCoreStd_l198) begin
                sm_stateNext = sm_enumDef_sIdle;
              end else begin
                sm_stateNext = sm_enumDef_sMixColumn;
              end
            end
          end
        end
      end
      sm_enumDef_sByteSub : begin
        if(sm_byteSub_cmd_ready) begin
          if(io_engine_cmd_payload_enc) begin
            sm_stateNext = sm_enumDef_sShiftRow;
          end else begin
            sm_stateNext = sm_enumDef_sKeyAdd;
          end
        end
      end
      sm_enumDef_sShiftRow : begin
        if(io_engine_cmd_payload_enc) begin
          if(when_AESCoreStd_l227) begin
            sm_stateNext = sm_enumDef_sKeyAdd;
          end else begin
            sm_stateNext = sm_enumDef_sMixColumn;
          end
        end else begin
          sm_stateNext = sm_enumDef_sByteSub;
        end
      end
      sm_enumDef_sMixColumn : begin
        if(sm_mixCol_cmd_ready) begin
          if(io_engine_cmd_payload_enc) begin
            sm_stateNext = sm_enumDef_sKeyAdd;
          end else begin
            sm_stateNext = sm_enumDef_sShiftRow;
          end
        end
      end
      default : begin
      end
    endcase
    if(sm_wantStart) begin
      sm_stateNext = sm_enumDef_sIdle;
    end
    if(sm_wantKill) begin
      sm_stateNext = sm_enumDef_BOOT;
    end
  end

  assign when_AESCoreStd_l160 = ((io_engine_cmd_valid && (! io_engine_cmd_ready)) && (! keyValid));
  assign when_AESCoreStd_l175 = (! keyValid);
  assign when_AESCoreStd_l179 = (cntRound == 4'b1010);
  assign when_AESCoreStd_l191 = (cntRound != 4'b0000);
  assign when_AESCoreStd_l196 = (cntRound == 4'b1010);
  assign when_AESCoreStd_l198 = (cntRound == 4'b0000);
  assign when_AESCoreStd_l227 = (cntRound == 4'b1010);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      keyValid <= 1'b0;
      keyMode <= AESKeyScheduleCmdMode_Std_INIT;
      smDone_regNext <= 1'b0;
      byteSubstitution_cntByte_value <= 4'b0000;
      sm_stateReg <= sm_enumDef_BOOT;
    end else begin
      if(io_keySchedule_cmd_ready) begin
        keyValid <= 1'b0;
      end
      smDone_regNext <= smDone;
      byteSubstitution_cntByte_value <= byteSubstitution_cntByte_valueNext;
      sm_stateReg <= sm_stateNext;
      case(sm_stateReg)
        sm_enumDef_sIdle : begin
          if(when_AESCoreStd_l160) begin
            keyValid <= 1'b1;
            keyMode <= AESKeyScheduleCmdMode_Std_INIT;
          end
          if(io_keySchedule_cmd_ready) begin
            keyValid <= 1'b0;
          end
        end
        sm_enumDef_sKeyAdd : begin
          if(when_AESCoreStd_l175) begin
            if(io_engine_cmd_payload_enc) begin
              if(!when_AESCoreStd_l179) begin
                keyValid <= 1'b1;
                keyMode <= AESKeyScheduleCmdMode_Std_NEXT_1;
              end
            end else begin
              if(when_AESCoreStd_l191) begin
                keyValid <= 1'b1;
                keyMode <= AESKeyScheduleCmdMode_Std_NEXT_1;
              end
            end
          end
        end
        sm_enumDef_sByteSub : begin
        end
        sm_enumDef_sShiftRow : begin
        end
        sm_enumDef_sMixColumn : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if(sm_keyAddition_cmd) begin
      if(when_AESCoreStd_l260) begin
        dataState_0 <= (io_engine_cmd_payload_block[127 : 120] ^ _zz_dataState_0);
        dataState_1 <= (io_engine_cmd_payload_block[119 : 112] ^ _zz_dataState_1);
        dataState_2 <= (io_engine_cmd_payload_block[111 : 104] ^ _zz_dataState_2);
        dataState_3 <= (io_engine_cmd_payload_block[103 : 96] ^ _zz_dataState_3);
        dataState_4 <= (io_engine_cmd_payload_block[95 : 88] ^ _zz_dataState_4);
        dataState_5 <= (io_engine_cmd_payload_block[87 : 80] ^ _zz_dataState_5);
        dataState_6 <= (io_engine_cmd_payload_block[79 : 72] ^ _zz_dataState_6);
        dataState_7 <= (io_engine_cmd_payload_block[71 : 64] ^ _zz_dataState_7);
        dataState_8 <= (io_engine_cmd_payload_block[63 : 56] ^ _zz_dataState_8);
        dataState_9 <= (io_engine_cmd_payload_block[55 : 48] ^ _zz_dataState_9);
        dataState_10 <= (io_engine_cmd_payload_block[47 : 40] ^ _zz_dataState_10);
        dataState_11 <= (io_engine_cmd_payload_block[39 : 32] ^ _zz_dataState_11);
        dataState_12 <= (io_engine_cmd_payload_block[31 : 24] ^ _zz_dataState_12);
        dataState_13 <= (io_engine_cmd_payload_block[23 : 16] ^ _zz_dataState_13);
        dataState_14 <= (io_engine_cmd_payload_block[15 : 8] ^ _zz_dataState_14);
        dataState_15 <= (io_engine_cmd_payload_block[7 : 0] ^ _zz_dataState_15);
      end else begin
        dataState_0 <= (dataState_0 ^ _zz_dataState_0);
        dataState_1 <= (dataState_1 ^ _zz_dataState_1);
        dataState_2 <= (dataState_2 ^ _zz_dataState_2);
        dataState_3 <= (dataState_3 ^ _zz_dataState_3);
        dataState_4 <= (dataState_4 ^ _zz_dataState_4);
        dataState_5 <= (dataState_5 ^ _zz_dataState_5);
        dataState_6 <= (dataState_6 ^ _zz_dataState_6);
        dataState_7 <= (dataState_7 ^ _zz_dataState_7);
        dataState_8 <= (dataState_8 ^ _zz_dataState_8);
        dataState_9 <= (dataState_9 ^ _zz_dataState_9);
        dataState_10 <= (dataState_10 ^ _zz_dataState_10);
        dataState_11 <= (dataState_11 ^ _zz_dataState_11);
        dataState_12 <= (dataState_12 ^ _zz_dataState_12);
        dataState_13 <= (dataState_13 ^ _zz_dataState_13);
        dataState_14 <= (dataState_14 ^ _zz_dataState_14);
        dataState_15 <= (dataState_15 ^ _zz_dataState_15);
      end
    end
    if(sm_byteSub_cmd_valid) begin
      if(io_engine_cmd_payload_enc) begin
        if(_zz_2) begin
          dataState_0 <= _zz_dataState_0_3;
        end
        if(_zz_3) begin
          dataState_1 <= _zz_dataState_0_3;
        end
        if(_zz_4) begin
          dataState_2 <= _zz_dataState_0_3;
        end
        if(_zz_5) begin
          dataState_3 <= _zz_dataState_0_3;
        end
        if(_zz_6) begin
          dataState_4 <= _zz_dataState_0_3;
        end
        if(_zz_7) begin
          dataState_5 <= _zz_dataState_0_3;
        end
        if(_zz_8) begin
          dataState_6 <= _zz_dataState_0_3;
        end
        if(_zz_9) begin
          dataState_7 <= _zz_dataState_0_3;
        end
        if(_zz_10) begin
          dataState_8 <= _zz_dataState_0_3;
        end
        if(_zz_11) begin
          dataState_9 <= _zz_dataState_0_3;
        end
        if(_zz_12) begin
          dataState_10 <= _zz_dataState_0_3;
        end
        if(_zz_13) begin
          dataState_11 <= _zz_dataState_0_3;
        end
        if(_zz_14) begin
          dataState_12 <= _zz_dataState_0_3;
        end
        if(_zz_15) begin
          dataState_13 <= _zz_dataState_0_3;
        end
        if(_zz_16) begin
          dataState_14 <= _zz_dataState_0_3;
        end
        if(_zz_17) begin
          dataState_15 <= _zz_dataState_0_3;
        end
      end else begin
        if(_zz_2) begin
          dataState_0 <= _zz_dataState_0_5;
        end
        if(_zz_3) begin
          dataState_1 <= _zz_dataState_0_5;
        end
        if(_zz_4) begin
          dataState_2 <= _zz_dataState_0_5;
        end
        if(_zz_5) begin
          dataState_3 <= _zz_dataState_0_5;
        end
        if(_zz_6) begin
          dataState_4 <= _zz_dataState_0_5;
        end
        if(_zz_7) begin
          dataState_5 <= _zz_dataState_0_5;
        end
        if(_zz_8) begin
          dataState_6 <= _zz_dataState_0_5;
        end
        if(_zz_9) begin
          dataState_7 <= _zz_dataState_0_5;
        end
        if(_zz_10) begin
          dataState_8 <= _zz_dataState_0_5;
        end
        if(_zz_11) begin
          dataState_9 <= _zz_dataState_0_5;
        end
        if(_zz_12) begin
          dataState_10 <= _zz_dataState_0_5;
        end
        if(_zz_13) begin
          dataState_11 <= _zz_dataState_0_5;
        end
        if(_zz_14) begin
          dataState_12 <= _zz_dataState_0_5;
        end
        if(_zz_15) begin
          dataState_13 <= _zz_dataState_0_5;
        end
        if(_zz_16) begin
          dataState_14 <= _zz_dataState_0_5;
        end
        if(_zz_17) begin
          dataState_15 <= _zz_dataState_0_5;
        end
      end
    end
    if(sm_shiftRow_cmd) begin
      if(io_engine_cmd_payload_enc) begin
        dataState_0 <= dataState_0;
        dataState_1 <= dataState_5;
        dataState_2 <= dataState_10;
        dataState_3 <= dataState_15;
        dataState_4 <= dataState_4;
        dataState_5 <= dataState_9;
        dataState_6 <= dataState_14;
        dataState_7 <= dataState_3;
        dataState_8 <= dataState_8;
        dataState_9 <= dataState_13;
        dataState_10 <= dataState_2;
        dataState_11 <= dataState_7;
        dataState_12 <= dataState_12;
        dataState_13 <= dataState_1;
        dataState_14 <= dataState_6;
        dataState_15 <= dataState_11;
      end else begin
        dataState_0 <= dataState_0;
        dataState_1 <= dataState_13;
        dataState_2 <= dataState_10;
        dataState_3 <= dataState_7;
        dataState_4 <= dataState_4;
        dataState_5 <= dataState_1;
        dataState_6 <= dataState_14;
        dataState_7 <= dataState_11;
        dataState_8 <= dataState_8;
        dataState_9 <= dataState_5;
        dataState_10 <= dataState_2;
        dataState_11 <= dataState_15;
        dataState_12 <= dataState_12;
        dataState_13 <= dataState_9;
        dataState_14 <= dataState_6;
        dataState_15 <= dataState_3;
      end
    end
    if(sm_mixCol_cmd_valid) begin
      if(io_engine_cmd_payload_enc) begin
        if(_zz_20[0]) begin
          dataState_0 <= _zz_dataState_0_19;
        end
        if(_zz_20[1]) begin
          dataState_1 <= _zz_dataState_0_19;
        end
        if(_zz_20[2]) begin
          dataState_2 <= _zz_dataState_0_19;
        end
        if(_zz_20[3]) begin
          dataState_3 <= _zz_dataState_0_19;
        end
        if(_zz_20[4]) begin
          dataState_4 <= _zz_dataState_0_19;
        end
        if(_zz_20[5]) begin
          dataState_5 <= _zz_dataState_0_19;
        end
        if(_zz_20[6]) begin
          dataState_6 <= _zz_dataState_0_19;
        end
        if(_zz_20[7]) begin
          dataState_7 <= _zz_dataState_0_19;
        end
        if(_zz_20[8]) begin
          dataState_8 <= _zz_dataState_0_19;
        end
        if(_zz_20[9]) begin
          dataState_9 <= _zz_dataState_0_19;
        end
        if(_zz_20[10]) begin
          dataState_10 <= _zz_dataState_0_19;
        end
        if(_zz_20[11]) begin
          dataState_11 <= _zz_dataState_0_19;
        end
        if(_zz_20[12]) begin
          dataState_12 <= _zz_dataState_0_19;
        end
        if(_zz_20[13]) begin
          dataState_13 <= _zz_dataState_0_19;
        end
        if(_zz_20[14]) begin
          dataState_14 <= _zz_dataState_0_19;
        end
        if(_zz_20[15]) begin
          dataState_15 <= _zz_dataState_0_19;
        end
        if(_zz_21[0]) begin
          dataState_0 <= _zz_dataState_0_33;
        end
        if(_zz_21[1]) begin
          dataState_1 <= _zz_dataState_0_33;
        end
        if(_zz_21[2]) begin
          dataState_2 <= _zz_dataState_0_33;
        end
        if(_zz_21[3]) begin
          dataState_3 <= _zz_dataState_0_33;
        end
        if(_zz_21[4]) begin
          dataState_4 <= _zz_dataState_0_33;
        end
        if(_zz_21[5]) begin
          dataState_5 <= _zz_dataState_0_33;
        end
        if(_zz_21[6]) begin
          dataState_6 <= _zz_dataState_0_33;
        end
        if(_zz_21[7]) begin
          dataState_7 <= _zz_dataState_0_33;
        end
        if(_zz_21[8]) begin
          dataState_8 <= _zz_dataState_0_33;
        end
        if(_zz_21[9]) begin
          dataState_9 <= _zz_dataState_0_33;
        end
        if(_zz_21[10]) begin
          dataState_10 <= _zz_dataState_0_33;
        end
        if(_zz_21[11]) begin
          dataState_11 <= _zz_dataState_0_33;
        end
        if(_zz_21[12]) begin
          dataState_12 <= _zz_dataState_0_33;
        end
        if(_zz_21[13]) begin
          dataState_13 <= _zz_dataState_0_33;
        end
        if(_zz_21[14]) begin
          dataState_14 <= _zz_dataState_0_33;
        end
        if(_zz_21[15]) begin
          dataState_15 <= _zz_dataState_0_33;
        end
        if(_zz_22[0]) begin
          dataState_0 <= _zz_dataState_0_47;
        end
        if(_zz_22[1]) begin
          dataState_1 <= _zz_dataState_0_47;
        end
        if(_zz_22[2]) begin
          dataState_2 <= _zz_dataState_0_47;
        end
        if(_zz_22[3]) begin
          dataState_3 <= _zz_dataState_0_47;
        end
        if(_zz_22[4]) begin
          dataState_4 <= _zz_dataState_0_47;
        end
        if(_zz_22[5]) begin
          dataState_5 <= _zz_dataState_0_47;
        end
        if(_zz_22[6]) begin
          dataState_6 <= _zz_dataState_0_47;
        end
        if(_zz_22[7]) begin
          dataState_7 <= _zz_dataState_0_47;
        end
        if(_zz_22[8]) begin
          dataState_8 <= _zz_dataState_0_47;
        end
        if(_zz_22[9]) begin
          dataState_9 <= _zz_dataState_0_47;
        end
        if(_zz_22[10]) begin
          dataState_10 <= _zz_dataState_0_47;
        end
        if(_zz_22[11]) begin
          dataState_11 <= _zz_dataState_0_47;
        end
        if(_zz_22[12]) begin
          dataState_12 <= _zz_dataState_0_47;
        end
        if(_zz_22[13]) begin
          dataState_13 <= _zz_dataState_0_47;
        end
        if(_zz_22[14]) begin
          dataState_14 <= _zz_dataState_0_47;
        end
        if(_zz_22[15]) begin
          dataState_15 <= _zz_dataState_0_47;
        end
        if(_zz_23[0]) begin
          dataState_0 <= _zz_dataState_0_61;
        end
        if(_zz_23[1]) begin
          dataState_1 <= _zz_dataState_0_61;
        end
        if(_zz_23[2]) begin
          dataState_2 <= _zz_dataState_0_61;
        end
        if(_zz_23[3]) begin
          dataState_3 <= _zz_dataState_0_61;
        end
        if(_zz_23[4]) begin
          dataState_4 <= _zz_dataState_0_61;
        end
        if(_zz_23[5]) begin
          dataState_5 <= _zz_dataState_0_61;
        end
        if(_zz_23[6]) begin
          dataState_6 <= _zz_dataState_0_61;
        end
        if(_zz_23[7]) begin
          dataState_7 <= _zz_dataState_0_61;
        end
        if(_zz_23[8]) begin
          dataState_8 <= _zz_dataState_0_61;
        end
        if(_zz_23[9]) begin
          dataState_9 <= _zz_dataState_0_61;
        end
        if(_zz_23[10]) begin
          dataState_10 <= _zz_dataState_0_61;
        end
        if(_zz_23[11]) begin
          dataState_11 <= _zz_dataState_0_61;
        end
        if(_zz_23[12]) begin
          dataState_12 <= _zz_dataState_0_61;
        end
        if(_zz_23[13]) begin
          dataState_13 <= _zz_dataState_0_61;
        end
        if(_zz_23[14]) begin
          dataState_14 <= _zz_dataState_0_61;
        end
        if(_zz_23[15]) begin
          dataState_15 <= _zz_dataState_0_61;
        end
      end else begin
        if(_zz_24[0]) begin
          dataState_0 <= _zz_dataState_0_98;
        end
        if(_zz_24[1]) begin
          dataState_1 <= _zz_dataState_0_98;
        end
        if(_zz_24[2]) begin
          dataState_2 <= _zz_dataState_0_98;
        end
        if(_zz_24[3]) begin
          dataState_3 <= _zz_dataState_0_98;
        end
        if(_zz_24[4]) begin
          dataState_4 <= _zz_dataState_0_98;
        end
        if(_zz_24[5]) begin
          dataState_5 <= _zz_dataState_0_98;
        end
        if(_zz_24[6]) begin
          dataState_6 <= _zz_dataState_0_98;
        end
        if(_zz_24[7]) begin
          dataState_7 <= _zz_dataState_0_98;
        end
        if(_zz_24[8]) begin
          dataState_8 <= _zz_dataState_0_98;
        end
        if(_zz_24[9]) begin
          dataState_9 <= _zz_dataState_0_98;
        end
        if(_zz_24[10]) begin
          dataState_10 <= _zz_dataState_0_98;
        end
        if(_zz_24[11]) begin
          dataState_11 <= _zz_dataState_0_98;
        end
        if(_zz_24[12]) begin
          dataState_12 <= _zz_dataState_0_98;
        end
        if(_zz_24[13]) begin
          dataState_13 <= _zz_dataState_0_98;
        end
        if(_zz_24[14]) begin
          dataState_14 <= _zz_dataState_0_98;
        end
        if(_zz_24[15]) begin
          dataState_15 <= _zz_dataState_0_98;
        end
        if(_zz_25[0]) begin
          dataState_0 <= _zz_dataState_0_135;
        end
        if(_zz_25[1]) begin
          dataState_1 <= _zz_dataState_0_135;
        end
        if(_zz_25[2]) begin
          dataState_2 <= _zz_dataState_0_135;
        end
        if(_zz_25[3]) begin
          dataState_3 <= _zz_dataState_0_135;
        end
        if(_zz_25[4]) begin
          dataState_4 <= _zz_dataState_0_135;
        end
        if(_zz_25[5]) begin
          dataState_5 <= _zz_dataState_0_135;
        end
        if(_zz_25[6]) begin
          dataState_6 <= _zz_dataState_0_135;
        end
        if(_zz_25[7]) begin
          dataState_7 <= _zz_dataState_0_135;
        end
        if(_zz_25[8]) begin
          dataState_8 <= _zz_dataState_0_135;
        end
        if(_zz_25[9]) begin
          dataState_9 <= _zz_dataState_0_135;
        end
        if(_zz_25[10]) begin
          dataState_10 <= _zz_dataState_0_135;
        end
        if(_zz_25[11]) begin
          dataState_11 <= _zz_dataState_0_135;
        end
        if(_zz_25[12]) begin
          dataState_12 <= _zz_dataState_0_135;
        end
        if(_zz_25[13]) begin
          dataState_13 <= _zz_dataState_0_135;
        end
        if(_zz_25[14]) begin
          dataState_14 <= _zz_dataState_0_135;
        end
        if(_zz_25[15]) begin
          dataState_15 <= _zz_dataState_0_135;
        end
        if(_zz_26[0]) begin
          dataState_0 <= _zz_dataState_0_172;
        end
        if(_zz_26[1]) begin
          dataState_1 <= _zz_dataState_0_172;
        end
        if(_zz_26[2]) begin
          dataState_2 <= _zz_dataState_0_172;
        end
        if(_zz_26[3]) begin
          dataState_3 <= _zz_dataState_0_172;
        end
        if(_zz_26[4]) begin
          dataState_4 <= _zz_dataState_0_172;
        end
        if(_zz_26[5]) begin
          dataState_5 <= _zz_dataState_0_172;
        end
        if(_zz_26[6]) begin
          dataState_6 <= _zz_dataState_0_172;
        end
        if(_zz_26[7]) begin
          dataState_7 <= _zz_dataState_0_172;
        end
        if(_zz_26[8]) begin
          dataState_8 <= _zz_dataState_0_172;
        end
        if(_zz_26[9]) begin
          dataState_9 <= _zz_dataState_0_172;
        end
        if(_zz_26[10]) begin
          dataState_10 <= _zz_dataState_0_172;
        end
        if(_zz_26[11]) begin
          dataState_11 <= _zz_dataState_0_172;
        end
        if(_zz_26[12]) begin
          dataState_12 <= _zz_dataState_0_172;
        end
        if(_zz_26[13]) begin
          dataState_13 <= _zz_dataState_0_172;
        end
        if(_zz_26[14]) begin
          dataState_14 <= _zz_dataState_0_172;
        end
        if(_zz_26[15]) begin
          dataState_15 <= _zz_dataState_0_172;
        end
        if(_zz_27[0]) begin
          dataState_0 <= _zz_dataState_0_209;
        end
        if(_zz_27[1]) begin
          dataState_1 <= _zz_dataState_0_209;
        end
        if(_zz_27[2]) begin
          dataState_2 <= _zz_dataState_0_209;
        end
        if(_zz_27[3]) begin
          dataState_3 <= _zz_dataState_0_209;
        end
        if(_zz_27[4]) begin
          dataState_4 <= _zz_dataState_0_209;
        end
        if(_zz_27[5]) begin
          dataState_5 <= _zz_dataState_0_209;
        end
        if(_zz_27[6]) begin
          dataState_6 <= _zz_dataState_0_209;
        end
        if(_zz_27[7]) begin
          dataState_7 <= _zz_dataState_0_209;
        end
        if(_zz_27[8]) begin
          dataState_8 <= _zz_dataState_0_209;
        end
        if(_zz_27[9]) begin
          dataState_9 <= _zz_dataState_0_209;
        end
        if(_zz_27[10]) begin
          dataState_10 <= _zz_dataState_0_209;
        end
        if(_zz_27[11]) begin
          dataState_11 <= _zz_dataState_0_209;
        end
        if(_zz_27[12]) begin
          dataState_12 <= _zz_dataState_0_209;
        end
        if(_zz_27[13]) begin
          dataState_13 <= _zz_dataState_0_209;
        end
        if(_zz_27[14]) begin
          dataState_14 <= _zz_dataState_0_209;
        end
        if(_zz_27[15]) begin
          dataState_15 <= _zz_dataState_0_209;
        end
      end
      mixColumn_cntColumn <= (mixColumn_cntColumn + 4'b0100);
    end else begin
      mixColumn_cntColumn <= 4'b0000;
    end
    case(sm_stateReg)
      sm_enumDef_sIdle : begin
        if(when_AESCoreStd_l160) begin
          cntRound <= (io_engine_cmd_payload_enc ? 4'b0000 : 4'b1010);
        end
      end
      sm_enumDef_sKeyAdd : begin
        if(when_AESCoreStd_l175) begin
          if(!io_engine_cmd_payload_enc) begin
            cntRound <= (cntRound - 4'b0001);
          end
        end
      end
      sm_enumDef_sByteSub : begin
        if(sm_byteSub_cmd_ready) begin
          if(io_engine_cmd_payload_enc) begin
            cntRound <= (cntRound + 4'b0001);
          end
        end
      end
      sm_enumDef_sShiftRow : begin
      end
      sm_enumDef_sMixColumn : begin
      end
      default : begin
      end
    endcase
  end


endmodule
