use16
.println:
    lodsb 				; load byte from string (DS:SI register)
    test al, al
    jz   .exit_println
    mov  ah, 0xE
    int  0x10
    jmp  .println
.exit_println:
    mov  al, 0xA 		; newline
    int  0x10 
    mov al, 0x0d 		; carriage return
    int 0x10
    ret
	
.read_sector:
    push bp
    mov bp, sp
    
    mov ah, 2 			; read sector
    mov al, 1			; one sector
    mov dh, 0
    mov dl, 1 			; floppy 1
    mov ch, 0
    mov cl, [bp+4] 		; sector number
    mov bx, [bp+6] 		; buffer
    int 0x13
    
    mov sp, bp
    pop bp
    ret
