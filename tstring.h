/*
	文字列コントロール処理 strings ヘッダファイル
	Copyright(C)2002 Yasuhiro ISHII
	All rights reserved.
	Ver 0.04

	0.02            : tstrlen追加
	0.04 2005/06/11 : 関数名称総変更
*/

#ifndef _TSTRING_H_
#define _TSTRING_H_

extern void TrimStringLeft(unsigned char* );
extern void TrimStringRight(unsigned char* );
extern void tstrcpy(char* ,const char* );
extern char tstrcmp(const char* ,const char* );
extern void tstrncpy(char* ,const char* ,int );
extern int SearchFirstPos(const char* ,char );
extern int tstrlen(char* );

#endif /* _TSTRING_H_ */

