
#include "graphics.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define SPRITE_SIZE		11
#define SPRITE_NUMBER	64
#define TABLE_SIZE		(SPRITE_SIZE * SPRITE_NUMBER)

u8* spriteTable = NULL;
u32 spriteIndex = 0;

void InitGraphics() {
	// 88 bits = 11 bytes * 64 entries
	spriteTable = (u8*)malloc(TABLE_SIZE);
	// Clear to 0
	memset(spriteTable, 0, TABLE_SIZE);

	// Start from the first sprite
	spriteIndex = 0;
}

void DeallocGraphics() {
	// Cleanup
	if (spriteTable) {
		free(spriteTable);
		spriteTable = NULL;
	}
}

void WaitForVSYNC() {
	// Wait for vsync
	while (!(*vga_vsync)) {}
}

void WaitForNotVSYNC() {
	// Wait for not vsync
	while ((*vga_vsync)) {}
}

void UploadGraphics() {
	// Set the place where we start uploading data to the beginning
	SetSpriteAddress(0);

	// Tell the gpu we are uploading sprite data
	*gpu_sprite = true;

	// Upload the data 4 bytes at a time
	for (u32 z = 0; z < spriteIndex; z += 4) {
		// Wait for the gpu to be ready
		while (!(*gpu_ready)) {}

		// Upload the next 4 bytes (low byte is low byte)
		*gpu_instruction = (spriteTable[z + 3] << 24) | (spriteTable[z + 2] << 16) | (spriteTable[z + 1] << 8) | spriteTable[z];

		// Toggle run
		*gpu_run = true;
		*gpu_run = false;
	}

	// Tell the gpu we are done uploading sprite data
	*gpu_sprite = false;

	// Reset this so we start at the first sprite
	spriteIndex = 0;
}

// Graphics operations
void FillRectangle(u16 x, u16 y, u16 width, u16 height, Color color) {
	// Format: sprite type (0:3), x pos (4:13), y pos (14:22), width (23:32), height (33:41), blue (42:49), green (50:57), red (58:65), unused(66:87)

	// Make sure these values don't go over (for safety, can be taken out for small speed increase probably)
	u16 realX = x & 0x3FF;
	u16 realY = y & 0x1FF;
	u16 realWidth = width & 0x3FF;
	u16 realHeight = height & 0x1FF;

	// Copy over the data
	spriteTable[spriteIndex++] = 0x1 | ((realX & 0xF) << 4);
	spriteTable[spriteIndex++] = (realX >> 4) | ((realY & 0x3) << 6);
	spriteTable[spriteIndex++] = (realY >> 2) | ((realWidth & 0x1) << 7);
	spriteTable[spriteIndex++] = (realWidth >> 1);
	spriteTable[spriteIndex++] = (realWidth >> 9) | ((realHeight & 0x7F) << 1);
	spriteTable[spriteIndex++] = (realHeight >> 7) | ((color.blue & 0x3F) << 2);
	spriteTable[spriteIndex++] = (color.blue >> 6) | ((color.green & 0x3F) << 2);
	spriteTable[spriteIndex++] = (color.green >> 6) | ((color.red & 0x3F) << 2);
	spriteTable[spriteIndex++] = (color.red >> 6);
	spriteTable[spriteIndex++] = 0;
	spriteTable[spriteIndex++] = 0;
}

void StrokeRectangle(u16 x, u16 y, u16 width, u16 height, Color color, u16 strokeWidth) {
	// Format: sprite type (0:3), x pos (4:13), y pos (14:22), width (23:32), height (33:41), blue (42:49), green (50:57),
	//			red (58:65), strokeWidth(66:75), unused(76:87)

	// Make sure these values don't go over (for safety, can be taken out for small speed increase probably)
	u16 realX = x & 0x3FF;
	u16 realY = y & 0x1FF;
	u16 realWidth = width & 0x3FF;
	u16 realHeight = height & 0x1FF;
	u16 realStroke = strokeWidth & 0x3FF;

	// Copy over the data
	spriteTable[spriteIndex++] = 0x2 | ((realX & 0xF) << 4);
	spriteTable[spriteIndex++] = (realX >> 4) | ((realY & 0x3) << 6);
	spriteTable[spriteIndex++] = (realY >> 2) | ((realWidth & 0x1) << 7);
	spriteTable[spriteIndex++] = (realWidth >> 1);
	spriteTable[spriteIndex++] = (realWidth >> 9) | ((realHeight & 0x7F) << 1);
	spriteTable[spriteIndex++] = (realHeight >> 7) | ((color.blue & 0x3F) << 2);
	spriteTable[spriteIndex++] = (color.blue >> 6) | ((color.green & 0x3F) << 2);
	spriteTable[spriteIndex++] = (color.green >> 6) | ((color.red & 0x3F) << 2);
	spriteTable[spriteIndex++] = (color.red >> 6) | ((realStroke & 0x3F) << 2);
	spriteTable[spriteIndex++] = (realStroke >> 6);
	spriteTable[spriteIndex++] = 0;
}

