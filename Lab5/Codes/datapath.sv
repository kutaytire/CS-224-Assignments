`timescale 1ns / 1ps

module datapath (input  logic sracc_selD,clk, reset,
                input  logic[2:0]  ALUControlD,
                input logic RegWriteD, MemtoRegD, MemWriteD, ALUSrcD, RegDstD, BranchD,
                 output logic [31:0] instrF,		
                 output logic [31:0] instrD, PC, PCF,
                output logic PcSrcD,                 
                output logic [31:0] ALUOutE, WriteDataE,
                output logic [1:0] ForwardAE, ForwardBE, ForwardCE,
                 output logic ForwardAD, ForwardBD); // Add or remove input-outputs if necessary

	// ********************************************************************
	// Here, define the wires that are needed inside this pipelined datapath module
	// ********************************************************************
  
  	//* We have defined a few wires for you
    	logic [31:0] PcSrcA, PcSrcB, PcBranchD, PcPlus4F;	
  	logic StallF;
  
	//* You should define others down below

	logic StallD, sracc_selE, sracc_selM;
	logic [31:0] PcPlus4D, SignImmD, SignImmDShifted, ResultW, RD1D, RD2D, RD1DFinal, RD2DFinal,RD1E, RD2E, SignImmE, SrcAE, SrcBE, ReadDataM;
	logic [31:0] ALUOutM, WriteDataM, ReadDataW, ALUOutW, RD3D, RD3E, finalRD3, addedALU, finalALU, finalRD3M;
	logic [4:0] rsD, rtD, rdD, WriteRegW, WriteRegE, WriteRegM, rsE, rtE, rdE; 
	logic RegWriteW, FlushE, RegWriteE, MemtoRegE, MemWriteE, ALUSrcE, RegDstE;
	logic RegWriteM, MemtoRegM, MemWriteM, MemtoRegW; 
	logic [2:0] ALUControlE;

  
  
	// ********************************************************************
	// Instantiate the required modules below in the order of the datapath flow.
	// ********************************************************************

  
  	//* We have provided you with some part of the datapath
    
  	// Instantiate PipeWtoF
  	PipeWtoF pipe1(PC,
                ~StallF, clk, reset,
                PCF);
  
  	// Do some operations
    	assign PcPlus4F = PCF + 4;
    	assign PcSrcB = PcBranchD;
	assign PcSrcA = PcPlus4F;
  	mux2 #(32) pc_mux(PcSrcA, PcSrcB, PcSrcD, PC);

    imem im1(PCF[7:2], instrF);
    
  	// Instantiate PipeFtoD

	PipeFtoD secondPipe(instrF, PcPlus4F, ~StallD, PcSrcD, clk, reset, instrD, PcPlus4D); 
  
  	// Do some operations

	assign rsD = instrD[25:21];
	assign rtD = instrD[20:16];
	assign rdD = instrD[15:11];

	signext extend(instrD[15:0], SignImmD);
	sl2 shifter(SignImmD, SignImmDShifted);

	adder findPC(SignImmDShifted, PcPlus4D, PcBranchD);

	regfile registerFile (clk, reset, RegWriteW, instrD[25:21], instrD[20:16], instrD[15:11], WriteRegW, ResultW, RD1D, RD2D, RD3D);

	mux2 #(32) muxForRD1(RD1D, ALUOutM, ForwardAD, RD1DFinal);
	mux2 #(32) muxForRD2(RD2D, ALUOutM, ForwardBD, RD2DFinal);

	assign PcSrcD = (RD1DFinal == RD2DFinal) & BranchD;
	
  
  	// Instantiate PipeDtoE

	PipeDtoE thirdPipe(RD1D, RD2D, RD3D, SignImmD, rsD, rtD, rdD, RegWriteD, MemtoRegD, MemWriteD, ALUSrcD, RegDstD, sracc_selD, ALUControlD, FlushE, clk, reset,
	RD1E, RD2E, SignImmE, RD3E, rsE, rtE, rdE, RegWriteE, MemtoRegE, MemWriteE, ALUSrcE, RegDstE, sracc_selE, ALUControlE);

  
  
  	// Do some operations

	mux2 #(5) writeRegMux(rtE, rdE, RegDstE, WriteRegE);
	mux2 #(32) ALUmux(WriteDataE, SignImmE, ALUSrcE, SrcBE);

	mux4 #(32) writeDataMux(RD2E, ResultW, finalALU, 0, ForwardBE, WriteDataE);
	mux4 #(32) SrcAmux(RD1E, ResultW, finalALU, 0, ForwardAE, SrcAE);
	mux4 #(32) rdregmux (RD3E, ResultW, finalALU, 0, ForwardCE, finalRD3);

	alu ALU(SrcAE, SrcBE, ALUControlE, ALUOutE);

  	// Instantiate PipeEtoM

	PipeEtoM fourthPipe(clk, reset, MemWriteE, MemtoRegE, RegWriteE, sracc_selE, ALUOutE, WriteDataE, finalRD3, WriteRegE, WriteRegM, 
	ALUOutM, WriteDataM, finalRD3M, MemWriteM, MemtoRegM, RegWriteM, sracc_selM);
  
  	// Do some operations

    adder addALU(finalRD3M, ALUOutM, addedALU);
	dmem dataMemory(clk, MemWriteM, ALUOutM, WriteDataM, ReadDataM);
	
	mux2 #(32) ALUChooseMux(ALUOutM, addedALU, sracc_selM, finalALU);

  	// Instantiate PipeMtoW

	PipeMtoW fifthPipe(clk, reset, MemtoRegM, RegWriteM, ReadDataM, finalALU, WriteRegM, WriteRegW, ReadDataW, ALUOutW, MemtoRegW, RegWriteW);
  
  	// Do some operations

	mux2 #(32) resultMux(ALUOutW, ReadDataW, MemtoRegW, ResultW);

	HazardUnit hzrunt(RegWriteW, BranchD, WriteRegW, WriteRegE, RegWriteM, MemtoRegM, WriteRegM, RegWriteE, MemtoRegE, rsE, rtE, rdE, rsD, rtD, rdD, ForwardAE, ForwardBE, ForwardCE, FlushE, StallD,
	StallF, ForwardAD, ForwardBD);

endmodule
