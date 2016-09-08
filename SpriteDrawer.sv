/*module SpriteDrawer(input clk, input reset,
				input logic[640*8-1:0] line,
				input logic[9:0] xPos, input logic[8:0] yPos, input display,
				// GPU things
				input logic[23:0] backgroundColor,
				output logic[7:0] red, green, blue);*/
				
				// Sprite table format
				// sprite type (4 bits), x pos (10 bits), y pos (9 bits), width (10 bits), height (9 bits), BGR (24 bits), address (20 bits), unused(2 bits - for byte boundary) = 88 bits
				// low bit to high bit
				// sprite type (0:3), x pos (4:13), y pos (14:22), width (23:32), height (33:41), blue (42:49), green (50:57), red (58:65), address(66:85), unused(86:87)
				
				/*
					sprite list:
					0 - none
					1 - fill rectangle
					2 - stroke rectangle (address = stroke width)
				*/
				
				// Internal cached table
				//logic[5631:0] spriteTable;
				//logic[88:0] sprite;
				//logic[8*64:0] redSprite, greenSprite, blueSprite;
				/*logic[7:0] spriteSel;
				
				always_comb begin
					spriteSel = line[(xPos*8) +: 8];
					if (spriteSel == -8'b1) begin
						red <= backgroundColor[23:16];
						green <= backgroundColor[15:8];
						blue <= backgroundColor[7:0];
					end else begin
						red <= spriteTable[(spriteSel*88)+58 +: 8];
						green <= spriteTable[(spriteSel*88)+50 +: 8];
						blue <= spriteTable[(spriteSel*88)+42 +: 8];
					end
				end*/
				
				/*always_ff @ (posedge clk or posedge reset) begin
					if (reset) begin
						spriteTable = 5632'b0;
						//redSprite = 0;
						//greenSprite = 0;
						//blueSprite = 0;
						//spriteSel = -8'b1;
					end else begin
						// Cache at the beginning of each frame (so there are no artifacts)
						if (xPos == 0 && yPos == 0)
							spriteTable <= sprites;
					end
				end*/
				
			/*	logic[7:0] tempSpriteSel;
				always_comb begin
						// Copy over sprite colors
						for (int z = 0; z < 4; z++) begin
							redSprite[(z*8)+:8] <= spriteTable[((z*88)+58)+:8];
							greenSprite[(z*8)+:8] <= spriteTable[((z*88)+50)+:8];
							blueSprite[(z*8)+:8] <= spriteTable[((z*88)+42)+:8];
						end
						
						tempSpriteSel = -8'b1;
						for (int z = 0; z < 4; z++) begin
								unique case (spriteTable[((z*8)+0) +: 3])
									4'd1: begin
										// Fill rectangle
										if (spriteTable[((z*88)+4)+:10] <= xPos && (spriteTable[((z*88)+4)+:10] + spriteTable[((z*88)+23)+:10]) >= xPos &&
											spriteTable[((z*88)+14)+:9] <= yPos && (spriteTable[((z*88)+14)+:9] + spriteTable[((z*88)+33)+:9]) >= yPos) begin
											tempSpriteSel = 8'(z);
										end
									end
									4'd2: begin
										// Stroke rectangle (strokeWidth(75:66))
										if (
											// Left side
											(spriteTable[((z*88)+4)+:10] <= xPos && (spriteTable[((z*88)+4)+:10] + spriteTable[((z*88)+66)+:10]) >= xPos &&
											spriteTable[((z*88)+14)+:9] <= yPos && (spriteTable[((z*88)+14)+:9] + spriteTable[((z*88)+33)+:9]) >= yPos) ||
											// Right side
											(spriteTable[((z*88)+4)+:10] + spriteTable[((z*88)+23)+:10] - spriteTable[((z*88)+66)+:10] <= xPos && (spriteTable[((z*88)+4)+:10] + spriteTable[((z*88)+23)+:10]) >= xPos &&
											spriteTable[((z*88)+14)+:9] <= yPos && (spriteTable[((z*88)+14)+:9] + spriteTable[((z*88)+33)+:9]) >= yPos) ||
											// Up side
											(spriteTable[((z*88)+4)+:10] <= xPos && (spriteTable[((z*88)+4)+:10] + spriteTable[((z*88)+23)+:10]) >= xPos &&
											spriteTable[((z*88)+14)+:9] <= yPos && (spriteTable[((z*88)+14)+:9] + spriteTable[((z*88)+66)+:10]) >= yPos) ||
											// Down side
											(spriteTable[((z*88)+4)+:10] <= xPos && (spriteTable[((z*88)+4)+:10] + spriteTable[((z*88)+23)+:10]) >= xPos &&
											spriteTable[((z*88)+14)+:9] + spriteTable[((z*88)+33)+:9] - spriteTable[((z*88)+66)+:10] <= yPos && (spriteTable[((z*88)+14)+:9] + spriteTable[((z*88)+33)+:9]) >= yPos)) begin
											tempSpriteSel = 8'(z);
										end
									end
									4'd3: begin
										// Fill rounded rectangle (radius(75:66))
										if (spriteTable[((z*88)+4)+:10] <= xPos && (spriteTable[((z*88)+4)+:10] + spriteTable[((z*88)+23)+:10]) >= xPos &&
											spriteTable[((z*88)+14)+:9] <= yPos && (spriteTable[((z*88)+14)+:9] + spriteTable[((z*88)+33)+:9]) >= yPos) begin
											// In the basic rectangle
											// Check if it is on the edges
											
											// Top Left edge
											if (spriteTable[((z*88)+4)+:10] <= xPos && (spriteTable[((z*8)+4)+:10] + spriteTable[((z*88)+66)+:10]) >= xPos &&
												spriteTable[((z*88)+14)+:9] <= yPos && (spriteTable[((z*88)+14)+:9] + spriteTable[((z*88)+66)+:10]) >= yPos) begin
													//if ((((spriteTable[((z*88)+4)+:10] + spriteTable[((z*88)+66)+:10]) - xPos) * ((spriteTable[((z*88)+4)+:10] + spriteTable[((z*88)+66)+:10]) - xPos) +
													//		((spriteTable[((z*88)+14)+:9] + spriteTable[((z*88)+66)+:10]) - yPos) * ((spriteTable[((z*88)+14)+:9] + spriteTable[((z*88)+66)+:10])) - yPos) <=
													//		spriteTable[((z*88)+66)+:10] * spriteTable[((z*88)+66)+:10]) begin
													//		spriteSel = 8'(z);
													//end
											// Top Right Edge
											end else if (spriteTable[((z*88)+4)+:10] + spriteTable[((z*88)+23)+:10] - spriteTable[((z*88)+66)+:10] <= xPos && (spriteTable[((z*88)+4)+:10] + spriteTable[((z*88)+23)+:10]) >= xPos &&
												spriteTable[((z*88)+14)+:9] <= yPos && (spriteTable[((z*88)+14)+:9] + spriteTable[((z*88)+66)+:10]) >= yPos) begin
											// Bottom Left Edge
											end else if (spriteTable[((z*88)+4)+:10] <= xPos && (spriteTable[((z*88)+4)+:10] + spriteTable[((z*88)+66)+:10]) >= xPos &&
												spriteTable[((z*88)+14)+:9] + spriteTable[((z*88)+33)+:9] - spriteTable[((z*88)+66)+:10] <= yPos && (spriteTable[((z*88)+14)+:9] + spriteTable[((z*88)+33)+:9]) >= yPos) begin
											// Bottom Right Edge
											end else if (spriteTable[((z*88)+4)+:10] + spriteTable[((z*88)+23)+:10] - spriteTable[((z*88)+66)+:10] <= xPos && (spriteTable[((z*88)+4)+:10] + spriteTable[((z*88)+23)+:10]) >= xPos &&
												spriteTable[((z*88)+14)+:9] + spriteTable[((z*88)+33)+:9] - spriteTable[((z*88)+66)+:10] <= yPos && (spriteTable[((z*88)+14)+:9] + spriteTable[((z*88)+33)+:9]) >= yPos) begin
											end else begin	// Normal rectangle
												spriteSel = 8'(z);
											end
										end
									end
									default: begin
										// None
									end
								endcase
						end
						spriteSel = tempSpriteSel;
				end*/
				
//endmodule
