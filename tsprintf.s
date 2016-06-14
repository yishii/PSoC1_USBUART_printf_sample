	cpu LMM
	.module tsprintf.c
	.area text(rom, con, rel)
	.dbfile ./tsprintf.c
	.dbfunc e ctsprintf _ctsprintf fI
;         result -> X+2
;            arg -> X+0
;            fmt -> X-7
;           buff -> X-5
_ctsprintf::
	.dbline -1
	push X
	mov X,SP
	add SP,4
	.dbline 48
; /*
;   Tiny sprintf module
;    for Embedded microcontrollers
;    Copyright(C) 2005 Yasuhiro ISHII
;    
;    File Version : 1.3
;    Copyright(C) 2005-2007 Yasuhiro ISHII
; 
;    【バージョンアップ履歴】
;    0.1 : とりあえずなんか動いた版
;    0.2 : decimalの0表示対応   20050313
;    0.3 : hexa decimalの0表示対応 20050313
;    0.4 : ソース中の変なコード(^M)を削除した 20050503
;    0.5 : tsprintf関数の変数 sizeを初期化するようにした 20050503
;    0.6 : %dの負数対応,%xのunsigned処理化 20050522
;    0.7 : %d,%xの桁数指定(%[n]d)/0補完指定(%0[n]d)対応 20050522
;    0.8 : va_listで渡すvtsprintfを作成し、vsprintfをvtsprintfの親関数にした 20050522
;    0.9 : hexで、値が0の時に桁が1になってしまうバグ修正 20050526
;    1.0 : decで、値が0の時に桁が1になってしまうバグ修正 20050629
;    1.1 : ハーバード・アーキテクチャ対応する為const版として定義 20061224
;    1.2 : 確保していないRAMを壊すバグを修正(10進、16進表示処理)
;    1.3 : PSoC専用に書き直し
; 
;    printfの書式設定を簡易的なものにして実装してあるので使用時には
;    説明書を確認して下さい。
; 
; */
; #include "common.h"
; #include "./tsprintf.h"
; #include "PSoCAPI.h"    // PSoC API definitions for all User Modules
; 
; int ctsprintf(char* ,const char* ,...);
; int cvtsprintf(char* buff,const char* fmt,va_list arg);
; 
; static int tsprintf_string(char* ,char* );
; static int tsprintf_cstring(const char* str,char* buff);
; static int tsprintf_char(int ,char* );
; static int tsprintf_decimal(signed long,char* ,int ,int );
; static int tsprintf_hexadecimal(unsigned long ,char* ,int ,int ,int );
; 
; /** Tiny sprintf(const書式指定文字列)関数
;  * @param buff 生成した文字列を格納する為のバッファへのポインタ
;  * @param fmt 書式指定文字列
;  * @param [argument]... 省略可能な引数
;  * @return 生成文字の文字数
;  * @note fmtに指定する文字列はROM内に確保したものを指定してください
;  */
; int ctsprintf(char* buff,const char* fmt, ...){
	.dbline 52
; 	va_list arg;
; 	int result;
; 
; 	va_start(arg, fmt);
	mov REG[0xd0],>__r0
	mov [__r1],X
	sub [__r1],7
	mov A,[__r1]
	mov [X+1],A
	mov [X+0],3
	.dbline 54
; 
; 	result = cvtsprintf(buff,fmt,arg);
	mov A,[X+0]
	push A
	mov A,[X+1]
	push A
	mov A,[X-7]
	push A
	mov A,[X-6]
	push A
	mov A,[X-5]
	push A
	mov A,[X-4]
	push A
	xcall _cvtsprintf
	add SP,-6
	mov REG[0xd0],>__r0
	mov A,[__r1]
	mov [X+3],A
	mov A,[__r0]
	mov [X+2],A
	.dbline 56
; 	
; 	va_end(arg);
	.dbline 58
; 
; 	return(result);
	mov A,[X+3]
	mov [__r1],A
	mov A,[X+2]
	mov [__r0],A
	.dbline -2
L1:
	add SP,-4
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l result 2 I
	.dbsym l arg 0 pc
	.dbsym l fmt -7 pc
	.dbsym l buff -5 pc
	.dbend
	.dbfunc e cvtsprintf _cvtsprintf fI
; prev_sizeofarg -> X+8
;          width -> X+6
;       zeroflag -> X+4
;            len -> X+2
;           size -> X+0
;            arg -> X-9
;            fmt -> X-7
;           buff -> X-5
_cvtsprintf::
	.dbline -1
	push X
	mov X,SP
	add SP,12
	.dbline 68
; }
; 
; /** Tiny vsprintf(const書式指定文字列)関数
;  * @param buff 生成した文字列を格納する為のバッファへのポインタ
;  * @param fmt 書式指定文字列
;  * @param arg 引数
;  * @return 生成文字の文字数
;  * @note fmtに指定する文字列はROM内に確保したものを指定してください
;  */
; int cvtsprintf(char* buff,const char* fmt,va_list arg){
	.dbline 74
; 	int len;
; 	int size;
; 	int zeroflag,width;
; 	int prev_sizeofarg;
; 
; 	prev_sizeofarg = 0;
	mov [X+9],0
	mov [X+8],0
	.dbline 76
; 
; 	size = 0;
	mov [X+1],0
	mov [X+0],0
	.dbline 77
; 	len = 0;
	mov [X+3],0
	mov [X+2],0
	xjmp L4
L3:
	.dbline 79
; 
; 	while(*fmt){
	.dbline 80
; 		if(*fmt=='%'){		/* % に関する処理 */
	mov REG[0xd0],>__r0
	mov A,[X-6]
	mov [__r1],A
	mov A,[X-7]
	push X
	mov X,[__r1]
	romx
	pop X
	cmp A,37
	jnz L6
	.dbline 80
	.dbline 81
; 			zeroflag = width = 0;
	mov [X+7],0
	mov [X+6],0
	mov [X+5],0
	mov [X+4],0
	.dbline 82
; 			fmt++;
	inc [X-6]
	adc [X-7],0
	.dbline 84
; 
; 			if (*fmt == '0'){
	mov A,[X-6]
	mov [__r1],A
	mov A,[X-7]
	push X
	mov X,[__r1]
	romx
	pop X
	cmp A,48
	jnz L8
	.dbline 84
	.dbline 85
; 				fmt++;
	inc [X-6]
	adc [X-7],0
	.dbline 86
; 				zeroflag = 1;
	mov [X+5],1
	mov [X+4],0
	.dbline 87
; 			}
L8:
	.dbline 88
; 			if ((*fmt >= '0') && (*fmt <= '9')){
	mov REG[0xd0],>__r0
	mov A,[X-6]
	mov [__r1],A
	mov A,[X-7]
	push X
	mov X,[__r1]
	romx
	pop X
	mov [__r1],A
	mov [__r0],0
	sub A,48
	mov A,0
	xor A,-128
	sbb A,(0 ^ 0x80)
	jc L10
X1:
	mov REG[0xd0],>__r0
	mov A,57
	sub A,[__r1]
	mov A,[__r0]
	xor A,-128
	mov [__rX],A
	mov A,(0 ^ 0x80)
	sbb A,[__rX]
	jc L10
X2:
	.dbline 88
	.dbline 89
; 				width = *(fmt++) - '0';
	mov REG[0xd0],>__r0
	mov A,[X-6]
	mov [__r1],A
	mov A,[X-7]
	mov [__r0],A
	mov A,[__r1]
	add A,1
	mov [X-6],A
	mov A,[__r0]
	adc A,0
	mov [X-7],A
	mov A,[__r0]
	push X
	mov X,[__r1]
	romx
	pop X
	sub A,48
	mov [X+7],A
	mov A,0
	sbb A,0
	mov [X+6],A
	.dbline 90
; 			}
L10:
	.dbline 92
; 
; 			switch(*fmt){
	mov REG[0xd0],>__r0
	mov A,[X-6]
	mov [__r1],A
	mov A,[X-7]
	push X
	mov X,[__r1]
	romx
	pop X
	mov [X+11],A
	mov [X+10],0
	cmp [X+10],0
	jnz X3
	cmp [X+11],99
	jz L18
X3:
	mov A,[X+11]
	sub A,100
	mov REG[0xd0],>__r0
	mov [__rY],A
	mov A,[X+10]
	xor A,-128
	sbb A,(0 ^ 0x80)
	or A,[__rY]
	jz L15
	jnc L22
X4:
L21:
	mov A,[X+11]
	sub A,83
	mov REG[0xd0],>__r0
	mov [__rY],A
	mov A,[X+10]
	xor A,-128
	sbb A,(0 ^ 0x80)
	jc L12
	or A,[__rY]
	jz L20
X5:
L23:
	cmp [X+10],0
	jnz X6
	cmp [X+11],88
	jz L17
X6:
	xjmp L12
L22:
	mov A,[X+11]
	sub A,115
	mov REG[0xd0],>__r0
	mov [__rY],A
	mov A,[X+10]
	xor A,-128
	sbb A,(0 ^ 0x80)
	jc L12
	or A,[__rY]
	jz L19
X7:
L24:
	cmp [X+10],0
	jnz X8
	cmp [X+11],120
	jz L16
X8:
	xjmp L12
X0:
	.dbline 92
L15:
	.dbline 94
; 			case 'd':		/* 16ビット 10進数 */
; 				size = tsprintf_decimal(va_arg(arg,H),buff,zeroflag,width);
	mov A,[X+6]
	push A
	mov A,[X+7]
	push A
	mov A,[X+4]
	push A
	mov A,[X+5]
	push A
	mov A,[X-5]
	push A
	mov A,[X-4]
	push A
	mov REG[0xd0],>__r0
	mov A,[X-8]
	add A,-2
	mov [__r1],A
	mov A,[X-9]
	adc A,-1
	mov [__r0],A
	mov A,[__r1]
	mov [X-8],A
	mov A,[__r0]
	mov [X-9],A
	mov REG[0xd4],A
	mvi A,[__r1]
	mov [__r0],A
	mvi A,[__r1]
	mov [__r3],A
	mov A,[__r0]
	mov [__r2],A
	tst [__r2],-128
	jz X9
	mov [__r1],-1
	mov [__r0],-1
	jmp X10
X9:
	mov REG[0xd0],>__r0
	mov [__r1],0
	mov [__r0],0
X10:
	mov REG[0xd0],>__r0
	mov A,[__r0]
	push A
	mov A,[__r1]
	push A
	mov A,[__r2]
	push A
	mov A,[__r3]
	push A
	xcall _tsprintf_decimal
	add SP,-10
	mov REG[0xd0],>__r0
	mov A,[__r1]
	mov [X+1],A
	mov A,[__r0]
	mov [X+0],A
	.dbline 95
; 				break;
	xjmp L13
L16:
	.dbline 98
; 			case 'x':		/* 16ビット 16進数 0-f */
; //				size = tsprintf_hexadecimal(va_arg(arg,unsigned long),buff,0,zeroflag,width);
; 				size = tsprintf_hexadecimal(va_arg(arg,UH),buff,0,zeroflag,width);
	mov A,[X+6]
	push A
	mov A,[X+7]
	push A
	mov A,[X+4]
	push A
	mov A,[X+5]
	push A
	mov A,0
	push A
	push A
	mov A,[X-5]
	push A
	mov A,[X-4]
	push A
	mov REG[0xd0],>__r0
	mov A,[X-8]
	add A,-2
	mov [__r1],A
	mov A,[X-9]
	adc A,-1
	mov [__r0],A
	mov A,[__r1]
	mov [X-8],A
	mov A,[__r0]
	mov [X-9],A
	mov REG[0xd4],A
	mvi A,[__r1]
	mov [__r0],A
	mvi A,[__r1]
	sub [__r1],2
	mov [__r3],A
	mov A,[__r0]
	mov [__r2],A
	mov A,0
	push A
	push A
	mov A,[__r2]
	push A
	mov A,[__r3]
	push A
	xcall _tsprintf_hexadecimal
	add SP,-12
	mov REG[0xd0],>__r0
	mov A,[__r1]
	mov [X+1],A
	mov A,[__r0]
	mov [X+0],A
	.dbline 99
; 				break;
	xjmp L13
L17:
	.dbline 102
; 			case 'X':		/* 16ビット 16進数 0-F */
; //				size = tsprintf_hexadecimal(va_arg(arg,unsigned long),buff,1,zeroflag,width);
; 				size = tsprintf_hexadecimal(va_arg(arg,UH),buff,1,zeroflag,width);
	mov A,[X+6]
	push A
	mov A,[X+7]
	push A
	mov A,[X+4]
	push A
	mov A,[X+5]
	push A
	mov A,0
	push A
	mov A,1
	push A
	mov A,[X-5]
	push A
	mov A,[X-4]
	push A
	mov REG[0xd0],>__r0
	mov A,[X-8]
	add A,-2
	mov [__r1],A
	mov A,[X-9]
	adc A,-1
	mov [__r0],A
	mov A,[__r1]
	mov [X-8],A
	mov A,[__r0]
	mov [X-9],A
	mov REG[0xd4],A
	mvi A,[__r1]
	mov [__r0],A
	mvi A,[__r1]
	sub [__r1],2
	mov [__r3],A
	mov A,[__r0]
	mov [__r2],A
	mov A,0
	push A
	push A
	mov A,[__r2]
	push A
	mov A,[__r3]
	push A
	xcall _tsprintf_hexadecimal
	add SP,-12
	mov REG[0xd0],>__r0
	mov A,[__r1]
	mov [X+1],A
	mov A,[__r0]
	mov [X+0],A
	.dbline 103
; 				break;
	xjmp L13
L18:
	.dbline 105
; 			case 'c':		/* キャラクター */
; 				size = tsprintf_char(va_arg(arg,H),buff);
	mov A,[X-5]
	push A
	mov A,[X-4]
	push A
	mov REG[0xd0],>__r0
	mov A,[X-8]
	add A,-2
	mov [__r1],A
	mov A,[X-9]
	adc A,-1
	mov [__r0],A
	mov A,[__r1]
	mov [X-8],A
	mov A,[__r0]
	mov [X-9],A
	mov REG[0xd4],A
	mvi A,[__r1]
	mov [__r0],A
	mvi A,[__r1]
	mov [__r1],A
	mov A,[__r0]
	push A
	mov A,[__r1]
	push A
	xcall _tsprintf_char
	add SP,-4
	mov REG[0xd0],>__r0
	mov A,[__r1]
	mov [X+1],A
	mov A,[__r0]
	mov [X+0],A
	.dbline 106
; 				break;
	xjmp L13
L19:
	.dbline 108
; 			case 's':		/* ASCIIZ文字列 */
; 				size = tsprintf_string(va_arg(arg,char*),buff);
	mov A,[X-5]
	push A
	mov A,[X-4]
	push A
	mov REG[0xd0],>__r0
	mov A,[X-8]
	add A,-2
	mov [__r1],A
	mov A,[X-9]
	adc A,-1
	mov [__r0],A
	mov A,[__r1]
	mov [X-8],A
	mov A,[__r0]
	mov [X-9],A
	mov REG[0xd4],A
	mvi A,[__r1]
	mov [__r0],A
	mvi A,[__r1]
	mov [__r1],A
	mov A,[__r0]
	push A
	mov A,[__r1]
	push A
	xcall _tsprintf_string
	add SP,-4
	mov REG[0xd0],>__r0
	mov A,[__r1]
	mov [X+1],A
	mov A,[__r0]
	mov [X+0],A
	.dbline 109
; 				break;
	xjmp L13
L20:
	.dbline 111
; 			case 'S':		/* const ASCIIZ文字列 */
; 				size = tsprintf_cstring(va_arg(arg,const char*),buff);
	mov A,[X-5]
	push A
	mov A,[X-4]
	push A
	mov REG[0xd0],>__r0
	mov A,[X-8]
	add A,-2
	mov [__r1],A
	mov A,[X-9]
	adc A,-1
	mov [__r0],A
	mov A,[__r1]
	mov [X-8],A
	mov A,[__r0]
	mov [X-9],A
	mov REG[0xd4],A
	mvi A,[__r1]
	mov [__r0],A
	mvi A,[__r1]
	mov [__r1],A
	mov A,[__r0]
	push A
	mov A,[__r1]
	push A
	xcall _tsprintf_cstring
	add SP,-4
	mov REG[0xd0],>__r0
	mov A,[__r1]
	mov [X+1],A
	mov A,[__r0]
	mov [X+0],A
	.dbline 112
; 				break;
	xjmp L13
L12:
	.dbline 115
; 			default:		/* コントロールコード以外の文字 */
; 				/* %%(%に対応)はここで対応される */
; 				len++;
	inc [X+3]
	adc [X+2],0
	.dbline 116
; 				*(buff++) = *fmt;
	mov REG[0xd0],>__r0
	mov A,[X-4]
	mov [__r1],A
	mov A,[X-5]
	mov [__r0],A
	mov A,[__r1]
	add A,1
	mov [X-4],A
	mov A,[__r0]
	adc A,0
	mov [X-5],A
	mov A,[X-6]
	mov [__r3],A
	mov A,[X-7]
	push X
	mov X,[__r3]
	romx
	pop X
	mov [__r2],A
	mov A,[__r0]
	mov REG[0xd5],A
	mov A,[__r2]
	mvi [__r1],A
	.dbline 117
; 				break;
L13:
	.dbline 119
; 			}
; 			len += size;
	mov A,[X+1]
	add [X+3],A
	mov A,[X+0]
	adc [X+2],A
	.dbline 120
; 			buff += size;
	mov A,[X+1]
	add A,[X-4]
	mov [X-4],A
	mov A,[X+0]
	adc A,[X-5]
	mov [X-5],A
	.dbline 121
; 			fmt++;
	inc [X-6]
	adc [X-7],0
	.dbline 122
	xjmp L7
L6:
	.dbline 122
; 		} else {
	.dbline 123
; 			*(buff++) = *(fmt++);
	mov REG[0xd0],>__r0
	mov A,[X-4]
	mov [__r1],A
	mov A,[X-5]
	mov [__r0],A
	mov A,[__r1]
	add A,1
	mov [X-4],A
	mov A,[__r0]
	adc A,0
	mov [X-5],A
	mov A,[X-6]
	mov [__r3],A
	mov A,[X-7]
	mov [__r2],A
	mov A,[__r3]
	add A,1
	mov [X-6],A
	mov A,[__r2]
	adc A,0
	mov [X-7],A
	mov A,[__r2]
	push X
	mov X,[__r3]
	romx
	pop X
	mov [__r2],A
	mov A,[__r0]
	mov REG[0xd5],A
	mov A,[__r2]
	mvi [__r1],A
	.dbline 124
; 			len++;
	inc [X+3]
	adc [X+2],0
	.dbline 125
; 		}
L7:
	.dbline 126
L4:
	.dbline 79
	mov REG[0xd0],>__r0
	mov A,[X-6]
	mov [__r1],A
	mov A,[X-7]
	push X
	mov X,[__r1]
	romx
	pop X
	cmp A,0
	jnz L3
	.dbline 128
; 	}
; 
; 	*buff = '\0';		/* 終端を入れる */
	mov A,[X-4]
	mov [__r1],A
	mov A,[X-5]
	mov REG[0xd5],A
	mov A,0
	mvi [__r1],A
	.dbline 130
; 
; 	va_end(arg);
	.dbline 131
; 	return (len);
	mov A,[X+3]
	mov [__r1],A
	mov A,[X+2]
	mov [__r0],A
	.dbline -2
L2:
	add SP,-12
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l prev_sizeofarg 8 I
	.dbsym l width 6 I
	.dbsym l zeroflag 4 I
	.dbsym l len 2 I
	.dbsym l size 0 I
	.dbsym l arg -9 pc
	.dbsym l fmt -7 pc
	.dbsym l buff -5 pc
	.dbend
	.dbfunc s tsprintf_decimal _tsprintf_decimal fI
;            tmp -> X+8
;          minus -> X+6
;              i -> X+4
;           ptmp -> X+2
;            len -> X+0
;             wd -> X-13
;             zf -> X-11
;           buff -> X-9
;            val -> X-7
_tsprintf_decimal:
	.dbline -1
	push X
	mov X,SP
	add SP,18
	.dbline 141
; }
; 
; /** 数値 => 10進文字列変換
;  * @param val 変換したい文字列データ
;  * @param buff 変換した文字列データを格納するバッファへのポインタ
;  * @param zf 1:文字列データ先頭部分に0を埋め込む
;  * @param wd 文字列する場合の桁数指定(0～9)
;  * @return 生成文字の文字数
;  */
; static int tsprintf_decimal(signed long val,char* buff,int zf,int wd){
	.dbline 144
; 	int i;
; 	char tmp[10];
; 	char* ptmp = tmp + 9;
	mov REG[0xd0],>__r0
	mov [__r1],X
	add [__r1],17
	mov A,[__r1]
	mov [X+3],A
	mov [X+2],3
	.dbline 145
; 	int len = 0;
	mov [X+1],0
	mov [X+0],0
	.dbline 146
; 	int minus = 0;
	mov [X+7],0
	mov [X+6],0
	.dbline 148
; 				
; 	if (!val){		/* 指定値が0の場合 */
	cmp [X-7],0
	jnz L27
	cmp [X-6],0
	jnz L27
	cmp [X-5],0
	jnz L27
	cmp [X-4],0
	jnz L27
X11:
	.dbline 148
	.dbline 149
; 		*(ptmp--) = '0';
	mov REG[0xd0],>__r0
	mov A,[X+3]
	mov [__r1],A
	mov A,[X+2]
	mov [__r0],A
	mov A,[__r1]
	add A,-1
	mov [X+3],A
	mov A,[__r0]
	adc A,-1
	mov [X+2],A
	mov A,[__r0]
	mov REG[0xd5],A
	mov A,48
	mvi [__r1],A
	.dbline 150
; 		len++;
	inc [X+1]
	adc [X+0],0
	.dbline 151
	xjmp L28
L27:
	.dbline 151
; 	} else {
	.dbline 153
; 		/* マイナスの値の場合には2の補数を取る */
; 		if (val < 0){
	mov A,[X-4]
	sub A,0
	mov A,[X-5]
	sbb A,0
	mov A,[X-6]
	sbb A,0
	mov A,[X-7]
	xor A,-128
	sbb A,(0 ^ 0x80)
	jnc L32
X12:
	.dbline 153
	.dbline 154
; 			val = ~val;
	mov A,[X-7]
	cpl A
	mov [X-7],A
	mov A,[X-6]
	cpl A
	mov [X-6],A
	mov A,[X-5]
	cpl A
	mov [X-5],A
	mov A,[X-4]
	cpl A
	mov [X-4],A
	.dbline 155
; 			val++;
	add [X-4],1
	adc [X-5],0
	adc [X-6],0
	adc [X-7],0
	.dbline 156
; 			minus = 1;
	mov [X+7],1
	mov [X+6],0
	.dbline 157
; 		}
	xjmp L32
L31:
	.dbline 158
; 		while (val){
	.dbline 161
; 
; 			/* バッファアンダーフロー対策 */
; 			if (len >= 8){
	mov A,[X+1]
	sub A,8
	mov A,[X+0]
	xor A,-128
	sbb A,(0 ^ 0x80)
	jc L34
X13:
	.dbline 161
	.dbline 162
; 				break;
	xjmp L33
L34:
	.dbline 165
	mov REG[0xd0],>__r0
	mov A,0
	push A
	push A
	push A
	mov A,10
	push A
	mov A,[X-7]
	push A
	mov A,[X-6]
	push A
	mov A,[X-5]
	push A
	mov A,[X-4]
	push A
	xcall __divmod_32X32_32
	add SP,-4
	pop A
	mov [__r3],A
	pop A
	mov [__r2],A
	pop A
	mov [__r1],A
	pop A
	mov [__r0],A
	add [__r3],48
	adc [__r2],0
	adc [__r1],0
	adc [__r0],0
	mov A,[__r3]
	mov [__r0],A
	mov A,[X+3]
	mov [__r3],A
	mov A,[X+2]
	mov REG[0xd5],A
	mov A,[__r0]
	mvi [__r3],A
	.dbline 167
	mov A,0
	push A
	push A
	push A
	mov A,10
	push A
	mov A,[X-7]
	push A
	mov A,[X-6]
	push A
	mov A,[X-5]
	push A
	mov A,[X-4]
	push A
	xcall __divmod_32X32_32
	pop A
	mov [X-4],A
	pop A
	mov [X-5],A
	pop A
	mov [X-6],A
	pop A
	mov [X-7],A
	add SP,-4
	.dbline 168
	add [X+3],-1
	adc [X+2],-1
	.dbline 169
	inc [X+1]
	adc [X+0],0
	.dbline 170
L32:
	.dbline 158
	cmp [X-7],0
	jnz L31
	cmp [X-6],0
	jnz L31
	cmp [X-5],0
	jnz L31
	cmp [X-4],0
	jnz L31
X14:
L33:
	.dbline 172
; 			}
; 	
; 			*ptmp = (val % 10) + '0';
; 
; 			val /= 10;
; 			ptmp--;
; 			len++;
; 		}
; 
; 	}
L28:
	.dbline 175
; 
; 	/* 符号、桁合わせに関する処理 */
; 	if (zf){
	cmp [X-11],0
	jnz X15
	cmp [X-10],0
	jz L36
X15:
	.dbline 175
	.dbline 176
; 		if (minus){
	cmp [X+6],0
	jnz X16
	cmp [X+7],0
	jz L41
X16:
	.dbline 176
	.dbline 177
; 			wd--;
	dec [X-12]
	sbb [X-13],0
	.dbline 178
; 		}
	xjmp L41
L40:
	.dbline 179
	.dbline 180
	mov REG[0xd0],>__r0
	mov A,[X+3]
	mov [__r1],A
	mov A,[X+2]
	mov [__r0],A
	mov A,[__r1]
	add A,-1
	mov [X+3],A
	mov A,[__r0]
	adc A,-1
	mov [X+2],A
	mov A,[__r0]
	mov REG[0xd5],A
	mov A,48
	mvi [__r1],A
	.dbline 181
	inc [X+1]
	adc [X+0],0
	.dbline 182
L41:
	.dbline 179
; 		while (len < wd){
	mov A,[X+1]
	sub A,[X-12]
	mov A,[X-13]
	xor A,-128
	mov REG[0xd0],>__r0
	mov [__rX],A
	mov A,[X+0]
	xor A,-128
	sbb A,[__rX]
	jc L40
X17:
	.dbline 183
; 			*(ptmp--) =  '0';
; 			len++;
; 		}
; 		if (minus){
	cmp [X+6],0
	jnz X18
	cmp [X+7],0
	jz L37
X18:
	.dbline 183
	.dbline 184
; 			*(ptmp--) = '-';
	mov REG[0xd0],>__r0
	mov A,[X+3]
	mov [__r1],A
	mov A,[X+2]
	mov [__r0],A
	mov A,[__r1]
	add A,-1
	mov [X+3],A
	mov A,[__r0]
	adc A,-1
	mov [X+2],A
	mov A,[__r0]
	mov REG[0xd5],A
	mov A,45
	mvi [__r1],A
	.dbline 185
; 			len++;
	inc [X+1]
	adc [X+0],0
	.dbline 186
; 		}
	.dbline 187
	xjmp L37
L36:
	.dbline 187
; 	} else {
	.dbline 188
; 		if (minus){
	cmp [X+6],0
	jnz X19
	cmp [X+7],0
	jz L48
X19:
	.dbline 188
	.dbline 189
; 			*(ptmp--) = '-';
	mov REG[0xd0],>__r0
	mov A,[X+3]
	mov [__r1],A
	mov A,[X+2]
	mov [__r0],A
	mov A,[__r1]
	add A,-1
	mov [X+3],A
	mov A,[__r0]
	adc A,-1
	mov [X+2],A
	mov A,[__r0]
	mov REG[0xd5],A
	mov A,45
	mvi [__r1],A
	.dbline 190
; 			len++;
	inc [X+1]
	adc [X+0],0
	.dbline 191
; 		}
	xjmp L48
L47:
	.dbline 192
	.dbline 193
	mov REG[0xd0],>__r0
	mov A,[X+3]
	mov [__r1],A
	mov A,[X+2]
	mov [__r0],A
	mov A,[__r1]
	add A,-1
	mov [X+3],A
	mov A,[__r0]
	adc A,-1
	mov [X+2],A
	mov A,[__r0]
	mov REG[0xd5],A
	mov A,32
	mvi [__r1],A
	.dbline 194
	inc [X+1]
	adc [X+0],0
	.dbline 195
L48:
	.dbline 192
; 		while (len < wd){
	mov A,[X+1]
	sub A,[X-12]
	mov A,[X-13]
	xor A,-128
	mov REG[0xd0],>__r0
	mov [__rX],A
	mov A,[X+0]
	xor A,-128
	sbb A,[__rX]
	jc L47
X20:
	.dbline 196
; 			*(ptmp--) =  ' ';
; 			len++;
; 		}
; 	}
L37:
	.dbline 199
	mov [X+5],0
	mov [X+4],0
	xjmp L53
L50:
	.dbline 199
	.dbline 200
	mov REG[0xd0],>__r0
	mov A,[X-8]
	mov [__r1],A
	mov A,[X-9]
	mov [__r0],A
	mov A,[__r1]
	add A,1
	mov [X-8],A
	mov A,[__r0]
	adc A,0
	mov [X-9],A
	mov A,[X+3]
	add A,1
	mov [__r3],A
	mov A,[X+2]
	adc A,0
	mov [__r2],A
	mov A,[__r3]
	mov [X+3],A
	mov A,[__r2]
	mov [X+2],A
	mov REG[0xd4],A
	mvi A,[__r3]
	dec [__r3]
	mov [__r2],A
	mov A,[__r0]
	mov REG[0xd5],A
	mov A,[__r2]
	mvi [__r1],A
	.dbline 201
L51:
	.dbline 199
	inc [X+5]
	adc [X+4],0
L53:
	.dbline 199
; 
; 	/* 生成文字列のバッファコピー */
; 	for (i=0;i<len;i++){
	mov A,[X+5]
	sub A,[X+1]
	mov A,[X+0]
	xor A,-128
	mov REG[0xd0],>__r0
	mov [__rX],A
	mov A,[X+4]
	xor A,-128
	sbb A,[__rX]
	jc L50
X21:
	.dbline 203
; 		*(buff++) = *(++ptmp);
; 	}
; 
; 	return (len);
	mov REG[0xd0],>__r0
	mov A,[X+1]
	mov [__r1],A
	mov A,[X+0]
	mov [__r0],A
	.dbline -2
L25:
	add SP,-18
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l tmp 8 A[10:10]c
	.dbsym l minus 6 I
	.dbsym l i 4 I
	.dbsym l ptmp 2 pc
	.dbsym l len 0 I
	.dbsym l wd -13 I
	.dbsym l zf -11 I
	.dbsym l buff -9 pc
	.dbsym l val -7 L
	.dbend
	.dbfunc s tsprintf_hexadecimal _tsprintf_hexadecimal fI
;            tmp -> X+7
;          str_a -> X+6
;              i -> X+4
;           ptmp -> X+2
;            len -> X+0
;             wd -> X-15
;             zf -> X-13
;        capital -> X-11
;           buff -> X-9
;            val -> X-7
_tsprintf_hexadecimal:
	.dbline -1
	push X
	mov X,SP
	add SP,19
	.dbline 215
; }
; 
; /** 数値 => 16進文字列変換
;  * @param val 変換したい文字列データ
;  * @param buff 変換した文字列データを格納するバッファへのポインタ
;  * @param capital 1 : 16進のa～fを'A'～'F'にする
;  * @param zf 1:文字列データ先頭部分に0を埋め込む
;  * @param wd 文字列する場合の桁数指定(0～9)
;  * @return 生成文字の文字数
;  */
; static int tsprintf_hexadecimal(unsigned long val,char* buff,
; 								int capital,int zf,int wd){
	.dbline 218
; 	int i;
; 	char tmp[10];
; 	char* ptmp = tmp + 9;
	mov REG[0xd0],>__r0
	mov [__r1],X
	add [__r1],16
	mov A,[__r1]
	mov [X+3],A
	mov [X+2],3
	.dbline 219
; 	int len = 0;
	mov [X+1],0
	mov [X+0],0
	.dbline 223
; 	char str_a;
; 
; 	/* A～Fを大文字にするか小文字にするか切り替える */
; 	if (capital){
	cmp [X-11],0
	jnz X23
	cmp [X-10],0
	jz L56
X23:
	.dbline 223
	.dbline 224
; 		str_a = 'A';
	mov [X+6],65
	.dbline 225
	xjmp L57
L56:
	.dbline 225
; 	} else {
	.dbline 226
; 		str_a = 'a';
	mov [X+6],97
	.dbline 227
; 	}
L57:
	.dbline 229
; 	
; 	if (!val){		/* 指定値が0の場合 */
	cmp [X-7],0
	jnz L61
	cmp [X-6],0
	jnz L61
	cmp [X-5],0
	jnz L61
	cmp [X-4],0
	jnz L61
X24:
	.dbline 229
	.dbline 230
; 		*(ptmp--) = '0';
	mov REG[0xd0],>__r0
	mov A,[X+3]
	mov [__r1],A
	mov A,[X+2]
	mov [__r0],A
	mov A,[__r1]
	add A,-1
	mov [X+3],A
	mov A,[__r0]
	adc A,-1
	mov [X+2],A
	mov A,[__r0]
	mov REG[0xd5],A
	mov A,48
	mvi [__r1],A
	.dbline 231
; 		len++;
	inc [X+1]
	adc [X+0],0
	.dbline 232
	xjmp L68
X22:
	.dbline 232
; 	} else {
L60:
	.dbline 233
; 		while (val){
	.dbline 235
; 			/* バッファアンダーフロー対策 */
; 			if (len >= 8){
	mov A,[X+1]
	sub A,8
	mov A,[X+0]
	xor A,-128
	sbb A,(0 ^ 0x80)
	jc L63
X25:
	.dbline 235
	.dbline 236
; 				break;
	xjmp L68
L63:
	.dbline 239
; 			}
; 
; 			*ptmp = (val % 16);
	mov REG[0xd0],>__r0
	mov A,[X-4]
	and A,15
	mov [__r0],A
	mov A,[X+3]
	mov [__r3],A
	mov A,[X+2]
	mov REG[0xd5],A
	mov A,[__r0]
	mvi [__r3],A
	.dbline 240
; 			if (*ptmp > 9){
	mov A,[X+3]
	mov [__r1],A
	mov A,[X+2]
	mov REG[0xd4],A
	mvi A,[__r1]
	mov [__r0],A
	mov A,9
	cmp A,[__r0]
	jnc L65
X26:
	.dbline 240
	.dbline 241
; 				*ptmp += str_a - 10;
	mov REG[0xd0],>__r0
	mov A,[X+6]
	sub A,10
	mov [__r0],A
	mov A,[X+3]
	mov [__r3],A
	mov A,[X+2]
	mov REG[0xd4],A
	mvi A,[__r3]
	add A,[__r0]
	mov [__r0],A
	mov A,[X+3]
	mov [__r3],A
	mov A,[X+2]
	mov REG[0xd5],A
	mov A,[__r0]
	mvi [__r3],A
	.dbline 242
	xjmp L66
L65:
	.dbline 242
; 			} else {
	.dbline 243
; 				*ptmp += '0';
	mov REG[0xd0],>__r0
	mov A,[X+3]
	mov [__r1],A
	mov A,[X+2]
	mov REG[0xd4],A
	mvi A,[__r1]
	mov [__r0],A
	add [__r0],48
	mov A,[X+3]
	mov [__r3],A
	mov A,[X+2]
	mov REG[0xd5],A
	mov A,[__r0]
	mvi [__r3],A
	.dbline 244
; 			}
L66:
	.dbline 246
	mov REG[0xd0],>__r0
	mov A,[X-7]
	mov [__r0],A
	mov A,[X-6]
	mov [__r1],A
	mov A,[X-5]
	mov [__r2],A
	mov A,[X-4]
	mov [__r3],A
	mov A,4
X27:
	and F,-5
	mov REG[0xd0],>__r0
	rrc [__r0]
	rrc [__r1]
	rrc [__r2]
	rrc [__r3]
	dec A
	jnz X27
	mov A,[__r0]
	mov [X-7],A
	mov A,[__r1]
	mov [X-6],A
	mov A,[__r2]
	mov [X-5],A
	mov A,[__r3]
	mov [X-4],A
	.dbline 247
	add [X+3],-1
	adc [X+2],-1
	.dbline 248
	inc [X+1]
	adc [X+0],0
	.dbline 249
L61:
	.dbline 233
	cmp [X-7],0
	jnz L60
	cmp [X-6],0
	jnz L60
	cmp [X-5],0
	jnz L60
	cmp [X-4],0
	jnz L60
X28:
	.dbline 250
; 		
; 			val >>= 4;		/* 16で割る */
; 			ptmp--;
; 			len++;
; 		}
; 	}
	xjmp L68
L67:
	.dbline 251
; 	while (len < wd){
	.dbline 252
; 		*(ptmp--) =  zf ? '0' : ' ';
	mov REG[0xd0],>__r0
	mov A,[X+3]
	mov [__r1],A
	mov A,[X+2]
	mov [__r0],A
	mov A,[__r1]
	add A,-1
	mov [X+3],A
	mov A,[__r0]
	adc A,-1
	mov [X+2],A
	cmp [X-13],0
	jnz X29
	cmp [X-12],0
	jz L71
X29:
	mov [X+18],48
	mov [X+17],0
	xjmp L72
L71:
	mov [X+18],32
	mov [X+17],0
L72:
	mov REG[0xd0],>__r0
	mov A,[X+18]
	mov [__r2],A
	mov A,[__r0]
	mov REG[0xd5],A
	mov A,[__r2]
	mvi [__r1],A
	.dbline 253
	inc [X+1]
	adc [X+0],0
	.dbline 254
L68:
	.dbline 251
	mov A,[X+1]
	sub A,[X-14]
	mov A,[X-15]
	xor A,-128
	mov REG[0xd0],>__r0
	mov [__rX],A
	mov A,[X+0]
	xor A,-128
	sbb A,[__rX]
	jc L67
X30:
	.dbline 256
	mov [X+5],0
	mov [X+4],0
	xjmp L76
L73:
	.dbline 256
	.dbline 257
	mov REG[0xd0],>__r0
	mov A,[X-8]
	mov [__r1],A
	mov A,[X-9]
	mov [__r0],A
	mov A,[__r1]
	add A,1
	mov [X-8],A
	mov A,[__r0]
	adc A,0
	mov [X-9],A
	mov A,[X+3]
	add A,1
	mov [__r3],A
	mov A,[X+2]
	adc A,0
	mov [__r2],A
	mov A,[__r3]
	mov [X+3],A
	mov A,[__r2]
	mov [X+2],A
	mov REG[0xd4],A
	mvi A,[__r3]
	dec [__r3]
	mov [__r2],A
	mov A,[__r0]
	mov REG[0xd5],A
	mov A,[__r2]
	mvi [__r1],A
	.dbline 258
L74:
	.dbline 256
	inc [X+5]
	adc [X+4],0
L76:
	.dbline 256
; 		len++;
; 	}
; 		
; 	for (i=0;i<len;i++){
	mov A,[X+5]
	sub A,[X+1]
	mov A,[X+0]
	xor A,-128
	mov REG[0xd0],>__r0
	mov [__rX],A
	mov A,[X+4]
	xor A,-128
	sbb A,[__rX]
	jc L73
X31:
	.dbline 260
; 		*(buff++) = *(++ptmp);
; 	}
; 
; 	return(len);
	mov REG[0xd0],>__r0
	mov A,[X+1]
	mov [__r1],A
	mov A,[X+0]
	mov [__r0],A
	.dbline -2
L54:
	add SP,-19
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l tmp 7 A[10:10]c
	.dbsym l str_a 6 c
	.dbsym l i 4 I
	.dbsym l ptmp 2 pc
	.dbsym l len 0 I
	.dbsym l wd -15 I
	.dbsym l zf -13 I
	.dbsym l capital -11 I
	.dbsym l buff -9 pc
	.dbsym l val -7 l
	.dbend
	.dbfunc s tsprintf_char _tsprintf_char fI
;           buff -> X-7
;             ch -> X-5
_tsprintf_char:
	.dbline -1
	push X
	mov X,SP
	.dbline 268
; }
; 
; /** 1キャラクタ表示
;  * @param ch 文字データのコード値
;  * @param buff 変換した文字列データを格納するバッファへのポインタ
;  * @return 生成文字の文字数
;  */
; static int tsprintf_char(int ch,char* buff){
	.dbline 269
; 	*buff = (char)ch;
	mov REG[0xd0],>__r0
	mov A,[X-4]
	mov [__r0],A
	mov A,[X-6]
	mov [__r3],A
	mov A,[X-7]
	mov REG[0xd5],A
	mov A,[__r0]
	mvi [__r3],A
	.dbline 270
; 	return(1);
	mov [__r1],1
	mov [__r0],0
	.dbline -2
L77:
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l buff -7 pc
	.dbsym l ch -5 I
	.dbend
	.dbfunc s tsprintf_string _tsprintf_string fI
;          count -> X+0
;           buff -> X-7
;            str -> X-5
_tsprintf_string:
	.dbline -1
	push X
	mov X,SP
	add SP,2
	.dbline 278
; }
; 
; /** ASCIIZ文字列表示(文字列はRAM内に確保すること)
;  * @param str ASCIIZ文字列データへのポインタ
;  * @param buff 変換した文字列データを格納するバッファへのポインタ
;  * @return 生成文字の文字数
;  */
; static int tsprintf_string(char* str,char* buff){
	.dbline 279
; 	int count = 0;
	mov [X+1],0
	mov [X+0],0
	xjmp L80
L79:
	.dbline 280
	.dbline 281
	mov REG[0xd0],>__r0
	mov A,[X-6]
	mov [__r1],A
	mov A,[X-7]
	mov [__r0],A
	mov A,[__r1]
	add A,1
	mov [X-6],A
	mov A,[__r0]
	adc A,0
	mov [X-7],A
	mov A,[X-4]
	mov [__r3],A
	mov A,[X-5]
	mov REG[0xd4],A
	mvi A,[__r3]
	mov [__r2],A
	mov A,[__r0]
	mov REG[0xd5],A
	mov A,[__r2]
	mvi [__r1],A
	.dbline 282
	inc [X-4]
	adc [X-5],0
	.dbline 283
	inc [X+1]
	adc [X+0],0
	.dbline 284
L80:
	.dbline 280
; 	while(*str){
	mov REG[0xd0],>__r0
	mov A,[X-4]
	mov [__r1],A
	mov A,[X-5]
	mov REG[0xd4],A
	mvi A,[__r1]
	cmp A,0
	jnz L79
	.dbline 285
; 		*(buff++) = *str;
; 		str++;
; 		count++;
; 	}
; 	return(count);
	mov A,[X+1]
	mov [__r1],A
	mov A,[X+0]
	mov [__r0],A
	.dbline -2
L78:
	add SP,-2
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l count 0 I
	.dbsym l buff -7 pc
	.dbsym l str -5 pc
	.dbend
	.dbfunc s tsprintf_cstring _tsprintf_cstring fI
;          count -> X+0
;           buff -> X-7
;            str -> X-5
_tsprintf_cstring:
	.dbline -1
	push X
	mov X,SP
	add SP,2
	.dbline 293
; }
; 
; /** Const ASCIIZ文字列表示(文字列はROM内に確保すること)
;  * @param str ASCIIZ文字列データへのポインタ
;  * @param buff 変換した文字列データを格納するバッファへのポインタ
;  * @return 生成文字の文字数
;  */
; static int tsprintf_cstring(const char* str,char* buff){
	.dbline 294
; 	int count = 0;
	mov [X+1],0
	mov [X+0],0
	xjmp L84
L83:
	.dbline 295
	.dbline 296
	mov REG[0xd0],>__r0
	mov A,[X-6]
	mov [__r1],A
	mov A,[X-7]
	mov [__r0],A
	mov A,[__r1]
	add A,1
	mov [X-6],A
	mov A,[__r0]
	adc A,0
	mov [X-7],A
	mov A,[X-4]
	mov [__r3],A
	mov A,[X-5]
	push X
	mov X,[__r3]
	romx
	pop X
	mov [__r2],A
	mov A,[__r0]
	mov REG[0xd5],A
	mov A,[__r2]
	mvi [__r1],A
	.dbline 297
	inc [X-4]
	adc [X-5],0
	.dbline 298
	inc [X+1]
	adc [X+0],0
	.dbline 299
L84:
	.dbline 295
; 	while(*str){
	mov REG[0xd0],>__r0
	mov A,[X-4]
	mov [__r1],A
	mov A,[X-5]
	push X
	mov X,[__r1]
	romx
	pop X
	cmp A,0
	jnz L83
	.dbline 300
; 		*(buff++) = *str;
; 		str++;
; 		count++;
; 	}
; 	return(count);
	mov A,[X+1]
	mov [__r1],A
	mov A,[X+0]
	mov [__r0],A
	.dbline -2
L82:
	add SP,-2
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l count 0 I
	.dbsym l buff -7 pc
	.dbsym l str -5 pc
	.dbend
