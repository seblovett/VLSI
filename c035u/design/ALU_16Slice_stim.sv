// stimulus file ALU_16Slice_stim.sv for ALU_16Slice
// created by ext2svmod 5.5

module ALU_16Slice_stim;

timeunit 1ns;
timeprecision 10ps;

logic Clock, nReset, Test;					//Globals
wire SDO; 

logic [15:0] A, B;						//Data Inputs
logic CIn, SUB, ZeroA, FAOut;					//Arith Control Inputs
logic AND, OR, XOR, NOT, NAND, NOR;				//Logic Control Inputs
logic Sign, ShSignIn, Sh1, Sh2, Sh4, Sh8, ShB, ShL, ShR, ShOut;	//Logic Control Inputs
logic LLI;							//LLI Control Input
logic ALUEnable; 						//Output Enable

wire [15:0] ALUOut;						//Main Data Output
wire CIn_Slice, COut, nZ, Sum;					//Flag Outputs

ALU_16Slice a(
	.ALUOut ( ALUOut ),
	.CIn_Slice ( CIn_Slice ),
	.COut ( COut ),
	.nZ ( nZ ),
	.SDO ( SDO ),
	.Sum ( Sum ),
	.A ( A ),
	.ALUEnable ( ALUEnable ),
	.AND ( AND ),
	.B ( B ),
	.CIn ( CIn ),
	.Clock ( Clock ),
	.FAOut ( FAOut ),
	.LLI ( LLI ),
	.NAND ( NAND ),
	.NOR ( NOR ),
	.NOT ( NOT ),
	.nReset ( nReset ),
	.OR ( OR ),
	.Sh1 ( Sh1 ),
	.Sh2 ( Sh2 ),
	.Sh4 ( Sh4 ),
	.Sh8 ( Sh8 ),
	.ShB ( ShB ),
	.ShL ( ShL ),
	.ShOut ( ShOut ),
	.ShR ( ShR ),
	.ShSignIn ( ShSignIn ),
	.Sign ( Sign ),
	.SUB ( SUB ),
	.Test ( Test ),
	.XOR ( XOR ),
	.ZeroA ( ZeroA )
	);

// stimulus information follows

