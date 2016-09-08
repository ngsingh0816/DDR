
#ifndef PIO_H
#define PIO_H

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
typedef signed char s8;
typedef signed short s16;
typedef signed int s32;

extern volatile int* vga_vsync;

extern volatile int* gpu_instruction;
extern volatile int* gpu_run;
extern volatile int* gpu_ready;
extern volatile int* gpu_sprite;

#endif
