

module DE25_Standard_NiosVg_Computer (
	// Clock pins
	CLOCK_50,

    // SDRAM
    DRAM_ADDR,
    DRAM_BA,
    DRAM_CAS_N,
    DRAM_CKE,
    DRAM_CLK,
    DRAM_CS_N,
    DRAM_DQ,
    DRAM_LDQM,
    DRAM_RAS_N,
    DRAM_UDQM,
    DRAM_WE_N,

	// Seven Segment Displays
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,

	// Pushbuttons
	KEY,

	// LEDs
	LEDR,

	// Slider Switches
	SW,

    // Expansion header
    GPIO,

    // HDMI
    FPGA_I2C_SCL,
    FPGA_I2C_SDA,
    HDMI_TX_CLK,
    HDMI_TX_HS,
    HDMI_TX_VS,
    HDMI_TX_D,
    HDMI_TX_DE,
    HDMI_TX_INT,
    HDMI_LRCLK,
    HDMI_MCLK,
    HDMI_SCLK,
    HDMI_I2S

);
//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

// Clock pins
input          CLOCK_50;

// SDRAM
output [12: 0] DRAM_ADDR;
output [ 1: 0] DRAM_BA;
output         DRAM_CAS_N;
output         DRAM_CKE;
output         DRAM_CLK;
output         DRAM_CS_N;
inout  [15: 0] DRAM_DQ;
output         DRAM_LDQM;
output         DRAM_RAS_N;
output         DRAM_UDQM;
output         DRAM_WE_N;

// Seven Segment Displays
output [ 6: 0] HEX0;
output [ 6: 0] HEX1;
output [ 6: 0] HEX2;
output [ 6: 0] HEX3;
output [ 6: 0] HEX4;
output [ 6: 0] HEX5;

// Pushbuttons
input  [ 3: 0] KEY;

// LEDs
output [ 9: 0] LEDR;

// Slider Switches
input  [ 9: 0] SW;

// Expansion header
inout [35: 0] GPIO;

// HDMI
inout wire FPGA_I2C_SCL;    // used to configure the HDMI output
inout wire FPGA_I2C_SDA;    // used to configure the HDMI output
output wire HDMI_TX_CLK;            // HDMI clock signal
output wire HDMI_TX_HS;             // HDMI control signal
output wire HDMI_TX_VS;             // HDMI control signal
output wire [23:0] HDMI_TX_D;
output wire HDMI_TX_DE;                // HDMI control signal
input wire HDMI_TX_INT;     // used to configure the HDMI output
output wire HDMI_LRCLK;     // used for audio
output wire HDMI_MCLK;      // used for audio
output wire HDMI_SCLK;      // used for audio
output wire HDMI_I2S;       // used for audio

//=======================================================
//  REG/WIRE declarations
//=======================================================

wire           ninit_done, reset, pll_stable;
wire           system_clock, sdram_clock, vga_clock;

wire   [9:0]   led;
wire   [31: 0] hex3_hex0;
wire   [15: 0] hex5_hex4;

assign LEDR = ~led;

assign HEX0 = ~hex3_hex0[ 7: 0];
assign HEX1 = ~hex3_hex0[15: 8];
assign HEX2 = ~hex3_hex0[23:16];
assign HEX3 = ~hex3_hex0[31:24];
assign HEX4 = ~hex5_hex4[ 7: 0];
assign HEX5 = ~hex5_hex4[15: 8];

//=======================================================
//  Structural coding
//=======================================================

reset_release u0 (ninit_done);
System_PLL_100 u1 (
    .refclk                             (CLOCK_50), 
    .locked                             (pll_stable),
    .rst                                (ninit_done),       // active-high reset
    .outclk_0                           (system_clock),
    .outclk_1                           (sdram_clock),
    .outclk_2                           (vga_clock)
);

assign reset = ninit_done | ~pll_stable;

assign DRAM_CLK = sdram_clock;

I2C_HDMI_Config u2 (
	.iCLK								(system_clock),
	.iRST_N								(~reset),           // active-low reset
	.I2C_SCLK							(FPGA_I2C_SCL),
	.I2C_SDAT							(FPGA_I2C_SDA),
	.HDMI_TX_INT						(HDMI_TX_INT)
);

Computer_System The_System (

	// Global signals
	.system_reset_reset	                (reset),            // active-high reset
	.system_clk			                (system_clock),
	.vga_in_clk			                (vga_clock),

	// Slider Switches
	.slider_switches_export				(SW),

	// Pushbuttons
	.pushbuttons_export					(~KEY),

	// LEDs
	.leds_export						(led),
	
	// Seven Segs
	.hex3_hex0_export					(hex3_hex0),
	.hex5_hex4_export					(hex5_hex4),
	
	// Expansion JP1
	.expansion_jp1_export				(GPIO[31:0]),
    
	// VGA Subsystem
	.vga_CLK							(HDMI_TX_CLK),
	.vga_BLANK							(HDMI_TX_DE),
	.vga_SYNC							(),
	.vga_HS								(HDMI_TX_HS),
	.vga_VS								(HDMI_TX_VS),
	.vga_R								(HDMI_TX_D[23:16]),
	.vga_G								(HDMI_TX_D[15:8]),
	.vga_B								(HDMI_TX_D[7:0]),
	
	// SDRAM
	.sdram_addr							(DRAM_ADDR),
	.sdram_ba							(DRAM_BA),
	.sdram_cas_n						(DRAM_CAS_N),
	.sdram_cke							(DRAM_CKE),
	.sdram_cs_n							(DRAM_CS_N),
	.sdram_dq							(DRAM_DQ),
	.sdram_dqm							({DRAM_UDQM,DRAM_LDQM}),
	.sdram_ras_n						(DRAM_RAS_N),
	.sdram_we_n							(DRAM_WE_N)
	
);


endmodule
