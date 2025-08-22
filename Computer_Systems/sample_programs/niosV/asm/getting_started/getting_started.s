.include    "address_map_niosV.s"

/******************************************************************************
 * This program demonstrates use of parallel ports
 *
 * It performs the following:
 * 	1. displays a rotating pattern on the LEDs
 * 	2. if any KEY is pressed, the SW switches are used as the rotating pattern
 ******************************************************************************/

.text                               # executable code follows
.global     _start              
_start:                             

/* initialize base addresses of parallel ports */
        la      s0, SW_BASE         # SW slider switch base address
        la      s1, LED_BASE        # LED base address
        la      s2, KEY_BASE        # pushbutton KEY base address
        la      t1, LED_bits       
        lw      t0, (t1)            # load pattern for LED lights

DO_DISPLAY:                         
        lw      t1, (s0)            # load slider switches

        lw      t2, (s2)            # load pushbuttons
        beqz    t2, NO_BUTTON   
        mv      t0, t1              # use SW switch values as LED pattern
WAIT:                               
        lw      t3, (s2)            # load pushbuttons
        bnez    t3, WAIT            # wait for button release

NO_BUTTON:                          
        sw      t0, (s1)            # write to the LEDs
        srli    t1, t0, 10          # perform some operations to rotate
        slli    t0, t0, 1           # the 10-bit pattern
        or      t0, t0, t1          # completes the "rotate" operation
        
        li      t2, 1500000         # delay counter
DELAY:                              
        addi    t2, t2, -1           
        bnez    t2, DELAY       

        j       DO_DISPLAY          

/******************************************************************************/
.data                           # data follows

LED_bits:                           
.word       0x0000030F          # 10-bit pattern

.end                            
