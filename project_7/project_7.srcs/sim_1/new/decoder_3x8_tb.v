`timescale 1ns / 1ps

module decoder_3x8_tb;
    
    reg [2:0] IN_DATA;
    wire [7:0] OUT_DATA;
    
    decoder_3x8 DEC(IN_DATA,OUT_DATA);
    
    initial begin
        IN_DATA = 3'b000;
        #10
        IN_DATA = 3'b001;
        #10
        IN_DATA = 3'b010;
        #10
        IN_DATA = 3'b011;
        #10
        IN_DATA = 3'b100;
        #10
        IN_DATA = 3'b101;
        #10
        IN_DATA = 3'b110;
        #10
        IN_DATA = 3'b111;   
        #10
        $finish;
    end



endmodule