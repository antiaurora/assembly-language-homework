DATAS SEGMENT
    ;�˴��������ݶδ���  
    buf1 db 100,?,100 dup(?)		;����������λ������������λ�Զ����������ַ������������ǻ�����
    buf2 db 100,?,100 dup(?)
    filename db 100 dup(?)	;�ļ���
    filename2 db 'A.txt'	;�ļ���	
    f dw ?	;����ļ�����
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
    
;----------�����ļ���----------
;	lea dx,buf1	;��Ч��ַ����
;    mov ah,0ah	;21�ж��е�ah�Ź��ܣ��������뵽������
;    int 21h
    
;----------�ļ�����ֵ----------
;    lea si,buf1+2
;    lea di,filename
;    cld
;    mov cx,10
;    rep movsb

;	lea dx,filename
;	mov cx,BUF1+1	;����
;	lea si,BUF1+2	;��ַ
;next:  
;	mov dl,[si]
;	mov ah,2
;	int 21h
;	inc si
;	loop next
	
;----------���ϵ�����Ҳ���ǲ���----------	
;	mov dx,offset buf2
;	mov ah,10
;	int 21h
;	lea si,buf2+2
;	lea di,filename
;	mov ch,0
;	mov cl,buf2+1
;	rep movsb
    
;----------��������----------
;    mov ah, 02h
;    mov dl,0ah 
;	int 21h
    
    mov SI,10
;----------����P1.txt�ļ�,��Masm/bin----------   
    mov cx,00		;CX=�ļ�����
	lea dx,filename2	;��Ч��ַ��
    mov ah,3ch		;21h�жϵ�3ch���ܣ������ļ����ɹ���AX=�ļ����ţ�����AX=��������
    int 21h
    mov f,ax		;����½����ļ����Ÿ�f
    
;----------���������ַ������ļ�----------
    lea dx,buf2		;��Ч��ַ����
    mov ah,0ah		;21�ж��е�ah�Ź��ܣ��������뵽������
    int 21h
    
 ;   xor ch,ch		;ch����
    mov cl,[buf2+1]	;CX=д����ֽ�������������ɺ�[buf+1]�Զ����������ַ�����
    lea dx,buf2	+2	;DS:DX=���ݻ�������ַ�������￪ʼ�������뻺��
    mov bx,f		;BX=�ļ�����
    mov ah,40h		;21�ж��е�40h�Ź��ܣ�д�ļ����豸
    int 21h
      
;----------���ļ�----------
	mov bx,f		;BX=�ļ�����
	mov ah,3eh		;21�ж��е�3eh�Ź��ܣ��ر��ļ�
	int 21h
	
    MOV AH,4CH
    INT 21H

CODES ENDS
    END START







