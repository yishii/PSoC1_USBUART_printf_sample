	cpu LMM
	.module tstring.c
	.area text(rom, con, rel)
	.dbfile ./tstring.c
	.dbfunc e TrimStringLeft _TrimStringLeft fV
;              i -> X+1
;              j -> X+0
;         buffer -> X-5
_TrimStringLeft::
	.dbline -1
	push X
	mov X,SP
	add SP,2
	.dbline 24
; /*
; 	文字列コントロール処理 string.c
; 	Copyright(C)2002 Yasuhiro ISHII
; 	All rights reserved.
; 	Ver 0.04
; 	0.02            : tstrlen追加
; 	0.03            : SearchFirstPosまともに動作していなかったので修正
; 	0.04 2005/06/11 : 関数名称総変更
; 
; */
; 
; #include "tstring.h"
; 
; void TrimStringLeft(unsigned char* );
; void TrimStringRight(unsigned char* );
; void tstrcpy(char* ,const char* );
; void tstrncpy(char* ,const char* ,int );
; char tstrcmp(const char* ,const char* );
; int SearchFirstPos(const char* ,char );
; int tstrlen(char* );
; 
; // 文字列のトリミング(文字列の始点側)
; // 空白(0x20)を取り除く
; void TrimStringLeft(unsigned char* buffer){
	.dbline 26
; 	unsigned char i,j;
; 	i=j=0;
	mov [X+0],0
	mov [X+1],0
	xjmp L3
L2:
	.dbline 27
	.dbline 28
	inc [X+1]
	.dbline 29
L3:
	.dbline 27
; 	while(buffer[i] == 0x20){
	mov REG[0xd0],>__r0
	mov A,[X+1]
	mov [__r1],A
	mov [__r0],0
	mov A,[X-4]
	add [__r1],A
	mov A,[X-5]
	adc [__r0],A
	mov A,[__r0]
	mov REG[0xd4],A
	mvi A,[__r1]
	cmp A,32
	jz L2
	xjmp L6
L5:
	.dbline 30
	.dbline 31
	mov REG[0xd0],>__r0
	mov A,[X+0]
	mov [__r1],A
	mov [__r0],0
	mov A,[X+1]
	mov [__r2],0
	add A,[__r1]
	mov [__r1],A
	mov A,0
	adc A,[__r0]
	mov [__r0],A
	mov A,[X-4]
	add [__r1],A
	mov A,[X-5]
	adc [__r0],A
	mov A,[__r0]
	mov REG[0xd4],A
	mvi A,[__r1]
	mov [__r0],A
	mov A,[X+0]
	mov [__r3],A
	mov A,[X-4]
	add [__r3],A
	mov A,[X-5]
	adc [__r2],A
	mov A,[__r2]
	mov REG[0xd5],A
	mov A,[__r0]
	mvi [__r3],A
	.dbline 32
	inc [X+0]
	.dbline 33
L6:
	.dbline 30
; 		i++;
; 	}
; 	while (buffer[i+j]){
	mov REG[0xd0],>__r0
	mov A,[X+0]
	mov [__r1],A
	mov [__r0],0
	mov A,[X+1]
	add A,[__r1]
	mov [__r1],A
	mov A,0
	adc A,[__r0]
	mov [__r0],A
	mov A,[X-4]
	add [__r1],A
	mov A,[X-5]
	adc [__r0],A
	mov A,[__r0]
	mov REG[0xd4],A
	mvi A,[__r1]
	cmp A,0
	jnz L5
	.dbline 34
; 		buffer[j]=buffer[i+j];
; 		j++;
; 	}
; 	buffer[j] = 0;
	mov A,[X+0]
	mov [__r1],A
	mov [__r0],0
	mov A,[X-4]
	add [__r1],A
	mov A,[X-5]
	adc [__r0],A
	mov A,[__r0]
	mov REG[0xd5],A
	mov A,0
	mvi [__r1],A
	.dbline -2
	.dbline 35
; }
L1:
	add SP,-2
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l i 1 c
	.dbsym l j 0 c
	.dbsym l buffer -5 pc
	.dbend
	.dbfunc e TrimStringRight _TrimStringRight fV
;              i -> X+0
;         buffer -> X-5
_TrimStringRight::
	.dbline -1
	push X
	mov X,SP
	add SP,1
	.dbline 39
