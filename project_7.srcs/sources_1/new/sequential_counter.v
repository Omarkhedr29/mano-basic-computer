
`timescale 1ns / 1ps 

module sequential_counter(clock,enable,reset,out);
    input clock;
    input enable;
    input reset;
    output reg[3:0] out;
	
	always@(posedge clock, posedge reset)
		if(reset)
			out <= 0;
		else if(enable)
			out <= out + 1;

endmodule