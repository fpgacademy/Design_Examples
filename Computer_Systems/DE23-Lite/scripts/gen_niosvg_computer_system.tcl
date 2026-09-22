# Generate the DE23-Lite NiosVg Computer

###############################################################################
# Add components to the system
#
# Add clocks
ifup_add_system_clock_bridge
ifup_add_sdram_sample_clock_bridge
ifup_add_vga_clock_bridge
ifup_add_reset_bridge
#
# Add processors
ifup_add_niosVg		NiosVg			$ifup_flag_niosV_0_data_manager $ifup_flag_niosV_0_instruction_manager $ifup_flag_niosV_0_irq_receiver
#
# Add bridges
ifup_add_jtag_to_fpga_bridge
#
# Add address span extenders
#
# Add memories
# ifup_add_sdram_64mb
ifup_add_sdram_64mb_32bit
ifup_add_onchip_memory_II	Onchip_SRAM 262144 0x08000000
#
# Add gpio
ifup_add_gpio	LEDs			leds			Output	false	RISING  10 0xFF200000 -1
ifup_add_gpio	HEX3_HEX0		hex3_hex0		Output	false	RISING  32 0xFF200020 -1
ifup_add_gpio	HEX5_HEX4		hex5_hex4		Output	false	RISING  16 0xFF200030 -1
ifup_add_gpio	Slider_Switches	slider_switches	Input	false	RISING  10 0xFF200040 -1
ifup_add_gpio	Pushbuttons		pushbuttons		Input	true	FALLING  4 0xFF200050  2
ifup_add_gpio	Expansion_JP1	expansion_jp1	Bidir	true	FALLING 32 0xFF200060 11

#
# Add communications
ifup_add_jtag_uart	JTAG_UART_NiosV		0xFF201000 [ expr $ifup_flag_niosV_0_data_manager | $ifup_flag_jtag_to_fpga_bridge ] 8 $ifup_flag_niosV_0_irq_receiver
#ifup_add_jtag_uart	JTAG_UART_2nd_Core	0xFF201000 $ifup_flag_nios2_1_data_master 8 $ifup_flag_nios2_1_irq_receiver
#
# Add timers
ifup_add_interval_timer	Interval_Timer_NiosV		0xFF202000 [ expr $ifup_flag_niosV_0_data_manager | $ifup_flag_jtag_to_fpga_bridge ] 0 $ifup_flag_niosV_0_irq_receiver
ifup_add_interval_timer	Interval_Timer_NiosV_2		0xFF202020 [ expr $ifup_flag_niosV_0_data_manager | $ifup_flag_jtag_to_fpga_bridge ] 1 $ifup_flag_niosV_0_irq_receiver
#
# Add sys id
ifup_add_system_id
#
# ifup_add_adc 10.0 6 false
# Add av cores
ifup_add_vga_subsystem
#
# Add address span extenders
###############################################################################


###############################################################################
# Modify component parameters that are specific to this system
#
###############################################################################


