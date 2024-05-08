`timescale 1ns / 1ps 

module alu_tb;

reg [7:0] AC;  // Accumulator
reg [7:0] DR;  // Data Register
reg [2:0] code; // signals
reg EI;          // E FF

wire [7:0] DATAOUT;
wire INC;
wire EO;

// duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
localparam period = 20;


ALLLU ALU(AC, DR, code, EI, EO, INC, DATAOUT);


always
begin
    AC = 8'b11111111;
    DR = 8'b10011010;
    code = 3'b000;
    EI = 1'b1;

    #period
    AC = 8'b00000101;
    DR = 8'b00000001;
    code = 3'b001;
    EI = 1'b0;
    
    #period
    AC = 8'b00000001;
    DR = 8'b00010001;
    code = 3'b010;
    EI = 1'b0;

    #period
    AC = 8'b00000001;
    DR = 8'b00100001;
    code = 3'b011;
    EI = 1'b0;

    #period
    AC = 8'b00000001;
    DR = 8'b00001001;
    code = 3'b100;
    EI = 1'b0;

    #period
    AC = 8'b01000001;
    DR = 8'b00001001;
    code = 3'b101;
    EI = 1'b0;

    #period
    AC = 8'b10100001;
    DR = 8'b00001001;
    code = 3'b110;
    EI = 1'b0;

    #period
    AC = 8'b10100001;
    DR = 8'b00001001;
    code = 3'b111;
    EI = 1'b0;

    #period
    AC = 8'b00100001;
    DR = 8'b00001001;
    code = 3'b000;
    EI = 1'b0;

    #period
    AC = 8'b00100001;
    DR = 8'b00001001;
    code = 3'b001;
    EI = 1'b0;

    #period
    AC = 8'b10100001;
    DR = 8'b00001001;
    code = 3'b100;
    EI = 1'b0;

    #period
    AC = 8'b10100001;
    DR = 8'b00001001;
    code = 3'b101;
    EI = 1'b0;
end
    
endmodule