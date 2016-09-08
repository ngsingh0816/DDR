
#include "pio.h"

struct Color {
	u8 red;
	u8 green;
	u8 blue;

	// Default
	Color() {
		red = 0;
		green = 0;
		blue = 0;
	}

	// Initialize with color
	Color(u8 r, u8 g, u8 b) {
		red = r;
		green = g;
		blue = b;
	}
};

// Graphics operations
void InitGraphics();
void DeallocGraphics();
void UploadGraphics();
void WaitForVSYNC();
void WaitForNotVSYNC();

// Drawing operations
void FillRectangle(u16 x, u16 y, u16 width, u16 height, Color color);
void StrokeRectangle(u16 x, u16 y, u16 width, u16 height, Color color, u16 strokeWidth);
void FillImage(u16 x, u16 y, u16 width, u16 height, Color color, u32 address);

void FillRoundedRectangle(u16 x, u16 y, u16 width, u16 height, Color color, u16 radius);

// Instructions
void SetBackgroundColor(Color color);
void SetSpriteAddress(u32 address);
