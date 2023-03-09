`timescale 1ns / 1ps
module PipeMtoW(input logic clk, reset, MemtoRegM, RegWriteM,
		input logic [31:0] ReadDataM, ALUOutM,
		input logic [4:0] WriteRegM,
		output logic [4:0] WriteRegW,
		output logic [31:0] ReadDataW, ALUOutW,
		output logic MemtoRegW, RegWriteW);

		always_ff @(posedge clk, posedge reset)
		begin
		
			if(reset) begin
				
				MemtoRegW <= 0;
				RegWriteW <= 0;
				ReadDataW <= 0;
				ALUOutW <= 0;
				WriteRegW <= 0;
			end
			else begin 
				
				MemtoRegW <= MemtoRegM;
				RegWriteW <= RegWriteM;
				ReadDataW <= ReadDataM;
				ALUOutW <= ALUOutM;
				WriteRegW <= WriteRegM;
			end
		end           
endmodule