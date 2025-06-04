#!/bin/bash
set -e

echo "🧹 Cleaning previous build..."
rm -f bin/floppy/boot.img
mkdir -p bin/BIOSBootloader bin/LOSKernel bin/floppy

echo "🔨 Assembling BIOS Bootloader..."
nasm -f bin src/BIOSBootloader/BIOSBootloader.asm -o bin/BIOSBootloader/BIOSBootloader.bin

# Ensure bootloader is exactly 512 bytes
truncate -s 512 bin/BIOSBootloader/BIOSBootloader.bin

echo "🧠 Compiling Kernel..."
g++ -ffreestanding -m32 -nostdlib -fno-pie -c src/LOSKernel/KernelMain.cpp -o bin/LOSKernel/KernelMain.o
nasm -f elf32 src/BIOSBootloader/kernel_entry.asm -o bin/LOSKernel/kernel_entry.o

echo "🔗 Linking Kernel as flat binary..."
ld -m elf_i386 -T src/LOSKernel/linker.ld -o bin/LOSKernel/kernel.bin bin/LOSKernel/kernel_entry.o bin/LOSKernel/KernelMain.o --oformat binary --nmagic --no-pie

# Create a raw floppy image: bootloader (512 bytes) + kernel
cat bin/BIOSBootloader/BIOSBootloader.bin bin/LOSKernel/kernel.bin > bin/floppy/boot.img

# Optionally, you can run the bootloader+kernel directly in QEMU as a floppy:
echo "🚀 Running bootloader+kernel in QEMU (floppy mode)..."
qemu-system-i386 -fda bin/floppy/boot.img

echo "✅ Done."
