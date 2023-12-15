use16
.switch_to_protected_mode:  
    ; Fast method of enabling A20 may not work on all x86 BIOSes
    ; It is good enough for emulators and most modern BIOSes
    ; See: https://wiki.osdev.org/A20_Line
    cli          ; Disable interrupts	
	;Fast A20 Gate
    in al, 0x92
    or al, 2
    out 0x92, al 
	; Enable A20 using Fast Method

    lgdt [.gdt_descriptor]           	; load the GDT descriptor
    mov eax, cr0
    or eax, 0x1                       	; set 32-bit mode bit in cr0	
    mov cr0, eax
	
	xor ax, ax
		
	; INIT DS WITH DATA SELECTOR 		; update the segment registers
	mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov fs, ax
    mov gs, ax
	
	; INIT ES WITH GPU SELECTOR (VIDEO MEMORY)
	mov ax, GPU_SEG
	mov es, ax
	
	xor ax, ax

    mov ebp, 0x90000 		; Set the stack to grow down from area under
							; EBDA/Video memory

    mov esp, ebp     		; set the stack pointer to the top of the free space
	
	jmp CODE_SEG:0 			; far jump by using a CODE SELECTOR
	