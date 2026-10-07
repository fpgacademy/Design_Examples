#include "../address_map_niosv.h"
#include <stdio.h>

/*******************************************************************************
 * This program demonstrates the use of the JP1 connector
 *
 * This test assumes that the connector JP1 has physical wires that are used to 
 * connect data bits 3-0 of the GPIO port to data bits 31-28 of this same port.
 * Specifically, a wire has to be used to connect JP1 connector Pin 2 (GPIO(0))
 * to JP1 Pin 37 (GPIO(28)), a wire from Pin 4 (GPIO(1)) to Pin 38 (GPIO(29)), 
 * a wire from Pin 5 (GPIO(2)) to Pin 39 (GPIO(30)), and, finally, a wire from 
 * Pin 6 (GPIO(3)) to Pin 40 (GPIO(31)).
 *
 * It performs the following:
 * 1. Sets up the GPIO so that bits 3-0 are outputs (all other bits are inputs)
 * 2. Reads from SW
 * 3. Writes the bitwise exclusive-OR of SW(4) with SW(3-0) to GPIO
 * 4. Writes GPIO(31-28) to LEDR(3-0).
 *
 * The test is successful if: 
 * -- when SW(4) = 0, LEDR(3-0) = SW(3-0)
 * -- when SW(4) = 1, LEDR(3-0) = ~SW(3-0)
 *
 ******************************************************************************/

int main(void) {
    /* Declare volatile pointers to I/O registers (volatile means that the
     * locations will not be cached, even in registers) */
    volatile unsigned int * GPIO_ptr = (unsigned int *)JP1_BASE;      // JP1 port address
    volatile unsigned int * SW_ptr = (unsigned int *)SW_BASE;         // SW port address
    volatile unsigned int * LEDR_ptr = (unsigned int *)LEDR_BASE;     // LEDR port address

    unsigned int switches, flipper;

    *(GPIO_ptr+1) = 0x0000000F;                   // configure bits GPIO(3-0) as outputs
    while (1) {
        switches = *(SW_ptr) & 0x1F;              // switches = SW(4-0)
        flipper = (switches >> 4) * 0xF;          // flipper = SW(4) SW(4) SW(4) SW(4)
        *(GPIO_ptr) = flipper ^ (switches & 0xF); // GPIO(3-0) = SW(3-0), or ~SW(3-0)
        *(LEDR_ptr) = *(GPIO_ptr) >> 28;          // LEDR(3-0) = GPIO(31-28) (**)
    }
    // (**): data bits GPIO(31-28), which are configured as inputs, are physically connected
    // to data bits GPIO(3-0), which are configured as outputs, by wires on connector JP1 

    return 0;
}

