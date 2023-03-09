`timescale 1ns / 1ps
module PipeFtoD(input logic[31:0] instr, PcPlus4F,
                input logic EN, clear, clk, reset,
                output logic[31:0] instrD, PcPlus4D);

                always_ff @(posedge clk, posedge reset)
                  if(reset)
                        begin
                        instrD <= 0;
                        PcPlus4D <= 0;
                        end
                    else if(EN)
                        begin
                          if(clear) // Can clear only if the pipe is enabled, that is, if it is not stalling.
                            begin
                        	   instrD <= 0;
                        	   PcPlus4D <= 0;
                            end
                          else
                            begin
                        		instrD<=instr;
                        		PcPlus4D<=PcPlus4F;
                            end
                        end
                
endmodule