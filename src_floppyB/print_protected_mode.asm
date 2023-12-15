;CODE SELECTOR
use32
; FROM HERE AND BELOW CODE EXECUTED IN PROTECTED MODE
code_selector:			   
lea esi, [msg - data_selector]
xor edi, edi
; COPY MESSAGE TO VIDEO MEMORY
lea ecx, [msg_end - msg]
rep movsb
jmp $

db 512-($-code_selector) dup(0)

data_selector:
ATR EQU 0x30 ; green

msg         db 'H', ATR, 'i', ATR, ' ', ATR
            db 'f', ATR, 'r', ATR, 'o', ATR, 'm', ATR, ' ', ATR
            db '3', ATR, '2', ATR, '-', ATR, 'b', ATR, 'i', ATR, 't', ATR, ' ', ATR
            db 'p', ATR, 'r', ATR, 'o', ATR, 't', ATR, 'e', ATR, 'c', ATR, 't', ATR, 'e', ATR, 'd', ATR, ' ', ATR
            db 'm', ATR, 'o', ATR, 'd', ATR, 'e', ATR
msg_end:           

db 512-($-data_selector) dup(0)