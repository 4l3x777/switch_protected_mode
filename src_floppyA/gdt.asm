align 8
.gdt_start: ; don't remove the labels, they're needed to compute sizes and jumps
    ; the GDT starts with a null 8-byte
    dd 0x0 ; 4 byte
    dd 0x0 ; 4 byte

; GDT for code segment. base = 0x7e00, length = 0x200 | Access: RX
.gdt_code: 
	db 0x00, 0x02, 0x00, 0x7e, 0x00, 0x9a, 0x40, 0x00 ; build from DescriptorBuilder

; GDT for data segment. base = 0x8000, length = 0x200 | Access: RW
.gdt_data:
	db 0x00, 0x02, 0x00, 0x80, 0x00, 0x92, 0x40, 0x00 ; build from DescriptorBuilder

; GDT for data segment. base = 0xb8000, length = 0xffff | Access: RW	
.gdt_gpu:
	db 0xff, 0xff, 0x00, 0x80, 0x0b, 0x92, 0x40, 0x00 ; build from DescriptorBuilder

.gdt_end:

; GDT descriptor
.gdt_descriptor:
    dw .gdt_end - .gdt_start - 1 	; size (16 bit), always one less of its true size
    dd .gdt_start 					; address (32 bit)

; define SEG constants
CODE_SEG equ .gdt_code - .gdt_start
DATA_SEG equ .gdt_data - .gdt_start
GPU_SEG equ .gdt_gpu - .gdt_start