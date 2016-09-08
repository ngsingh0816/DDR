module SpriteCalculator(input logic[87:0] sTable, input logic[9:0] xPos, input logic[8:0] yPos,
								input logic[1:0] drawIn, input logic[7:0] inRed, inGreen, inBlue, input logic[19:0] addressIn, input logic addressTypeIn,
								output logic[1:0] draw, output logic[7:0] red, green, blue, output logic[19:0] address, output logic addressType);
								
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
				
				always_comb begin	
					draw = drawIn;
					red = inRed;
					green = inGreen;
					blue = inBlue;
					address = addressIn;
					addressType = addressTypeIn;
					
					unique case (sTable[3:0])
						4'd1: begin
							// Fill rectangle
							if (sTable[13:4] <= xPos && (sTable[13:4] + sTable[32:23]) > xPos &&
								sTable[22:14] <= yPos && (sTable[22:14] + sTable[41:33]) > yPos) begin
								draw <= 1'b1;
								red <= sTable[65:58];
								green <= sTable[57:50];
								blue <= sTable[49:42];
							end
						end
						4'd2: begin
							// Stroke rectangle (strokeWidth(75:66))
							if (
								// Left side
								(sTable[13:4] <= xPos && (sTable[13:4] + sTable[75:66]) >= xPos &&
								sTable[22:14] <= yPos && (sTable[22:14] + sTable[41:33]) >= yPos) ||
								// Right side
								(sTable[13:4] + sTable[32:23] - sTable[75:66] <= xPos && (sTable[13:4] + sTable[32:23]) >= xPos &&
								sTable[22:14] <= yPos && (sTable[22:14] + sTable[41:33]) >= yPos) ||
								// Up side
								(sTable[13:4] <= xPos && (sTable[13:4] + sTable[32:23]) >= xPos &&
								sTable[22:14] <= yPos && (sTable[22:14] + sTable[75:66]) >= yPos) ||
								// Down side
								(sTable[13:4] <= xPos && (sTable[13:4] + sTable[32:23]) >= xPos &&
								sTable[22:14] + sTable[41:33] - sTable[75:66] <= yPos && (sTable[22:14] + sTable[41:33]) >= yPos)) begin
								draw <= 1'b1;
								red <= sTable[65:58];
								green <= sTable[57:50];
								blue <= sTable[49:42];
							end
						end
						4'd3: begin
							if (sTable[13:4] <= xPos && (sTable[13:4] + sTable[32:23]) > xPos &&
								sTable[22:14] <= yPos && (sTable[22:14] + sTable[41:33]) > yPos) begin
								draw[1] <= 1'b1;
								red <= sTable[65:58];
								green <= sTable[57:50];
								blue <= sTable[49:42];
								{ draw[0], address } = 21'((32'((sTable[32:23]) * 32'((yPos - sTable[22:14]))) + xPos - sTable[13:4]) * 3);
								addressType = address[0];
								address = sTable[85:66] + { draw[0], 19'(address >> 1) };
							end
						end
						/*4'd4: begin
							// Fill rounded rectangle (radius(75:66))
							if (spriteTable[((spriteIndex*88)+4)+:10] <= xPos && (spriteTable[((spriteIndex*88)+4)+:10] + spriteTable[((spriteIndex*88)+23)+:10]) >= xPos &&
								spriteTable[((spriteIndex*88)+14)+:9] <= yPos && (spriteTable[((spriteIndex*88)+14)+:9] + spriteTable[((spriteIndex*88)+33)+:9]) >= yPos) begin
								// In the basic rectangle
								// Check if it is on the edges
								
								// Top Left edge
								if (spriteTable[((spriteIndex*88)+4)+:10] <= xPos && (spriteTable[((spriteIndex*8)+4)+:10] + spriteTable[((spriteIndex*88)+66)+:10]) >= xPos &&
									spriteTable[((spriteIndex*88)+14)+:9] <= yPos && (spriteTable[((spriteIndex*88)+14)+:9] + spriteTable[((spriteIndex*88)+66)+:10]) >= yPos) begin
										//if ((((spriteTable[((spriteIndex*88)+4)+:10] + spriteTable[((spriteIndex*88)+66)+:10]) - xPos) * ((spriteTable[((spriteIndex*88)+4)+:10] + spriteTable[((spriteIndex*88)+66)+:10]) - xPos) +
										//		((spriteTable[((spriteIndex*88)+14)+:9] + spriteTable[((spriteIndex*88)+66)+:10]) - yPos) * ((spriteTable[((spriteIndex*88)+14)+:9] + spriteTable[((spriteIndex*88)+66)+:10])) - yPos) <=
										//		spriteTable[((spriteIndex*88)+66)+:10] * spriteTable[((spriteIndex*88)+66)+:10]) begin
										//		spriteSel = 8'(z);
										//end
								// Top Right Edge
								end else if (spriteTable[((spriteIndex*88)+4)+:10] + spriteTable[((spriteIndex*88)+23)+:10] - spriteTable[((spriteIndex*88)+66)+:10] <= xPos && (spriteTable[((spriteIndex*88)+4)+:10] + spriteTable[((spriteIndex*88)+23)+:10]) >= xPos &&
									spriteTable[((spriteIndex*88)+14)+:9] <= yPos && (spriteTable[((spriteIndex*88)+14)+:9] + spriteTable[((spriteIndex*88)+66)+:10]) >= yPos) begin
								// Bottom Left Edge
								end else if (spriteTable[((spriteIndex*88)+4)+:10] <= xPos && (spriteTable[((spriteIndex*88)+4)+:10] + spriteTable[((spriteIndex*88)+66)+:10]) >= xPos &&
									spriteTable[((spriteIndex*88)+14)+:9] + spriteTable[((spriteIndex*88)+33)+:9] - spriteTable[((spriteIndex*88)+66)+:10] <= yPos && (spriteTable[((spriteIndex*88)+14)+:9] + spriteTable[((spriteIndex*88)+33)+:9]) >= yPos) begin
								// Bottom Right Edge
								end else if (spriteTable[((spriteIndex*88)+4)+:10] + spriteTable[((spriteIndex*88)+23)+:10] - spriteTable[((spriteIndex*88)+66)+:10] <= xPos && (spriteTable[((spriteIndex*88)+4)+:10] + spriteTable[((spriteIndex*88)+23)+:10]) >= xPos &&
									spriteTable[((spriteIndex*88)+14)+:9] + spriteTable[((spriteIndex*88)+33)+:9] - spriteTable[((spriteIndex*88)+66)+:10] <= yPos && (spriteTable[((spriteIndex*88)+14)+:9] + spriteTable[((spriteIndex*88)+33)+:9]) >= yPos) begin
								end else begin	// Normal rectangle
									spriteSel = 8'(z);
								end
							end
						end*/
						default: begin
							// None

						end
				endcase
			end
endmodule

module SpriteCalculator64(input logic[64*88-1:0] sTable, input logic[9:0] xPos, input logic[8:0] yPos,
									input logic[1:0] drawIn, input logic[7:0] inRed, inGreen, inBlue, input logic[19:0] addressIn, input logic addressTypeIn,
									output logic[1:0] draw, output logic[7:0] red, green, blue, output logic[19:0] address, output logic addressType);
									
				logic[7:0] redOut[3], greenOut[3], blueOut[3];
				logic[1:0] drawOut[3];
				logic[19:0] addressOut[3];
				logic addressTypeOut[3];
				
				SpriteCalculator16 sp0(.sTable(sTable[1407:0]), .xPos(xPos), .yPos(yPos),
					.drawIn(drawIn), .inRed(inRed), .inGreen(inGreen), .inBlue(inBlue), .addressIn(addressIn), .addressTypeIn(addressTypeIn),
					.draw(drawOut[0]), .red(redOut[0]), .green(greenOut[0]), .blue(blueOut[0]), .address(addressOut[0]), .addressType(addressTypeOut[0]));
					
				SpriteCalculator16 sp1(.sTable(sTable[2815:1408]), .xPos(xPos), .yPos(yPos),
					.drawIn(drawOut[0]), .inRed(redOut[0]), .inGreen(greenOut[0]), .inBlue(blueOut[0]), .addressIn(addressOut[0]), .addressTypeIn(addressTypeOut[0]),
					.draw(drawOut[1]), .red(redOut[1]), .green(greenOut[1]), .blue(blueOut[1]), .address(addressOut[1]), .addressType(addressTypeOut[1]));
					
				SpriteCalculator16 sp2(.sTable(sTable[4223:2816]), .xPos(xPos), .yPos(yPos),
					.drawIn(drawOut[1]), .inRed(redOut[1]), .inGreen(greenOut[1]), .inBlue(blueOut[1]), .addressIn(addressOut[1]), .addressTypeIn(addressTypeOut[1]),
					.draw(drawOut[2]), .red(redOut[2]), .green(greenOut[2]), .blue(blueOut[2]), .address(addressOut[2]), .addressType(addressTypeOut[2]));
					
				SpriteCalculator16 sp3(.sTable(sTable[5631:4224]), .xPos(xPos), .yPos(yPos),
					.drawIn(drawOut[2]), .inRed(redOut[2]), .inGreen(greenOut[2]), .inBlue(blueOut[2]), .addressIn(addressOut[2]), .addressTypeIn(addressTypeOut[2]),
					.draw(draw), .red(red), .green(green), .blue(blue), .address(address), .addressType(addressType));					
									
endmodule

module SpriteCalculator16(input logic[16*88-1:0] sTable, input logic[9:0] xPos, input logic[8:0] yPos,
									input logic[1:0] drawIn, input logic[7:0] inRed, inGreen, inBlue, input logic[19:0] addressIn, input logic addressTypeIn,
									output logic[1:0] draw, output logic[7:0] red, green, blue, output logic[19:0] address, output logic addressType);
									
				logic[7:0] redOut[4], greenOut[4], blueOut[4];
				logic[1:0] drawOut[4];
				logic[19:0] addressOut[4];
				logic addressTypeOut[4];
				
				always_comb begin
					if (drawOut[3] != 2'b0) begin
						draw <= drawOut[3];
						red <= redOut[3];
						green <= greenOut[3];
						blue <= blueOut[3];
						address <= addressOut[3];
						addressType <= addressTypeOut[3];
					end else if (drawOut[2] != 2'b0) begin
						draw <= drawOut[2];
						red <= redOut[2];
						green <= greenOut[2];
						blue <= blueOut[2];
						address <= addressOut[2];
						addressType <= addressTypeOut[2];
					end else if (drawOut[1] != 2'b0) begin
						draw <= drawOut[1];
						red <= redOut[1];
						green <= greenOut[1];
						blue <= blueOut[1];
						address <= addressOut[1];
						addressType <= addressTypeOut[1];
					end else if (drawOut[0] != 2'b0) begin
						draw <= drawOut[0];
						red <= redOut[0];
						green <= greenOut[0];
						blue <= blueOut[0];
						address <= addressOut[0];
						addressType <= addressTypeOut[0];
					end else begin
						draw <= drawIn;
						red <= inRed;
						green <= inGreen;
						blue <= inBlue;
						address <= addressIn;
						addressType <= addressTypeIn;
					end
				end
				
				SpriteCalculator4 sp0(.sTable(sTable[351:0]), .xPos(xPos), .yPos(yPos),
					.drawIn(2'b0), .inRed(8'b0), .inGreen(8'b0), .inBlue(8'b0), .addressIn(20'b0), .addressTypeIn(1'b0),
					.draw(drawOut[0]), .red(redOut[0]), .green(greenOut[0]), .blue(blueOut[0]), .address(addressOut[0]), .addressType(addressTypeOut[0]));
					
				// Only works up to 12
				/*SpriteCalculator4 sp1(.sTable(sTable[703:352]), .xPos(xPos), .yPos(yPos),
					.drawIn(2'b0), .inRed(8'b0), .inGreen(8'b0), .inBlue(8'b0), .addressIn(20'b0), .addressTypeIn(1'b0),
					.draw(drawOut[1]), .red(redOut[1]), .green(greenOut[1]), .blue(blueOut[1]), .address(addressOut[1]), .addressType(addressTypeOut[1]));
					
				SpriteCalculator4 sp2(.sTable(sTable[1055:704]), .xPos(xPos), .yPos(yPos),
					.drawIn(2'b0), .inRed(8'b0), .inGreen(8'b0), .inBlue(8'b0), .addressIn(20'b0), .addressTypeIn(1'b0),
					.draw(drawOut[2]), .red(redOut[2]), .green(greenOut[2]), .blue(blueOut[2]), .address(addressOut[2]), .addressType(addressTypeOut[2]));
					
				SpriteCalculator4 sp3(.sTable(sTable[1407:1056]), .xPos(xPos), .yPos(yPos),
					.drawIn(2'b0), .inRed(8'b0), .inGreen(8'b0), .inBlue(8'b0), .addressIn(20'b0), .addressTypeIn(1'b0),
					.draw(drawOut[3]), .red(redOut[3]), .green(greenOut[3]), .blue(blueOut[3]), .address(addressOut[3]), .addressType(addressTypeOut[3]));*/
									
endmodule

/*module SpriteCalculator16(input logic[16*88-1:0] sTable, input logic[9:0] xPos, input logic[8:0] yPos,
									input logic[1:0] drawIn, input logic[7:0] inRed, inGreen, inBlue,
									output logic[1:0] draw, output logic[7:0] red, green, blue);
									
				logic[7:0] redOut[3], greenOut[3], blueOut[3];
				logic[1:0] drawOut[3];				
				
				SpriteCalculator4 sp0(.sTable(sTable[351:0]), .xPos(xPos), .yPos(yPos),
					.drawIn(drawIn), .inRed(inRed), .inGreen(inGreen), .inBlue(inBlue),
					.draw(drawOut[0]), .red(redOut[0]), .green(greenOut[0]), .blue(blueOut[0]));
					
				SpriteCalculator4 sp1(.sTable(sTable[703:352]), .xPos(xPos), .yPos(yPos),
					.drawIn(drawOut[0]), .inRed(redOut[0]), .inGreen(greenOut[0]), .inBlue(blueOut[0]),
					.draw(drawOut[1]), .red(redOut[1]), .green(greenOut[1]), .blue(blueOut[1]));
					
				SpriteCalculator4 sp2(.sTable(sTable[1055:704]), .xPos(xPos), .yPos(yPos),
					.drawIn(drawOut[1]), .inRed(redOut[1]), .inGreen(greenOut[1]), .inBlue(blueOut[1]),
					.draw(drawOut[2]), .red(redOut[2]), .green(greenOut[2]), .blue(blueOut[2]));
					
				SpriteCalculator4 sp3(.sTable(sTable[1407:1056]), .xPos(xPos), .yPos(yPos),
					.drawIn(drawOut[2]), .inRed(redOut[2]), .inGreen(greenOut[2]), .inBlue(blueOut[2]),
					.draw(draw), .red(red), .green(green), .blue(blue));
									
endmodule*/

module SpriteCalculator4(input logic[4*88-1:0] sTable, input logic[9:0] xPos, input logic[8:0] yPos,
									input logic[1:0] drawIn, input logic[7:0] inRed, inGreen, inBlue, input logic[19:0] addressIn, input logic addressTypeIn,
									output logic[1:0] draw, output logic[7:0] red, green, blue, output logic[19:0] address, output logic addressType);
				
				logic[7:0] redOut[3], greenOut[3], blueOut[3];
				logic[1:0] drawOut[3];
				logic[19:0] addressOut[3];
				logic addressTypeOut[3];
				
				SpriteCalculator sp0(.sTable(sTable[87:0]), .xPos(xPos), .yPos(yPos),
					.drawIn(drawIn), .inRed(inRed), .inGreen(inGreen), .inBlue(inBlue), .addressIn(addressIn), .addressTypeIn(addressTypeIn),
					.draw(drawOut[0]), .red(redOut[0]), .green(greenOut[0]), .blue(blueOut[0]), .address(addressOut[0]), .addressType(addressTypeOut[0]));
					
				SpriteCalculator sp1(.sTable(sTable[175:88]), .xPos(xPos), .yPos(yPos),
					.drawIn(drawOut[0]), .inRed(redOut[0]), .inGreen(greenOut[0]), .inBlue(blueOut[0]), .addressIn(addressOut[0]), .addressTypeIn(addressTypeOut[0]),
					.draw(drawOut[1]), .red(redOut[1]), .green(greenOut[1]), .blue(blueOut[1]), .address(addressOut[1]), .addressType(addressTypeOut[1]));
					
				SpriteCalculator sp2(.sTable(sTable[263:176]), .xPos(xPos), .yPos(yPos),
					.drawIn(drawOut[1]), .inRed(redOut[1]), .inGreen(greenOut[1]), .inBlue(blueOut[1]), .addressIn(addressOut[1]), .addressTypeIn(addressTypeOut[1]),
					.draw(drawOut[2]), .red(redOut[2]), .green(greenOut[2]), .blue(blueOut[2]), .address(addressOut[2]), .addressType(addressTypeOut[2]));
					
				SpriteCalculator sp3(.sTable(sTable[351:264]), .xPos(xPos), .yPos(yPos),
					.drawIn(drawOut[2]), .inRed(redOut[2]), .inGreen(greenOut[2]), .inBlue(blueOut[2]), .addressIn(addressOut[2]), .addressTypeIn(addressTypeOut[2]),
					.draw(draw), .red(red), .green(green), .blue(blue), .address(address), .addressType(addressType)); 
endmodule

