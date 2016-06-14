/*
  Tiny printf module
   for Embedded microcontrollers
   Copyright(C) 2005-2006 Yasuhiro ISHII
   File Version : 0.3

   (内部でtsprintfとuart_txsを使用します)

   0.3 : 送出関数をコールバックに変更
   0.2 : vtsprintfを作成して渡すようにした
   0.1 : First version
*/

//#include <stdarg.h>
#include "common.h"
#include "./tsprintf.h"

int ctprintf(const char* , ...);
void tprintf_SetCallBack(void (*)(char*));

static void (*uart_txs)(char*);

/** const文字列用Tiny printf関数
 * @param fmt 書式指定文字列
 * @param [argument]... 省略可能な引数
 * @return 生成文字の文字数
 * @note fmtに指定する文字列はROM内に確保したものを指定してください
 */
int ctprintf(const char* fmt, ...){
	char buf[80];
	va_list ap;
	int len;

	// コールバックが設定されていない場合の確認
	if (uart_txs == NULL){
		return(-1);
	}

	va_start(ap, fmt);
	
	len = cvtsprintf(buf, fmt, ap);

	va_end(ap);

	// 出力用コールバック関数をコール
	(*uart_txs)(buf);
	
	return(len);
}

/** Type printf標準出力用関数をコールバック登録する
 * @param func ASCIIZ文字列を出力できるvoid func(char*)型関数へのポインタ
 * @note NULLを指定しないこと
 */
void tprintf_SetCallBack(void (*func)(char*)){

	uart_txs = func;

}
