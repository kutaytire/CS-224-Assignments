`timescale 1ns / 1ps

module controller(input  logic[5:0] op, funct,
                  output logic     memtoreg, memwrite,
                  output logic     alusrc,
                  output logic     regdst, regwrite,
                  output logic[2:0] alucontrol,
                  output logic branch, sracc_sel);

   logic [1:0] aluop;

  maindec md (op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, aluop, sracc_sel);

   aludec  ad (funct, aluop, alucontrol);

endmodule