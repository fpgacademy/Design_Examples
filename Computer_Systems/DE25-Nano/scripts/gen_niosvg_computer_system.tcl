# Generate the DE25-Nano NiosVg Computer

###############################################################################
# Add components to the system
#
# Add clocks
ifup_add_system_clock_bridge
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
ifup_add_sdram_128mb
ifup_add_onchip_memory_II	Onchip_SRAM 262144 0x08000000
#
# Add gpio
ifup_add_gpio	LEDs			leds			Output	false	RISING   8 0xFF200000 -1
ifup_add_gpio	Slider_Switches	slider_switches	Input	false	RISING   4 0xFF200040 -1
ifup_add_gpio	Pushbuttons		pushbuttons		Input	true	FALLING  2 0xFF200050  2
# ifup_add_gpio	Expansion_JP1	expansion_jp1	Bidir	true	FALLING 32 0xFF200060 11

#
# Add communications
ifup_add_jtag_uart	JTAG_UART_NiosV		0xFF201000 [ expr $ifup_flag_niosV_0_data_manager | $ifup_flag_jtag_to_fpga_bridge ] 8 $ifup_flag_niosV_0_irq_receiver
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


