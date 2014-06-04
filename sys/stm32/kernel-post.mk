
DEPFLAGS	= -MT $@ -MP -MD -MF .deps/$*.dep
CFLAGS		= -I. -I$(H) -O $(DEFS) $(DEPFLAGS)
ASFLAGS		= -I. -I$(H) $(DEFS) $(DEPFLAGS)

include $(BUILDPATH)/gcc-config.mk

CC		= $(GCCPREFIX)gcc -g -gdwarf-2
CC		+= -fno-builtin -Werror -Wall -fno-dwarf2-cfi-asm -mthumb -mcpu=cortex-m4 -mfloat-abi=softfp -mfpu=fpv4-sp-d16 -DUSE_STDPERIPH_DRIVER -O0 -Imachine
LDFLAGS         += -nostdlib -T $(LDSCRIPT) -Wl,-Map=unix.map
SIZE		= $(GCCPREFIX)size
OBJDUMP		= $(GCCPREFIX)objdump
OBJCOPY		= $(GCCPREFIX)objcopy
PROGTOOL        = $(AVRDUDE) -c stk500v2 -p pic32 -b 115200
BLLDFLAGS       = -nostdlib -T$(BUILDPATH)/cfg/boot.ld -Wl,-Map=usbboot.map
BLCC            = $(CC) #$(GCCPREFIX)gcc -g -Werror -Wall -fno-dwarf2-cfi-asm
BLCFLAGS        = -Os -I. -Imachine -I$(H) $(DEFS) $(DEPFLAGS) -mthumb -mcpu=cortex-m4 -mfloat-abi=softfp -mfpu=fpv4-sp-d16 -g -gdwarf-2 -DUSE_STDPERIPH_DRIVER

# -mfloat-abi=hard # removed

DEFS            += -DCONFIG=$(CONFIG)

all:		.deps sys machine unix.elf $(EXTRA_TARGETS)
		$(SIZE) unix.elf

bootloader:     .deps sys machine bootloader.elf

clean:
		rm -rf .deps *.o *.elf *.bin *.dis *.map *.srec core \
		mklog assym.h vers.c genassym sys machine

.deps:
		mkdir .deps

sys:
		ln -s $(BUILDPATH)/../include $@

machine:
		ln -s $(BUILDPATH) $@

unix.elf:       $(KERNOBJ) $(LDSCRIPT)
		$(CC) $(LDFLAGS) $(KERNOBJ) -o $@
		chmod -x $@
		$(OBJDUMP) -d -S $@ > unix.dis
		$(OBJCOPY) -O binary $@ unix.bin
		$(OBJCOPY) -O ihex --change-addresses=0x80000000 $@ unix.hex
		chmod -x $@ unix.bin

bootloader.elf: bl_usb_boot.o bl_usb_device.o bl_usb_function_hid.o bl_devcfg.o
		$(BLCC) $(BLLDFLAGS) bl_usb_boot.o bl_usb_device.o bl_usb_function_hid.o bl_devcfg.o -o bootloader.elf
		chmod -x bootloader.elf
		$(OBJDUMP) -d -S bootloader.elf > bootloader.dis
		$(OBJCOPY) -O ihex --change-addresses=0x80000000 bootloader.elf bootloader.hex

bl_usb_boot.o:  $(BUILDPATH)/usb_boot.c
		$(BLCC) $(BLCFLAGS) -o $@ -c $(BUILDPATH)/usb_boot.c

bl_usb_device.o: $(BUILDPATH)/usb_device.c
		$(BLCC) $(BLCFLAGS) -o $@ -c $(BUILDPATH)/usb_device.c

bl_usb_function_hid.o: $(BUILDPATH)/usb_function_hid.c
		$(BLCC) $(BLCFLAGS) -o $@ -c $(BUILDPATH)/usb_function_hid.c

bl_devcfg.o:    $(BUILDPATH)/devcfg.c
		$(BLCC) $(BLCFLAGS) -o $@ -c $(BUILDPATH)/devcfg.c

load:           unix.hex
		pic32prog $(BLREBOOT) unix.hex

loadboot:       bootloader.hex
		pic32prog $(BLREBOOT) bootloader.hex

vers.o:		$(BUILDPATH)/newvers.sh $(H)/*.h $(M)/*.[ch] $(S)/*.c
		sh $(BUILDPATH)/newvers.sh > vers.c
		$(CC) -c vers.c

reconfig:
		../../../tools/configsys/config $(CONFIG)

.SUFFIXES:	.i .srec .hex .dis .cpp .cxx .bin .elf

.o.dis:
		$(OBJDUMP) -d -z -S $< > $@

ifeq (.deps, $(wildcard .deps))
-include .deps/*.dep
endif
