;11-1
;c11_mbr.asm
;
;2011-5-16 19:54

;====================================================
  mov ax,cs                          ; init stack
  mov ss,ax
  mov sp,0x7c00

  ;GDT
  mov ax,[cs:gdt_base+0x7c00]        ;16
  mov dx,[cs:gdt_base+0x7c00+0x02]   ;16
  mov bx,16        
  div bx            
  mov ds,ax                          ; logic addr to DS
  mov bx,dx                          ; offset

  
  mov dword [bx+0x00],0x00           ; null descriptor
  mov dword [bx+0x04],0x00  

  
  mov dword [bx+0x08],0x7c0001ff     ; code seg descriptor
  mov dword [bx+0x0c],0x00409800     

  
  mov dword [bx+0x10],0x8000ffff     ; data seg descriptor
  mov dword [bx+0x14],0x0040920b     

  
  mov dword [bx+0x18],0x00007a00      ; stack seg descriptor
  mov dword [bx+0x1c],0x00409600

  ;GDTR
  mov word [cs: gdt_size+0x7c00],31  ; 4*8byte - 1
                                      
  lgdt [cs: gdt_size+0x7c00]         ; load to GDTR register

  in al,0x92                         ; open A20
  or al,0000_0010B
  out 0x92,al                        

  cli                                ; forbid interrupt
                                     
  mov eax,cr0                        ; set CR0, enter protect mode
  or eax,1
  mov cr0,eax                        ;

  
  jmp dword 0x0008:flush             ; compile with [bits 16]
;
[bits 32] 

  flush:
      mov cx,00000000000_10_000B         ; (0x10)
      mov ds,cx

      ; character "Protect mode OK." 
      mov byte [0x00],'P'                ; 
      mov byte [0x02],'r'
      mov byte [0x04],'o'
      mov byte [0x06],'t'
      mov byte [0x08],'e'
      mov byte [0x0a],'c'
      mov byte [0x0c],'t'
      mov byte [0x0e],' '
      mov byte [0x10],'m'
      mov byte [0x12],'o'
      mov byte [0x14],'d'
      mov byte [0x16],'e'
      mov byte [0x18],' '
      mov byte [0x1a],'O'
      mov byte [0x1c],'K'

      ; stack segment
      mov cx,00000000000_11_000B         ; init stack on protect mode
      mov ss,cx
      mov esp,0x7c00

      mov ebp,esp                        ; 
      push byte '.'                      ;
      
      sub ebp,4
      cmp ebp,esp                        ; ESP register
      jnz ghalt                          
      pop eax
      mov [0x1e],al                      ;
      
  ghalt:     
    hlt                                ;

;-------------------------------------------------------------------------------
     
gdt_size         dw 0
gdt_base         dd 0x00007e00     ; GDT base addr
                    
times 510-($-$$) db 0
db 0x55,0xaa