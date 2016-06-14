/*
	文字列コントロール処理 string.c
	Copyright(C)2002 Yasuhiro ISHII
	All rights reserved.
	Ver 0.04
	0.02            : tstrlen追加
	0.03            : SearchFirstPosまともに動作していなかったので修正
	0.04 2005/06/11 : 関数名称総変更

*/

#include "tstring.h"

void TrimStringLeft(unsigned char* );
void TrimStringRight(unsigned char* );
void tstrcpy(char* ,const char* );
void tstrncpy(char* ,const char* ,int );
char tstrcmp(const char* ,const char* );
int SearchFirstPos(const char* ,char );
int tstrlen(char* );

// 文字列のトリミング(文字列の始点側)
// 空白(0x20)を取り除く
void TrimStringLeft(unsigned char* buffer){
	unsigned char i,j;
	i=j=0;
	while(buffer[i] == 0x20){
		i++;
	}
	while (buffer[i+j]){
		buffer[j]=buffer[i+j];
		j++;
	}
	buffer[j] = 0;
}

// 文字列のトリミング(文字列の終点側)
// 空白(0x20)を取り除く
void TrimStringRight(unsigned char* buffer){
    unsigned char i;
	i=0;
    while(buffer[i++]);
    i-=2;
    while(buffer[i--] == 0x20);
    buffer[i+2]=0x00;
}

// strcpyコンパチ関数
// 但し返り値なし
void tstrcpy(char* dst,const char* src){
    while(*src){
		*dst++ = *src++;
    }
    *dst=*src;
}


// strncpyコンパチ関数
// 但し返り値なし
void tstrncpy(char* dst,const char* src,int count){
    int i;
    i=0;
    if (count){
		while(*src && i < count - 1){
			*dst++ = *src++;
		}
		*dst=*src;
    }
}

// string compare
// 返り値は標準のstrcmpと少し異なる
// 返り値 : string1とstring2が同じ : 0
//          string1とstring2は異なる : 1
char tstrcmp(const char* string1,const char* string2){
    while(*string1 | *string2){
		if (*string1++ != *string2++){
		    return 1;
		}
    }
    return(0);
}

// 最初に引数2に指定したchar型データが来た場所を返す
// 返り値 : 発見したポジション
//          但し、見つからなかった場合は -1 を返す
int SearchFirstPos(const char* buffer,char c){
    int i;
    i = 0;
    while((*buffer != c) && (*buffer)){
		buffer++;
		i++;
    }
    return (*buffer ? i+1 : -1);
}


/*
	文字列の長さを調べる
    引数 : 文字列
    返値 : 引数で指定した文字列の文字数
*/
int tstrlen(char* ucpStr){
	int len = 0;

	while(*(ucpStr++)){
		len++;
	}

	return(len);
}
