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
    jmp main

load_sectors:			 	; Read and copy the rest sectors of disk

   	push es
    xor ax, ax
    mov es, ax									; es=0x0000
 	mov bx, main 							; es:bx, Buffer Address Pointer
    mov ah,2 									; Read Sector Mode
    mov al,(sector_end - main)/512 + 1  	; Sectors to Read Count
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
								


;------------------------------------------------------------------------------------
jmp main
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

main:

    ;initializing
	mov ebx, 0x100	;0x100 row value store
	mov dword[ebx], 0xa0
	mov ebx, 0x110	;0x110 column value store
	mov dword[ebx], 0
    mov ebx, 0x100
	mov edi, [ebx]
	mov ebx, 0x110
	mov esi, [ebx]

    mov eax, 0x01234567
    mov dword[ebx], 0x89abcdef
    
    
    imul eax, [ebx]
    

    mov ebx, 0x300
    mov dword[ebx], eax

    and eax, 0xf0000000
    shr eax, 28
    call check

    mov ebx, 0x300
    mov eax, [ebx]
    and eax, 0xf000000
    shr eax, 24
    call check

    mov ebx, 0x300
    mov eax, [ebx]
    and eax, 0xf00000
    shr eax, 20
    call check

    mov ebx, 0x300
    mov eax, [ebx]
    and eax, 0xf0000
    shr eax, 16
    call check

    mov ebx, 0x300
    mov eax, [ebx]
    and eax, 0xf000
    shr eax, 12
    call check

    mov ebx, 0x300
    mov eax, [ebx]
    and eax, 0xf00
    shr eax, 8
    call check

    mov ebx, 0x300
    mov eax, [ebx]
    and eax, 0xf0
    shr eax, 4
    call check

    mov ebx, 0x300
    mov eax, [ebx]
    and eax, 0xf
    call check
sector_end: