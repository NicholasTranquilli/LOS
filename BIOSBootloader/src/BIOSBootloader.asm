BITS 16
ORG 0x7C00

start:
    mov si, hello_msg 

print_loop:
    lodsb
    cmp al, 0
    je done_printing
    mov ah, 0x0E
    int 0x10
    jmp print_loop

done_printing:

hang:
    jmp hang

hello_msg db 'Hello, World!', 0

times 510 - ($ - $$) db 0
dw 0xAA55
