OUTPUT_FORMAT(binary)
ENTRY(kernel_main)

SECTIONS
{
    /* Place kernel at 0x10000 (physical address) */
    . = 0x10000;
    .text : {
        *(.text)
    }
    .rodata : {
        *(.rodata*)
    }
    .data : {
        *(.data*)
    }
    .bss : {
        __bss_start = .;
        *(.bss*)
        *(COMMON)
        __bss_end = .;
    }
}
