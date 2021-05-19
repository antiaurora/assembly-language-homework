DATAS SEGMENT
    ;此处输入数据段代码  
    buf1 db 100,?,100 dup(?)		;缓冲区，首位是最大个数，次位自动获得输入的字符个数，后面是缓冲区
    buf2 db 100,?,100 dup(?)
    filename db 100 dup(?)	;文件名
    filename2 db 'A.txt'	;文件名	
    f dw ?	;存放文件代号
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
    
;----------输入文件名----------
;	lea dx,buf1	;有效地址传送
;    mov ah,0ah	;21中断中的ah号功能：键盘输入到缓冲区
;    int 21h
    
;----------文件名赋值----------
;    lea si,buf1+2
;    lea di,filename
;    cld
;    mov cx,10
;    rep movsb

;	lea dx,filename
;	mov cx,BUF1+1	;次数
;	lea si,BUF1+2	;地址
;next:  
;	mov dl,[si]
;	mov ah,2
;	int 21h
;	inc si
;	loop next
	
;----------书上的例子也还是不行----------	
;	mov dx,offset buf2
;	mov ah,10
;	int 21h
;	lea si,buf2+2
;	lea di,filename
;	mov ch,0
;	mov cl,buf2+1
;	rep movsb
    
;----------做个换行----------
;    mov ah, 02h
;    mov dl,0ah 
;	int 21h
    
    mov SI,10
;----------创建P1.txt文件,在Masm/bin----------   
    mov cx,00		;CX=文件属性
	lea dx,filename2	;有效地址传
    mov ah,3ch		;21h中断的3ch功能：建立文件。成功：AX=文件代号，错误：AX=错误码送
    int 21h
    mov f,ax		;存放新建的文件代号给f
    
;----------键盘输入字符串到文件----------
    lea dx,buf2		;有效地址传送
    mov ah,0ah		;21中断中的ah号功能：键盘输入到缓冲区
    int 21h
    
 ;   xor ch,ch		;ch置零
    mov cl,[buf2+1]	;CX=写入的字节数。在输入完成后，[buf+1]自动获得输入的字符个数
    lea dx,buf2	+2	;DS:DX=数据缓冲区地址，从这里开始键盘输入缓存
    mov bx,f		;BX=文件代号
    mov ah,40h		;21中断中的40h号功能：写文件或设备
    int 21h
      
;----------关文件----------
	mov bx,f		;BX=文件代号
	mov ah,3eh		;21中断中的3eh号功能：关闭文件
	int 21h
	
    MOV AH,4CH
    INT 21H

CODES ENDS
    END START







