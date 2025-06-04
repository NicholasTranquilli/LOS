;
;   16 bit print function
;

[bits 16]
print:
    pusha
.print_loop:
    mov al, [bx]        ; Load character from [bx]
    cmp al, 0           ; Check for null terminator
    je .done
    mov ah, 0x0E        ; BIOS teletype function
    int 0x10
    inc bx
    jmp .print_loop
.done:
    popa
    ret

;
;   32 bit print function for protected mode
;

[bits 32]
VIDEO_MEMORY equ 0xb8000 ; the address of the video memory in text mode
WHITE_ON_BLACK equ 0x0f ; the color byte for each character

print32:
    pusha
    mov edx, VIDEO_MEMORY
.print32_loop:
    mov al, [ebx] ; [ebx] is the address of our character
    mov ah, WHITE_ON_BLACK

    cmp al, 0 ; check if end of string
    je .print32_done

    mov [edx], ax ; store character + attribute in video memory
    add ebx, 1 ; next char
    add edx, 2 ; next video memory position

    jmp .print32_loop
.print32_done:
    popa
    ret