/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_qsys_0' in SOPC Builder design 'nios'
 * SOPC Builder design path: ../../nios.sopcinfo
 *
 * Generated: Mon Apr 25 02:43:49 CDT 2016
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_qsys"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00001020
#define ALT_CPU_CPU_FREQ 100000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1d
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x10000020
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 100000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x1d
#define ALT_CPU_NAME "nios2_qsys_0"
#define ALT_CPU_RESET_ADDR 0x10000000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00001020
#define NIOS2_CPU_FREQ 100000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x1d
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x10000020
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x1d
#define NIOS2_RESET_ADDR 0x10000000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_NIOS2_QSYS
#define __ALTPLL


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone IV E"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart_0"
#define ALT_STDERR_BASE 0x98
#define ALT_STDERR_DEV jtag_uart_0
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart_0"
#define ALT_STDIN_BASE 0x98
#define ALT_STDIN_DEV jtag_uart_0
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart_0"
#define ALT_STDOUT_BASE 0x98
#define ALT_STDOUT_DEV jtag_uart_0
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "nios"


/*
 * gpu_instruction configuration
 *
 */

#define ALT_MODULE_CLASS_gpu_instruction altera_avalon_pio
#define GPU_INSTRUCTION_BASE 0x50
#define GPU_INSTRUCTION_BIT_CLEARING_EDGE_REGISTER 0
#define GPU_INSTRUCTION_BIT_MODIFYING_OUTPUT_REGISTER 0
#define GPU_INSTRUCTION_CAPTURE 0
#define GPU_INSTRUCTION_DATA_WIDTH 32
#define GPU_INSTRUCTION_DO_TEST_BENCH_WIRING 0
#define GPU_INSTRUCTION_DRIVEN_SIM_VALUE 0
#define GPU_INSTRUCTION_EDGE_TYPE "NONE"
#define GPU_INSTRUCTION_FREQ 100000000
#define GPU_INSTRUCTION_HAS_IN 0
#define GPU_INSTRUCTION_HAS_OUT 1
#define GPU_INSTRUCTION_HAS_TRI 0
#define GPU_INSTRUCTION_IRQ -1
#define GPU_INSTRUCTION_IRQ_INTERRUPT_CONTROLLER_ID -1
#define GPU_INSTRUCTION_IRQ_TYPE "NONE"
#define GPU_INSTRUCTION_NAME "/dev/gpu_instruction"
#define GPU_INSTRUCTION_RESET_VALUE 0
#define GPU_INSTRUCTION_SPAN 16
#define GPU_INSTRUCTION_TYPE "altera_avalon_pio"


/*
 * gpu_ready configuration
 *
 */

#define ALT_MODULE_CLASS_gpu_ready altera_avalon_pio
#define GPU_READY_BASE 0x30
#define GPU_READY_BIT_CLEARING_EDGE_REGISTER 0
#define GPU_READY_BIT_MODIFYING_OUTPUT_REGISTER 0
#define GPU_READY_CAPTURE 0
#define GPU_READY_DATA_WIDTH 1
#define GPU_READY_DO_TEST_BENCH_WIRING 0
#define GPU_READY_DRIVEN_SIM_VALUE 0
#define GPU_READY_EDGE_TYPE "NONE"
#define GPU_READY_FREQ 100000000
#define GPU_READY_HAS_IN 1
#define GPU_READY_HAS_OUT 0
#define GPU_READY_HAS_TRI 0
#define GPU_READY_IRQ -1
#define GPU_READY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define GPU_READY_IRQ_TYPE "NONE"
#define GPU_READY_NAME "/dev/gpu_ready"
#define GPU_READY_RESET_VALUE 0
#define GPU_READY_SPAN 16
#define GPU_READY_TYPE "altera_avalon_pio"


/*
 * gpu_run configuration
 *
 */

