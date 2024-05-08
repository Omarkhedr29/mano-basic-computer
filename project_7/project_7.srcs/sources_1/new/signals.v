`timescale 1ns / 1ps 

module signals(reset, clock, enable,dec_signal);
	
	input reset;
	input clock;
	input enable;
	output [7:0] dec_signal;
    wire [3:0] sc_signal;
	 
	sequential_counter SC (clock, enable, reset, sc_signal);	
	decoder_3x8 DEC (sc_signal, dec_signal);

endmodule