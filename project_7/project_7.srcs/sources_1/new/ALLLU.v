

`timescale 1ns / 1ps

module ALLLU(AC,DR,code,EI,EO,INC,data);
	
	input [7:0] AC;
	input [7:0] DR;
	input [2:0] code;
	input EI;		// EI -> input from E-FF
	output EO; 		// EO -> output to 	E-FF
	output INC;		// signal for detecting performing increment on PC (Program Counter)
	output [7:0] data;
	reg [7:0] TMP = 0;
	
	 always@* // build the sensitivity list for all inputs
		case(code)

			4'b000 : TMP <= AC & DR; 	// AND
			4'b001 : TMP <= AC + DR; 	// ADD
			4'b010 : TMP <= DR;		// LDA
			4'b011 : TMP <= DR;		// STA
			4'b110 : TMP <= 0;			// CLA
			4'b011 : TMP <= ~AC;		// CMA
			4'b100 : TMP <= 0;			// CLE
			4'b101 : TMP <= ~EI;		// CME
			default : TMP <= 17'bz;		// high impedance because no arithmetic operation is needed
 		
		endcase

	 assign data = TMP[7:0];
	 
endmodule