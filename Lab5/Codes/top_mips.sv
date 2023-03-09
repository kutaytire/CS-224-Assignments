`timescale 1ns / 1ps

module top_mips (input  logic        clk, reset,
             output  logic[31:0]  instrF,
             output logic[31:0] PC, PCF,
             output logic PcSrcD,
             output logic MemWriteD, MemtoRegD, ALUSrcD, BranchD, RegDstD, RegWriteD,
             output logic [2:0]  alucontrol,
             output logic [31:0] instrD, 
             output logic [31:0] ALUOutE, WriteDataE,
             output logic [1:0] ForwardAE, ForwardBE, ForwardCE,
             output logic ForwardAD, ForwardBD);

       logic sracc_selD;
	// ********************************************************************
	// Below, instantiate a controller and a datapath with their new (if modified) signatures
	// and corresponding connections.
	// ********************************************************************

		controller cont(instrD[31:26], instrD[5:0], MemtoRegD, MemWriteD, ALUSrcD, RegDstD, RegWriteD, alucontrol, BranchD, sracc_selD);
		
		datapath dp(sracc_selD, clk, reset, alucontrol, RegWriteD, MemtoRegD, MemWriteD, ALUSrcD, RegDstD, BranchD, instrF, instrD, PC, PCF, PcSrcD,
		ALUOutE, WriteDataE, ForwardAE, ForwardBE, ForwardCE, ForwardAD, ForwardBD);
endmodule