#define ALT_MODULE_CLASS_gpu_run altera_avalon_pio
#define GPU_RUN_BASE 0x40
#define GPU_RUN_BIT_CLEARING_EDGE_REGISTER 0
#define GPU_RUN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define GPU_RUN_CAPTURE 0
#define GPU_RUN_DATA_WIDTH 1
#define GPU_RUN_DO_TEST_BENCH_WIRING 0
#define GPU_RUN_DRIVEN_SIM_VALUE 0
#define GPU_RUN_EDGE_TYPE "NONE"
#define GPU_RUN_FREQ 100000000
#define GPU_RUN_HAS_IN 0
#define GPU_RUN_HAS_OUT 1
#define GPU_RUN_HAS_TRI 0
#define GPU_RUN_IRQ -1
#define GPU_RUN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define GPU_RUN_IRQ_TYPE "NONE"
#define GPU_RUN_NAME "/dev/gpu_run"
#define GPU_RUN_RESET_VALUE 0
#define GPU_RUN_SPAN 16
#define GPU_RUN_TYPE "altera_avalon_pio"


/*
 * gpu_sprite configuration
 *
 */

#define ALT_MODULE_CLASS_gpu_sprite altera_avalon_pio
#define GPU_SPRITE_BASE 0x20
#define GPU_SPRITE_BIT_CLEARING_EDGE_REGISTER 0
#define GPU_SPRITE_BIT_MODIFYING_OUTPUT_REGISTER 0
#define GPU_SPRITE_CAPTURE 0
#define GPU_SPRITE_DATA_WIDTH 1
#define GPU_SPRITE_DO_TEST_BENCH_WIRING 0
#define GPU_SPRITE_DRIVEN_SIM_VALUE 0
#define GPU_SPRITE_EDGE_TYPE "NONE"
#define GPU_SPRITE_FREQ 100000000
#define GPU_SPRITE_HAS_IN 0
#define GPU_SPRITE_HAS_OUT 1
#define GPU_SPRITE_HAS_TRI 0
#define GPU_SPRITE_IRQ -1
#define GPU_SPRITE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define GPU_SPRITE_IRQ_TYPE "NONE"
#define GPU_SPRITE_NAME "/dev/gpu_sprite"
#define GPU_SPRITE_RESET_VALUE 0
#define GPU_SPRITE_SPAN 16
#define GPU_SPRITE_TYPE "altera_avalon_pio"


/*
 * hal configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart_0 configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart_0 altera_avalon_jtag_uart
#define JTAG_UART_0_BASE 0x98
#define JTAG_UART_0_IRQ 5
#define JTAG_UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_0_NAME "/dev/jtag_uart_0"
#define JTAG_UART_0_READ_DEPTH 64
#define JTAG_UART_0_READ_THRESHOLD 8
#define JTAG_UART_0_SPAN 8
#define JTAG_UART_0_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_0_WRITE_DEPTH 64
#define JTAG_UART_0_WRITE_THRESHOLD 8


/*
 * onchip_memory2_0 configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_memory2_0 altera_avalon_onchip_memory2
#define ONCHIP_MEMORY2_0_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY2_0_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY2_0_BASE 0x0
#define ONCHIP_MEMORY2_0_CONTENTS_INFO ""
#define ONCHIP_MEMORY2_0_DUAL_PORT 0
#define ONCHIP_MEMORY2_0_GUI_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY2_0_INIT_CONTENTS_FILE "nios_onchip_memory2_0"
#define ONCHIP_MEMORY2_0_INIT_MEM_CONTENT 1
#define ONCHIP_MEMORY2_0_INSTANCE_ID "NONE"
#define ONCHIP_MEMORY2_0_IRQ -1
#define ONCHIP_MEMORY2_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_MEMORY2_0_NAME "/dev/onchip_memory2_0"
#define ONCHIP_MEMORY2_0_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY2_0_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY2_0_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEMORY2_0_SINGLE_CLOCK_OP 0
#define ONCHIP_MEMORY2_0_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY2_0_SIZE_VALUE 16
#define ONCHIP_MEMORY2_0_SPAN 16
#define ONCHIP_MEMORY2_0_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEMORY2_0_WRITABLE 1


/*
 * sdram configuration
 *
 */