initial
  begin
    A = 0; B = 0;
    CIn = 0; SUB = 0; ZeroA = 0; FAOut = 0;
    AND = 0; OR = 0; XOR = 0; NOT = 0; NAND = 0; NOR = 0;
    Sign = 0; ShSignIn = 0; Sh1 = 0; Sh2 = 0; Sh4 = 0; Sh8 = 0; ShB = 0; ShL = 0; ShR = 0; ShOut = 0;
    LLI = 0;
    ALUEnable = 0;

    //Arithmetic Testing
	$write("This ALU Module does not include a decoder\n\n");
	$write("===Arithmetic Testing===\n");
	$write("    A    B           ALUOut\n");
    #50 A = 16328; B = 9000;
    //#50 assert(ALUOut == 16'bz); $display("%b;\n", ALUOut);
    #50 ALUEnable = 1;
    //#50 assert(ALUOut == 16'bz); $display("%b;\n", ALUOut);
    #50 FAOut = 1; $write("%5d + %5d      = ", A, B);
    #50 $write("%5d", ALUOut); $write("   FLAGS: CIn = %b, COut = %b, nZ = %b, Sum = %b\n", CIn_Slice, COut, nZ, Sum);
	assert(ALUOut == (A+B));
	assert(nZ == ~(ALUOut == 0));
	assert(Sum == ALUOut[15]);
    #50 CIn = 1; $write("%5d + %5d +  %b = ", A, B, CIn);
    #50 $write("%5d", ALUOut); $write("   FLAGS: CIn = %b, COut = %b, nZ = %b, Sum = %b\n", CIn_Slice, COut, nZ, Sum);
	assert(ALUOut == (A+B+CIn));
	assert(nZ == ~(ALUOut == 0));
	assert(Sum == ALUOut[15]);
    #50 SUB = 1; $write("%5d - %5d - ~%b = ", A, B, CIn);
    #50 $write("%5d", ALUOut); $write("   FLAGS: CIn = %b, COut = %b, nZ = %b, Sum = %b\n", CIn_Slice, COut, nZ, Sum);
	if (A < B)
		assert(ALUOut == (A-B)+65536);
	else
		assert(ALUOut == (A-B));
	assert(nZ == ~(ALUOut == 0));
	assert(Sum == ALUOut[15]);
    #50 CIn = 0; $write("%5d - %5d - ~0 = ", A, B);
    #50 $write("%5d", ALUOut); $write("   FLAGS: CIn = %b, COut = %b, nZ = %b, Sum = %b\n", CIn_Slice, COut, nZ, Sum);
	if (A < B)
		assert(ALUOut == (A-B-1+65536));
	else
		assert(ALUOut == (A-B-1));
	assert(nZ == ~(ALUOut == 0));
	assert(Sum == ALUOut[15]);
    #50 ZeroA = 1; $write("    0 - %5d - ~0 = ", B);
    #50 $write("%5d", ALUOut); $write("   FLAGS: CIn = %b, COut = %b, nZ = %b, Sum = %b\n", CIn_Slice, COut, nZ, Sum);
	assert(ALUOut == 16'd56535); //MANUALLY CHANGE
	assert(nZ == ~(ALUOut == 0));
	assert(Sum == ALUOut[15]);
    #50 SUB = 0; $write("    0 + %5d      = ", B);
    #50 $write("%5d", ALUOut); $write("   FLAGS: CIn = %b, COut = %b, nZ = %b, Sum = %b\n", CIn_Slice, COut, nZ, Sum);
	assert(ALUOut == B);
	assert(nZ == ~(ALUOut == 0));
	assert(Sum == ALUOut[15]);

    //Logical Testing
	$write("===Logical Testing===\n");
	$write("               A      B                  ALUOut\n");
    #50 FAOut = 0; AND = 1;
    #50 $display("%b AND  %b = %b   ", A, B, ALUOut); assert(ALUOut == (A&B)); //fails for unknown reason (output is correct)
    #50 AND = 0; OR = 1;
    #50 $display("%b OR   %b = %b   ", A, B, ALUOut); assert(ALUOut == A|B);
    #50 OR = 0; XOR = 1;
    #50 $display("%b XOR  %b = %b   ", A, B, ALUOut); assert(ALUOut == A^B);
    #50 XOR = 0; NOT = 1;
    #50 $display("                 NOT  %b = %b   ", A, ALUOut); assert(ALUOut == ~A);
    #50 NOT = 0; NAND = 1;
    #50 $display("%b NAND %b = %b   ", A, B, ALUOut); assert(ALUOut == ~(A&B));
    #50 NAND = 0; NOR = 1;
    #50 $display("%b NOR  %b = %b   ", A, B, ALUOut); assert(ALUOut == ~(A|B));

    //Shifting Testing
	$write("===Shifting Testing===\n");
	$write("               A       ALUOut\n");
    #50 NOR = 0; ShOut = 1;
    #50 $display("%b NS  = %b        ", A, ALUOut); assert(ALUOut == A);
    #50 ShL = 1;
    #50 $display("%b LS0 = %b       ", A, ALUOut); assert(ALUOut == A);
    #50 Sh1 = 1;
    #50 $display("%b LS1 = %b       ", A, ALUOut); assert(ALUOut == A<<1);
    #50 Sh2 = 1;
    #50 $display("%b LS3 = %b       ", A, ALUOut); assert(ALUOut == A<<3);
    #50 Sh4 = 1; Sh2 = 0; Sh1 = 0;
    #50 $display("%b LS4 = %b       ", A, ALUOut); assert(ALUOut == A<<4);
    #50 Sh4 = 1; Sh2 = 0; Sh1 = 1;
    #50 $display("%b LS5 = %b       ", A, ALUOut); assert(ALUOut == A<<5);
    #50 Sh4 = 1; Sh2 = 1; Sh1 = 0;
    #50 $display("%b LS6 = %b       ", A, ALUOut); assert(ALUOut == A<<6);
    #50 Sh4 = 1; Sh2 = 1; Sh1 = 1;
    #50 $display("%b LS7 = %b       ", A, ALUOut); assert(ALUOut == A<<7);
    #50 Sh8 = 1;
    #50 $display("%b LS15 = %b      ", A, ALUOut); assert(ALUOut == A<<15);
    #50 ShL = 0; ShR = 1;
    #50 $display("%b RS15 = %b      ", A, ALUOut); assert(ALUOut == A>>15);
    #50 ShB = 1;
    #50 $display("%b RS15(B) = %b   ", B, ALUOut); assert(ALUOut == B>>15);
    #50 ShSignIn = 1;
    #50 $display("%b ARS15_1(B) = %b", B, ALUOut); assert(ALUOut == 16'b1111111111111110);
    #50 B = -23;
    #50 $display("%b ARS15_1(B) = %b", B, ALUOut); assert(ALUOut == 16'b1111111111111111);
    #50 ShSignIn = 0;
    #50 $display("%b RS15(B) = %b   ", B, ALUOut); assert(ALUOut == 16'b0000000000000001);
    #50 Sh8 = 1; Sh4 = 0; Sh2 = 0; Sh1 = 0;
    #50 $display("%b RS8(B) = %b    ", B, ALUOut); assert(ALUOut == (B>>8));
    #50 B = 8; Sh8 = 1; Sh4 = 0; Sh2 = 0; Sh1 = 0; ShL = 1; ShR = 0; 
	$write("                    A                 B    ALUOut\n");
    #50 $display("LUI: %b, %b -> %b ", A, B, ALUOut); assert(ALUOut == {B[7:0], 8'b0});

    //LLI Testing
	$write("===LLI Module Testing===\n");
	$write("                    A                 B    ALUOut\n");
    #50 ShOut = 1; LLI = 1; Sh1 = 0; Sh2 = 0; Sh4 = 0; Sh8 = 0; ShL = 0; ShR = 0; ShB = 0; 
    #50 $display("LLI: %b, %b -> %b", A, B, ALUOut); assert(ALUOut == {A[15:8],B[7:0]});
    #50 B = 67;
    #50 $display("LLI: %b, %b -> %b", A, B, ALUOut); assert(ALUOut == {A[15:8],B[7:0]});

    #50 $finish;

  end

//SIMVISION SCRIPT:ALU_16Slice.tcl

endmodule
