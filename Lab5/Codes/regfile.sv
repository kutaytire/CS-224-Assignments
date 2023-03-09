`timescale 1ns / 1ps

module regfile (input    logic clk, reset, we3, 
                input    logic[4:0]  ra1, ra2, ra3, wa3, 
                input    logic[31:0] wd3, 
                output   logic[31:0] rd1, rd2, rd3);

  logic [31:0] rf [31:0];

  // three ported register file: read two ports combinationally
  // write third port on falling edge of clock. Register0 hardwired to 0.

  always_ff @(negedge clk)
     if (we3) 
         rf [wa3] <= wd3;
  	 else if(reset)
       for (int i=0; i<32; i++) rf[i] = {32{1'b0}};	

  assign rd1 = (ra1 != 0) ? rf [ra1] : 0;
  assign rd2 = (ra2 != 0) ? rf[ ra2] : 0;
  assign rd3 = (ra3 != 0) ? rf[ ra3] : 0;

endmodule
