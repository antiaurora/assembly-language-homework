DATAS SEGMENT
    ;此处输入数据段代码 
    buf1 db 100 dup(?)
    buf2 db 100 dup(?)
    file1 db 'A.txt',00h		;原文件
    f1 dw ?		;存放文件代号
    file2 db 'A_ENC.txt',00h	;加密文件
    f2 dw ?		;存放文件代号
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码
    mov si,10
    
;----------打开文件1----------
	mov ah,3dh
	lea dx,file1
	mov al,00
	int 21h
	mov f1,ax
	
;----------读文件----------
	mov ah,3fh
    mov bx,f1
    mov cx,100	;读一百个数据,此时AX=实际读入的字节数
    lea dx,buf1	;放到缓冲区
    int 21h
    
;----------加密，采用a~z倒置为z~a的简单加密----------
	mov cx,ax	;AX=实际读入的字节数
	mov si,0
encryption:
	cmp buf1[si],'a'	;如果不是小写字母
	jb change
	cmp buf1[si],'z'
	ja change
	
	mov ax,219		;'a'+'z'=219
	mov bl,buf1[si]
	sub ax,bx		;a~z倒置为z~a
	mov buf2[si],al
change:
	inc si
loop encryption    
    
;----------创建加密文件----------  
    mov ah,3ch
    mov cx,00
    lea dx,file2
    int 21h
    mov f2,ax	;存放新建的文件代号
	
;----------写入加密文件----------
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
    

