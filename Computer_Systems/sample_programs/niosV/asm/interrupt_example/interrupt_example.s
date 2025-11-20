.include    "address_map_niosv.s" 
/***************************************************************************
 * This program demonstrates use of interrupts with assembly code. It first
 * sets up interrupts from three devices: the Nios V machine timer, an FPGA 
 * interval timer, and the pushbutton KEY port. Next, the program makes a 
 * software interrupt occur. Finally, the program loops while responding to 
 * interrupts from the timers and the pushbutton KEY port. 
 *
 * The interrupt service routine for the software interrupt turns on most
 * of the red lights in the LEDR port. 
 *
 * The interrupt service routine for the Nios V machine timer causes the
 * main program to display a binary counter on the LEDR red lights.
 *
 * The interrupt service routine for the interval timer causes the main 
 * program to display a decimal counter on HEX0. The counter either 
 * increases or decreases, in the range 0 to 9. When a KEY is pressed, the 
 * direction of counting on HEX0 is reversed. 
*****************************************************************************/
.equ clock_rate, 100000000
.equ quarter_clock, clock_rate / 4

.global _start
_start:     li      sp, SDRAM_END-3  # bottom of memory
            jal     set_mtimer       # initialize machine timer
            jal     set_itimer       # initialize interval timer
            jal     set_KEY          # initialize the KEY port
     
            # Set handler address, enable interrupts
            csrci   mstatus, 0x8     # disable Nios V interrupts
            la      t0, handler
            csrw    mtvec, t0        # set trap address
            csrr    t0, mie          # what ints are enabled?
            csrc    mie, t0          # disable all ints that were enabled
            li      t0, 0x50088      # set the enable pattern
            csrs    mie, t0          # swi, itimer, KEY, mtimer
            csrsi   mstatus, 0x8     # enable Nios V interrupts

            # Make a software interrupt happen
            la      t0, MTIME_BASE   # base address
            li      t1, 1            # pattern to write to msip
            sw      t1, 16(t0)       # write to msip (sw interrupt)

            la      s0, counter      # pointer to counter
            la      s1, LEDR_BASE    # pointer to red lights
            la      s2, digit        # pointer to digit
            la      s3, HEX3_HEX0_BASE    # pointer to hex display
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
            li      t1, 0x80000003   # IRQ 3
            bne     t0, t1, next     # software interrupt?
            jal     SWI_ISR
            j       trap_end
next:       li      t1, 0x80000007   # IRQ 7
            bne     t0, t1, nnext    # machine timer?
            jal     mtimer_ISR
            j       trap_end
nnext:      li      t1, 0x80000010   # IRQ 16
            bne     t0, t1, chk_KEY
            jal     itimer_ISR
            j       trap_end
chk_KEY:    li      t1, 0x80000012   # IRQ 18
stay:       bne     t0, t1, stay     # unexpected!
            jal     KEY_ISR

trap_end:   lw      t0, (sp)         # restore regs
            lw      t1, 4(sp)
            lw      t2, 8(sp)
            lw      ra, 12(sp)
            addi    sp, sp, 16
            mret

# Handle software interrupt
SWI_ISR:    la      t0, counter      # pointer to counter
            li      t1, 0b1111111100
            sw      t1, (t0)         # write to counter
            la      t0, MTIME_BASE   # base address
            sw      zero, 16(t0)     # clear software interrupt in msip
            ret

# Handle machine timer interrupt
mtimer_ISR: la      t0, MTIME_BASE
            lw      t1, 8(t0)        # read mtimecmp low
            li      t2, quarter_clock
            add     t2, t2, t1       # add to mtimecmp
            sw      t2, 8(t0)        # write to mtimecmp low
            sltu    t2, t2, t1       # check for carry-out
            lw      t1, 12(t0)       # read mtimecmp high
            add     t1, t1, t2       # increment (t2 = carry-out)
            sw      t1, 12(t0)       # write to mtimecmp high

            la      t0, counter      # pointer to counter
            lw      t1, (t0)         # read counter value
            addi    t1, t1, 1        # increment the counter
            sw      t1, (t0)         # store counter to memory
            ret

# Handle interval timer interrupt
itimer_ISR: la      t0, TIMER_BASE
            sh      zero, (t0)       # clear interrupt
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
KEY_ISR:    la      t0, KEY_BASE
            lw      t1, 0xc(t0)      # read edgecapture register
            sw      t1, 0xc(t0)      # write to edgecapture
            la      t0, KEY_dir
            lw      t1, (t0)         # get current direction
            neg     t1, t1           # reverse
            sw      t1, (t0)         # set current direction
            ret

# Initialize Nios V machine timer
set_mtimer: la      t0, MTIME_BASE   # set address
            # read the current time
tloop:      lw      t2, 4(t0)        # read mtime high
            lw      t1, 0(t0)        # read mtime low
            lw      t3, 4(t0)        # read high again
            bne     t3, t2, tloop    # check for overflow from low to high
            # current time is t2:t1
            li      t3, quarter_clock
            add     t3, t3, t1       # add to current time
            sw      t3, 8(t0)        # write to mtimecmp low
            sltu    t3, t3, t1       # check for carry-out
            add     t2, t2, t3       # increment (t3 = carry-out)
            sw      t2, 12(t0)       # write to mtimecmp high
            ret
     
# Initialize FPGA interval timer
set_itimer: la      t0, TIMER_BASE   # set address
            sh      zero, 4(t0)      # stop the timer
            sh      zero, (t0)       # clear the interrupt bit
            li      t1, clock_rate   # timeout value
            sh      t1, 8(t0)        # write to timer low half-word
            srli    t1, t1, 16
            sh      t1, 0xc(t0)      # write to timer high half-word
            li      t1, 0b0111       # START = 1, CONT = 1, ITO = 1
            sh      t1, 4(t0)        # reset lower word of mtime
            ret
     
# Enable interrupts in the KEY port
set_KEY:    la      t0, KEY_BASE     # set address
            li      t1, 0xf          
            sw      t1, 0xc(t0)      # clear all EdgeCapture bits
            li      t1, 0xf          # bit pattern for all four KEYs
            sw      t1, 8(t0)        # write to interrupt mask register
            ret
     
# Convert digit in a0 to seven-segment code. Return code in a0
seg7_code:  la      t0, bit_codes    # starting address of the bit codes
            add     t0, t0, a0       # index into the bit codes
            lb      a0, (t0)         # read the bit code for our digit
            ret

counter:    .word   0                # binary counter to be displayed
digit:      .word   0                # decimal digit to be displayed
KEY_dir:    .word   1                # digit counter direction
# 7-segment codes for digits 0, 1, ..., 9
bit_codes:  .byte   0x3f, 0x06, 0x5b, 0x4f, 0x66
            .byte   0x6d, 0x7d, 0x07, 0x7f, 0x67
