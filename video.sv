module video(input CLOCK_50, input [3:0] KEY,
				output logic [6:0] HEX0, output logic [6:0] HEX1, output logic [6:0] HEX2, output logic [6:0] HEX3, output logic [6:0] HEX4, output logic [6:0] HEX5, output logic [6:0] HEX6, output logic [6:0] HEX7,
				input logic [15:0] SW,
						// VGA Interface 
                  output [7:0]   VGA_R,					// VGA Red
											VGA_G,					// VGA Green
											VGA_B,					// VGA Blue
						output         VGA_CLK,					// VGA Clock
							            VGA_SYNC_N,				// VGA Sync signal
											VGA_BLANK_N,			// VGA Blank signal
											VGA_VS,					// VGA virtical sync signal	
											VGA_HS,					// VGA horizontal sync signal
						// SRAM
						output logic [19:0] SRAM_ADDR,		// SRAM Address 20 bits
						inout wire [15:0] SRAM_DQ,				// SRAM Data 16 bits
						output logic SRAM_UB_N,					// SRAM Upper Byte enable (active low)
						output logic SRAM_LB_N,					// SRAM Lower Byte enable (active low)
						output logic SRAM_CE_N, 				// SRAM Chip Enable (active low)
						output logic SRAM_OE_N,					// SRAM Output Enable (active low)
						output logic SRAM_WE_N,					// SRAM Write Enable (active low)
						// SDRAM
						output [12:0] DRAM_ADDR,				// SDRAM Address 13 Bits
						inout [31:0]  DRAM_DQ,				// SDRAM Data 32 Bits
						output [1:0]  DRAM_BA,				// SDRAM Bank Address 2 Bits
						output [3:0]  DRAM_DQM,				// SDRAM Data Mast 4 Bits
						output			 DRAM_RAS_N,			// SDRAM Row Address Strobe
						output			 DRAM_CAS_N,			// SDRAM Column Address Strobe
						output			 DRAM_CKE,				// SDRAM Clock Enable
						output			 DRAM_WE_N,				// SDRAM Write Enable
						output			 DRAM_CS_N,				// SDRAM Chip Select
						output			 DRAM_CLK				// SDRAM Clock
						);
						
						
						// Create the NIOS system
						logic [31:0] GPUInstruction;
						logic GPURun, GPUReady, GPUSprite, vga_vs;
						nios nios2 (
							.clk_clk(CLOCK_50),
							.gpu_instruction_export(GPUInstruction),
							.gpu_run_export(GPURun),
							.gpu_ready_export(GPUReady),
							.gpu_sprite_export(GPUSprite),
							.reset_reset_n(KEY[0]),
							.sdram_clk_clk(DRAM_CLK),
							.sdram_wire_addr(DRAM_ADDR),
							.sdram_wire_ba(DRAM_BA),
							.sdram_wire_cas_n(DRAM_CAS_N),
							.sdram_wire_cke(DRAM_CKE),
							.sdram_wire_cs_n(DRAM_CS_N),
							.sdram_wire_dq(DRAM_DQ),
							.sdram_wire_dqm(DRAM_DQM),
							.sdram_wire_ras_n(DRAM_RAS_N),
							.sdram_wire_we_n(DRAM_WE_N),
							.vga_vsync_export(vga_vs)
						);
						
						logic [9:0] xPos;
						logic [8:0] yPos;
						logic waitFrame;
						vga_controller vga(.Clk(CLOCK_50), .Reset(~KEY[0]),
								.hs(VGA_HS), .vs(VGA_VS), .pixel_clk(VGA_CLK), .blank(VGA_BLANK_N), .sync(VGA_SYNC_N),
								.DrawX(xPos), .DrawY(yPos), .update(vga_vs), .waitFrame(waitFrame));
						
						logic [5631:0] sprites;
						logic [23:0] backgroundColor;
						GPU gpu(.clk(CLOCK_50), .reset(~KEY[0]),
							.instruction(GPUInstruction), .run(GPURun), .isSpriteData(GPUSprite),
							.ready(GPUReady),
							.sprites(sprites),
							.backgroundColor(backgroundColor));
						
						logic[19:0] sramAddress;
						logic[15:0] sramData;
						sram_io sram(.clk(CLOCK_50), .address(sramAddress), .addressOut(SRAM_ADDR),
							.dataIn(15'b0), .dataOutHW(sramData), .dataOut(SRAM_DQ),
							.write(1'b0), .enable(1'b1),
							.UB(SRAM_UB_N), .LB(SRAM_LB_N), .CE(SRAM_CE_N), .OE(SRAM_OE_N), .WE(SRAM_WE_N));
						
						SpriteController controller(.clk(CLOCK_50), .reset(~KEY[0]),
							.start(~VGA_CLK), .xPos(xPos), .yPos(yPos),
							.sprites(sprites), .backgroundColor(backgroundColor),
							.red(VGA_R), .green(VGA_G), .blue(VGA_B),
							.sramData(sramData), .sramAddress(sramAddress));
						
						/*SpriteDrawer spriteDrawer(.clk(CLOCK_50), .reset(~KEY[0]),
							.sprites(sprites), .xPos(xPos), .yPos(yPos), .display(VGA_BLANK_N),
							.backgroundColor(backgroundColor),
							.red(VGA_R), .green(VGA_G), .blue(VGA_B));*/
							
						/*HexDriver hex0(spriteSel[3:0], HEX0);
						HexDriver hex1(spriteSel[7:4], HEX1);*/

endmodule
