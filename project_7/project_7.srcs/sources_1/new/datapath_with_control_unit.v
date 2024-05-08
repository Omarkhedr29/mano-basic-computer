`timescale 1ns / 100ps 

module datapath_with_control_unit(
		input clk, reset, en,
		output [7:0] ac_data, ir_data, dr_data,
					 dc_sgnl,mem_data,
		output [3:0] pc_data, ar_data, sc_dat
    );
	 	 
	 wire ar_we, ar_inc;	 
	 wire [3:0] ar_idat, ar_odat; 
	 wire pc_we, pc_inc;	 
	 wire [3:0] pc_idat, pc_odat;
	 wire ir_inc;	 
	 wire [7:0] ir_idat, ir_odat;
	 wire ac_we, ac_inc;	 
	 wire [7:0] ac_idat, ac_odat;
	 wire dr_we, dr_inc;	 
	 wire [7:0] dr_idat, dr_odat;
	 
	 wire [7:0] mem_dat;		//memory
	 wire mem_we;
	 
	 wire [7:0] dec_signal;	//decoders
	 wire [7:0] sec_signal;	
	 wire [7:0] dec_opcode;
	 
	 wire [7:0] data;			//alu var
	 wire [3:0] ctrl_alu;
	 wire ei, eo, pcinc;
	 
	 wire ff_en;				//E var
        
     wire [3:0] sc_data;   
	 //memory
	 memory rom  (.clock(clk), .address(ar_odat), .write_enable(mem_we), .input_data(ac_odat), .output_data(mem_dat));
	  
     //seq counter & decoder
	 signals sig (.reset(reset), .clock(clk), .dec_signal(dec_signal), .enable(en));
     //
     sequential_counter sec (.reset(reset), .clock(clk), .out(sec_signal), .enable(en));
     //registers
	 register ar (.write_enable(ar_we), .increment_signal(ar_inc), .clear(reset), .input_data(ar_idat), .output_data(ar_odat), .clock(clk));
	 register pc (.write_enable(pc_we), .increment_signal(pc_inc), .clear(reset), .input_data(pc_idat), .output_data(pc_odat), .clock(clk));
	 register ir (.write_enable(dec_signal[1]), .increment_signal(ir_inc), .clear(reset), .input_data(ir_idat), .output_data(ir_odat), .clock(clk));
	 register dr (.write_enable(dr_we), .increment_signal(dr_inc), .clear(reset), .input_data(dr_idat), .output_data(dr_odat), .clock(clk));
	 register ac (.write_enable(ac_we), .increment_signal(ac_inc), .clear(reset), .input_data(ac_idat), .output_data(ac_odat), .clock(clk));
    
     // ALU Unit
	 ALLLU ALU_unit (.AC(ac_odat), .DR(dr_odat), .code(ctrl_alu), .EI(ei), .EO(eo), .INC(pcinc), .data(data));

     // E Flip Flop
	 DFF E (.clock(clk), .D(eo), .Q(ei), .clear(reset), .enable(ff_en));

     // opcode decoder
	 opcode_decoder decode_ir (.opcode(ir_odat[6:4]), .decoded_signal(dec_opcode));
	 
     // Control Unit
	 control_unit control (
						.alu_pcinc(pcinc),
						.dec_signal(sec_signal),
						.ar_idat(ar_idat),
						.ir_idat(ir_idat),
						.dr_idat(dr_idat),
						.ac_idat(ac_idat),
						.mem_dat(mem_dat),
						.pc_odat(pc_odat),
						.ir_odat(ir_odat),
						.ar_we(ar_we),
						.dr_we(dr_we),
						.ac_we(ac_we),
						.pc_inc(pc_inc),
						.ff_en(ff_en),
						.mem_we(mem_we),
						.ctrl_alu(ctrl_alu),
						.alu_data(data),
						.dec(dec_opcode)
					  );

	  
	 
	 assign ac_data = ac_odat;	  
	 assign pc_data = pc_odat;
	 assign ar_data = ar_odat;
	 assign ir_data = ir_odat;
	 assign dr_data = dr_odat;
	 assign dc_sgnl = dec_signal; 
	 assign mem_data = mem_dat;
	 assign sc_dat = sec_signal;
	 
endmodule