`timescale 1ns / 1ps
module HazardUnit( input logic RegWriteW, BranchD,
                input logic [4:0] WriteRegW, WriteRegE,
                input logic RegWriteM,MemtoRegM,
                input logic [4:0] WriteRegM,
                input logic RegWriteE,MemtoRegE,
                input logic [4:0] rsE,rtE,rdE,
                input logic [4:0] rsD,rtD, rdD,
                output logic [1:0] ForwardAE,ForwardBE, ForwardCE,
                output logic FlushE,StallD,StallF,ForwardAD, ForwardBD
                 ); // Add or remove input-outputs if necessary
       
	// ********************************************************************
	// Here, write equations for the Hazard Logic.
	// If you have troubles, please study pages ~420-430 in your book.
	// ********************************************************************
  
		
		logic lwstall, branchstall;
		always_comb begin

			if((rsE != 2'b00000) & rsE == WriteRegM & RegWriteM) begin

				ForwardAE = 2'b10; 
			end
			else if((rsE != 2'b00000) & rsE == WriteRegW & RegWriteW) begin
				
				ForwardAE = 2'b01;
			end
			else 
				
				ForwardAE = 2'b00;

			///////////////////////////////////////////////////////////////////////////////

			if((rtE != 2'b00000) & rtE == WriteRegM & RegWriteM) begin

				ForwardBE = 2'b10; 
			end
			else if((rtE != 2'b00000) & rtE == WriteRegW & RegWriteW) begin
				
				ForwardBE = 2'b01;
			end
			else 
				
				ForwardBE = 2'b00;

			///////////////////////////////////////////////////////////////////////////////
			
			if((rdE != 2'b00000) & rdE == WriteRegM & RegWriteM) begin

				ForwardCE = 2'b10; 
			end
			else if((rdE != 2'b00000) & rdE == WriteRegW & RegWriteW) begin
				
				ForwardCE = 2'b01;
			end
			else 
				
				ForwardCE = 2'b00;

			///////////////////////////////////////////////////////////////////////////////

			lwstall = ((rsD == rtE) | (rtD == rtE)) & MemtoRegE;
			branchstall = (BranchD & RegWriteE & (WriteRegE == rsD | WriteRegE == rtD)) |  (BranchD & MemtoRegM & (WriteRegM == rsD | WriteRegM == rtD));
			
			FlushE <= lwstall | branchstall;
			StallD <= lwstall | branchstall;
			StallF <= lwstall | branchstall;
			
			///////////////////////////////////////////////////////////////////////////////
			
			ForwardAD = (rsD != 0) & (rsD == WriteRegM) & RegWriteM;
			ForwardBD = (rtD != 0) & (rtD == WriteRegM) & RegWriteM;
			
		end
				

endmodule