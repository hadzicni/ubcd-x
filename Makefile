ISO_NAME := memtest-bios.iso
SRC_DIR := src
BUILD_DIR := build
GRUB_MKRESCUE := grub-mkrescue
QEMU := qemu-system-x86_64

.PHONY: all build run-bios clean check

all: build

build: check
	mkdir -p $(BUILD_DIR)
	$(GRUB_MKRESCUE) -o $(BUILD_DIR)/$(ISO_NAME) $(SRC_DIR)

check:
	@test -f $(SRC_DIR)/boot/grub/grub.cfg || (echo "ERROR: grub.cfg fehlt" && exit 1)
	@test -f $(SRC_DIR)/boot/memtest86+.bin || (echo "ERROR: memtest86+.bin fehlt" && exit 1)

run: build
	$(QEMU) -m 2048 -cdrom $(BUILD_DIR)/$(ISO_NAME) -boot d

clean:
	rm -rf $(BUILD_DIR)
