`timescale 1ns / 1ps 

module signals_tb;

reg RESET;
reg CLOCK;
reg ENABLE;

wire[7:0] OUT_SIGNALS;

signals SIG(RESET, CLOCK, ENABLE, OUT_SIGNALS);

initial
begin
    CLOCK = 0;

    RESET = 1;
    ENABLE = 1;

    #20
    RESET = 0;
    ENABLE = 1;
end

always
begin
    #10
    CLOCK = !CLOCK;    
end

endmodule