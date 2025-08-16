# Generates the DE10-Nano Nios V/m Computer

###############################################################################
# Add components to the system
#
# Add clocks
ifup_add_system_clock_source	100000000
ifup_add_vga_clock_source		25000000
#
# Add processors
ifup_add_niosVm		NiosVm			$ifup_flag_niosV_0_data_manager $ifup_flag_niosV_0_instruction_manager $ifup_flag_niosV_0_irq_receiver
#ifup_add_niosVm		NiosVm_2nd_Core	$ifup_flag_niosV_1_data_manager $ifup_flag_niosV_1_instruction_manager $ifup_flag_niosV_1_irq_receiver
#
# Add bridges
ifup_add_jtag_to_fpga_bridge
#
# Add address span extenders
#
# Add memories
ifup_add_onchip_memory	Nios2_SRAM			32768	0x00000000
ifup_add_onchip_memory	Nios2_2nd_Core_SRAM 32768	0x00010000
ifup_add_onchip_memory	Onchip_SRAM			262144	0x08000000
#
# Add gpio
ifup_add_gpio	LEDs			leds			Output	false	RISING   8 0xFF200000 -1
ifup_add_gpio	Slider_Switches	slider_switches	Input	false	RISING   4 0xFF200040 -1
ifup_add_gpio	Pushbuttons		pushbuttons		Input	true	FALLING  2 0xFF200050  2
ifup_add_gpio	Expansion_JP1	expansion_jp1	Bidir	true	FALLING 32 0xFF200060 11
ifup_add_gpio	Expansion_JP7	expansion_jp7	Bidir	true	FALLING 32 0xFF200070 12
ifup_add_gpio	Arduino_GPIO	arduino_gpio	Bidir	true	FALLING 16 0xFF200100 13
ifup_add_gpio	Arduino_Reset_N	arduino_reset_n	Output	true	FALLING  1 0xFF200110 -1
#
# Add communications
ifup_add_jtag_uart	JTAG_UART_NiosV			0xFF201000 [ expr $ifup_flag_niosV_0_data_manager | $ifup_flag_jtag_to_fpga_bridge ] 8 $ifup_flag_niosV_0_irq_receiver
#ifup_add_jtag_uart	JTAG_UART_NiosV_2nd_Core	0xFF201000 $ifup_flag_niosV_1_data_manager 8 $ifup_flag_niosV_1_irq_receiver
#
# Add timers
ifup_add_interval_timer	Interval_Timer_NiosV				0xFF202000 [ expr $ifup_flag_niosV_0_data_manager | $ifup_flag_jtag_to_fpga_bridge ] 0 $ifup_flag_niosV_0_irq_receiver
ifup_add_interval_timer	Interval_Timer_NiosV_2				0xFF202020 [ expr $ifup_flag_niosV_0_data_manager | $ifup_flag_jtag_to_fpga_bridge ] 1 $ifup_flag_niosV_0_irq_receiver
#ifup_add_interval_timer	Interval_Timer_NiosV_2nd_Core		0xFF202000 $ifup_flag_niosV_1_data_manager 0 $ifup_flag_niosV_1_irq_receiver
#ifup_add_interval_timer	Interval_Timer_NiosV_2nd_Core_2	0xFF202020 $ifup_flag_niosV_1_data_manager 1 $ifup_flag_niosV_1_irq_receiver
#
# Add sys id
ifup_add_system_id
#
# Add av cores
ifup_add_adc 12.5
ifup_add_vga_subsystem
ifup_add_audio_subsystem	5
#
# Add address span extenders
###############################################################################


###############################################################################
# Modify component parameters that are specific to this system
#
###############################################################################

