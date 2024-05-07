`timescale 1ns / 1ps

module DFF(D, clock, clear, enable,Q);
		input D;
		input clock;
		input clear;
		input enable;
		output reg Q;
	 
	 always@(posedge clock, posedge clear)
		if(clear) begin
		    Q <= 0;
        end
		else if(enable)begin
			    Q <= D;
        end
endmodule