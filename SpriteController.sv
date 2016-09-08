module SpriteController(input clk, input reset,
								input start,
								input logic[9:0] xPos, input logic[8:0] yPos,
								input logic[5631:0] sprites, input logic[23:0] backgroundColor,
								output logic[7:0] red, green, blue,
								input logic[15:0] sramData,
								output logic[19:0] sramAddress);
								
								logic[5631:0] spriteTable;
								logic[1:0] drawIn, draw;
								
								logic[7:0] redSpriteIn, greenSpriteIn, blueSpriteIn,
										redSprite, greenSprite, blueSprite;
								logic[19:0] addressIn, address;
								logic sramClock;
								logic[15:0] tempData;
								logic addressType, addressTypeIn;
								
								always_comb begin
									if (draw == 2'b0) begin
										red <= backgroundColor[23:16];
										green <= backgroundColor[15:8];
										blue <= backgroundColor[7:0];
									end else if (draw == 2'b1) begin
										red <= redSprite;
										green <= greenSprite;
										blue <= blueSprite;
									end else begin
										if (addressType) begin
											blue <= tempData[15:8];
											green <= sramData[7:0];
											red <= sramData[15:8];
										end else begin
											blue <= tempData[7:0];
											green <= tempData[15:8];
											red <= sramData[7:0];
										end
									end
								end
								
								enum logic[2:0] { WAIT,
														CALC
														} state, next_state;
								
								SpriteCalculator16 sp(.sTable(spriteTable), .xPos(xPos), .yPos(yPos),
									.drawIn(drawIn), .inRed(redSpriteIn), .inGreen(greenSpriteIn), .inBlue(blueSpriteIn), .addressIn(addressIn), .addressTypeIn(addressTypeIn),
									.draw(draw), .red(redSprite), .green(greenSprite), .blue(blueSprite), .address(address), .addressType(addressType));
									
								always_comb begin
									sramAddress <= sramClock ? address : (address + 1'b1);
								end
								
								always_ff @ (posedge clk or posedge reset) begin
									if (reset) begin
										state = WAIT;
										
										redSpriteIn <= 0;
										greenSpriteIn <= 0;
										blueSpriteIn <= 0;
										
										drawIn <= 0;
										
										addressIn <= 0;
										addressTypeIn <= 0;
										
										sramClock <= 0;
										tempData <= 0;
										sramClock <= 0;					
									end else begin
										state = next_state;
										unique case (state)
											WAIT: begin
												spriteTable <= sprites;
												
												redSpriteIn <= 0;
												greenSpriteIn <= 0;
												blueSpriteIn <= 0;
																						
												drawIn <= 0;
												
												addressIn <= 0;
												addressTypeIn <= 0;
												
												sramClock <= 0;
											end
											CALC: begin
												sramClock <= 1'b1;
												tempData <= sramData;
											end
										endcase
									end
								end
								
								always_comb begin
									if (reset) begin
										next_state = WAIT;
									end else begin
										next_state = state;
										unique case (state)
											WAIT: begin
												next_state <= CALC;
											end
											CALC: begin
												next_state <= WAIT;
											end
										endcase
									end
								end
								
endmodule
