# Author has to know the difference among '?=', '=', '+=' and ':='

CROSS_COMPILE		= arm-none-eabi-
PROCESSOR			= cortex-m3

DEBUG_FLAG		= -g
CONFIG_FLAG		= -mcpu=$(PROCESSOR) -mthumb

MACHINE			= stm32f100
PROJECT			= freeRTOS
TARGET			= freeRTOS-$(MACHINE)

# Desciption of directory structure
ROOT			= $(PWD)
MAKE			= make
