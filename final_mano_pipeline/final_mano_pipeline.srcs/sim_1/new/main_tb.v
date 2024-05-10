//TESTBENCH

`timescale 1ns/1ps

module main_tb();

	reg clk;
	wire [7:0] IR;
	wire [7:0] DR;
	wire [7:0] AC;
	wire [3:0] PC;
	wire [3:0] AR_1;
	wire [3:0] AR_2;
	wire [2:0] timer;
	wire E;
	wire I;
	wire PL;
	wire [2:0] OP;
	wire Flag;
	
			// instantiate device under test
	main dut(IR,DR,AC,PC,AR_2,AR_1,clk,timer,E,I,OP,PL,Flag);

	always begin
		clk = 0; 
			#5; 
		clk = 1; 
		    #5;
	end

	endmodule