void FillImage(u16 x, u16 y, u16 width, u16 height, Color color, u32 address) {
	// Format: sprite type (0:3), x pos (4:13), y pos (14:22), width (23:32), height (33:41), blue (42:49), green (50:57),
	//			red (58:65), address(66:85), unused(86:87)

	// Make sure these values don't go over (for safety, can be taken out for small speed increase probably)
	u16 realX = x & 0x3FF;
	u16 realY = y & 0x1FF;
	u16 realWidth = width & 0x3FF;
	u16 realHeight = height & 0x1FF;
	u32 realAddress = address & 0xFFFFF;

	// Copy over the data
	spriteTable[spriteIndex++] = 0x3 | ((realX & 0xF) << 4);
	spriteTable[spriteIndex++] = (realX >> 4) | ((realY & 0x3) << 6);
	spriteTable[spriteIndex++] = (realY >> 2) | ((realWidth & 0x1) << 7);
	spriteTable[spriteIndex++] = (realWidth >> 1);
	spriteTable[spriteIndex++] = (realWidth >> 9) | ((realHeight & 0x7F) << 1);
	spriteTable[spriteIndex++] = (realHeight >> 7) | ((color.blue & 0x3F) << 2);
	spriteTable[spriteIndex++] = (color.blue >> 6) | ((color.green & 0x3F) << 2);
	spriteTable[spriteIndex++] = (color.green >> 6) | ((color.red & 0x3F) << 2);
	spriteTable[spriteIndex++] = (color.red >> 6) | ((realAddress & 0x3F) << 2);
	spriteTable[spriteIndex++] = (realAddress >> 6) & 0xFF;
	spriteTable[spriteIndex++] = realAddress >> 14;
}

void FillRoundedRectangle(u16 x, u16 y, u16 width, u16 height, Color color, u16 radius) {
	// Format: sprite type (0:3), x pos (4:13), y pos (14:22), width (23:32), height (33:41), blue (42:49), green (50:57),
	//			red (58:65), strokeWidth(66:75), unused(76:87)

	// Make sure these values don't go over (for safety, can be taken out for small speed increase probably)
	u16 realX = x & 0x3FF;
	u16 realY = y & 0x1FF;
	u16 realWidth = width & 0x3FF;
	u16 realHeight = height & 0x1FF;
	u16 realRadius = radius & 0x3FF;

	// Copy over the data
	spriteTable[spriteIndex++] = 0x4 | ((realX & 0xF) << 4);
	spriteTable[spriteIndex++] = (realX >> 4) | ((realY & 0x3) << 6);
	spriteTable[spriteIndex++] = (realY >> 2) | ((realWidth & 0x1) << 7);
	spriteTable[spriteIndex++] = (realWidth >> 1);
	spriteTable[spriteIndex++] = (realWidth >> 9) | ((realHeight & 0x7F) << 1);
	spriteTable[spriteIndex++] = (realHeight >> 7) | ((color.blue & 0x3F) << 2);
	spriteTable[spriteIndex++] = (color.blue >> 6) | ((color.green & 0x3F) << 2);
	spriteTable[spriteIndex++] = (color.green >> 6) | ((color.red & 0x3F) << 2);
	spriteTable[spriteIndex++] = (color.red >> 6) | ((realRadius & 0x3F) << 2);
	spriteTable[spriteIndex++] = (realRadius >> 6);
	spriteTable[spriteIndex++] = 0;
}

// Instructions
void SetBackgroundColor(Color color) {
	// Wait for the gpu to be ready
	while (!(*gpu_ready)) {}

	// RGB (24), unused(4), opcode 1 (4)
	*gpu_instruction = (color.red << 24) | (color.green << 16) | (color.blue << 8) | 0x1;

	// Toggle run
	*gpu_run = true;
	*gpu_run = false;
}

void SetSpriteAddress(u32 address) {
	// Wait for the gpu to be ready
	while (!(*gpu_ready)) {}

	// address (20), unused(8), opcode 2 (4)
	*gpu_instruction = ((address & 0xFFFFF) << 12) | 0x2;

	// Toggle run
	*gpu_run = true;
	*gpu_run = false;
}
