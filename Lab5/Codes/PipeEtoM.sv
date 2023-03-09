`timescale 1ns / 1ps
module PipeEtoM(input logic clk, reset, MemWriteE, MemtoRegE, RegWriteE, sracc_selE,
		input logic [31:0] ALUOutE, WriteDataE, finalRD3,
		input logic [4:0] WriteRegE,
		output logic [4:0] WriteRegM,
		output logic [31:0] ALUOutM, WriteDataM, finalRD3M,
		output logic MemWriteM, MemtoRegM, RegWriteM, sracc_selM);

	always_ff @(posedge clk, posedge reset) 
	begin

		if(reset) begin
			
			MemWriteM <= 0;
			MemtoRegM <= 0;
			RegWriteM <= 0;
			ALUOutM <= 0;
			WriteDataM <= 0;
			WriteRegM <= 0;
			
			finalRD3M <= 0;
			sracc_selM <= 0;
		end
		else begin

			MemWriteM <= MemWriteE;
			MemtoRegM <= MemtoRegE;
			RegWriteM <= RegWriteE;
			ALUOutM <= ALUOutE;
			WriteDataM <= WriteDataE;
			WriteRegM <= WriteRegE;
			
			finalRD3M <= finalRD3;
			sracc_selM <= sracc_selE;
		end
	end
           
endmodule