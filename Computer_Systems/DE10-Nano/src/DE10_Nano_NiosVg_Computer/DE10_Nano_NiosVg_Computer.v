
module DE10_Nano_NiosVg_Computer (
	////////////////////////////////////
	// FPGA Pins
	////////////////////////////////////

	// Clock pins
	input              CLOCK_50,
	input              CLOCK2_50,
	input              CLOCK3_50,
	
	// ADC
	output             ADC_CONVST,
	output             ADC_SCK,
	output             ADC_SDI,
	input              ADC_SDO,
	
	// ARDUINO
	inout       [15:0] ARDUINO_IO,
	inout              ARDUINO_RESET_N,
	
	// GPIO
	inout       [35:0] GPIO_0,
	inout       [35:0] GPIO_1,

	// HDMI
	inout              HDMI_I2C_SCL,
	inout              HDMI_I2C_SDA,
	inout              HDMI_I2S,
	inout              HDMI_LRCLK,
	inout              HDMI_MCLK,
	inout              HDMI_SCLK,
	output             HDMI_TX_CLK,
	output      [23:0] HDMI_TX_D,
	output             HDMI_TX_DE,
	output             HDMI_TX_HS,
	input              HDMI_TX_INT,
	output             HDMI_TX_VS,
    
	// KEY
	input       [1:0]  KEY,
	
	// LED
	output      [7:0]  LED,
	
	// SW
	input       [3:0]  SW
	
	////////////////////////////////////
	// HPS Pins
	////////////////////////////////////
);


//=======================================================
//  REG/WIRE declarations
//=======================================================
wire  hps_fpga_reset_n;

wire						system_clock;
wire						system_clock_locked;
wire						vga_clock;
wire						vga_clock_locked;



//=======================================================
//  Structural coding
//=======================================================

System_PLL_100 System_PLL (
	.refclk		(CLOCK_50),
	.rst			(1'b0),
	.outclk_0	(system_clock),
	.outclk_1	(DRAM_CLK),
	.locked		(system_clock_locked)
);

VGA_PLL VGA_PLL (
	.refclk		(CLOCK2_50),
	.rst			(1'b0),
	.outclk_0	(vga_clock),
	.locked		(vga_clock_locked)
);

I2C_HDMI_Config u_I2C_HDMI_Config (
	.iCLK								(CLOCK3_50),
	.iRST_N								(1'b1),
	.I2C_SCLK							(HDMI_I2C_SCL),
	.I2C_SDAT							(HDMI_I2C_SDA),
	.HDMI_TX_INT						(HDMI_TX_INT)
);

Computer_System The_System (
	////////////////////////////////////
	// FPGA Side
	////////////////////////////////////

	// Global signals
	.sys_clk_ref_clk			(system_clock),
	.sys_clk_reset_n			(system_clock_locked),
	.vga_clk_ref_clk			(vga_clock),
	.vga_clk_reset_n			(1'b1),

	// ADC
	.adc_sclk							(ADC_SCK),
	.adc_cs_n							(ADC_CONVST),
	.adc_dout							(ADC_SDO),
	.adc_din							(ADC_SDI),

	// Arduino GPIO
	.arduino_gpio_export				(ARDUINO_IO),

	// Arduino Reset_n
	.arduino_reset_n_export				(ARDUINO_RESET_N),

	// Slider Switches
	.slider_switches_export				(SW),

	// Pushbuttons
	.pushbuttons_export					(~KEY),

	// Expansion JP1
	.expansion_jp1_export				({GPIO_0[35:19], GPIO_0[17], GPIO_0[15:3], GPIO_0[1]}),

	// Expansion JP7
	.expansion_jp7_export				({GPIO_1[35:19], GPIO_1[17], GPIO_1[15:3], GPIO_1[1]}),

	// LEDs
	.leds_export						(LED),

	// VGA Subsystem
	.vga_CLK							(HDMI_TX_CLK),
	.vga_BLANK							(HDMI_TX_DE),
	.vga_SYNC							(),
	.vga_HS								(HDMI_TX_HS),
	.vga_VS								(HDMI_TX_VS),
	.vga_R								(HDMI_TX_D[23:20]),
	.vga_G								(HDMI_TX_D[15:12]),
	.vga_B								(HDMI_TX_D[7:4]),
	
	// Audio Subsystem
	.audio_pll_ref_clk_clk				(CLOCK3_50),
	.audio_pll_ref_reset_reset			(1'b0),
	.audio_pll_clk_clk					(HDMI_SCLK),
	.audio_clks_bclk_clk				(HDMI_SCLK),
	.audio_clks_lrclk_clk				(HDMI_LRCLK),
	.audio_BCLK							(HDMI_SCLK),
	.audio_DACDAT						(HDMI_I2S),
	.audio_DACLRCK						(HDMI_LRCLK)
	
	////////////////////////////////////
	// HPS Side
	////////////////////////////////////
);

endmodule

