// stimulus file Datapath_slice_stim.sv for Datapath_slice
// created by ext2svmod 5.5

module Datapath_slice_stim;

timeunit 1ns;
timeprecision 10ps;

logic Clock, nReset;
wire SysBus;							//Global Bus
logic DR_SysBus;
logic Imm;							//Left inputs (DataIn ignored)
logic PcIncCin, LrSel, LrWe, LrEn, PcWe, PcEn;			//Pc_slice related
logic [2:0] PcSel;
wire PcIncCout; 
logic WdSel; 							//Datapath_slice unique
logic [7:0] Rw, Rs1, Rs2;					//regBlock_slice related
logic Op1Sel;							//Datapath_slice unique
logic [1:0] Op2Sel;
logic ZeroA, SUB, CIn_Slice, nZ_prev, FAOut, AND, OR, XOR, NOT, NAND, NOR;	//ALUSlice related (CIn ignored)
logic ShB, ShL, Sh8H_L, Sh4D_L, Sh2C_L, Sh1_L_In, Sh8, ShR, Sh8H_R, Sh4, Sh4C_R, Sh2, Sh2B_R, Sh1, Sh1_R_in, ShOut, AluOut; 
wire COut, Sum, nZ, A, Sh8Z_L, Sh4Z_L, Sh2A_L, Sh1_L_Out, Sh8Z_R, Sh4Y_R, Sh2Z_R, Sh1_R_Out; 

Datapath_slice ds(
	.A ( A ),
	.COut ( COut ),
	.nZ ( nZ ),
	.PcIncCout ( PcIncCout ),
	.Sh1_L_Out ( Sh1_L_Out ),
	.Sh1_R_Out ( Sh1_R_Out ),
	.Sh2A_L ( Sh2A_L ),
	.Sh2Z_R ( Sh2Z_R ),
	.Sh4Y_R ( Sh4Y_R ),
	.Sh4Z_L ( Sh4Z_L ),
	.Sh8Z_L ( Sh8Z_L ),
	.Sh8Z_R ( Sh8Z_R ),
	.Sum ( Sum ),
	.SysBus ( SysBus ),
	.AluOut ( AluOut ),
	.AND ( AND ),
	.CIn_Slice ( CIn_Slice ),
	.FAOut ( FAOut ),
	.Imm ( Imm ),
	.LrEn ( LrEn ),
	.LrSel ( LrSel ),
	.LrWe ( LrWe ),
	.NAND ( NAND ),
	.NOR ( NOR ),
	.NOT ( NOT ),
	.nZ_prev ( nZ_prev ),
	.Op1Sel ( Op1Sel ),
	.Op2Sel ( Op2Sel ),
	.OR ( OR ),
	.PcEn ( PcEn ),
	.PcIncCin ( PcIncCin ),
	.PcSel ( PcSel ),
	.PcWe ( PcWe ),
	.Rs1 ( Rs1 ),
	.Rs2 ( Rs2 ),
	.Rw ( Rw ),
	.Sh1 ( Sh1 ),
	.Sh1_L_In ( Sh1_L_In ),
	.Sh1_R_in ( Sh1_R_in ),
	.Sh2 ( Sh2 ),
	.Sh2B_R ( Sh2B_R ),
	.Sh2C_L ( Sh2C_L ),
	.Sh4 ( Sh4 ),
	.Sh4C_R ( Sh4C_R ),
	.Sh4D_L ( Sh4D_L ),
	.Sh8 ( Sh8 ),
	.Sh8H_L ( Sh8H_L ),
	.Sh8H_R ( Sh8H_R ),
	.ShB ( ShB ),
	.ShL ( ShL ),
	.ShOut ( ShOut ),
	.ShR ( ShR ),
	.SUB ( SUB ),
	.WdSel ( WdSel ),
	.XOR ( XOR ),
	.ZeroA ( ZeroA ),
	.Clock ( Clock ),
	.nReset ( nReset )
	);

//Prevent directly driving bus
assign SysBus = DR_SysBus; 

int errors;

