# LOS

Just an OS dev side project I'm working on.

# Quick Start Guide
- Assemble BIOSBootloader.asm using NASM
- Then run this command (I utilized WSL for this) to generate LOSFloppy.img
```bash
dd if=<(cat BIOSBootloader.bin; dd if=/dev/zero bs=512 count=2879) of=LOSFloppy.img bs=512 count=2880
```
- Open VirtualBox and create a new VM and use this image as the ISO file
- Before booting the machine, go to Settings -> Storage -> Add Controller -> I82078 (Floppy) -> Add Floppy Drive -> LOSFloppy.img
- Lastly, change the boot order to ustilize the floppy disk first.

# Compile Instructions
- Assemble BIOSBootloader OR UEFIBootloader
- BIOS:
```bash
nasm -f bin -o bin/BIOSBootloader.bin src/BIOSBootloader.asm
```
- UEFI:
```
coming soon...
```

- Compile Kernel:
```
coming soon...
```