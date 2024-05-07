`timescale 1ns / 1ps

module decoder_3x8(in_data,out_data);
    
    input [2 : 0] in_data;
    output [7 : 0] out_data;
    reg [7 : 0] tmp_reg;
    
    always@*
		case(in_data)
			3'h0 : tmp_reg <= 8'h01;
			3'h1 : tmp_reg <= 8'h02;
			3'h2 : tmp_reg <= 8'h04;
			3'h3 : tmp_reg <= 8'h08;
			3'h4 : tmp_reg <= 8'h10;
			3'h5 : tmp_reg <= 8'h20;
			3'h6 : tmp_reg <= 8'h40;
			3'h7 : tmp_reg <= 8'h80;
			endcase
	assign out_data = tmp_reg;
endmodule