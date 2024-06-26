`timescale 1ns / 1ps

module control_unit(
			input alu_pcinc,// I - signal from ALU to increment PC (Program Counter)
			input [3:0] pc_odat,// I - PC output data
			input [7:0] mem_dat, alu_data, ir_odat,	// I - memory data, ALU output, IR (Instruction Register) data 
			input [7:0] dec_signal,// I - decoded signal for sequential counter
			input [7:0] dec,// I - opcode decoder
			output [3:0] ctrl_alu,// O - control signals of ALU for operation selection
			output [3:0] ar_idat,// O - AR (Address Register)
			output [7:0] ir_idat, dr_idat, ac_idat,// O - IR (Intruction Reg), DR (Data Reg), AC (Accumulator)
			output ar_we, dr_we, ac_we, pc_inc, ff_en, mem_we   // O - AR Write Enable, DR Write Enable, AC Write Enable, PC Write Enable, EFF Enable, Memory Write Enable
		); 
		
// Based on IR and decoding its 14-13-12 in opcode decoder (D7) 
// Also with using IR(7) which in the book it is stored in I-FF
// We decide and complete the ASM chart of the processor
// An intruction is memory referenced when D7 = 0
// If I = IR(7) = 0 it is used for I/O operations

		wire m_ref_ind = ir_odat[7] & (~dec[7]) & dec_signal[3]; // specifying whether an access is indirect

		wire m_ref = (~dec[7]) & dec_signal[7];
		wire m_alu = (~dec[7]) & dec_signal[5];
		wire m_sta = m_ref & dec[3];
		
		wire r_ref = (~ir_odat[7]) & dec[7] & dec_signal[3];
		wire r_ac = r_ref & (ir_odat[11] | ir_odat[9] | ir_odat[7] | ir_odat[6] | ir_odat[5]);		//reg-ref AC enable

// According to the Book, we set the signals for the registers we have in the Datapath part
// AR (Address Register), PC (Program Counter), DR (Data Register), AC (Accumulator), IR (Instruction Register)
// We have four signals for each register: Clock, Clear (CLR or RESET), INCREMENT (INC or INR), Load (Write Enable or LD)

		assign ar_we = dec_signal[0] | dec_signal[2] | m_ref_ind;
		assign ar_idat = dec_signal[0] ? pc_odat : dec_signal[4] ? ir_odat[7:0] : m_ref_ind ? mem_dat[7:0] : 0;
		assign ir_idat = dec_signal[2] ? mem_dat : 0;	//data stable at t5 dec4
		
		assign dr_we = m_ref && (~dec[3]);
		assign dr_idat = dr_we ? mem_dat : 0;
		assign ac_we = (m_alu | r_ac) & (~m_sta);
		assign ac_idat = ac_we ? alu_data : 0;
		assign ctrl_alu = 	(m_alu && dec[0]) 		? 	3'b000 :
							(m_alu && dec[1])       ?   3'b001 :
							(m_alu && dec[2])       ?   3'b010 : 
							(m_alu && dec[3])       ?   3'b011 : 
							(r_ref && ir_odat[3])   ?   3'b100 :
							(r_ref && ir_odat[2])   ?   3'b101 :
							(r_ref && ir_odat[1])   ?   3'b110 : 
							(r_ref && ir_odat[0])   ?   3'b111 : 3'b111;

		assign mem_we = m_sta;
		
		//E enable
		assign ff_en = (m_alu && dec[1]) | (r_ref && (ir_odat[7] | ir_odat[6] | ir_odat[8] | ir_odat[10]));
		
		//PC INC 11 
		assign pc_inc = (alu_pcinc | dec_signal[1]);
			
endmodule