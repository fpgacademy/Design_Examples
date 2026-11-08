
############################################
# used to make fpgacademy.zip

CURRENT_DATE := $(shell date +%Y-%m%d)
FILE = fpgacademy.zip

SOF:
	cp ../Computer_Systems/DE23-Lite/rel/DE23-Lite/DE23_Lite_NiosVg_Computer/DE23_Lite_NiosVg_Computer.sof ./Computer_Systems/
	cp ../Computer_Systems/DE25-Standard/rel/DE25-Standard/DE25_Standard_NiosVg_Computer/DE25_Standard_NiosVg_Computer.sof ./Computer_Systems/
	cp ../Computer_Systems/DE1-SoC/rel/DE1-SoC/DE1_SoC_NiosVg_Computer/DE1_SoC_NiosVg_Computer.sof ./Computer_Systems/
	cp ../Computer_Systems/DE10-Lite/rel/DE10-Lite/DE10_Lite_NiosVg_Computer/DE10_Lite_NiosVg_Computer.sof ./Computer_Systems/
	cp ../Computer_Systems/DE10-Standard/rel/DE10-Standard/DE10_Standard_NiosVg_Computer/DE10_Standard_NiosVg_Computer.sof ./Computer_Systems/
	cp ../Computer_Systems/DE10-Nano/rel/DE10-Nano/DE10_Nano_NiosVg_Computer/DE10_Nano_NiosVg_Computer.sof ./Computer_Systems/
	cp -r ../Computer_Systems/sample_programs/niosV ./Computer_Systems/

ZIP:
	@if [ -f "$(FILE)" ]; then \
		mv fpgacademy.zip fpgacademy_$(CURRENT_DATE).zip; \
	fi
	zip fpgacademy.zip -r AMP Computer_Systems GDB

