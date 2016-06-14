/** 
 * @file  main.c
 * @brief PSoC USBUARTテスト メイン処理
 *
 * @author Yasuhiro ISHII
 * @date 2007-01-01
 * @version $Id: $
 *
 */

#include <m8c.h>        // part specific constants and macros
#include <stdlib.h>
#include "common.h"
#include "PSoCAPI.h"    // PSoC API definitions for all User Modules

static void usbuart_stdout(char* str);

BYTE pData[32];  
int Len;

void main(void){
	int i = 30;
	char ram[10];

	M8C_EnableGInt;							// Global Interrupts有効化

	USBUART_Start(USBUART_5V_OPERATION);
	tprintf_SetCallBack(usbuart_stdout);	// tprintf文字列出力用コールバック関数を登録
	while(!USBUART_Init());					// USBUART初期化待ち

	///////////////////////////////////////////////////////////////////////////
	// 初期化完了
	///////////////////////////////////////////////////////////////////////////

	// 通常処理

	while(1){

		// 何かキー入力があるまで待つ

		Len = USBUART_bGetRxCount();       //Get count of ready data
		if (Len){
			USBUART_ReadAll(pData);        //Read all data rom RX

			// キー入力があったら、テスト用のメッセージを表示する
			{
				i++;		// インクリメント

				tstrcpy(ram,"R A M!");

				ctprintf("i = %d(Hex:%X)(ROM:%S)(RAM:%s) %c%c%c\n\r",i,i,"Hello",ram,0x31,0x32,0x33);
			}
		}
	}

}

/** USBUARTへ文字列出力する
 * @param str 出力したいASCIIZ文字列に対するポインタ
 */
static void usbuart_stdout(char* str){
	int len;

	len = tstrlen(str) + 1;

	while (!USBUART_bTxIsReady());
	USBUART_Write(str,len);

}

