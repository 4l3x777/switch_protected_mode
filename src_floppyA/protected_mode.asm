use16 
org 0x7c00 ; bootloader offset
.main:
    xor ax, ax     ; DS=SS=0. Real mode code below doesn't use ES
    mov ds, ax
    mov ss, ax                 
    mov sp, 0x7c00 ; Stack at 0x0000:0x7c00 below bootloader
    cld            ; Set string instructions to use forward movement
	
	; clean screen
	mov ax, 0x3
	int 0x10

    lea si, [MSG_REAL_MODE]
    call .println
	
	; wait user's any keyboard symbol
    xor ax, ax
    int 0x16
	
	; clean screen
	mov ax, 0x3
	int 0x10

	; read code_section
	mov si, 0x7e00		; code selector base addr (GDT)
	push si
	push 1 				; 1 sector FLOPPY1
	call .read_sector
	add sp, 2
	
	; read data_section
	mov si, 0x8000		; data selector base addr (GDT)
	push si
	push 2 				; 1 sector FLOPPY1
	call .read_sector
	add sp, 2
	
	call .switch_to_protected_mode

include 'utils.asm'
include 'gdt.asm'
include "switch_protected_mode.asm"

MSG_REAL_MODE db "Hi from 16-bit real mode", 0

; bootsector
times 510-($-$$) db 0
dw 0xaa55 ; Magic number for boot sector