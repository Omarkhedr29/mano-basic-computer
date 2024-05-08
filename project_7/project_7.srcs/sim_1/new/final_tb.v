`timescale 1ns / 1ps 

module final_tb;

	reg clk = 1'b0;
    reg reset = 1'b0;
    reg en = 1'b0;
    wire [7:0] ac_data;
    wire [3:0] pc_data;
    wire [3:0] ar_data;
    wire [7:0] ir_data;
    wire [7:0] dr_data;
    wire [7:0] dc_sgnl;
    wire [7:0] mem_dat;
    wire [3:0] sc_dat;
  

    initial begin
        
        forever
        begin
            clk = 1'b0;
            #(100) 
            clk = 1'b1;
            #(100);
        end
    end

    datapath_with_control_unit UUT(
        .clk(clk),
        .reset(reset),
        .en(en),
        .ac_data(ac_data),
        .pc_data(pc_data),
		.ar_data(ar_data),
		.ir_data(ir_data),
		.dr_data(dr_data),
		.dc_sgnl(dc_sgnl),
		.mem_data(mem_dat),
		.sc_dat(sc_dat)
        );
		/*
        .alu_pcinc(pcinc),
		.mem_dat(mem_dat),
		.ar_we(ar_we),
		.dr_we(dr_we),
		.ac_we(ac_we),
		.pc_inc(pc_inc),
		.ff_en(ff_en),
		.mem_we(mem_we),
		.ctrl_alu(ctrl_alu),
		.alu_data(data),
		.dec(dec_opcode)
		*/

    initial begin

        #100;
        reset = 1'b1;
        // -------------------------------------
        // -------------  Current Time:  185ns
        #100;
        reset = 1'b0;
        en = 1'b1;

    end

endmodule