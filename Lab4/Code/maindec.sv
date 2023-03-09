`timescale 1ns / 1ps

module maindec (input logic[5:0] op, 
	              output logic memtoreg, memwrite, branch,
	              output logic alusrc, regdst, regwrite, jump,
	              output logic[1:0] aluop,
                output logic sracc_sel);
   logic [9:0] controls;

   assign {regwrite, regdst, alusrc, branch, memwrite,
                memtoreg,  aluop, jump, sracc_sel} = controls;

  always_comb
    case(op)
      6'b000000: controls <= 10'b1100001000; // R-type
      6'b100011: controls <= 10'b1010010000; // LW
      6'b101011: controls <= 10'b0010100000; // SW
      6'b000100: controls <= 10'b0001000100; // BEQ
      6'b001000: controls <= 10'b1010000000; // ADDI
      6'b000010: controls <= 10'b0000000010; // J
      6'b001100: controls <= 10'b1100001101; // SRACC
      6'b010100: controls <= 10'b1010000100; // SUBI
      default:   controls <= 10'bxxxxxxxxxx; // illegal op
    endcase
endmodule