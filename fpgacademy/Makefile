
############################################
# makefile that changes all design example makefile installation locations

CURRENT_DATE := $(shell date +%Y-%m%d)
FILE = fpgacademy.zip

SOF:
	cp ../Computer_Systems/DE1-SoC/rel/DE1-SoC/DE1_SoC_NiosVg_Computer/DE1_SoC_NiosVg_Computer.sof ./Computer_Systems/DE1-SoC/DE1-SoC_Computer/niosVg/DE1_SoC_Computer.sof
	cp ../Computer_Systems/DE10-Lite/rel/DE10-Lite/DE10_Lite_NiosVg_Computer/DE10_Lite_NiosVg_Computer.sof ./Computer_Systems/DE10-Lite/DE10-Lite_Computer/niosVg/DE10_Lite_Computer.sof

ZIP:
	@if [ -f "$(FILE)" ]; then \
		mv fpgacademy.zip fpgacademy_$(CURRENT_DATE).zip; \
	fi
	zip fpgacademy.zip -r AMP Computer_Systems GDB

