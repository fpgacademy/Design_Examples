/*******************************************************************************
 * This file provides address values that exist in the DE10-Standard Computer
 ******************************************************************************/

/* Memory */
	.equ	DDR_BASE,				0x40000000
	.equ	DDR_END,				0x7FFFFFFF
	.equ	SDRAM_BASE,				0x00000000
	.equ	SDRAM_END,				0x03FFFFFF
	.equ	FPGA_PIXEL_BUF_BASE,		0x08000000
	.equ	FPGA_PIXEL_BUF_END,		0x0803FFFF
	.equ	FPGA_CHAR_BASE,			0x09000000
	.equ	FPGA_CHAR_END,			0x09001FFF

/* Cyclone V FPGA devices */
	.equ	LED_BASE, 			0xFF200000
	.equ	LEDR_BASE,				0xFF200000
	.equ	HEX3_HEX0_BASE,			0xFF200020
	.equ	HEX5_HEX4_BASE,			0xFF200030
	.equ	SW_BASE,				0xFF200040
	.equ	KEY_BASE,				0xFF200050
	.equ	JP1_BASE,				0xFF200060
	.equ	JP2_BASE,				0xFF200070
	.equ	PS2_BASE,				0xFF200100
	.equ	PS2_DUAL_BASE,			0xFF200108
	.equ	JTAG_UART_BASE,			0xFF201000
	.equ	IrDA_BASE,				0xFF201020
	.equ	TIMER_BASE,				0xFF202000
	.equ	TIMER_2_BASE,			0xFF202020
	.equ	AV_CONFIG_BASE,			0xFF203000
	.equ	PIXEL_BUF_CTRL_BASE,	0xFF203020
	.equ	CHAR_BUF_CTRL_BASE,		0xFF203030
	.equ	AUDIO_BASE,				0xFF203040
	.equ	VIDEO_IN_BASE,			0xFF203060
	.equ	EDGE_DETECT_CTRL_BASE,	0xFF203070
	.equ	ADC_BASE,				0xFF204000

/* Nios V memory-mapped registers */
    .equ    MTIME_BASE,             0xFF202100
