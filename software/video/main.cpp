
#include "graphics.h"
#include "pio.h"
#include <stdio.h>

int main() {
	// Initialize the graphics
	InitGraphics();

	// Infinite loop
	int xpos = 0;
	for (;;) {
		WaitForVSYNC();

		/*StrokeRectangle(80, 240 - 30, 640 - 160, 60, Color(200, 200, 200), 1);
		FillRectangle(81, 240 - 29, xpos, 58, Color(0, 255, 0));
		xpos++;
		if (xpos >= 640 - 160 - 6)
			xpos = 0;*/

		//for (int z = 0; z < 64; z++)
		//	FillRectangle(z * 10, 240 - 30, 10, 60, Color(z * 3 + 40, z * 3 + 40, z * 3 + 40));

		FillImage(0, 0, 640, 480, Color(255, 255, 255), 0x0);
		FillRectangle(0, 0, 64, 48, Color(255, 0, 0));

		//FillRectangle(80, 240 - 30, 640 - 160, 60, Color(255, 255, 255));

		UploadGraphics();

		// Wait for frame to finish
		WaitForNotVSYNC();

	}

	// Cleanup the graphics
	DeallocGraphics();

	return 0;
}