#define ALT_MODULE_CLASS_sdram altera_avalon_new_sdram_controller
#define SDRAM_BASE 0x10000000
#define SDRAM_CAS_LATENCY 3
#define SDRAM_CONTENTS_INFO
#define SDRAM_INIT_NOP_DELAY 0.0
#define SDRAM_INIT_REFRESH_COMMANDS 2
#define SDRAM_IRQ -1
#define SDRAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_IS_INITIALIZED 1
#define SDRAM_NAME "/dev/sdram"
#define SDRAM_POWERUP_DELAY 200.0
#define SDRAM_REFRESH_PERIOD 7.8125
#define SDRAM_REGISTER_DATA_IN 1
#define SDRAM_SDRAM_ADDR_WIDTH 0x19
#define SDRAM_SDRAM_BANK_WIDTH 2
#define SDRAM_SDRAM_COL_WIDTH 10
#define SDRAM_SDRAM_DATA_WIDTH 32
#define SDRAM_SDRAM_NUM_BANKS 4
#define SDRAM_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_SDRAM_ROW_WIDTH 13
#define SDRAM_SHARED_DATA 0
#define SDRAM_SIM_MODEL_BASE 0
#define SDRAM_SPAN 134217728
#define SDRAM_STARVATION_INDICATOR 0
#define SDRAM_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_T_AC 5.5
#define SDRAM_T_MRD 3
#define SDRAM_T_RCD 20.0
#define SDRAM_T_RFC 70.0
#define SDRAM_T_RP 20.0
#define SDRAM_T_WR 14.0


/*
 * sdram_pll configuration
 *
 */

#define ALT_MODULE_CLASS_sdram_pll altpll
#define SDRAM_PLL_BASE 0x70
#define SDRAM_PLL_IRQ -1
#define SDRAM_PLL_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_PLL_NAME "/dev/sdram_pll"
#define SDRAM_PLL_SPAN 16
#define SDRAM_PLL_TYPE "altpll"


/*
 * sysid_qsys_0 configuration
 *
 */

#define ALT_MODULE_CLASS_sysid_qsys_0 altera_avalon_sysid_qsys
#define SYSID_QSYS_0_BASE 0x90
#define SYSID_QSYS_0_ID 0
#define SYSID_QSYS_0_IRQ -1
#define SYSID_QSYS_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_QSYS_0_NAME "/dev/sysid_qsys_0"
#define SYSID_QSYS_0_SPAN 8
#define SYSID_QSYS_0_TIMESTAMP 1461568625
#define SYSID_QSYS_0_TYPE "altera_avalon_sysid_qsys"


/*
 * vga_vsync configuration
 *
 */

#define ALT_MODULE_CLASS_vga_vsync altera_avalon_pio
#define VGA_VSYNC_BASE 0x60
#define VGA_VSYNC_BIT_CLEARING_EDGE_REGISTER 0
#define VGA_VSYNC_BIT_MODIFYING_OUTPUT_REGISTER 0
#define VGA_VSYNC_CAPTURE 0
#define VGA_VSYNC_DATA_WIDTH 1
#define VGA_VSYNC_DO_TEST_BENCH_WIRING 0
#define VGA_VSYNC_DRIVEN_SIM_VALUE 0
#define VGA_VSYNC_EDGE_TYPE "NONE"
#define VGA_VSYNC_FREQ 100000000
#define VGA_VSYNC_HAS_IN 1
#define VGA_VSYNC_HAS_OUT 0
#define VGA_VSYNC_HAS_TRI 0
#define VGA_VSYNC_IRQ -1
#define VGA_VSYNC_IRQ_INTERRUPT_CONTROLLER_ID -1
#define VGA_VSYNC_IRQ_TYPE "NONE"
#define VGA_VSYNC_NAME "/dev/vga_vsync"
#define VGA_VSYNC_RESET_VALUE 0
#define VGA_VSYNC_SPAN 16
#define VGA_VSYNC_TYPE "altera_avalon_pio"

#endif /* __SYSTEM_H_ */
