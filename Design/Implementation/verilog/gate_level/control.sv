
// Generated by Cadence Encounter(R) RTL Compiler RC9.1.203 - v09.10-s242_1

module control(ALE, AluEn, AluWe, AluOR, CFlag, ENB, ImmSel, IrWe,
     LrEn, LrSel, LrWe, MemEn, nME, nOE, nWE, Op1Sel, Op2Sel, PcEn,
     PcSel, PcWe, RegWe, Rs1Sel, RwSel, WdSel, StatusReg, StatusRegEn,
     SysBus, Clock, Flags, nIRQ, nReset, nWait, OpcodeCondIn);
  input [3:0] SysBus, Flags;
  input Clock, nIRQ, nReset, nWait;
  input [7:0] OpcodeCondIn;
  output ALE, AluEn, AluWe, CFlag, ENB, ImmSel, IrWe, LrEn, LrSel,
       LrWe, MemEn, nME, nOE, nWE, Op1Sel, PcEn, PcWe, RegWe, WdSel,
       StatusRegEn;
  output [1:0] AluOR, Op2Sel, Rs1Sel, RwSel;
  output [2:0] PcSel;
  output [3:0] StatusReg;
timeunit 1ns;
timeprecision 100ps;
  wire [3:0] SysBus, Flags;
  wire Clock, nIRQ, nReset, nWait;
  wire [7:0] OpcodeCondIn;
  wire ALE, AluEn, AluWe, CFlag, ENB, ImmSel, IrWe, LrEn, LrSel, LrWe,
       MemEn, nME, nOE, nWE, Op1Sel, PcEn, PcWe, RegWe, WdSel,
       StatusRegEn;
  wire [1:0] AluOR, Op2Sel, Rs1Sel, RwSel;
  wire [2:0] PcSel;
  wire [3:0] StatusReg;
  wire IRQ1, IRQ2, IntStatus, n_0, n_1, n_5, n_6, n_7;
  wire n_8, n_9, n_10, n_11, n_12, n_13, n_14, n_15;
  wire n_16, n_17, n_18, n_19, n_20, n_21, n_22, n_23;
  wire n_24, n_25, n_26, n_27, n_28, n_29, n_30, n_31;
  wire n_32, n_33, n_34, n_35, n_36, n_37, n_38, n_39;
  wire n_40, n_41, n_42, n_44, n_45, n_46, n_47, n_48;
  wire n_49, n_50, n_51, n_52, n_53, n_54, n_55, n_56;
  wire n_57, n_58, n_59, n_60, n_61, n_62, n_63, n_64;
  wire n_65, n_66, n_67, n_68, n_69, n_70, n_71, n_72;
  wire n_73, n_74, n_75, n_76, n_77, n_78, n_79, n_80;
  wire n_81, n_82, n_83, n_84, n_85, n_86, n_87, n_88;
  wire n_89, n_90, n_91, n_92, n_93, n_94, n_95, n_96;
  wire n_97, n_98, n_99, n_100, n_101, n_102, n_103, n_104;
  wire n_105, n_106, n_107, n_108, n_109, n_110, n_111, n_112;
  wire n_113, n_114, n_115, n_116, n_117, n_118, n_119, n_120;
  wire n_121, n_122, n_123, n_124, n_125, n_126, n_127, n_128;
  wire n_129, n_131, n_132, n_133, n_134, n_135, n_136, n_137;
  wire n_138, n_139, n_140, n_141, n_142, n_144, n_145, n_146;
  wire n_147, n_148, n_149, n_150, n_151, n_152, n_153, n_154;
  wire n_155, n_156, n_157, n_158, n_159, n_160, n_161, n_162;
  wire n_163, n_164, n_165, n_166, n_167, n_168, n_169, n_170;
  wire n_171, n_172, n_173, n_174, n_175, n_176, n_177, n_178;
  wire n_179, n_180, n_181, n_182, n_183, n_184, n_185, n_186;
  wire n_187, n_188, n_189, n_190, n_191, n_192, n_193, n_194;
  wire n_195, n_196, n_197, n_198, n_199, n_200, n_202, n_203;
  wire n_204, n_206, n_207, n_208, n_209, n_210, n_211, n_212;
  wire n_213, n_214, n_215, n_216, n_217, n_218, n_219, n_221;
  wire n_222, n_223, n_224, n_225, n_226, n_227, n_228, n_229;
  wire n_230, n_231, n_232, n_233, n_234, n_235, n_236, n_237;
  wire n_238, n_239, n_240, n_241, n_242, n_243, n_244, n_245;
  wire n_246, n_247, n_249, n_250, n_251, n_252, n_253, n_254;
  wire n_255, n_256, n_257, n_258, n_259, n_261, n_262, n_263;
  wire n_265, n_266, n_267, n_268, n_269, n_270, n_271, n_272;
  wire n_273, n_274, n_275, n_276, n_277, n_278, n_279, n_280;
  wire n_282, n_283, n_284, n_285, n_286, n_287, n_288, n_289;
  wire n_290, n_291, n_292, n_293, n_294, n_295, n_296, n_298;
  wire n_299, n_300, n_301, n_302, n_303, n_304, n_305, n_306;
  wire n_307, n_308, n_309, n_310, n_312, n_313, n_314, n_315;
  wire n_316, n_317, n_318, n_319, n_320, n_321, n_322, n_323;
  wire n_324, n_325, n_326, n_329, n_331, n_332, n_333, n_334;
  wire n_338, n_341, n_344, n_345, n_346, n_347, n_348, n_349;
  wire n_350, n_351, n_353, n_357, n_359, n_361, n_362, n_363;
  wire n_364, n_367, n_369, n_370, n_371, n_372, n_392, n_393;
  wire n_394, n_395, n_396, n_397, n_398, \stateSub[0] , \stateSub[1] ,
       \stateSub[2] ;
  wire \state[0] , \state[1] ;
  nand3 g8051(.A (n_363), .B (n_369), .C (n_359), .Y (AluEn));
  scandtype \StatusReg_reg[1] (.nReset (nReset), .Clock (Clock), .D
       (n_370), .Q (CFlag), .nQ ());
  scandtype \StatusReg_reg[0] (.nReset (nReset), .Clock (Clock), .D
       (n_372), .Q (StatusReg[0]), .nQ (n_393));
  scandtype \StatusReg_reg[2] (.nReset (nReset), .Clock (Clock), .D
       (n_371), .Q (StatusReg[2]), .nQ (n_392));
  scandtype \StatusReg_reg[3] (.nReset (nReset), .Clock (Clock), .D
       (n_362), .Q (StatusReg[3]), .nQ (n_394));
  nand2 g8045(.A (n_367), .B (n_275), .Y (Rs1Sel[0]));
  nand3 g8079(.A (n_209), .B (n_351), .C (n_211), .Y (Op2Sel[0]));
  nand3 g8054(.A (n_325), .B (n_348), .C (n_296), .Y (n_372));
  nand3 g8055(.A (n_322), .B (n_345), .C (n_293), .Y (n_371));
  nand3 g8052(.A (n_324), .B (n_347), .C (n_295), .Y (n_370));
  nor2 g8065(.A (n_361), .B (Op1Sel), .Y (n_369));
  scandtype \stateSub_reg[1] (.nReset (nReset), .Clock (Clock), .D
       (n_349), .Q (\stateSub[1] ), .nQ (n_119));
  nor2 g8049(.A (n_350), .B (n_32), .Y (n_367));
  nand3 g8075(.A (n_364), .B (n_332), .C (n_353), .Y (Op2Sel[1]));
  nand4 g8059(.A (n_364), .B (n_363), .C (n_333), .D (n_357), .Y
       (Rs1Sel[1]));
  nand3 g8056(.A (n_321), .B (n_344), .C (n_292), .Y (n_362));
  nand4 g8082(.A (n_172), .B (n_245), .C (n_317), .D (n_318), .Y
       (n_361));
  nand3 g8073(.A (n_359), .B (n_363), .C (n_305), .Y (AluWe));
  nand4 g8076(.A (n_249), .B (n_316), .C (n_359), .D (n_357), .Y
       (ImmSel));
  nand4 g8069(.A (n_235), .B (n_277), .C (n_307), .D (n_152), .Y
       (PcEn));
  nand3 g8088(.A (n_280), .B (n_341), .C (n_338), .Y (PcSel[1]));
  nand4 g8060(.A (n_334), .B (n_313), .C (n_302), .D (n_353), .Y
       (RegWe));
  nand4 g8050(.A (n_213), .B (n_126), .C (n_303), .D (n_274), .Y
       (RwSel[0]));
  nand2 g8099(.A (n_331), .B (OpcodeCondIn[4]), .Y (n_351));
  nand4 g8053(.A (n_314), .B (n_144), .C (n_304), .D (n_81), .Y
       (n_350));
  nand3 g8080(.A (n_133), .B (n_306), .C (n_35), .Y (n_349));
  nand2 g8061(.A (n_346), .B (StatusReg[0]), .Y (n_348));
  nand2 g8062(.A (n_346), .B (CFlag), .Y (n_347));
  nand2 g8063(.A (n_346), .B (StatusReg[2]), .Y (n_345));
  nand2 g8064(.A (n_346), .B (StatusReg[3]), .Y (n_344));
  scanreg IntStatus_reg(.nReset (nReset), .Clock (Clock), .D (n_276),
       .Load (n_266), .Q (IntStatus), .nQ ());
  scandtype \stateSub_reg[2] (.nReset (nReset), .Clock (Clock), .D
       (n_315), .Q (\stateSub[2] ), .nQ (n_137));
  nand3 g8083(.A (n_258), .B (n_329), .C (n_353), .Y (AluOR[1]));
  nand2 g8110(.A (n_341), .B (n_145), .Y (LrEn));
  nand2 g8111(.A (n_326), .B (n_187), .Y (LrWe));
  nand2 g8108(.A (n_309), .B (n_338), .Y (PcSel[0]));
  nand3 g8072(.A (n_121), .B (n_289), .C (\stateSub[0] ), .Y (nME));
  nand2 g8070(.A (n_312), .B (n_173), .Y (PcWe));
  nand3 g8084(.A (n_270), .B (n_363), .C (n_334), .Y (RwSel[1]));
  inv g8112(.A (n_320), .Y (n_333));
  inv g8119(.A (n_319), .Y (n_332));
  nand2 g8124(.A (n_291), .B (n_231), .Y (n_331));
  nor2 g8128(.A (n_288), .B (n_234), .Y (Op1Sel));
  scandtype \state_reg[1] (.nReset (nReset), .Clock (Clock), .D
       (n_301), .Q (\state[1] ), .nQ (n_225));
  scandtype \state_reg[0] (.nReset (nReset), .Clock (Clock), .D
       (n_299), .Q (\state[0] ), .nQ (n_44));
  nand2 g8115(.A (n_329), .B (n_353), .Y (AluOR[0]));
  nand2 g8085(.A (n_287), .B (n_84), .Y (ENB));
  nand3 g8087(.A (n_310), .B (n_283), .C (n_52), .Y (nWE));
  inv g8145(.A (n_326), .Y (LrSel));
  nand2 g8104(.A (n_323), .B (Flags[0]), .Y (n_325));
  nand2 g8105(.A (n_323), .B (Flags[1]), .Y (n_324));
  nand2 g8106(.A (n_323), .B (Flags[2]), .Y (n_322));
  nand2 g8107(.A (n_323), .B (Flags[3]), .Y (n_321));
  nand3 g8113(.A (n_243), .B (n_267), .C (n_300), .Y (n_320));
  nand4 g8120(.A (n_150), .B (n_242), .C (n_269), .D (n_318), .Y
       (n_319));
  nand2 g8123(.A (n_290), .B (n_223), .Y (n_317));
  nor2 g8125(.A (n_271), .B (n_215), .Y (n_316));
  nand4 g8089(.A (n_314), .B (n_222), .C (n_262), .D (n_20), .Y
       (n_315));
  nor2 g8130(.A (n_272), .B (n_398), .Y (n_313));
  nand2 g8131(.A (n_308), .B (n_112), .Y (n_341));
  inv g8090(.A (n_298), .Y (n_312));
  nand3 g8114(.A (n_310), .B (n_251), .C (n_64), .Y (nOE));
  nand2 g8141(.A (n_216), .B (n_308), .Y (n_309));
  nand2 g8146(.A (n_308), .B (n_210), .Y (n_326));
  inv g8148(.A (n_323), .Y (n_307));
  nand2 g8101(.A (n_396), .B (n_286), .Y (n_306));
  nand2 g8103(.A (n_278), .B (\stateSub[0] ), .Y (n_305));
  nand4 g8071(.A (n_185), .B (n_263), .C (n_189), .D (n_118), .Y
       (n_346));
  nor2 g8074(.A (n_279), .B (n_178), .Y (n_304));
  inv g8077(.A (n_285), .Y (n_303));
  inv g8117(.A (n_284), .Y (n_302));
  nand3 g8081(.A (n_86), .B (n_227), .C (n_22), .Y (n_301));
  and2 g8134(.A (n_255), .B (n_300), .Y (n_329));
  nand2 g8086(.A (n_250), .B (n_109), .Y (n_299));
  nand4 g8091(.A (n_151), .B (n_203), .C (n_224), .D (n_338), .Y
       (n_298));
  and2 g8133(.A (n_254), .B (n_353), .Y (n_363));
  nand2 g8122(.A (n_259), .B (n_117), .Y (ALE));
  nand2 g8093(.A (n_294), .B (SysBus[0]), .Y (n_296));
  nand2 g8094(.A (n_294), .B (SysBus[1]), .Y (n_295));
  nand2 g8095(.A (n_294), .B (SysBus[2]), .Y (n_293));
  nand2 g8096(.A (n_294), .B (SysBus[3]), .Y (n_292));
  nand3 g8149(.A (n_206), .B (n_240), .C (n_158), .Y (n_323));
  inv g8155(.A (n_290), .Y (n_291));
  nand2 g8102(.A (n_265), .B (\state[0] ), .Y (n_289));
  inv g8162(.A (n_308), .Y (n_288));
  nand3 g8116(.A (n_286), .B (n_282), .C (\stateSub[0] ), .Y (n_287));
  nand3 g8078(.A (n_105), .B (n_226), .C (n_5), .Y (n_285));
  nand4 g8118(.A (n_208), .B (n_238), .C (n_197), .D (n_155), .Y
       (n_284));
  and2 g8126(.A (n_247), .B (n_246), .Y (n_359));
  nand2 g8127(.A (n_282), .B (n_225), .Y (n_283));
  nand3 g8132(.A (n_202), .B (n_257), .C (n_146), .Y (n_280));
  scandtype \stateSub_reg[0] (.nReset (nReset), .Clock (Clock), .D
       (n_221), .Q (\stateSub[0] ), .nQ (n_195));
  nand4 g8092(.A (n_199), .B (n_114), .C (n_134), .D (n_48), .Y
       (n_279));
  nand2 g8138(.A (n_148), .B (n_237), .Y (n_278));
  nand2 g8143(.A (n_218), .B (n_256), .Y (n_334));
  nand2 g8144(.A (n_282), .B (n_261), .Y (n_277));
  nand4 g8100(.A (n_275), .B (n_110), .C (n_214), .D (n_274), .Y
       (n_276));
  nor2 g8156(.A (n_273), .B (OpcodeCondIn[6]), .Y (n_290));
  nor2 g8163(.A (n_273), .B (n_82), .Y (n_308));
  nor2 g8164(.A (n_273), .B (n_72), .Y (n_272));
  nor2 g8165(.A (n_273), .B (n_97), .Y (n_271));
  nand2 g8168(.A (n_268), .B (n_252), .Y (n_270));
  nand2 g8169(.A (n_268), .B (n_230), .Y (n_269));
  nand2 g8172(.A (n_268), .B (OpcodeCondIn[3]), .Y (n_267));
  nand2 g8175(.A (n_229), .B (n_353), .Y (n_266));
  nand2 g8135(.A (n_190), .B (n_183), .Y (n_265));
  nor2 g8151(.A (n_193), .B (n_7), .Y (WdSel));
  and2 g8139(.A (n_196), .B (n_177), .Y (n_263));
  and2 g8140(.A (n_194), .B (OpcodeCondIn[7]), .Y (n_294));
  nand2 g8142(.A (n_219), .B (n_261), .Y (n_262));
  nand3 g8157(.A (n_232), .B (n_244), .C (n_195), .Y (n_259));
  nand2 g8161(.A (n_257), .B (n_256), .Y (n_258));
  nand2 g8167(.A (n_253), .B (n_228), .Y (n_255));
  nand2 g8170(.A (n_253), .B (n_252), .Y (n_254));
  nand2 g8171(.A (n_212), .B (n_171), .Y (n_251));
  nand2 g8109(.A (n_198), .B (\state[0] ), .Y (n_250));
  nand3 g8183(.A (n_236), .B (n_239), .C (n_73), .Y (n_249));
  inv g8184(.A (n_186), .Y (StatusRegEn));
  nand3 g8186(.A (n_252), .B (n_233), .C (n_182), .Y (n_247));
  inv g8192(.A (n_246), .Y (n_268));
  nand2 g8194(.A (n_244), .B (n_179), .Y (n_245));
  nand2 g8196(.A (n_241), .B (n_34), .Y (n_243));
  nand2 g8197(.A (n_241), .B (\stateSub[0] ), .Y (n_242));
  nand2 g8201(.A (n_239), .B (n_96), .Y (n_240));
  nand2 g8202(.A (n_239), .B (OpcodeCondIn[7]), .Y (n_273));
  nand2 g8203(.A (n_239), .B (n_42), .Y (n_238));
  nand2 g8205(.A (n_241), .B (n_236), .Y (n_237));
  nand3 g8224(.A (n_234), .B (n_233), .C (n_156), .Y (n_235));
  nand2 g8210(.A (n_244), .B (n_232), .Y (n_310));
  nand2 g8213(.A (n_239), .B (n_230), .Y (n_231));
  nand3 g8223(.A (n_234), .B (n_233), .C (n_228), .Y (n_229));
  and2 g8136(.A (n_184), .B (n_181), .Y (n_364));
  nand4 g8097(.A (IntStatus), .B (\state[0] ), .C (n_168), .D (IRQ2),
       .Y (n_227));
  nand2 g8098(.A (n_174), .B (n_225), .Y (n_226));
  nand3 g8153(.A (n_234), .B (n_200), .C (n_223), .Y (n_224));
  nand2 g8160(.A (n_204), .B (n_225), .Y (n_222));
  nand2 g8166(.A (n_217), .B (n_161), .Y (n_282));
  nand3 g8177(.A (n_40), .B (n_163), .C (n_70), .Y (n_221));
  nand2 g8181(.A (n_217), .B (n_159), .Y (n_218));
  nand4 g8188(.A (n_80), .B (n_49), .C (n_142), .D (n_16), .Y (n_216));
  nor2 g8189(.A (n_175), .B (\stateSub[0] ), .Y (n_215));
  and2 g8190(.A (n_213), .B (n_160), .Y (n_214));
  nand2 g8191(.A (n_153), .B (n_140), .Y (n_212));
  nand2 g8193(.A (n_233), .B (n_170), .Y (n_246));
  nand2 g8198(.A (n_207), .B (n_115), .Y (n_211));
  and2 g8200(.A (n_233), .B (n_210), .Y (n_253));
  nand2 g8209(.A (n_233), .B (n_154), .Y (n_209));
  inv g8211(.A (n_217), .Y (n_257));
  nand2 g8222(.A (n_207), .B (n_99), .Y (n_208));
  nand2 g8215(.A (n_207), .B (n_59), .Y (n_206));
  nand3 g8219(.A (n_137), .B (n_202), .C (nWait), .Y (n_203));
  nand3 g8137(.A (n_167), .B (n_286), .C (n_162), .Y (n_199));
  nand4 g8150(.A (n_101), .B (n_141), .C (n_176), .D (n_261), .Y
       (n_198));
  nand4 g8152(.A (n_60), .B (n_192), .C (n_202), .D (n_191), .Y
       (n_197));
  nand2 g8158(.A (n_165), .B (n_195), .Y (n_196));
  nor2 g8159(.A (n_188), .B (n_131), .Y (n_194));
  nand3 g8221(.A (n_192), .B (n_202), .C (n_191), .Y (n_193));
  nand2 g8173(.A (n_169), .B (OpcodeCondIn[7]), .Y (n_190));
  nand2 g8176(.A (n_188), .B (\stateSub[0] ), .Y (n_189));
  nand2 g8179(.A (n_164), .B (\state[0] ), .Y (n_219));
  nand4 g8182(.A (n_230), .B (n_192), .C (n_202), .D (OpcodeCondIn[2]),
       .Y (n_187));
  nand3 g8185(.A (n_185), .B (n_180), .C (n_210), .Y (n_186));
  nand4 g8187(.A (n_183), .B (n_228), .C (n_256), .D (n_182), .Y
       (n_184));
  nand2 g8195(.A (n_180), .B (n_179), .Y (n_181));
  nand2 g8199(.A (n_138), .B (n_139), .Y (n_178));
  nand2 g8212(.A (n_180), .B (n_182), .Y (n_217));
  nand2 g8214(.A (n_136), .B (OpcodeCondIn[5]), .Y (n_177));
  nand2 g8218(.A (n_176), .B (n_124), .Y (n_204));
  inv g8240(.A (n_175), .Y (n_241));
  nand2 g8242(.A (n_132), .B (n_91), .Y (n_244));
  nand4 g8147(.A (n_92), .B (n_166), .C (n_90), .D (OpcodeCondIn[3]),
       .Y (n_174));
  inv g8259(.A (n_173), .Y (n_239));
  nand3 g8263(.A (n_171), .B (n_192), .C (n_149), .Y (n_172));
  nand4 g8225(.A (n_170), .B (n_230), .C (n_256), .D (n_183), .Y
       (n_357));
  nand2 g8204(.A (n_127), .B (n_252), .Y (n_169));
  nor2 g8206(.A (n_129), .B (n_51), .Y (n_168));
  nand2 g8208(.A (n_166), .B (OpcodeCondIn[3]), .Y (n_167));
  nand3 g8216(.A (n_120), .B (\stateSub[2] ), .C (n_83), .Y (n_165));
  nand3 g8226(.A (n_182), .B (n_147), .C (OpcodeCondIn[2]), .Y (n_188));
  nand3 g8227(.A (IntStatus), .B (n_93), .C (IRQ2), .Y (n_164));
  nand2 g8229(.A (n_122), .B (\stateSub[0] ), .Y (n_163));
  and2 g8234(.A (n_157), .B (n_162), .Y (n_207));
  nand2 g8236(.A (n_192), .B (n_191), .Y (n_161));
  nand2 g8238(.A (n_225), .B (n_113), .Y (n_160));
  nand2 g8241(.A (n_179), .B (n_192), .Y (n_175));
  nand2 g8244(.A (n_192), .B (n_230), .Y (n_159));
  nand2 g8246(.A (n_157), .B (n_104), .Y (n_158));
  and2 g8247(.A (n_157), .B (n_156), .Y (n_200));
  nand2 g8248(.A (n_157), .B (n_154), .Y (n_155));
  nand2 g8252(.A (n_192), .B (OpcodeCondIn[6]), .Y (n_153));
  and2 g8254(.A (n_157), .B (n_183), .Y (n_233));
  and2 g8255(.A (n_111), .B (n_95), .Y (n_152));
  nand2 g8258(.A (n_157), .B (n_128), .Y (n_151));
  nand2 g8260(.A (n_157), .B (OpcodeCondIn[5]), .Y (n_173));
  nand3 g8262(.A (n_192), .B (n_185), .C (n_149), .Y (n_150));
  nand4 g8174(.A (n_170), .B (n_147), .C (n_171), .D (n_146), .Y
       (n_148));
  nand4 g8180(.A (n_170), .B (n_147), .C (n_185), .D (OpcodeCondIn[2]),
       .Y (n_145));
  nand2 g8207(.A (n_125), .B (\stateSub[1] ), .Y (n_144));
  and2 g8228(.A (n_85), .B (nWait), .Y (IrWe));
  nor2 g8230(.A (n_88), .B (n_47), .Y (n_142));
  nand2 g8231(.A (n_135), .B (n_108), .Y (n_141));
  nand2 g8232(.A (n_147), .B (n_210), .Y (n_140));
  and2 g8233(.A (n_147), .B (OpcodeCondIn[7]), .Y (n_180));
  nand2 g8235(.A (n_106), .B (\stateSub[0] ), .Y (n_139));
  nand2 g8237(.A (n_87), .B (n_137), .Y (n_138));
  nand2 g8239(.A (n_103), .B (n_69), .Y (n_136));
  nand2 g8243(.A (n_135), .B (OpcodeCondIn[4]), .Y (n_176));
  nand2 g8253(.A (n_89), .B (OpcodeCondIn[7]), .Y (n_134));
  nand2 g8256(.A (n_107), .B (\stateSub[0] ), .Y (n_133));
  inv g8271(.A (n_192), .Y (n_132));
  inv g8292(.A (n_131), .Y (n_202));
  nand3 g8306(.A (\state[1] ), .B (n_116), .C (n_119), .Y (n_300));
  inv g8307(.A (n_338), .Y (PcSel[2]));
  nor2 g8245(.A (n_94), .B (n_128), .Y (n_129));
  nand2 g8249(.A (\stateSub[1] ), .B (n_123), .Y (n_127));
  inv g8250(.A (n_125), .Y (n_126));
  nand3 g8257(.A (n_102), .B (n_100), .C (OpcodeCondIn[7]), .Y (n_124));
  nand2 g8261(.A (n_123), .B (OpcodeCondIn[7]), .Y (n_166));
  nand2 g8264(.A (n_121), .B (n_27), .Y (n_122));
  nand2 g8267(.A (n_228), .B (n_162), .Y (n_120));
  nor2 g8269(.A (n_75), .B (n_119), .Y (n_213));
  nor2 g8272(.A (\stateSub[2] ), .B (n_118), .Y (n_192));
  nand2 g8273(.A (n_116), .B (n_119), .Y (n_117));
  nand2 g8278(.A (n_66), .B (n_74), .Y (n_115));
  and2 g8280(.A (n_185), .B (n_195), .Y (n_256));
  nand2 g8286(.A (n_71), .B (n_232), .Y (n_114));
  nand2 g8289(.A (n_112), .B (n_228), .Y (n_113));
  nand2 g8291(.A (n_116), .B (\stateSub[1] ), .Y (n_111));
  nand2 g8293(.A (n_185), .B (\stateSub[0] ), .Y (n_131));
  and2 g8294(.A (n_185), .B (n_110), .Y (n_157));
  nand2 g8304(.A (n_116), .B (n_286), .Y (n_109));
  nand2 g8308(.A (n_116), .B (n_78), .Y (n_338));
  nand2 g8251(.A (n_8), .B (n_50), .Y (n_125));
  inv g8265(.A (n_123), .Y (n_108));
  nand2 g8268(.A (n_76), .B (n_119), .Y (n_107));
  nand2 g8274(.A (n_225), .B (n_98), .Y (n_106));
  nand2 g8275(.A (n_45), .B (\state[1] ), .Y (n_105));
  nand2 g8279(.A (n_62), .B (n_24), .Y (n_104));
  nand3 g8282(.A (OpcodeCondIn[7]), .B (n_102), .C (OpcodeCondIn[4]),
       .Y (n_103));
  nand2 g8283(.A (n_100), .B (n_63), .Y (n_101));
  nand2 g8285(.A (n_98), .B (n_33), .Y (n_99));
  nor2 g8287(.A (n_96), .B (n_38), .Y (n_97));
  nand2 g8288(.A (n_79), .B (n_54), .Y (n_95));
  nor2 g8295(.A (n_94), .B (n_67), .Y (n_135));
  nand2 g8296(.A (n_100), .B (n_92), .Y (n_93));
  inv g8297(.A (n_91), .Y (n_147));
  nand2 g8299(.A (\stateSub[2] ), .B (n_41), .Y (n_90));
  nand2 g8300(.A (n_65), .B (n_11), .Y (n_89));
  and2 g8301(.A (n_57), .B (n_182), .Y (n_88));
  nand2 g8302(.A (n_53), .B (n_39), .Y (n_87));
  nand2 g8303(.A (n_68), .B (\state[1] ), .Y (n_86));
  inv g8310(.A (n_84), .Y (n_85));
  inv g8348(.A (n_77), .Y (n_149));
  and2 g8350(.A (n_232), .B (\state[0] ), .Y (n_179));
  nand2 g8359(.A (n_183), .B (OpcodeCondIn[6]), .Y (n_83));
  nor2 g8266(.A (n_210), .B (n_182), .Y (n_123));
  nand2 g8336(.A (n_102), .B (OpcodeCondIn[4]), .Y (n_82));
  nand3 g8276(.A (n_154), .B (n_225), .C (n_162), .Y (n_81));
  nand3 g8281(.A (n_55), .B (n_56), .C (n_37), .Y (n_80));
  and2 g8333(.A (n_286), .B (n_195), .Y (n_261));
  nand3 g8284(.A (n_58), .B (n_30), .C (n_92), .Y (n_128));
  nand3 g8311(.A (n_286), .B (n_79), .C (\stateSub[0] ), .Y (n_84));
  nand3 g8290(.A (n_78), .B (n_110), .C (n_44), .Y (n_353));
  nand3 g8298(.A (n_183), .B (n_137), .C (n_252), .Y (n_91));
  nor2 g8349(.A (n_102), .B (n_36), .Y (n_77));
  inv g8314(.A (n_76), .Y (n_121));
  nor2 g8321(.A (\state[1] ), .B (n_183), .Y (n_75));
  nand2 g8322(.A (n_73), .B (n_72), .Y (n_74));
  nand2 g8324(.A (n_9), .B (n_183), .Y (n_71));
  nand2 g8326(.A (n_232), .B (n_137), .Y (n_70));
  nand2 g8327(.A (n_154), .B (n_223), .Y (n_69));
  inv g8329(.A (n_68), .Y (n_116));
  nand2 g8332(.A (n_170), .B (n_183), .Y (n_118));
  and2 g8342(.A (n_286), .B (\state[0] ), .Y (n_185));
  inv g8343(.A (n_67), .Y (n_228));
  nand2 g8345(.A (n_230), .B (OpcodeCondIn[7]), .Y (n_66));
  nand3 g8346(.A (\state[1] ), .B (n_79), .C (n_119), .Y (n_318));
  nor2 g8351(.A (n_137), .B (n_61), .Y (n_100));
  nand2 g8352(.A (n_21), .B (\stateSub[0] ), .Y (n_65));
  nand2 g8353(.A (n_79), .B (n_29), .Y (n_64));
  nand2 g8355(.A (n_19), .B (n_10), .Y (n_96));
  nand2 g8356(.A (n_31), .B (OpcodeCondIn[7]), .Y (n_63));
  nand2 g8325(.A (n_61), .B (n_170), .Y (n_62));
  nand2 g8360(.A (n_23), .B (OpcodeCondIn[3]), .Y (n_60));
  nand2 g8361(.A (n_58), .B (n_92), .Y (n_59));
  nand2 g8363(.A (n_56), .B (n_55), .Y (n_57));
  nand2 g8339(.A (n_28), .B (n_53), .Y (n_54));
  nand2 g8357(.A (n_79), .B (n_53), .Y (n_52));
  nand2 g8358(.A (n_51), .B (\stateSub[2] ), .Y (n_314));
  scandtype IRQ2_reg(.nReset (nReset), .Clock (Clock), .D (IRQ1), .Q
       (IRQ2), .nQ ());
  nand2 g8270(.A (n_137), .B (n_14), .Y (n_50));
  and2 g8277(.A (n_13), .B (n_146), .Y (n_234));
  nand3 g8305(.A (n_46), .B (n_393), .C (OpcodeCondIn[2]), .Y (n_49));
  nand3 g8309(.A (n_92), .B (n_225), .C (OpcodeCondIn[5]), .Y (n_48));
  nor2 g8312(.A (n_46), .B (OpcodeCondIn[2]), .Y (n_47));
  nor2 g8315(.A (n_79), .B (n_26), .Y (n_76));
  nand2 g8316(.A (n_110), .B (n_44), .Y (n_45));
  nand2 g8319(.A (n_25), .B (OpcodeCondIn[4]), .Y (n_42));
  and2 g8320(.A (n_46), .B (n_146), .Y (n_112));
  nand2 g8323(.A (n_18), .B (OpcodeCondIn[6]), .Y (n_41));
  nand2 g8328(.A (n_79), .B (n_119), .Y (n_40));
  nand2 g8330(.A (n_79), .B (n_195), .Y (n_68));
  nand2 g8331(.A (\stateSub[1] ), .B (n_61), .Y (n_39));
  nand2 g8334(.A (n_170), .B (n_252), .Y (n_98));
  and2 g8340(.A (n_37), .B (n_36), .Y (n_38));
  nand2 g8341(.A (n_78), .B (\state[0] ), .Y (n_35));
  nand2 g8344(.A (n_252), .B (OpcodeCondIn[7]), .Y (n_67));
  nand2 g8347(.A (n_15), .B (n_236), .Y (n_34));
  nand2 g8354(.A (n_12), .B (OpcodeCondIn[4]), .Y (n_33));
  inv g8370(.A (n_61), .Y (n_183));
  inv g8375(.A (n_274), .Y (n_32));
  inv g8391(.A (n_31), .Y (n_102));
  inv g8403(.A (n_30), .Y (n_73));
  inv g8394(.A (n_29), .Y (n_286));
  inv g8401(.A (n_92), .Y (n_154));
  inv g8385(.A (n_236), .Y (n_230));
  inv g8377(.A (n_28), .Y (n_232));
  nor2 g8318(.A (n_6), .B (OpcodeCondIn[2]), .Y (n_210));
  nand2 g8365(.A (n_225), .B (n_0), .Y (n_27));
  nand2 g8367(.A (StatusReg[3]), .B (n_392), .Y (n_55));
  nand2 g8368(.A (StatusReg[2]), .B (n_394), .Y (n_56));
  nand2 g8371(.A (n_223), .B (n_162), .Y (n_61));
  and2 g8372(.A (n_17), .B (OpcodeCondIn[0]), .Y (n_37));
  and2 g8373(.A (n_137), .B (n_44), .Y (n_79));
  nand2 g8378(.A (n_119), .B (n_225), .Y (n_28));
  and2 g8379(.A (n_137), .B (n_225), .Y (n_26));
  inv g8405(.A (n_53), .Y (n_78));
  nand2 g8381(.A (n_170), .B (n_72), .Y (n_25));
  nand2 g8382(.A (\stateSub[2] ), .B (n_162), .Y (n_94));
  nand2 g8384(.A (n_191), .B (OpcodeCondIn[4]), .Y (n_24));
  nand2 g8392(.A (n_72), .B (OpcodeCondIn[6]), .Y (n_31));
  nand2 g8383(.A (n_146), .B (nWait), .Y (n_23));
  nand2 g8393(.A (\state[1] ), .B (n_119), .Y (n_22));
  nand2 g8388(.A (n_119), .B (OpcodeCondIn[3]), .Y (n_21));
  and2 g8399(.A (\stateSub[2] ), .B (n_195), .Y (n_110));
  and2 g8387(.A (n_146), .B (OpcodeCondIn[6]), .Y (n_36));
  nand3 g8338(.A (\state[0] ), .B (\stateSub[2] ), .C (\state[1] ), .Y
       (n_20));
  nand2 g8390(.A (n_223), .B (OpcodeCondIn[6]), .Y (n_19));
  nand2 g8376(.A (n_44), .B (n_225), .Y (n_274));
  nand2 g8389(.A (n_72), .B (OpcodeCondIn[4]), .Y (n_58));
  nand2 g8374(.A (n_17), .B (OpcodeCondIn[7]), .Y (n_18));
  nor2 g8396(.A (n_44), .B (\state[1] ), .Y (n_171));
  nand2 g8404(.A (n_170), .B (OpcodeCondIn[4]), .Y (n_30));
  nand3 g8335(.A (OpcodeCondIn[0]), .B (StatusReg[0]), .C
       (OpcodeCondIn[1]), .Y (n_16));
  nand2 g8398(.A (n_195), .B (OpcodeCondIn[3]), .Y (n_15));
  nor2 g8369(.A (n_17), .B (OpcodeCondIn[0]), .Y (n_46));
  nand2 g8386(.A (n_191), .B (OpcodeCondIn[3]), .Y (n_236));
  nand2 g8402(.A (n_191), .B (OpcodeCondIn[7]), .Y (n_92));
  mux2 g8362(.S (OpcodeCondIn[7]), .I0 (OpcodeCondIn[6]), .I1
       (OpcodeCondIn[1]), .Y (n_14));
  xor2 g8337(.A (OpcodeCondIn[0]), .B (OpcodeCondIn[1]), .Y (n_13));
  scandtype IRQ1_reg(.nReset (nReset), .Clock (Clock), .D (n_1), .Q
       (IRQ1), .nQ ());
  nand2 g8400(.A (n_195), .B (\stateSub[1] ), .Y (n_51));
  inv g8412(.A (n_12), .Y (n_156));
  nand2 g8397(.A (n_225), .B (OpcodeCondIn[4]), .Y (n_11));
  inv g8414(.A (n_10), .Y (n_252));
  nand2 g8380(.A (n_195), .B (n_72), .Y (n_9));
  nand2 g8395(.A (\stateSub[1] ), .B (n_225), .Y (n_29));
  nand2 g8413(.A (OpcodeCondIn[7]), .B (OpcodeCondIn[3]), .Y (n_12));
  nand2 g8406(.A (\state[1] ), .B (\stateSub[1] ), .Y (n_53));
  nand2 g8409(.A (\stateSub[0] ), .B (OpcodeCondIn[2]), .Y (n_8));
  nand2 g8410(.A (\state[0] ), .B (\state[1] ), .Y (n_275));
  and2 g8407(.A (OpcodeCondIn[3]), .B (OpcodeCondIn[2]), .Y (n_7));
  nand2 g8408(.A (OpcodeCondIn[0]), .B (OpcodeCondIn[1]), .Y (n_6));
  nand2 g8411(.A (\stateSub[0] ), .B (OpcodeCondIn[6]), .Y (n_5));
  nand2 g8415(.A (OpcodeCondIn[6]), .B (OpcodeCondIn[3]), .Y (n_10));
  nor2 g8366(.A (OpcodeCondIn[0]), .B (OpcodeCondIn[1]), .Y (n_182));
  inv g8424(.A (OpcodeCondIn[2]), .Y (n_146));
  inv g8425(.A (OpcodeCondIn[6]), .Y (n_191));
  inv g8420(.A (OpcodeCondIn[3]), .Y (n_72));
  inv g8430(.A (nIRQ), .Y (n_1));
  inv g8422(.A (nWait), .Y (n_0));
  inv g8432(.A (OpcodeCondIn[7]), .Y (n_170));
  inv g8429(.A (OpcodeCondIn[5]), .Y (n_162));
  inv g8426(.A (OpcodeCondIn[4]), .Y (n_223));
  inv g8416(.A (OpcodeCondIn[1]), .Y (n_17));
  inv g3(.A (n_395), .Y (n_396));
  nor2 g2(.A (n_219), .B (n_204), .Y (n_395));
  inv g8445(.A (n_397), .Y (n_398));
  nand3 g8446(.A (n_200), .B (n_223), .C (n_210), .Y (n_397));
  buffer rm_assigns_buf_MemEn(.A (ENB), .Y (MemEn));
  buffer rm_assigns_buf_StatusReg_1(.A (CFlag), .Y (StatusReg[1]));
endmodule
