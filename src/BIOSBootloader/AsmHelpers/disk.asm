;
;   16 bit load disk function
;

[bits 16]
load_disk:
    pusha                   ; Save all general-purpose registers
    push dx                 ; Save DX (contains drive and sector count info)

    ; Set up registers for BIOS INT 13h disk read
    mov ah, 0x02            ; AH = 0x02 (read sectors)
    mov al, dh              ; AL = number of sectors to read (from DH)
    mov cl, 0x02            ; CL = starting sector (2, since 1 is boot sector)
    mov ch, 0x00            ; CH = cylinder (0)
    mov dh, 0x00            ; DH = head (0)
    ; DL = drive number (already set by caller)
    ; ES:BX = buffer address (already set by caller)

    int 0x13                ; Call BIOS to read sectors
    jc .disk_error          ; If carry flag set, there was an error

    pop dx                  ; Restore DX (original value)
    cmp al, dh              ; AL = sectors actually read, DH = requested
    jne .sectors_error      ; If not equal, error
    popa                    ; Restore all registers
    ret

; Error: Disk read failed
.disk_error:
    mov bx, DISK_ERROR      ; BX = pointer to error string
    call print
    jmp .disk_loop

; Error: Wrong number of sectors read
.sectors_error:
    mov bx, SECTORS_ERROR   ; BX = pointer to error string
    call print

.disk_loop:
    jmp $                   ; Infinite loop

DISK_ERROR: db "Disk read error", 13, 10, 0
SECTORS_ERROR: db "Incorrect number of sectors read", 13, 10, 0

