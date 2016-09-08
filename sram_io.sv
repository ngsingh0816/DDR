
module sram_io(input logic clk, input logic [19:0] address, output logic [19:0] addressOut, 
					input logic [15:0] dataIn, output logic [15:0] dataOutHW, inout wire [15:0] dataOut,
					input logic write, input enable,
					output logic UB, output logic LB, output logic CE, output logic OE, output logic WE);
					
					// Enable chip enable, low byte, and high byte
					assign CE = 0;
					assign LB = 0;
					assign UB = 0;
					
					// Assign the correct address
					assign addressOut = address;
					
					/*always_ff @ (posedge clk) begin
						addressOut <= address;
						OE <= write;
						WE <= ~write;
					end*/
					
					// Writing enables
					assign OE = write;
					assign WE = ~write;
					
					// Update data
					/*assign dataOut = (write ? dataIn : 16'bZ);
					assign dataOutHW = dataOut;*/
					
					tristate state(.Clk(clk), .OE(OE), .In(dataIn), .Out(dataOutHW), .Data(dataOut));
										
					/*always_ff @ (posedge clk) begin
						addressOut = address;
						if (write) begin
							// Disable output
							OE = 1;
							// Enable write
							WE = 0;
							dataOutHW = dataOut;
							// Set data
							dataOut = dataIn;
						end else begin
							// Enable output
							OE = 0;
							// Disable write
							WE = 1;
							dataOutHW = dataOut;
							// Disable input
							dataOut = 16'bZ;
						end
					end*/
					
					/*always_comb begin
							dataOutHW <= dataOut;
					end*/

endmodule
