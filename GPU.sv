module GPU(input clk, input reset,
				input logic[31:0] instruction, input logic run, input logic isSpriteData,
				output logic ready,
				output logic[5631:0] sprites,
				output logic[23:0] backgroundColor);
				
				
				enum logic[4:0] { WAIT,						// Do nothing state
										SPRITE_CLEAR, SPRITE,// Upload sprite data
										EXECUTE,					// Execute current instruction
										DONE						// Done with action, wait for run to be reset
									} state, next_state;
				
				/* Opcode is low 4 bits of instruction
					Opcode:
						0 - NOP
						1 - Set Background Color (color = top 24 bits of instruction (RGB))
						2 - Set Sprite Address (address = top 20 bits of instruction)
				*/
				
				// Internals
				logic[19:0] spriteAddress;
				
				
				always_ff @ (posedge clk or posedge reset) begin
					if (reset) begin
						backgroundColor <= 24'h000000;	// Black
						sprites <= 5632'b0;
						spriteAddress <= 20'b0;
						ready <= 1'b0;
						
						state <= WAIT;
					end else begin
						unique case (state)
							WAIT: begin
								ready <= 1'b1;
							end
							
							SPRITE_CLEAR: begin
								sprites <= sprites & (-5632'b1 ^ (32'hFFFFFFFF << spriteAddress));
								
								ready <= 1'b0;
							end
							SPRITE: begin
								// Upload data
								sprites = sprites | (instruction << spriteAddress);
								// Auto increment
								spriteAddress = spriteAddress + 20'd32;
								
								ready <= 1'b0;
							end
							
							EXECUTE: begin
								unique case (instruction[3:0])
									// Set background color (color = top 24 bits of instruction (RGB))
									4'h1:	begin
										backgroundColor <= instruction[31:8];
									end
									// Set sprite address (address = top 20 bits of instruction)
									4'h2: begin
										spriteAddress <= instruction[31:12];
									end
									// NOP
									default: begin
									end
								endcase
								
								ready <= 1'b0;
							end
							
							DONE: begin
								ready <= 1'b0;
							end
						endcase
						
						state = next_state;
					end
				end
				
				// Next state table
				always_comb begin
					if (reset) begin
						next_state <= WAIT;
					end else begin
						next_state = state;
						unique case (state)
							WAIT: begin
								next_state <= run ? (isSpriteData ? SPRITE_CLEAR : EXECUTE) : WAIT;
							end
							SPRITE_CLEAR: begin
								next_state <= SPRITE;
							end
							SPRITE: begin
								next_state <= DONE;
							end
							EXECUTE: begin
								next_state <= DONE;
							end
							DONE: begin
								next_state <= run ? DONE : WAIT;
							end
						endcase
					end
				end
				
endmodule