; 
; // 文字列のトリミング(文字列の終点側)
; // 空白(0x20)を取り除く
; void TrimStringRight(unsigned char* buffer){
	.dbline 41
;     unsigned char i;
; 	i=0;
	mov [X+0],0
L9:
	.dbline 42
L10:
	.dbline 42
;     while(buffer[i++]);
	mov REG[0xd0],>__r0
	mov A,[X+0]
	mov [__r1],A
	mov [__r0],0
	add A,1
	mov [X+0],A
	mov A,[X-4]
	add [__r1],A
	mov A,[X-5]
	adc [__r0],A
	mov A,[__r0]
	mov REG[0xd4],A
	mvi A,[__r1]
	cmp A,0
	jnz L9
	.dbline 43
;     i-=2;
	mov A,[X+0]
	sub A,2
	mov [X+0],A
L12:
	.dbline 44
L13:
	.dbline 44
;     while(buffer[i--] == 0x20);
	mov REG[0xd0],>__r0
	mov A,[X+0]
	mov [__r1],A
	mov [__r0],0
	sub A,1
	mov [X+0],A
	mov A,[X-4]
	add [__r1],A
	mov A,[X-5]
	adc [__r0],A
	mov A,[__r0]
	mov REG[0xd4],A
	mvi A,[__r1]
	cmp A,32
	jz L12
	.dbline 45
;     buffer[i+2]=0x00;
	mov A,[X+0]
	mov [__r1],A
	mov [__r0],0
	mov A,[X-4]
	add [__r1],A
	mov A,[X-5]
	adc [__r0],A
	add [__r1],2
	adc [__r0],0
	mov A,[__r0]
	mov REG[0xd5],A
	mov A,0
	mvi [__r1],A
	.dbline -2
	.dbline 46
; }
L8:
	add SP,-1
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l i 0 c
	.dbsym l buffer -5 pc
	.dbend
	.dbfunc e tstrcpy _tstrcpy fV
;            src -> X-7
;            dst -> X-5
_tstrcpy::
	.dbline -1
	push X
	mov X,SP
	.dbline 50
; 
; // strcpyコンパチ関数
; // 但し返り値なし
; void tstrcpy(char* dst,const char* src){
	xjmp L17
L16:
	.dbline 51
	.dbline 52
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
	.dbline 53
L17:
	.dbline 51
;     while(*src){
	mov REG[0xd0],>__r0
	mov A,[X-6]
	mov [__r1],A
	mov A,[X-7]
	push X
	mov X,[__r1]
	romx
	pop X
	cmp A,0
	jnz L16
	.dbline 54
; 		*dst++ = *src++;
;     }
;     *dst=*src;
	mov A,[X-6]
	mov [__r1],A
	mov A,[X-7]
	push X
	mov X,[__r1]
	romx
	pop X
	mov [__r0],A
	mov A,[X-4]
	mov [__r3],A
	mov A,[X-5]
	mov REG[0xd5],A
	mov A,[__r0]
	mvi [__r3],A
	.dbline -2
	.dbline 55
; }
L15:
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l src -7 pc
	.dbsym l dst -5 pc
	.dbend
	.dbfunc e tstrncpy _tstrncpy fV
;              i -> X+0
;          count -> X-9
;            src -> X-7
;            dst -> X-5
_tstrncpy::
	.dbline -1
	push X
	mov X,SP
	add SP,2
	.dbline 60
; 
; 
; // strncpyコンパチ関数
; // 但し返り値なし
; void tstrncpy(char* dst,const char* src,int count){
	.dbline 62
;     int i;
;     i=0;
	mov [X+1],0
	mov [X+0],0
	.dbline 63
;     if (count){
	cmp [X-9],0
	jnz X0
	cmp [X-8],0
	jz L20
X0:
	.dbline 63
	xjmp L23
L22:
	.dbline 64
	.dbline 65
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
	.dbline 66
L23:
	.dbline 64
; 		while(*src && i < count - 1){
	mov REG[0xd0],>__r0
	mov A,[X-6]
	mov [__r1],A
	mov A,[X-7]
	push X
	mov X,[__r1]
	romx
	pop X
	cmp A,0
	jz L25
	mov A,[X-8]
	sub A,1
	mov [__r1],A
	mov A,[X-9]
	sbb A,0
	mov [__r0],A
	mov A,[X+1]
	sub A,[__r1]
	mov A,[__r0]
	xor A,-128
	mov [__rX],A
	mov A,[X+0]
	xor A,-128
	sbb A,[__rX]
	jc L22
X1:
L25:
	.dbline 67
	mov REG[0xd0],>__r0
	mov A,[X-6]
	mov [__r1],A
	mov A,[X-7]
	push X
	mov X,[__r1]
	romx
	pop X
	mov [__r0],A
	mov A,[X-4]
	mov [__r3],A
	mov A,[X-5]
	mov REG[0xd5],A
	mov A,[__r0]
	mvi [__r3],A
	.dbline 68
L20:
	.dbline -2
	.dbline 69
; 			*dst++ = *src++;
; 		}
; 		*dst=*src;
;     }
; }
L19:
	add SP,-2
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l i 0 I
	.dbsym l count -9 I
	.dbsym l src -7 pc
	.dbsym l dst -5 pc
	.dbend
	.dbfunc e tstrcmp _tstrcmp fc
;        string2 -> X-7
;        string1 -> X-5
_tstrcmp::
	.dbline -1
	push X
	mov X,SP
	.dbline 75
