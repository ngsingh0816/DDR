
#include "pio.h"

volatile int* vga_vsync = (int*)0x60;

volatile int* gpu_instruction = (int*)0x50;
volatile int* gpu_run = (int*)0x40;
volatile int* gpu_ready = (int*)0x30;
volatile int* gpu_sprite = (int*)0x20;
