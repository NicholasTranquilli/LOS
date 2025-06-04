;
; GDT (Global Descriptor Table)
;

gdt_start:

    ; Null descriptor (required, always first)
    times 8 db 0

; Code segment descriptor
; Each GDT entry is 8 bytes: [Limit Low][Base Low][Base Middle][Access][Flags+Limit High][Base High]
gdt_code:
    dw 0xFFFF          ; Limit Low: lower 16 bits of segment limit (max addressable offset)
    dw 0x0000          ; Base Low: lower 16 bits of the base address of the segment
    db 0x00            ; Base Middle: next 8 bits (bits 16-23) of the base address
    db 10011010b       ; Access: present, ring 0, executable, readable, accessed
    db 11001111b       ; Flags+Limit High: high 4 bits of limit (bits 16-19) and flags (granularity, 32-bit, etc)
    db 0x00            ; Base High: highest 8 bits (bits 24-31) of the base address

; Data segment descriptor
; Same layout as above, but access flags differ for data segment
; [Limit Low][Base Low][Base Middle][Access][Flags+Limit High][Base High]
gdt_data:
    dw 0xFFFF          ; Same as Code Segment
    dw 0x0000          ; Same as Code Segment
    db 0x00            ; Same as Code Segment
    db 10010010b       ; CHANGED -> Access: present, ring 0, data, writable, accessed
    db 11001111b       ; Same as Code Segment
    db 0x00            ; Same as Code Segment

gdt_end:

; GDT descriptor
gdt_descriptor:
    dw gdt_end - gdt_start - 1   ; Size (limit): size of GDT in bytes minus 1
    dd gdt_start                 ; Address: linear address of GDT

; Segment selectors (offsets into GDT, must be multiples of 8)
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start