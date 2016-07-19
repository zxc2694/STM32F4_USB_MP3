# Sources
SRCS = main.c stm32f4xx_it.c system_stm32f4xx.c syscalls.c

# Audio
SRCS += Audio.c

# USB
SRCS += usbh_usr.c usb_bsp.c

# Project name
PROJ_NAME=stm32F4_usb_mp3

###################################################

CC=arm-none-eabi-gcc
OBJCOPY=arm-none-eabi-objcopy
SIZE=arm-none-eabi-size

CFLAGS  = -std=gnu99 -g -O2 -Wall -Tstm32_flash.ld
CFLAGS += -mlittle-endian -mthumb -mthumb-interwork -nostartfiles -mcpu=cortex-m4

CFLAGS += -fsingle-precision-constant -Wdouble-promotion
CFLAGS += -mfpu=fpv4-sp-d16 -mfloat-abi=soft

vpath %.c src
vpath %.a lib

ROOT=$(shell pwd)

# Includes
CFLAGS += -Iinc -Ilib/Core/cmsis -Ilib/Core/stm32
CFLAGS += -Ilib/Conf

# Library paths
LIBPATHS = -Llib/StdPeriph -Llib/USB_OTG
LIBPATHS += -Llib/USB_Host/Core -Llib/USB_Host/Class/MSC
LIBPATHS += -Llib/fat_fs
LIBPATHS += -Llib/helix

# Libraries to link
LIBS = -lm -lhelix -lfatfs -lstdperiph -lusbhostcore -lusbhostmsc -lusbcore

# Extra includes
CFLAGS += -Ilib/StdPeriph/inc
CFLAGS += -Ilib/USB_OTG/inc
CFLAGS += -Ilib/USB_Host/Core/inc
CFLAGS += -Ilib/USB_Host/Class/MSC/inc
CFLAGS += -Ilib/fat_fs/inc
CFLAGS += -Ilib/helix/pub

# add startup file to build
SRCS += lib/startup_stm32f4xx.s

OBJS = $(SRCS:.c=.o)

###################################################

.PHONY: lib proj

all: lib proj
	$(SIZE) $(PROJ_NAME).elf

lib:
	$(MAKE) -C lib FLOAT_TYPE=$(FLOAT_TYPE)

proj: 	$(PROJ_NAME).elf

$(PROJ_NAME).elf: $(SRCS)
	$(CC) $(CFLAGS) $^ -o $@ $(LIBPATHS) $(LIBS)
	$(OBJCOPY) -O ihex $(PROJ_NAME).elf $(PROJ_NAME).hex
	$(OBJCOPY) -O binary $(PROJ_NAME).elf $(PROJ_NAME).bin

flash:
	st-flash write $(PROJ_NAME).bin 0x8000000
clean:
	rm -f *.o
	rm -f $(PROJ_NAME).elf
	rm -f $(PROJ_NAME).hex
	rm -f $(PROJ_NAME).bin
	$(MAKE) clean -C lib # Remove this line if you don't want to clean the libs as well
	
