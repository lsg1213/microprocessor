[org 0x7c00]		; Assembly command
					; Let NASM compiler know starting address of memory
					; BIOS reads 1st sector and copied it on memory address 0x7c00
[bits 16] 			; Assembly command
					; Let NASM compiler know that this code consists of 16its

[SECTION .text] 	; Text section

START:				; Boot loader(1st sector) starts
    cli				; Clear interrupt
    xor ax, ax		; Initialize ax register
	mov ax, 0x8FF
	mov ds, ax		; Set data segment register
	mov bx, 0x00
	mov al, 0x01

;-----------Following code is for filling some values in the memory-------------;

mem:																		
	mov byte [ds:bx], al
	cmp bx, 0xFF
	je test_end
	jmp re

re:
	add al, 0x02
	add bx, 0x01
	jmp mem
	
test_end:
	cli
	xor ax, ax
	mov ds, ax
    mov ax, 0xB800
    mov es, ax 
	
;-------------------------------------------------------------------------------;

	sti						; Set interrupt
	
    call load_sectors 		; Load rest sectors
    jmp sector_2

load_sectors:			 	; Read and copy the rest sectors of disk

   	push es
    xor ax, ax
    mov es, ax									; es=0x0000
 	mov bx, sector_2 							; es:bx, Buffer Address Pointer
    mov ah,2 									; Read Sector Mode
    mov al,(sector_end - sector_2)/512 + 1  	; Sectors to Read Count
    mov ch,0 									; Cylinder Number=0
    mov cl,2 									; Sector Number=2
    mov dh,0 									; Head=0
    mov dl,0 									; Drive=0, A:drive
	int 0x13 									; BIOS interrupt
												; Services depend on ah value
    pop es
    ret

times   510-($-$$) db 0 		; $ : current address, $$ : start address of SECTION
								; $-$$ means the size of source
dw      0xAA55 					; signature bytes
								; End of Master Boot Record(1st Sector)
								
		

sector_2:						; Program Starts
	mov ax, 0x8FF
	mov ss, ax
	mov sp, 0x10
	mov ax, 0x1234
	push ax
	mov bx, 0x8FFC
	mov dl, byte [ds:bx]
	add ah, dl
	xchg al, bh
	mov bx, 0x8FFD
	mov word[ds:bx], ax
	sub al, ah
	mov bx, 0x8FFF
	mov byte[ds:bx], al
	

;-------------------------Write your code here----------------------------------;	
; Print your Name in VMware screen											    ;
; Print your ID in VMware screen											    ;
; Print the value(word size) in the Stack Pointer after executing the above code;

; 1:blue 2:green 3:emerald 4:red 5:purple
; 
; edi -> row, esi -> column

	jmp main

;function sector
print:
	cmp byte[bx], ''		;bx is the start of string, ax is index of string
	je new_line
	
continue:
	mov ah, [bx]

	mov byte[es:edi+esi], ah
	mov byte[es:edi+esi+1], 0x02
	call next_word

	jmp print
	
new_line:
	add edi, 0x0a0				;new line
	cmp edi, 0x280
	jne conti
	sub edi, 0x0a0
	ret

conti:
	mov ebx, 0x100
	mov dword[ebx], edi
	mov esi, 0				;move curser to the start of string
	mov ebx, 0x110
	mov dword[ebx], esi
	
	ret

next_word:
	
	mov ax, bx
	mov ebx, 0x200
	mov word[ebx], ax
	add esi, 0x02			;next is 2byte
	mov ebx, 0x110
	mov dword[ebx], esi
	mov ebx, 0x200
	mov bx, word[ebx]
	add bx, 0x01			;next charecter in string is 1byte
	ret

main:
	;initializing
	mov ebx, 0x100	;0x100 row value store
	mov dword[ebx], 0xa0
	mov ebx, 0x110	;0x110 column value store
	mov dword[ebx], 0
	mov ebx, 0x200	;0x200 output index store
	mov byte[ebx], 0
	mov ax, 0

	mov ebx, 0x100
	mov edi, [ebx]
	mov ebx, 0x110
	mov esi, [ebx]
	mov ebx, 0x200
	mov ax, [ebx]
	

	;NAME printing
	mov bx, NAMEE
	
	call print

	;ID printing
	mov bx, ID
	
	call print

	;Stack pointer printing
	mov bx, Answer
	
	call print
	
	;find stack pointer and print it
	
	pop ax

	mov ebx, 0x300
	mov word[ebx], ax
	
	shr ax, 12
	call check

	mov ax, [ebx]

	and ax, 0xf00
	shr ax, 8
	call check

	mov ax, [ebx]

	and ax, 0xf0
	shr ax, 4
	call check

	mov ax, [ebx]

	and ax, 0xf
	call check

	jmp sector_end

check:
	cmp ax, 0x09
	jna _print
	add ax, 0x07

_print:
	add ax, 0x30
	mov byte[es:edi+esi], al
	mov byte[es:edi+esi+1], 0x02
	add esi, 0x02

	ret
;-------------------------------------------------------------------------------;



;---------------------- Write y our Name and ID here-----------------------------;

ID  db 'ID : 2014314666',0
NAMEE db 'NAME : Lee Seung jin',0
Answer db 'A value in Stack Pointer(word size) : ',0

;-------------------------------------------------------------------------------;
	
sector_end:

