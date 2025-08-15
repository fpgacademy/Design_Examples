# Generates the DE10-Lite Nios II Computer

###############################################################################
# Add components to the system
#
# Add clocks
ifup_add_system_clock_source	100000000
ifup_add_vga_clock_source		25000000
#
# Add processors
ifup_add_niosII		 Nios2			"SDRAM.s1" 0x00000000 "SDRAM.s1" 0x00000020 0 1 $ifup_flag_nios2_0_data_master $ifup_flag_nios2_0_instruction_master $ifup_flag_nios2_0_irq_receiver
ifup_add_niosII		 Nios2_2nd_Core	"SDRAM.s1" 0x02000000 "SDRAM.s1" 0x02000020 1 1 $ifup_flag_nios2_1_data_master $ifup_flag_nios2_1_instruction_master $ifup_flag_nios2_1_irq_receiver
#
# Add bridges
ifup_add_jtag_to_fpga_bridge
#
# Add address span extenders
#
# Add memories
ifup_add_sdram_64mb
ifup_add_onchip_memory	Onchip_SRAM 65536 0x08000000
#
# Add gpio
ifup_add_gpio	LEDs			leds			Output	false	RISING  10 0xFF200000 -1
ifup_add_gpio	HEX3_HEX0		hex3_hex0		Output	false	RISING  32 0xFF200020 -1
ifup_add_gpio	HEX5_HEX4		hex5_hex4		Output	false	RISING  16 0xFF200030 -1
ifup_add_gpio	Slider_Switches	slider_switches	Input	false	RISING  10 0xFF200040 -1
ifup_add_gpio	Pushbuttons		pushbuttons		Input	true	FALLING  2 0xFF200050  1
ifup_add_gpio	Expansion_JP1	expansion_jp1	Bidir	true	FALLING 32 0xFF200060 11
ifup_add_gpio	Arduino_GPIO	arduino_gpio	Bidir	true	FALLING 16 0xFF200100 13
ifup_add_gpio	Arduino_Reset_N	arduino_reset_n	Output	true	FALLING  1 0xFF200110 -1
#
# Add communications
ifup_add_jtag_uart	JTAG_UART			0xFF201000 [ expr $ifup_flag_nios2_0_data_master | $ifup_flag_jtag_to_fpga_bridge ] 8 $ifup_flag_nios2_0_irq_receiver
ifup_add_jtag_uart	JTAG_UART_2nd_Core	0xFF201000 $ifup_flag_nios2_1_data_master 8 $ifup_flag_nios2_1_irq_receiver
#
# Add timers
ifup_add_interval_timer	Interval_Timer				0xFF202000 [ expr $ifup_flag_nios2_0_data_master | $ifup_flag_jtag_to_fpga_bridge ] 0 $ifup_flag_nios2_0_irq_receiver
ifup_add_interval_timer	Interval_Timer_2			0xFF202020 [ expr $ifup_flag_nios2_0_data_master | $ifup_flag_jtag_to_fpga_bridge ] 2 $ifup_flag_nios2_0_irq_receiver
ifup_add_interval_timer	Interval_Timer_2nd_Core		0xFF202000 $ifup_flag_nios2_1_data_master 0 $ifup_flag_nios2_1_irq_receiver
ifup_add_interval_timer	Interval_Timer_2nd_Core_2	0xFF202020 $ifup_flag_nios2_1_data_master 2 $ifup_flag_nios2_1_irq_receiver
#
# Add sys id
ifup_add_system_id
#
# Add av cores
ifup_add_adc 10.0 6 false
ifup_add_vga_subsystem
ifup_add_accelerometer
#
# Add address span extenders
###############################################################################


###############################################################################
# Modify component parameters that are specific to this system
#
###############################################################################


