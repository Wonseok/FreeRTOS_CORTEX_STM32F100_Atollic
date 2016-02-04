include config.mk

ASM_FILES	= $(wildcard Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x/startup/TrueSTUDIO/*.S)

C_FILES 	= $(wildcard Simple_Demo_Source/*.c) 								 \
			  $(wildcard Libraries/CMSIS/CM3/CoreSupport/*.c) \
			  $(wildcard Libraries/STM32F10x_StdPeriph_Driver/src/*.c) \
			  $(wildcard FreeRTOS_Source/*.c) \
			  $(wildcard FreeRTOS_Source/portable/MemMang/*.c) \
			  $(wildcard FreeRTOS_Source/portable/GCC/ARM_CM3/*.c) \
			  $(wildcard Utilities/STM32_EVAL/STM32_Discovery/*.c)

OBJS 		:= $(ASM_FILES:.S=.o) $(C_FILES:.c=.o)

BIN			= $(BUILD_DIR)/$(TARGET).bin
LD_SCRIPT	= $(PROJECT).lds.S
OUTPUT 		= $(TARGET).axf
MAP			= $(PROJECT).map

CC			= $(CROSS_COMPILE)gcc
LD			= $(CROSS_COMPILE)ld
NM			= $(CROSS_COMPILE)nm
OBJCOPY		= $(CROSS_COMPILE)objcopy


INCLUDES	= -I Simple_Demo_Source
INCLUDES	+= -I Libraries/CMSIS/CM3/CoreSupport
INCLUDES	+= -I Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x
INCLUDES	+= -I Libraries/STM32F10x_StdPeriph_Driver/inc
INCLUDES	+= -I FreeRTOS_Source/include
INCLUDES	+= -I FreeRTOS_Source/portable/GCC/ARM_CM3
INCLUDES	+= -I Utilities/STM32_EVAL/STM32_Discovery

CPPFLAGS	= $(CONFIG_FLAG) $(INCLUDES) -nostartfiles $(DEBUG_FLAG)
CPPFLAGS	+= -Wall

all: $(OBJS) $(OUTPUT) $(MAP)

$(MAP): $(OUTPUT)
	$(NM) $< > $@

clean:
	rm -f $(MAP) $(OUTPUT) $(BIN) $(OBJS)

$(OUTPUT): $(OBJS)
	$(CC) -T stm32_flash.ld -nostartfiles -L $(LIBS) -mcpu=cortex-m3 -g -o $@ $(OBJS) -lc -lcs3unhosted


$(BIN): $(OUTPUT)
	$(OBJCOPY) -O binary $(OUTPUT) $(BIN)

%.o: %.S
	$(CC) $(CPPFLAGS) -I. -c -o $@ $<

%.o: %.c
	$(CC) $(CPPFLAGS) -I. -c -o $@ $<

%: force
	$(MAKE) -C $(KERNEL_SRC) $@

force: ;

Makefile: ;

.PHONY: all clean config.mk
