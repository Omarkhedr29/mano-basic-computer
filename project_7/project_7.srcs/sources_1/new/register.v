
`timescale 1ns / 1ps

module register(increment_signal,write_enable,clear,clock,input_data,output_data);

	input increment_signal; 
	input write_enable;
    input clear;
	input clock;
    input [7:0] input_data;
	output [7:0] output_data;
	reg [7:0] data;
	
	always@(posedge clock, posedge clear)
		if(write_enable)
			data <= input_data;
		else if(clear)
			data <= 0;
		else if(increment_signal)
			data <= data + 1;
	assign output_data = data;
endmodule