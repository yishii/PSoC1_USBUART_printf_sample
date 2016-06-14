	cpu LMM
	.module main.c
	.area text(rom, con, rel)
	.dbfile ./main.c
	.dbfunc e main _main fV
;            ram -> X+2
;              i -> X+0
_main::
	.dbline -1
	push X
	mov X,SP
	add SP,12
	.dbline 21
; /** 
;  * @file  main.c
;  * @brief PSoC USBUARTテスト メイン処理
;  *
;  * @author Yasuhiro ISHII
;  * @date 2007-01-01
;  * @version $Id: $
;  *
;  */
; 
; #include <m8c.h>        // part specific constants and macros
; #include <stdlib.h>
; #include "common.h"
; #include "PSoCAPI.h"    // PSoC API definitions for all User Modules
; 
; static void usbuart_stdout(char* str);
; 
; BYTE pData[32];  
; int Len;
; 
; void main(void){
	.dbline 22
; 	int i = 30;
	mov [X+1],30
	mov [X+0],0
	.dbline 25
; 	char ram[10];
; 
; 	M8C_EnableGInt;							// Global Interrupts有効化
		or  F, 01h

	.dbline 27
; 
; 	USBUART_Start(USBUART_5V_OPERATION);
	push X
	mov A,3
	xcall _USBUART_Start
	pop X
	.dbline 28
; 	tprintf_SetCallBack(usbuart_stdout);	// tprintf文字列出力用コールバック関数を登録
	mov A,>PL_usbuart_stdout
	push A
	mov A,<PL_usbuart_stdout
	push A
	xcall _tprintf_SetCallBack
	add SP,-2
L2:
	.dbline 29
L3:
	.dbline 29
; 	while(!USBUART_Init());					// USBUART初期化待ち
	push X
	xcall _USBUART_Init
	mov REG[0xd0],>__r0
	pop X
	cmp A,0
	jz L2
	xjmp L6
L5:
	.dbline 37
; 
; 	///////////////////////////////////////////////////////////////////////////
; 	// 初期化完了
; 	///////////////////////////////////////////////////////////////////////////
; 
; 	// 通常処理
; 
; 	while(1){
	.dbline 41
; 
; 		// 何かキー入力があるまで待つ
; 
; 		Len = USBUART_bGetRxCount();       //Get count of ready data
	push X
	xcall _USBUART_bGetRxCount
	pop X
	mov REG[0xd0],>_Len
	mov [_Len+1],A
	mov [_Len],0
	.dbline 42
; 		if (Len){
	cmp [_Len],0
	jnz X1
	cmp [_Len+1],0
	jz L8
X1:
	.dbline 42
	.dbline 43
; 			USBUART_ReadAll(pData);        //Read all data rom RX
	push X
	mov A,>_pData
	push A
	mov A,<_pData
	mov X,A
	pop A
	xcall _USBUART_ReadAll
	pop X
	.dbline 46
; 
; 			// キー入力があったら、テスト用のメッセージを表示する
; 			{
	.dbline 47
; 				i++;		// インクリメント
	inc [X+1]
	adc [X+0],0
	.dbline 49
; 
; 				tstrcpy(ram,"R A M!");
	mov A,>L10
	push A
	mov A,<L10
	push A
	mov REG[0xd0],>__r0
	mov [__r1],X
	add [__r1],2
	mov A,3
	push A
	mov A,[__r1]
	push A
	xcall _tstrcpy
	.dbline 51
; 
; 				ctprintf("i = %d(Hex:%X)(ROM:%S)(RAM:%s) %c%c%c\n\r",i,i,"Hello",ram,0x31,0x32,0x33);
	mov A,0
	push A
	mov A,51
	push A
	mov A,0
	push A
	mov A,50
	push A
	mov A,0
	push A
	mov A,49
	push A
	mov REG[0xd0],>__r0
	mov [__r1],X
	add [__r1],2
	mov A,3
	push A
	mov A,[__r1]
	push A
	mov A,>L12
	push A
	mov A,<L12
	push A
	mov A,[X+0]
	push A
	mov A,[X+1]
	push A
	mov A,[X+0]
	push A
	mov A,[X+1]
	push A
	mov A,>L11
	push A
	mov A,<L11
	push A
	xcall _ctprintf
	add SP,-20
	.dbline 52
; 			}
	.dbline 53
; 		}
L8:
	.dbline 54
L6:
	.dbline 37
	xjmp L5
X0:
	.dbline -2
	.dbline 56
; 	}
; 
; }
L1:
	add SP,-12
	pop X
	.dbline 0 ; func end
	jmp .
	.dbsym l ram 2 A[10:10]c
	.dbsym l i 0 I
	.dbend
	.dbfunc s usbuart_stdout _usbuart_stdout fV
;            len -> X+0
;            str -> X-5
_usbuart_stdout:
	.dbline -1
	push X
	mov X,SP
	add SP,2
	.dbline 61
; 
; /** USBUARTへ文字列出力する
;  * @param str 出力したいASCIIZ文字列に対するポインタ
;  */
; static void usbuart_stdout(char* str){
	.dbline 64
; 	int len;
; 
; 	len = tstrlen(str) + 1;
	mov A,[X-5]
	push A
	mov A,[X-4]
	push A
	xcall _tstrlen
	add SP,-2
	mov REG[0xd0],>__r0
	mov A,[__r1]
	add A,1
	mov [X+1],A
	mov A,[__r0]
	adc A,0
	mov [X+0],A
L14:
	.dbline 66
L15:
	.dbline 66
; 
; 	while (!USBUART_bTxIsReady());
	push X
	xcall _USBUART_bTxIsReady
	mov REG[0xd0],>__r0
	pop X
	cmp A,0
	jz L14
	.dbline 67
; 	USBUART_Write(str,len);
	mov A,[X+1]
	push X
	push A
	mov A,[X-5]
	push A
	mov A,[X-4]
	push A
	xcall _USBUART_Write
	add SP,-3
	pop X
	.dbline -2
	.dbline 69
; 
; }
L13:
	add SP,-2
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l len 0 I
	.dbsym l str -5 pc
	.dbend
	.area data(ram, con, rel)
	.dbfile ./main.c
_Len::
	.byte 0,0
	.dbsym e Len _Len I
	.area data(ram, con, rel)
	.dbfile ./main.c
_pData::
	.word 0,0,0,0,0
	.word 0,0,0,0,0
	.word 0,0,0,0,0
	.byte 0,0
	.dbsym e pData _pData A[32:32]c
	.area lit(rom, con, rel)
L12:
	.byte 'H,'e,'l,'l,'o,0
L11:
	.byte 'i,32,61,32,37,'d,40,'H,'e,'x,58,37,'X,41,40,'R
	.byte 'O,'M,58,37,'S,41,40,'R,'A,'M,58,37,'s,41,32,37
	.byte 'c,37,'c,37,'c,10,13,0
L10:
	.byte 'R,32,'A,32,'M,33,0
	.area func_lit
PL_usbuart_stdout:	.word _usbuart_stdout
