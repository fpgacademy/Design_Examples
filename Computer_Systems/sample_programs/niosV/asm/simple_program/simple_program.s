.include    "address_map_niosv.s" 

.text        

.global     _start 
_start:                         
        la      s0, LED_BASE    # Address of LEDs
        la      s1, SW_BASE     # Address of switches

LOOP:                           
        lw      t0, (s1)        # Read the state of switches
        sw      t0, (s0)        # Display the state on LEDs
        j       LOOP            

.end         
