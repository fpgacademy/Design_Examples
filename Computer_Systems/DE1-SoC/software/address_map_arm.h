#define DDR_BASE              0x00000000  // Memory
#define DDR_END               0x3FFFFFFF
#define A9_ONCHIP_BASE        0xFFFF0000
#define A9_ONCHIP_END         0xFFFFFFFF
#define SDRAM_BASE            0xC0000000
#define SDRAM_END             0xC3FFFFFF
#define FPGA_PIXEL_BUF_BASE   0xC8000000
#define FPGA_PIXEL_BUF_END    0xC803FFFF
#define FPGA_CHAR_BASE        0xC9000000
#define FPGA_CHAR_END         0xC9001FFF

#define LED_BASE              0xFF200000  // FPGA devices
#define LEDR_BASE             0xFF200000
#define HEX3_HEX0_BASE        0xFF200020
#define HEX5_HEX4_BASE        0xFF200030
#define SW_BASE               0xFF200040
#define KEY_BASE              0xFF200050
#define JP1_BASE              0xFF200060
#define JP2_BASE              0xFF200070
#define PS2_BASE              0xFF200100
#define PS2_DUAL_BASE         0xFF200108
#define JTAG_UART_BASE        0xFF201000
#define JTAG_UART_2_BASE      0xFF201008
#define IrDA_BASE             0xFF201020
#define TIMER_BASE            0xFF202000
#define TIMER_2_BASE          0xFF202020
#define AV_CONFIG_BASE        0xFF203000
#define RGB_RESAMPLER_BASE    0xFF203010
#define PIXEL_BUF_CTRL_BASE   0xFF203020
#define CHAR_BUF_CTRL_BASE    0xFF203030
#define AUDIO_BASE            0xFF203040
#define VIDEO_IN_BASE         0xFF203060
#define EDGE_DETECT_CTRL_BASE 0xFF203070
#define ADC_BASE              0xFF204000

#define HPS_GPIO1_BASE        0xFF709000  // HPS devices
#define I2C0_BASE             0xFFC04000
#define I2C1_BASE             0xFFC05000
#define I2C2_BASE             0xFFC06000
#define I2C3_BASE             0xFFC07000
#define HPS_TIMER0_BASE       0xFFC08000
#define HPS_TIMER1_BASE       0xFFC09000
#define HPS_TIMER2_BASE       0xFFD00000
#define HPS_TIMER3_BASE       0xFFD01000
#define FPGA_BRIDGE           0xFFD0501C

#define PERIPH_BASE           0xFFFEC000  // ARM devices
#define MPCORE_PRIV_TIMER     0xFFFEC600

#define MPCORE_GIC_CPUIF      0xFFFEC100  // GIC
#define ICCICR                0x00        // offset to CPU interface control
#define ICCPMR                0x04        // interrupt priority mask
#define ICCIAR                0x0C        // interrupt acknowledge
#define ICCEOIR               0x10        // interrupt 
#define MPCORE_GIC_DIST       0xFFFED000  // GIC distributor
#define ICDDCR                0x00        // offset to distributor control
#define ICDISER               0x100       // interrupt set-enable
#define ICDICER               0x180       // interrupt clear-enable
#define ICDIPTR               0x800       // interrupt processor targets
#define ICDICFR               0xC00       // interrupt configuration
