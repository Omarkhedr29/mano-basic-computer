`timescale 1ns / 1ps

module memory_tb;

reg [7:0] DATA_IN;
reg [3:0] ADDRESS;
reg WRITE_ENABLE;
reg CLOCK;

wire [7:0] DATA_OUT;

memory MEM(CLOCK, WRITE_ENABLE, ADDRESS, DATA_IN, DATA_OUT);

initial begin
    
    CLOCK = 0; 
    
    #10
    DATA_IN = 8'b00000000;
    ADDRESS = 4'b0000;
    WRITE_ENABLE = 1'b0;
    
    #10
    DATA_IN = 8'b10011001;
    ADDRESS = 4'b0000;
    WRITE_ENABLE = 1'b1;
    
    #10
    DATA_IN = 8'b00000000;
    ADDRESS = 4'b0000;
    WRITE_ENABLE = 1'b0;
 
end

always begin
    #5
    CLOCK = !CLOCK;
end

endmodule