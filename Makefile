QEMU := qemu-system-gnuarmeclipse
BOARD := STM32F4-Discovery
MCU := STM32F407VG
ELF := Debug/lab4.elf
TCP_ADDR := 1234
QEMU_BIN := ~/opt/xPacks/qemu-arm/xpack-qemu-arm-7.2.0-1/bin

.PHONY: qemu_run qemu check

check:
	@test -f $(ELF) || (echo "Error: $(ELF) not found. Build project in CubeIDE first."; exit 1)

qemu_run: check
	PATH=$(QEMU_BIN):$$PATH SDL_VIDEODRIVER=x11 SDL_RENDER_DRIVER=software \
	$(QEMU) --verbose --board $(BOARD) --mcu $(MCU) --kernel $(ELF)

qemu: check
	PATH=$(QEMU_BIN):$$PATH SDL_VIDEODRIVER=x11 SDL_RENDER_DRIVER=software \
	$(QEMU) --verbose --board $(BOARD) --mcu $(MCU) --kernel $(ELF) -gdb tcp::$(TCP_ADDR) -S