// stimulus information follows
initial
  begin
    errors = 0; 
    //Globals
    Imm = 0; DR_SysBus = 0; Clock = 0; nReset = 1;
    //Pc_slice
    PcIncCin = 0; LrSel = 0; LrWe = 0; LrEn = 0; PcWe = 0; PcEn = 0; PcSel = 0;
    //Datapath_slice unique (sectionA)
    WdSel = 0;
    //regBlock_slice
    Rw = 0; Rs1 = 0; Rs2 = 0;
    //Datapath_slice unique (sectionB)
    Op1Sel = 0; Op2Sel = 0;
    //ALUSlice
    ZeroA = 0; SUB = 0; nZ_prev = 0; FAOut = 0; AND = 0; OR = 0; XOR = 0; NOT = 0; NAND = 0; NOR = 0;
    ShB = 0; ShL = 0; Sh8H_L = 0; Sh4D_L = 0; Sh2C_L = 0; Sh1_L_In = 0; Sh8 = 0; ShR = 0; Sh8H_R = 0; Sh4 = 0; Sh4C_R = 0; Sh2 = 0; Sh2B_R = 0; Sh1 = 0; Sh1_R_in = 0; ShOut = 0; 
    AluOut = 0;

    //Reset Registers
    #500 nReset = 0;
    #500 nReset = 1;
    //Only Testing Unique sections as sub-modules are tested already and just extended to top/bottom
    //Section A
	$display("Starting Section A Tests");
	$display("Sel | AluOut SysBus | WData");
	$display("    |  (0)    (1)   |      ");
    #500 $display(" %b  |   %b      %b    |   %b", WdSel, AluOut, SysBus, ds.WData);
	assert(ds.WData == AluOut) else begin $display("ERROR:WData - %b, %b", ds.WData, AluOut); errors++; end
    #500 AluOut = 1;
    #500 $display(" %b  |   %b      %b    |   %b", WdSel, AluOut, SysBus, ds.WData);
	 assert(ds.WData == AluOut) else begin $display("ERROR:WData - %b, %b", ds.WData, AluOut); errors++; end
    #500 WdSel = 1;
    #500 $display(" %b  |   %b      %b    |   %b", WdSel, AluOut, SysBus, ds.WData);
	 assert(ds.WData == SysBus) else begin $display("ERROR:WData - %b, %b", ds.WData, DR_SysBus); errors++; end
    #500 DR_SysBus = 1;
    #500 $display(" %b  |   %b      %b    |   %b", WdSel, AluOut, SysBus, ds.WData);
	 assert(ds.WData == SysBus) else begin $display("ERROR:WData - %b, %b", ds.WData, DR_SysBus); errors++; end
    //Section B
	$display("Starting Section B Tests");
	$display("Op1 Op2 | Rd1 Pc  Imm Rd2  0  | A B ");
	$display("        | (0) (1) (0) (1) (2) |     ");
    #500 Rw = 8'b00000001; Rs1 = 8'b00000001; Rs2 = 8'b00000001;
    #500 Clock = 1;
	 $display("Clock->high: WData = %b regs = %b, Rw = %b", ds.WData, ds.Regs, Rw);
    #500 Clock = 0;
	 $display("Clock->low: WData = %b regs = %b, Rw = %b", ds.WData, ds.Regs, Rw);
    //#500 assert(ds.Regs == ds.WData) else begin $display("ERROR: Regs not written"); errors++; end
    #500 $display(" %d   %d  |  %b   %b   %b   %b      | %b %b ", Op1Sel, Op2Sel, ds.Rd1, ds.Pc, ds.Imm, ds.Rd2, A, ds.B);
	 assert(A == ds.RD1) else begin $display("ERROR: A, Op1Sel=0"); errors++; end
    #500 Op1Sel = 1;
    #500 $display(" %d   %d  |  %b   %b   %b   %b      | %b %b ", Op1Sel, Op2Sel, ds.Rd1, ds.Pc, ds.Imm, ds.Rd2, A, ds.B);
	 assert(A == ds.Pc) else begin $display("ERROR: A, Op1Sel=1"); errors++; end
	 assert(ds.B == ds.Imm) else begin $display("ERROR: B, Op2Sel=0"); errors++; end
    #500 Op2Sel = 1;
    #500 $display(" %d   %d  |  %b   %b   %b   %b      | %b %b ", Op1Sel, Op2Sel, ds.Rd1, ds.Pc, ds.Imm, ds.Rd2, A, ds.B);
	 assert(ds.B == ds.RD2) else begin $display("ERROR: B, Op2Sel=1"); errors++; end
    #500 Op2Sel = 2;
    #500 $display(" %d   %d  |  %b   %b   %b   %b      | %b %b ", Op1Sel, Op2Sel, ds.Rd1, ds.Pc, ds.Imm, ds.Rd2, A, ds.B);
	 assert(ds.B == 0) else begin $display("ERROR: B, Op2Sel=2"); errors++; end
    #500 Op2Sel = 3; 
    #500 $display(" %d   %d  |  %b   %b   %b   %b      | %b %b ", Op1Sel, Op2Sel, ds.Rd1, ds.Pc, ds.Imm, ds.Rd2, A, ds.B);
	 assert(ds.B == 0) else begin $display("ERROR: B, Op2Sel=3"); errors++; end

    #500 if(errors == 0)
		$display("Simulation PASSED");
	else
		$display("Simulation FAILED");
    $finish;
  end

//SIMVISION SCRIPT:Datapath_slice.tcl

endmodule
