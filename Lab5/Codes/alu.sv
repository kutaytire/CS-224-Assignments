`timescale 1ns / 1ps


module alu(input  logic [31:0] a, b, 
           input  logic [2:0]  alucont, 
           output logic [31:0] result);
    
    always_comb
        case(alucont)
            3'b010: result = a + b;
            3'b011: result = a << b;
            3'b100: result = a >> b;
            3'b110: result = a - b;
            3'b000: result = a & b;
            3'b001: result = a | b;
            3'b111: result = (a < b) ? 1 : 0;
            default: result = {32{1'bx}};
        endcase

endmodule