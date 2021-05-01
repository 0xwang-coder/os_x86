;11-1
;c11_mbr.asm
;
;2011-5-16 19:54

  ;
  mov ax,cs      
  mov ss,ax
  mov sp,0x7c00

  ;GDT
  mov ax,[cs:gdt_base+0x7c00]        ;��16λ 
  mov dx,[cs:gdt_base+0x7c00+0x02]   ;��16λ 
  mov bx,16        
  div bx            
  mov ds,ax                          ;��DSָ��ö��Խ��в���
  mov bx,dx                          ;������ʼƫ�Ƶ�ַ 

  ;
  mov dword [bx+0x00],0x00
  mov dword [bx+0x04],0x00  

  ;
  mov dword [bx+0x08],0x7c0001ff     
  mov dword [bx+0x0c],0x00409800     

  ;
  mov dword [bx+0x10],0x8000ffff     
  mov dword [bx+0x14],0x0040920b     

  ;
  mov dword [bx+0x18],0x00007a00
  mov dword [bx+0x1c],0x00409600

  ;GDTR
  mov word [cs: gdt_size+0x7c00],31  ;  
                                      
  lgdt [cs: gdt_size+0x7c00]

  in al,0x92                         ;
  or al,0000_0010B
  out 0x92,al                        ;A20

  cli                                ;
                                    ;
  mov eax,cr0
  or eax,1
  mov cr0,eax                        ;

  ;���½��뱣��ģʽ... ...
  jmp dword 0x0008:flush             ;16λ��������ѡ���ӣ�32λƫ��
                                    ;����ˮ�߲����л������� 
  [bits 32] 

    flush:
         mov cx,00000000000_10_000B         ;�������ݶ�ѡ����(0x10)
         mov ds,cx

         ;��������Ļ����ʾ"Protect mode OK." 
         mov byte [0x00],'P'  
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

         ;�����ü򵥵�ʾ������������32λ����ģʽ�µĶ�ջ���� 
         mov cx,00000000000_11_000B         ;���ض�ջ��ѡ����
         mov ss,cx
         mov esp,0x7c00

         mov ebp,esp                        ;�����ջָ�� 
         push byte '.'                      ;ѹ�����������ֽڣ�
         
         sub ebp,4
         cmp ebp,esp                        ;�ж�ѹ��������ʱ��ESP�Ƿ��4 
         jnz ghalt                          
         pop eax
         mov [0x1e],al                      ;��ʾ��� 
      
  ghalt:     
         hlt                                ;�Ѿ���ֹ�жϣ������ᱻ���� 

;-------------------------------------------------------------------------------
     
gdt_size         dw 0
gdt_base         dd 0x00007e00     ;GDT
                    
times 510-($-$$) db 0
db 0x55,0xaa