.include    "address_map_niosv.s" 
/***********************************************************************************
 * This program demonstrates use of interrupts with assembly code. It first starts
 * two timers: the Nios V machine timer, and an FPGA interval timer. The program 
 * responds to interrupts from these timers in addition to the pushbutton KEYs. 
 *
 * The interrupt service routine for the Nios V machine timer causes the main 
 * program to display a binary counter that increments every 1/4 second on the LEDR
 * red lights.
 *
 * The interrupt service routine for the interval timer displays a one-digit decimal
 * counter on HEX0. This counter either increments or decrements once per second, 
 * in the range 0 to 9. Whenever a KEY is pressed, its corresponding interrupt 
 * service routine reverses the direction of counting on HEX0. 
 **********************************************************************************/
            .equ    quarter_second, 25000000
            .equ    one_second, 100000000

            .text
            .global _start
_start:     li      sp, SDRAM_END-3  # bottom of memory
            jal     set_mtimer       # initialize machine timer
            jal     set_itimer       # initialize interval timer
            jal     set_KEY          # initialize the KEY port
     
            # Set handler address, enable interrupts
            la      t0, handler
            csrw    mtvec, t0        # set trap address
            li      t0, 0x50080      # set the enable pattern
            csrs    mie, t0          # machine timer, interval timer, KEY
            csrsi   mstatus, 0x8     # enable global interrupts

            la      s0, counter      # pointer to counter
            la      s1, LEDR_BASE    # pointer to red lights
            la      s2, digit        # pointer to digit
            la      s3, HEX3_HEX0_BASE    # pointer to hex display
            sw      zero, (s1)       # turn off all LEDR lights
            li      t0, 0x3f         # pattern for 7-segment digit 0
            sw      t0, (s3)         # display 0 on HEX0

loop:       wfi
            lw      t0, (s0)         # load the counter value
            sw      t0, (s1)         # write to the lights
            lw      a0, (s2)         # load the digit value
            jal     seg7_code        # get 7-segment code to display
            sw      a0, (s3)         # write code to HEX0
            j       loop

# Trap handler
handler:    addi    sp, sp, -16      # save regs that will be modified
            sw      ra, 12(sp)
            sw      t2, 8(sp)
            sw      t1, 4(sp)
            sw      t0, (sp)
            
            # check for cause of trap
            csrr    t0, mcause       # read mcause register
            li      t1, 0x80000007   # IRQ 7
            bne     t0, t1, next     # machine timer?
            jal     mtimer_IRQ
            j       trap_end
next:       li      t1, 0x80000010   # IRQ 16
            bne     t0, t1, chk_KEY
            jal     itimer_IRQ
            j       trap_end
chk_KEY:    li      t1, 0x80000012   # IRQ 18
stay:       bne     t0, t1, stay     # unexpected!
            jal     KEY_IRQ

trap_end:   lw      t0, (sp)         # restore regs
            lw      t1, 4(sp)
            lw      t2, 8(sp)
            lw      ra, 12(sp)
            addi    sp, sp, 16
            mret

# Handle machine timer interrupt
mtimer_IRQ: la      t0, MTIME_BASE
            sw      zero, 8(t0)      # write to mtime

            la      t0, counter      # pointer to counter
            lw      t1, (t0)         # read counter value
            addi    t1, t1, 1        # increment the counter
            sw      t1, (t0)         # store counter to memory
            ret

# Handle interval timer interrupt
itimer_IRQ: la      t0, TIMER_BASE
            sh      zero, (t0)
            la      t0, digit
            lw      t1, (t0)

            la      t2, KEY_dir
            lw      t2, (t2)
            add     t1, t1, t2
            li      t2, 9
            bgt     t1, t2, itimer_end
            bltz    t1, itimer_end
            sw      t1, (t0)         # store counter to memory
itimer_end: ret

# Handle KEY port interrupt
KEY_IRQ:    la      t0, KEY_BASE
            lw      t1, 0xc(t0)      # read edgecapture register
            sw      t1, 0xc(t0)      # write to edgecapture
            la      t0, KEY_dir
            lw      t1, (t0)         # get current direction
            neg     t1, t1           # reverse
            sw      t1, (t0)         # set current direction
            ret

# Initialize Nios V machine timer
set_mtimer: la      t0, MTIME_BASE   # set address
            sw      zero, 8(t0)      # reset lower word of mtime
            sw      zero, 0xc(t0)    # reset upper word of mtime
            
            li      t1, quarter_second # 1/4 second timeout
            sw      t1, (t0)         # set mtimecmp low word
            sw      zero, 4(t0)      # set mtimecmp upper word
            ret
     
# Initialize FPGA interval timer
set_itimer: la      t0, TIMER_BASE   # set address
            li      t1, one_second   # 1 second timeout
            sh      t1, 8(t0)        # write to timer low half-word
            srli    t1, t1, 16
            sh      t1, 0xc(t0)      # write to timer high half-word
            li      t1, 0b0111       # START = 1, CONT = 1, ITO = 1
            sh      t1, 4(t0)        # reset lower word of mtime
            ret
     
# Enable interrupts in the KEY port
set_KEY:    la      t0, KEY_BASE     # set address
            li      t1, 0xf          # bit pattern for all four KEYs
            sw      t1, 8(t0)        # write to interrupt mask register
            ret
     
# Convert digit in a0 to seven-segment code. Return code in a0
seg7_code:  la      t0, bit_codes    # starting address of the bit codes
            add     t0, t0, a0       # index into the bit codes
            lb      a0, (t0)         # read the bit code needed for our digit
            ret

            .data
counter:    .word   0                # binary counter to be displayed
digit:      .word   0                # decimal digit to be displayed
KEY_dir:    .word   1                # digit counter direction
# 7-segment codes for digits 0, 1, ..., 9
bit_codes:  .byte   0x3f, 0x06, 0x5b, 0x4f, 0x66
            .byte   0x6d, 0x7d, 0x07, 0x7f, 0x67
