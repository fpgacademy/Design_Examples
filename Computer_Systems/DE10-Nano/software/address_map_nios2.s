/*******************************************************************************
 * This file provides address values that exist in the DE10-Nano Computer
 ******************************************************************************/

/* Memory */
	.equ	SDRAM_BASE,             0x00000000
	.equ	SDRAM_END,              0x00007FFF
	.equ	A9_ONCHIP_BASE,		0xFFFF0000
	.equ	A9_ONCHIP_END,		0xFFFFFFFF
	.equ	ONCHIP_MEMORY_BASE,     0x00000000
	.equ	ONCHIP_MEMORY_END,      0x00007FFF
	.equ	ONCHIP_2ND_MEMORY_BASE,	0x00010000
	.equ	ONCHIP_2ND_MEMORY_END,	0x00017FFF
	.equ	ONCHIP_SRAM_BASE,      	0x08000000
	.equ	ONCHIP_SRAM_END,        0x08007FFF
	.equ	FPGA_PIXEL_BUF_BASE,    0x08000000
	.equ	FPGA_PIXEL_BUF_END,     0x08007FFF
	.equ	FPGA_CHAR_BASE,        	0x09000000
	.equ	FPGA_CHAR_END,         	0x09001FFF

/* Cyclone V FPGA devices */
	.equ	LED_BASE,               0xFF200000
	.equ	SW_BASE,                0xFF200040
	.equ	KEY_BASE,               0xFF200050
	.equ	JP1_BASE,               0xFF200060
	.equ	JP7_BASE,               0xFF200070
	.equ	ARDUINO_GPIO_BASE,      0xFF200100
	.equ	ARDUINO_RESET_N,        0xFF200110
	.equ	JTAG_UART_BASE,         0xFF201000
	.equ	TIMER_BASE,             0xFF202000
	.equ	TIMER_2_BASE,           0xFF202020
	.equ	PIXEL_BUF_CTRL_BASE,    0xFF203020
	.equ	SYSID_BASE,             0xFF202040
	.equ	ADC_BASE,               0xFF204000

/* Cyclone V HPS devices */
	.equ	HPS_GPIO1_BASE,         0xFF709000
	.equ	HPS_TIMER0_BASE,        0xFFC08000
	.equ	HPS_TIMER1_BASE,        0xFFC09000
	.equ	HPS_TIMER2_BASE,        0xFFD00000
	.equ	HPS_TIMER3_BASE,        0xFFD01000
	.equ	FPGA_BRIDGE,            0xFFD0501C
