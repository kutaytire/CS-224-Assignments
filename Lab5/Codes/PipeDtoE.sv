`timescale 1ns / 1ps
module PipeDtoE(input logic[31:0] RD1, RD2, RD3, SignImmD,
                input logic[4:0] RsD, RtD, RdD,
                input logic RegWriteD, MemtoRegD, MemWriteD, ALUSrcD, RegDstD, sracc_selD,
                input logic[2:0] ALUControlD,
                input logic clear, clk, reset,
                output logic[31:0] RsData, RtData, SignImmE, RD3E,
                output logic[4:0] RsE, RtE, RdE, 
                output logic RegWriteE, MemtoRegE, MemWriteE, ALUSrcE, RegDstE, sracc_selE,
                output logic[2:0] ALUControlE);

        always_ff @(posedge clk, posedge reset)
          if(reset || clear)
                begin
                // Control signals
                RegWriteE <= 0;
                MemtoRegE <= 0;
                MemWriteE <= 0;
                ALUControlE <= 0;
                ALUSrcE <= 0;
                RegDstE <= 0;
                
                // Data
                RsData <= 0;
                RtData <= 0;
                RsE <= 0;
                RtE <= 0;
                RdE <= 0;
                SignImmE <= 0;
                
                RD3E <= 0;
                sracc_selE <= 0;
                end
            else
                begin
                // Control signals
                RegWriteE <= RegWriteD;
                MemtoRegE <= MemtoRegD;
                MemWriteE <= MemWriteD;
                ALUControlE <= ALUControlD;
                ALUSrcE <= ALUSrcD;
                RegDstE <= RegDstD;
                
                // Data
                RsData <= RD1;
                RtData <= RD2;
                RsE <= RsD;
                RtE <= RtD;
                RdE <= RdD;
                SignImmE <= SignImmD;
                
                RD3E <= RD3;
                sracc_selE <= sracc_selD;
                end

endmodule