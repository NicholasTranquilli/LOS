;
;   16 bit switch to protected mode function
;

[bits 16]
switch_to_32:
    cli                         ; Disable interrupts for safety
    lgdt [gdt_descriptor]       ; Load address and size of GDT into GDTR
    mov eax, cr0                ; Get current control register 0
    or eax, 0x1                 ; Set PE (Protection Enable) bit to enter protected mode
    mov cr0, eax                ; Write back to CR0 to enable protected mode
    jmp CODE_SEG:init_kernel_32 ; Far jump: loads CS with code segment selector and flushes pipeline

;
;   32 bit kernel initialization function
; 

[bits 32]
init_kernel_32:
    mov ax, DATA_SEG            ; Load data segment selector
    mov ds, ax                  ; Update DS (data segment)
    mov ss, ax                  ; Update SS (stack segment)
    mov es, ax                  ; Update ES (extra segment)
    mov fs, ax                  ; Update FS
    mov gs, ax                  ; Update GS

    mov ebp, 0x90000            ; Set up a stack base pointer (arbitrary safe address)
    mov esp, ebp                ; Set stack pointer

    call jump_kernel            ; Call the kernel entry point (should be set up elsewhere)