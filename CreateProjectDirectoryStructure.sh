#!/bin/bash
echo "This file should be executed from the command line prior to the first"
echo "build.  It will be necessary to refresh the Eclipse project once the"
echo ".bat file has been executed (normally just press F5 to refresh)."
echo "Copies all the required files from their location within the standard"
echo "FreeRTOS directory structure to under the Eclipse project directory."
echo "This permits the Eclipse project to be used in 'managed' mode and without"
echo "having to setup any linked resources."
echo "Have the files already been copied?"
#IF EXIST FreeRTOS_Source Goto END

echo "Create the required directory structure."
mkdir -p FreeRTOS_Source
mkdir -p FreeRTOS_Source/include
mkdir -p FreeRTOS_Source/portable/GCC
mkdir -p FreeRTOS_Source/portable/GCC/ARM_CM3
mkdir -p FreeRTOS_Source/portable/MemMang

echo "cp the core kernel files."
cp ../../Source/tasks.c FreeRTOS_Source
cp ../../Source/queue.c FreeRTOS_Source
cp ../../Source/list.c FreeRTOS_Source
cp ../../Source/timers.c FreeRTOS_Source

echo "cp the common header files"

cp ../../Source/include/* FreeRTOS_Source/include

echo "cp the portable layer files"
cp ../../Source/portable/GCC/ARM_CM3/* FreeRTOS_Source/portable/GCC/ARM_CM3/

echo "cp the basic memory allocation files"
cp ../../Source/portable/MemMang/heap_1.c FreeRTOS_Source/portable/MemMang

#: END
