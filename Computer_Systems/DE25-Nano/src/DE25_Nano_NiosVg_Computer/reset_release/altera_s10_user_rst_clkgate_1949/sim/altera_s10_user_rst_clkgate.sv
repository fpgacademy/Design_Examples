// (C) 2001-2026 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


`timescale 1 ns / 1 ns
module altera_s10_user_rst_clkgate (
	output logic ninit_done
);

	localparam USER_RESET_DELAY = 0;
	
	initial begin
		#0 ninit_done = 1;
		#1 ninit_done = 0;
	end
					
	
endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "PGRPtde+6ouOHEYqS7uKloDasX1/C362eIC0QpUDLJRknz796vnvlWaYd+TTLN0tkXA7V+HvpuL2jmiC/v6uhGnVxbLOGkXVodX8mCQ1H4a6HcydPuK+mOFfk4mvvhH1UnGPs8KkWjP2elxojgaHcZxcPRXFnncXbAjEFRKNSyCK0lEhaxN0Tlub3aScS26GTev7jVVTRkVuKfHEjL/LqORhlJd4q2wc7Cmyosid/pV6JedRyOZ+c9h6a5VglvJxbJJZB9sh6y+Ej50hL1Yovl0YcULaeTl72oldZpFLwcXUSxOmB90kTGAjCunVSQPSan4ZuDkuvC4D41uQzNhADvCUwZTxuDw9zH+ZbFj5UIzbfmh9K4iQEbXOukPYtgVRb9FpNawCIIaScg9F2Cprm1Z6GCEaVFiQVIEteVNO+zZ0v3tTK73jhshLjlVchiivf9q6T8RCXZH0Zqc6uW/j8HH22mi8ZtTCVHkTThY5S3zKQ4zxPNgvcSjkMOBJv+bi1ZefNLlPh9Uwy4pVgArcMLT2pYdDZpGF0mY9NUKBXowkd0S4HGsPLASYSKmhHnhxOuRNK77rphZs9jdUnXz1jC2oDiG4PDaasrOC6iNarpFQgwvJh/qZaQb6ONGABK7Mh8jY/2C1ztFArDsVeSHCkTaondZzV64w043QNOw5gtgybbTyR+HOcsmK6N4YOyAsfCL8Q/7PEDIZkXUyf4Z0QPpay/7q5OB1kuOfY5r3HjiMWBDDUX29O8KnGIWyzL9KodwdFU4yTwRS+FeDYmcGNEwIuBqUm3FBHMp3WhmodINcsgxNOBOWEE6bV6dtrab/B7M/RtbROPqyMU+jkDhCiCaff1kW1xfpmSpE3Ewfga8lGuDjNTLoLRBcykVopqqvaoWDyWhD+ZUj+Nd3728eHIWQKyRk9Y++baj30G8yAemgiWDg0uGak+4GrCnfMryy5vl0uxX7lw4eZQEwvsdTl8MrAtTGK5J3z5JtoQKnz6W3XNB7+AgAsXGHgu397Hde"
`endif