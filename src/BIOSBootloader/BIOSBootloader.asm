[org 0x7c00]

KERNEL_OFFSET equ 0x1000 ; Where the kernel will be loaded in memory (must match linker script)

; Bootloader entry point - this is where BIOS jumps after loading us
bootloader_entry:
    mov [BOOT_DRIVE], dl ; Save the boot drive number (BIOS puts it in DL)

    ; Set up a simple stack in RAM (required for function calls and local variables)
    mov bp, 0x9000
    mov sp, bp

    ; Print a message to show we're running in 16-bit real mode
    mov bx, MSG_REAL_MODE
    call print

    ; Switch to VGA graphics mode 13h (320x200, 256 colors)
    mov ah, 0x00        ; BIOS function: set video mode
    mov al, 0x13        ; 0x13 = 320x200x256 graphics mode
    int 0x10            ; Call BIOS interrupt

    ; Load the kernel from disk into memory
    call load_kernel

    ; Enter 32-bit protected mode and jump to the kernel
    call switch_to_32

    ; Infinite loop (should never reach here)
    jmp $

; Include helper routines (printing, GDT setup, disk loading, mode switching)
%include "src/BIOSBootloader/AsmHelpers/print.asm"
%include "src/BIOSBootloader/AsmHelpers/gdt.asm"
%include "src/BIOSBootloader/AsmHelpers/disk.asm"
%include "src/BIOSBootloader/AsmHelpers/mode.asm"

[bits 16]
; Loads the kernel from disk into memory at KERNEL_OFFSET
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print

    mov bx, KERNEL_OFFSET ; Destination address for the kernel
    mov dh, 2             ; Number of sectors to read (adjust as needed)
    mov dl, [BOOT_DRIVE]  ; Use the saved boot drive number
    call load_disk        ; Read sectors from disk into memory
    ret

[bits 32]
; Prints a message and jumps to the loaded kernel in protected mode
jump_kernel:
    mov ebx, MSG_PROT_MODE
    call print32
    call KERNEL_OFFSET    ; Jump to the kernel's entry point
    jmp $                 ; If the kernel returns, halt here

; Data and messages
BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit Real Mode", 13, 10, 0
MSG_PROT_MODE db "Landed in 32-bit Protected Mode", 13, 10, 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 13, 10, 0

; Pad the boot sector to 512 bytes and add the boot signature (0xAA55)
times 510 - ($-$$) db 0
    dw 0xaa55