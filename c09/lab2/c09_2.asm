;9-2
;c09_2.asm
;BIOS interrupt
;
         
;===============================================================================
SECTION header vstart=0                     ;
	program_length  dd program_end          ;[0x00]
	
	; entry
	code_entry      dw start                ;[0x04]
									dd section.code.start   ;[0x06] 
	
	realloc_tbl_len dw (header_end-realloc_begin)/4
                                            ;[0x0a]
    
  realloc_begin:
    ;          
    code_segment    dd section.code.start   ;[0x0c]
    data_segment    dd section.data.start   ;[0x14]
    stack_segment   dd section.stack.start  ;[0x1c]
    
header_end:                
    
;===============================================================================
SECTION code align=16 vstart=0           ;
start:
	mov ax,[stack_segment]							; init register
	mov ss,ax
	mov sp,ss_pointer
	mov ax,[data_segment]
	mov ds,ax
	
	mov cx,msg_end-message							; 
	mov bx,message
      
 	.putc:
		mov ah,0x0e
		mov al,[bx]
		int 0x10
		inc bx														; point to next char position
		loop .putc

 	.reps:
		mov ah,0x00												; read char from keyboard
		int 0x16
		
		mov ah,0x0e												; show char from keyboard on screen
		mov bl,0x07
		int 0x10

  	jmp .reps													; continue read char from keyboard

;===============================================================================
SECTION data align=16 vstart=0

	message       db 'Hello, friend!',0x0d,0x0a
								db 'This simple procedure used to demonstrate '
								db 'the BIOS interrupt.',0x0d,0x0a
								db 'Please press the keys on the keyboard ->'
	msg_end:
                   
;===============================================================================
SECTION stack align=16 vstart=0
           
  resb 256
ss_pointer:
 
;===============================================================================
SECTION program_trail
program_end: