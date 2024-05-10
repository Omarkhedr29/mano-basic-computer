`timescale 1ns / 1ps

module main(IR,DR,AC,PC,AR_2,AR_1,clk,timer,E,I,OP,PL,Flag);

	input clk;
	output reg [7:0] IR;
	output reg [7:0] DR;
	output reg [7:0] AC;
	output reg [3:0] PC;
	output reg [3:0] AR_1;
	output reg [3:0] AR_2;
	reg [7:0] MEM [15:0];
	output reg I;
	output reg E;
	output reg PL;
	output reg [2:0] OP;
	output reg [2:0] timer;
	output reg Flag;
	
	initial begin
		timer <= 0;
		Flag <= 0;
		PC <= 0;
		AC <= 8'hff;
		$readmemh("F:\MEMORY.txt",MEM); //in hexadecimal	
	end


	always @(posedge clk)begin 
		
		//start stack overflow
		if (PC  ==  4'h6)begin
			//PC <= 0;
			$finish;
		end
		//end stack overflow
		
		//Start Fetch
		else  if (timer == 0 && PC[0] == 0) begin	
			AR_2 <= PC;
			if(Flag == 0)begin
			     IR <= MEM[PC];
			     Flag = 1;
			end
			PL <= 0; 
			timer <= timer + 1;
		end
		else if (timer == 0 && PC[0] == 1) begin	
			AR_1 <= PC;
			PL <= 1;
			timer <= timer + 1;
		end
		//End fetch
		
		//Start Decode
		else if (timer == 1) begin
			PC <= PC + 1;	
			I  <= IR[7];
			OP <= IR[6:4];
			if(PL == 0)begin
				AR_2 <= IR[3:0];
			end
			else begin //PC[0] == 1
				AR_1 <= IR[3:0];
			end			
			timer <= timer + 1;
		end
		//End Decode

		//Start All instrunctions
		else begin
			if (I == 1)begin // 111 1011	
				if(IR[6] == 1)begin//CLA  1100 0000 C0
					AC <= 0;
				end
				else if(IR[5] == 1)begin//CLE 1010 0000 A0
					E <= 0;
				end
				else if(IR[4] == 1)begin//CMA 1001 0000 90
					AC <= ~AC;
				end
				else if(IR[3] == 1)begin//CME 1000 1000 88
					E <= ~E;
				end
				else if(IR[2] == 1)begin//INC 1000 0100 84
					{E,AC} <= AC + 1;
				end
				else if(IR[1] == 1)begin//SZA 1000 0010 82
					if(AC == 0)begin
						PC <= PC + 1;
					end				
				end
				else if(IR[0] == 1)begin //HLT 1000 0001 81
					$finish;				
				end
				timer <= 0;//commen in all instrunctions
				IR <= MEM[PC];//Fetch of next instrunction
			end	
			
			else begin//I = 0
				//Start seconed Fetch
				if(timer == 2)begin
					IR <= MEM[PC];
				end				
				//End second Fetch
				if(OP == 3'b000) begin //AND 0x
					if(timer == 2 && PL == 0) begin
						DR <= MEM[AR_2]; 
						timer <= timer + 1;							
					end
					else if(timer == 2 && PL == 1)begin
						DR <= MEM[AR_1]; 
						timer <= timer + 1;
					end	
					else if(timer == 3)begin
						AC <= (AC & DR);
						timer <= 0; 
					end
				end
				else if(OP == 3'b001) begin //ADD 1x
					if(timer == 2 && PL == 0) begin
						DR <= MEM[AR_2]; 
						timer <= timer + 1;							
					end
					else if(timer == 2 && PL == 1)begin
						DR <= MEM[AR_1]; 
						timer <= timer + 1;
					end	
					else if(timer == 3)begin
						{E,AC} <= (AC + DR);
						timer <= 0; 
					end
				end		
				else if(OP == 3'b010) begin //LDA 2X
					if(timer == 2 && PL == 0) begin
						DR <= MEM[AR_2]; 
						timer <= timer + 1;							
					end
					else if(timer == 2 && PL == 1)begin
						DR <= MEM[AR_1]; 
						timer <= timer + 1;
					end	
					else if(timer == 3) begin
						AC <= DR;
						timer <= 0; 
					end
				end	
				else if(OP == 3'b011)begin //STA	3x
					if(timer == 2 && PL == 0)begin
						MEM[AR_2] <= AC;
					end
					else if(timer == 2 && PL == 1)begin
						MEM[AR_1] <= AC;
					end
					timer <= 0;
				end
			end	
		end//End All instrunctions
	end
endmodule			

