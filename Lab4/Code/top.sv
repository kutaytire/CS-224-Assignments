`timescale 1ns / 1ps

module top  (

   input  logic 	LeftButton, RightButton, clk
   output logic [6:0]  segment,
   output logic [3:0]  an,
   output logic        dp,
   output logic        memwriteLed);    

   logic [31:0] dataadr, writedata, pc, readdata, instr;
   logic theRight, theLeft;

   
   pulse_controller controlPulse1(clk, LeftButton, theRight, theLeft);
   pulse_controller controlPulse2(clk, RightButton, 1'b0, theRight);
   

   mips mipsModule (theLeft, theRight, pc, instr, memwriteLed, dataadr, writedata, readdata);  
   dmem dmem (theLeft, memwriteLed, dataadr, writedata, readdata);
   imem imem (pc[7:2], instr); 

   display_controller display(clk, pc[7:4], pc[3:0],dataadr[7:4],dataadr[3:0], segment, dp, an);
endmodule