; 
; // string compare
; // 返り値は標準のstrcmpと少し異なる
; // 返り値 : string1とstring2が同じ : 0
; //          string1とstring2は異なる : 1
; char tstrcmp(const char* string1,const char* string2){
	xjmp L28
L27:
	.dbline 76
;     while(*string1 | *string2){
	.dbline 77
; 		if (*string1++ != *string2++){
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
	push X
	mov X,[__r1]
	romx
	pop X
	cmp A,[__r2]
	jz L30
	.dbline 77
	.dbline 78
; 		    return 1;
	mov A,1
	xjmp L26
L30:
	.dbline 80
L28:
	.dbline 76
	mov REG[0xd0],>__r0
	mov A,[X-6]
	mov [__r1],A
	mov A,[X-7]
	push X
	mov X,[__r1]
	romx
	pop X
	mov [__r0],A
	mov A,[X-4]
	mov [__r3],A
	mov A,[X-5]
	push X
	mov X,[__r3]
	romx
	pop X
	or A,[__r0]
	cmp A,0
	jnz L27
	.dbline 81
; 		}
;     }
;     return(0);
	mov A,0
	.dbline -2
L26:
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l string2 -7 pc
	.dbsym l string1 -5 pc
	.dbend
	.dbfunc e SearchFirstPos _SearchFirstPos fI
;              i -> X+0
;              c -> X-6
;         buffer -> X-5
_SearchFirstPos::
	.dbline -1
	push X
	mov X,SP
	add SP,4
	.dbline 87
; }
; 
; // 最初に引数2に指定したchar型データが来た場所を返す
; // 返り値 : 発見したポジション
; //          但し、見つからなかった場合は -1 を返す
; int SearchFirstPos(const char* buffer,char c){
	.dbline 89
;     int i;
;     i = 0;
	mov [X+1],0
	mov [X+0],0
	xjmp L34
L33:
	.dbline 90
	.dbline 91
	inc [X-4]
	adc [X-5],0
	.dbline 92
	inc [X+1]
	adc [X+0],0
	.dbline 93
L34:
	.dbline 90
;     while((*buffer != c) && (*buffer)){
	mov REG[0xd0],>__r0
	mov A,[X-4]
	mov [__r1],A
	mov A,[X-5]
	push X
	mov X,[__r1]
	romx
	pop X
	mov [__r1],A
	mov [__r0],0
	mov A,[X-6]
	mov [__r3],A
	mov [__r2],0
	mov A,0
	cmp A,[__r2]
	jnz X2
	mov A,[__r1]
	cmp A,[__r3]
	jz L36
X2:
	mov REG[0xd0],>__r0
	cmp [__r0],0
	jnz L33
	cmp [__r1],0
	jnz L33
X3:
L36:
	.dbline 94
; 		buffer++;
; 		i++;
;     }
;     return (*buffer ? i+1 : -1);
	mov REG[0xd0],>__r0
	mov A,[X-4]
	mov [__r1],A
	mov A,[X-5]
	push X
	mov X,[__r1]
	romx
	pop X
	cmp A,0
	jz L38
	mov A,[X+1]
	add A,1
	mov [X+3],A
	mov A,[X+0]
	adc A,0
	mov [X+2],A
	xjmp L39
L38:
	mov [X+3],-1
	mov [X+2],-1
L39:
	mov REG[0xd0],>__r0
	mov A,[X+3]
	mov [__r1],A
	mov A,[X+2]
	mov [__r0],A
	.dbline -2
L32:
	add SP,-4
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l i 0 I
	.dbsym l c -6 c
	.dbsym l buffer -5 pc
	.dbend
	.dbfunc e tstrlen _tstrlen fI
;            len -> X+0
;         ucpStr -> X-5
_tstrlen::
	.dbline -1
	push X
	mov X,SP
	add SP,2
	.dbline 103
; }
; 
; 
; /*
; 	文字列の長さを調べる
;     引数 : 文字列
;     返値 : 引数で指定した文字列の文字数
; */
; int tstrlen(char* ucpStr){
	.dbline 104
; 	int len = 0;
	mov [X+1],0
	mov [X+0],0
	xjmp L42
L41:
	.dbline 106
	.dbline 107
	inc [X+1]
	adc [X+0],0
	.dbline 108
L42:
	.dbline 106
; 
; 	while(*(ucpStr++)){
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
	mov A,[__r0]
	mov REG[0xd4],A
	mvi A,[__r1]
	cmp A,0
	jnz L41
	.dbline 110
; 		len++;
; 	}
; 
; 	return(len);
	mov A,[X+1]
	mov [__r1],A
	mov A,[X+0]
	mov [__r0],A
	.dbline -2
L40:
	add SP,-2
	pop X
	.dbline 0 ; func end
	ret
	.dbsym l len 0 I
	.dbsym l ucpStr -5 pc
	.dbend
