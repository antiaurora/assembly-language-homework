DATAS SEGMENT
    ;�˴��������ݶδ��� 
    buf1 db 100 dup(?)
    buf2 db 100 dup(?)
    file1 db 'A.txt',00h		;ԭ�ļ�
    f1 dw ?		;����ļ�����
    file2 db 'A_ENC.txt',00h	;�����ļ�
    f2 dw ?		;����ļ�����
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;�˴��������δ���
    mov si,10
    
;----------���ļ�1----------
	mov ah,3dh
	lea dx,file1
	mov al,00
	int 21h
	mov f1,ax
	
;----------���ļ�----------
	mov ah,3fh
    mov bx,f1
    mov cx,100	;��һ�ٸ�����,��ʱAX=ʵ�ʶ�����ֽ���
    lea dx,buf1	;�ŵ�������
    int 21h
    
;----------���ܣ�����a~z����Ϊz~a�ļ򵥼���----------
	mov cx,ax	;AX=ʵ�ʶ�����ֽ���
	mov si,0
encryption:
	cmp buf1[si],'a'	;�������Сд��ĸ
	jb change
	cmp buf1[si],'z'
	ja change
	
	mov ax,219		;'a'+'z'=219
	mov bl,buf1[si]
	sub ax,bx		;a~z����Ϊz~a
	mov buf2[si],al
change:
	inc si
loop encryption    
    
;----------���������ļ�----------  
    mov ah,3ch
    mov cx,00
    lea dx,file2
    int 21h
    mov f2,ax	;����½����ļ�����
	
;----------д������ļ�----------
    mov ah,40h
    mov bx,f2
    xor cx,cx
    mov cl,100
    lea dx,buf2
    int 21h    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
    

