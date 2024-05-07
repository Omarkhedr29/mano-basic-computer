
`timescale 1ns / 1ps

module memory(clock,write_enable,address,input_data,output_data);
    input clock;
    input write_enable; // clock signal, signal for enabling writing
    input [3 : 0] address; // address of the desired word
	input [7 : 0] input_data; // input data for store in the memory
    output reg [7 : 0] output_data; // output data of the memory
	reg [7 : 0] read_memory [15 : 0]; // our memory 4096 cells

    initial begin // filling our memory with instructions		
		$readmemh("D:\VPU_mem.txt", read_memory, 0, 15);
	end
	
	// This memory is synchronous with the clock - working just on positive edges
	always@(posedge clock)begin
		// writes data if only the write enable signal is set to one
		if(write_enable)begin
			read_memory[address] <= input_data;
		end
		// Otherwise, it is considered that a word is needed to be read
		output_data <= read_memory[address];
		end

endmodule