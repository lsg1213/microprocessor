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

	jmp main

printf_s:
	mov cl, byte [ds:eax]
	mov byte [es: edi], cl
	inc edi
	mov byte [es: edi], bl
	inc edi

	inc eax								
	mov cl, byte [ds:eax]
	mov ch, 0
	cmp cl, ch							
	je printf_end						
	jmp printf_s	

printf_end:
	ret

main:
;-------------------------Write your code here----------------------------------;	
; Print your Name in VMware screen											    ;
; Print your ID in VMware screen											    ;
; Print the value(word size) in the Stack Pointer after executing the above code;
;																				;
;																				;
;																				;
;																				;
;																				;
;																				;
;-------------------------------------------------------------------------------;

	mov eax, ID 
	mov edi, 80*2*1+0
	mov bl, 0x02
	call printf_s

	mov eax, NAMEE
	mov edi, 80*2*2+0
	mov bl, 0x02
	call printf_s

	mov eax, Answer
	mov edi, 80*2*3+0
	mov bl, 0x02
	call printf_s

	pop dx
	mov ax, dx
	shr dx, 12

	add dx, '0'
	mov byte [es:edi], dl
	inc edi
	mov byte [es:edi], 0x2
	inc edi

	mov dx, ax
	shl dx, 4
	shr dx, 12
	
	add dx, '0'
	mov byte [es:edi], dl
	inc edi
	mov byte [es:edi], 0x2
	inc edi

	mov dx, ax
	shl dx, 8
	shr dx, 12
	
	add dx, '0'
	mov byte [es:edi], dl
	inc edi
	mov byte [es:edi], 0x2
	inc edi

	mov dx, ax
	shl dx, 12
	shr dx, 12
	
	add dx, '0'
	sub dx, '9'
	sub dx, 1
	add dx, 'a'
	mov byte [es:edi], dl
	inc edi
	mov byte [es:edi], 0x2
	inc edi


;---------------------- Write your Name and ID here-----------------------------;

ID  db 'ID : 2015000000',0
NAMEE db 'NAME : Lee Seung jin',0
Answer db 'A value in Stack Pointer(word size) : ',0

;-------------------------------------------------------------------------------;
	
sector_end:

