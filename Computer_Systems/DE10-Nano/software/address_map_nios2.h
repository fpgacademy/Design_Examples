/*******************************************************************************
 * This file provides address values that exist in the DE10-Nano Computer
 ******************************************************************************/

#ifndef __SYSTEM_INFO__
#define __SYSTEM_INFO__

#define BOARD					"DE10-Nano"

/* Memory */
#define ONCHIP_MEMORY_BASE		0x00000000
#define ONCHIP_MEMORY_END		0x00007FFF
#define ONCHIP_2ND_MEMORY_BASE	0x00010000
#define ONCHIP_2ND_MEMORY_END	0x00017FFF
#define ONCHIP_SRAM_BASE		0x08000000
#define ONCHIP_SRAM_END			0x08007FFF
#define FPGA_PIXEL_BUF_BASE		0x08000000
#define FPGA_PIXEL_BUF_END		0x08007FFF
#define FPGA_CHAR_BASE        	0x09000000
#define FPGA_CHAR_END         	0x09001FFF
#define A9_ONCHIP_BASE			0xFFFF0000
#define A9_ONCHIP_END			0xFFFFFFFF

/* Cyclone V FPGA devices */
#define LED_BASE				0xFF200000
#define SW_BASE					0xFF200040
#define KEY_BASE				0xFF200050
#define JP1_BASE				0xFF200060
#define JP7_BASE				0xFF200070
#define ARDUINO_GPIO_BASE		0xFF200100
#define ARDUINO_RESET_N			0xFF200110
#define JTAG_UART_BASE			0xFF201000
#define TIMER_BASE				0xFF202000
#define TIMER_2_BASE			0xFF202020
#define SYSID_BASE				0xFF202040
#define RGB_RESAMPLER_BASE  	0xFF203010
#define PIXEL_BUF_CTRL_BASE 	0xFF203020
#define ADC_BASE				0xFF204000

/* Cyclone V HPS devices */
#define HPS_GPIO1_BASE			0xFF709000
#define HPS_TIMER0_BASE			0xFFC08000
#define HPS_TIMER1_BASE			0xFFC09000
#define HPS_TIMER2_BASE			0xFFD00000
#define HPS_TIMER3_BASE			0xFFD01000
#define FPGA_BRIDGE				0xFFD0501C

#endif
