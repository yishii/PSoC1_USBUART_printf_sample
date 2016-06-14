	cpu LMM
	.module tprintf.c
	.area text(rom, con, rel)
	.dbfile ./tprintf.c
	.dbfunc e ctprintf _ctprintf fI
;            len -> X+82
;             ap -> X+80
;            buf -> X+0
;            fmt -> X-5
_ctprintf::
	.dbline -1
	push X
	mov X,SP
	add SP,84
	.dbline 29
; /*
;   Tiny printf module
;    for Embedded microcontrollers
;    Copyright(C) 2005-2006 Yasuhiro ISHII
;    File Version : 0.3
; 
;    (������tsprintf��uart_txs���g�p���܂�)
; 
;    0.3 : ���o�֐����R�[���o�b�N�ɕύX
;    0.2 : vtsprintf���쐬���ēn���悤�ɂ���
;    0.1 : First version
; */
; 
; //#include <stdarg.h>
; #include "common.h"
; #include "./tsprintf.h"
; 
; int ctprintf(const char* , ...);
; void tprintf_SetCallBack(void (*)(char*));
; 
; static void (*uart_txs)(char*);
; 
; /** const������pTiny printf�֐�
;  * @param fmt �����w�蕶����
;  * @param [argument]... �ȗ��\�Ȉ���
;  * @return ���������̕�����
;  * @note fmt�Ɏw�肷�镶�����ROM���Ɋm�ۂ������̂��w�肵�Ă�������
;  */
; int ctprintf(const char* fmt, ...){
	.dbline 35
; 	char buf[80];
; 	va_list ap;
; 	int len;
; 
; 	// �R�[���o�b�N���ݒ肳��Ă��Ȃ��ꍇ�̊m�F
; 	if (uart_txs == NULL){
	mov REG[0xd0],>_uart_txs
	mov A,[_uart_txs+1]
	push A
	mov A,[_uart_txs]
	mov REG[0xd0],>__r0
	mov [__r0],A
	pop A
	mov [__r1],A
	mov A,[__r0]
	push X
	push A
	mov X,[__r1]
	romx
	mov [__r0],A
	pop A
	inc X
	adc A,0
	romx
	pop X
	cmp [__r0],0
	jnz L2
	cmp A,0
	jnz L2
X0:
	.dbline 35
	.dbline 36
; 		return(-1);
	mov REG[0xd0],>__r0
	mov [__r1],-1
	mov [__r0],-1
	xjmp L1
L2:
	.dbline 39
; 	}
; 
; 	va_start(ap, fmt);
	mov REG[0xd0],>__r0
	mov [__r1],X
	sub [__r1],5
	mov A,[__r1]
	mov [X+81],A
	mov [X+80],3
	.dbline 41
; 	
; 	len = cvtsprintf(buf, fmt, ap);
	mov A,[X+80]
	push A
	mov A,[X+81]
	push A
	mov A,[X-5]
	push A
	mov A,[X-4]
	push A
	mov A,3
	push A
	push X
	xcall _cvtsprintf
	add SP,-6
	mov REG[0xd0],>__r0
	mov A,[__r1]
	mov [X+83],A
	mov A,[__r0]
	mov [X+82],A
	.dbline 43
; 
; 	va_end(ap);
	.dbline 46
; 
; 	// �o�͗p�R�[���o�b�N�֐����R�[��
; 	(*uart_txs)(buf);
	mov A,3
	push A
	push X
	mov REG[0xd0],>_uart_txs
	mov A,[_uart_txs+1]
	push A
	mov A,[_uart_txs]
	mov REG[0xd0],>__r0
	mov [__r0],A
	pop A
	mov [__r1],A
	mov A,[__r0]
	push X
	push A
	mov X,[__r1]
	romx
	mov [__r0],A
	pop A
	inc X
	adc A,0
	romx
	mov [__r1],A
	pop X
	xcall __icall
	add SP,-2
	.dbline 48
; 	
; 	return(len);
	mov REG[0xd0],>__r0
	mov A,[X+83]
	mov [__r1],A
	mov A,[X+82]
	mov [__r0],A
	.dbline -2
L1:
	add SP,-84
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l len 82 I
	.dbsym l ap 80 pc
	.dbsym l buf 0 A[80:80]c
	.dbsym l fmt -5 pc
	.dbend
	.dbfunc e tprintf_SetCallBack _tprintf_SetCallBack fV
;           func -> X-5
_tprintf_SetCallBack::
	.dbline -1
	push X
	mov X,SP
	.dbline 55
; }
; 
; /** Type printf�W���o�͗p�֐����R�[���o�b�N�o�^����
;  * @param func ASCIIZ��������o�͂ł���void func(char*)�^�֐��ւ̃|�C���^
;  * @note NULL���w�肵�Ȃ�����
;  */
; void tprintf_SetCallBack(void (*func)(char*)){
	.dbline 57
; 
; 	uart_txs = func;
	mov REG[0xd0],>_uart_txs
	mov A,[X-4]
	mov [_uart_txs+1],A
	mov A,[X-5]
	mov [_uart_txs],A
	.dbline -2
	.dbline 59
; 
; }
L4:
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l func -5 pfV
	.dbend
	.area data(ram, con, rel)
	.dbfile ./tprintf.c
_uart_txs:
	.byte 0,0
	.dbsym s uart_txs _uart_txs pfV
