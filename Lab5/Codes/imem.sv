`timescale 1ns / 1ps

module imem ( input logic [5:0] addr, output logic [31:0] instr);

// imem is modeled as a lookup table, a stored-program byte-addressable ROM
	always_comb
	   case ({addr,2'b00})		   	// word-aligned fetch

/*	-------		-----------
	8'h00: instr = 32'h20080005;    // addi $t0, $zero, 5              
    8'h04: instr = 32'h2009000c;    // addi $t1, $zero, 12
    8'h08: instr = 32'h200a0006;    // addi $t2, $zero, 6
    8'h0c: instr = 32'h210bfff7;    // addi $t3, $t0, -9
    8'h10: instr = 32'h01288025;    // or $s0, $t1, $t0
    8'h14: instr = 32'h012a8824;    // and $s1, $t1, $t2
    8'h18: instr = 32'h010b9020;    // add $s2, $t0, $t3
    8'h1c: instr = 32'h010a202a;    // slt $a0, $t0, $t2
    8'h20: instr = 32'h02112820;    // add $a1, $s0, $s1
    8'h24: instr = 32'h02493022;    // sub $a2, $s2, $t1
    8'h28: instr = 32'had320074;    // sw $s2, 0x74($t1)
    8'h2c: instr = 32'h8c020080;    // lw $v0, 0x80($zero)
    */
    
   
        8'h00: instr = 32'h20080005;
        8'h04: instr = 32'h21090007;
        8'h08: instr = 32'h210A0002;
        8'h0c: instr = 32'h012A5025;
        8'h10: instr = 32'h01498024;
        8'h14: instr = 32'h01108820;
        
        8'h18: instr = 32'h20040005; //a0
		8'h1c: instr = 32'h2005000C; //a1
		8'h20: instr = 32'h20060002; //a2
		8'h24: instr = 32'h20040005; //a0
		8'h28: instr = 32'h30A6201E; // sracacc $a0, $a1, $a2
		
    
    
    /*
    8'h00: instr = 32'h20080005;
    8'h04: instr = 32'hAC080060;
    8'h08: instr = 32'h8C090060;
    8'h0c: instr = 32'h212A0004;
    8'h10: instr = 32'h212B0003;
    */
    
    // Branch
    
    /*
    8'h00: instr = 32'h20080003;
    8'h04: instr = 32'h20090003;
    8'h08: instr = 32'h11090003;
    8'h0c: instr = 32'h01285020;
    8'h10: instr = 32'h01094022;
    8'h14: instr = 32'h2129FFFF;
    8'h18: instr = 32'h11280002;
    8'h1c: instr = 32'hAC0A0050;
    8'h20: instr = 32'h01284025;
    */
    
       default:  instr = {32{1'bx}};	// unknown address
	   endcase
endmodule