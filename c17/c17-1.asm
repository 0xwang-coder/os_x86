;�����嵥17-3
;�ļ�����c17_1.asm
;
;
	program_length   dd program_end          ;�����ܳ���#0x00
	entry_point      dd start                ;������ڵ�#0x04
	salt_position    dd salt_begin           ;SALT����ʼƫ����#0x08 
	salt_items       dd (salt_end-salt_begin)/256 ;SALT��Ŀ��#0x0C

;-------------------------------------------------------------------------------

;
salt_begin:                                     
	PrintString      db  '@PrintString'
			times 256-($-PrintString) db 0
				
	TerminateProgram db  '@TerminateProgram'
			times 256-($-TerminateProgram) db 0

	ReadDiskData     db  '@ReadDiskData'
			times 256-($-ReadDiskData) db 0
	
	PrintDwordAsHex  db  '@PrintDwordAsHexString'
			times 256-($-PrintDwordAsHex) db 0

salt_end:
	message_0       db  '  User task A->;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'
			db  0x0d,0x0a,0

;-------------------------------------------------------------------------------
[bits 32]
;-------------------------------------------------------------------------------

start:      
	mov ebx,message_0
	call far [PrintString]
	jmp start
			
	call far [TerminateProgram]              ;
    
;-------------------------------------------------------------------------------
program_end: