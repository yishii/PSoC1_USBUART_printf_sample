/** 
 * @file  main.c
 * @brief PSoC USBUART�e�X�g ���C������
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

	M8C_EnableGInt;							// Global Interrupts�L����

	USBUART_Start(USBUART_5V_OPERATION);
	tprintf_SetCallBack(usbuart_stdout);	// tprintf������o�͗p�R�[���o�b�N�֐���o�^
	while(!USBUART_Init());					// USBUART�������҂�

	///////////////////////////////////////////////////////////////////////////
	// ����������
	///////////////////////////////////////////////////////////////////////////

	// �ʏ폈��

	while(1){

		// �����L�[���͂�����܂ő҂�

		Len = USBUART_bGetRxCount();       //Get count of ready data
		if (Len){
			USBUART_ReadAll(pData);        //Read all data rom RX

			// �L�[���͂���������A�e�X�g�p�̃��b�Z�[�W��\������
			{
				i++;		// �C���N�������g

				tstrcpy(ram,"R A M!");

				ctprintf("i = %d(Hex:%X)(ROM:%S)(RAM:%s) %c%c%c\n\r",i,i,"Hello",ram,0x31,0x32,0x33);
			}
		}
	}

}

/** USBUART�֕�����o�͂���
 * @param str �o�͂�����ASCIIZ������ɑ΂���|�C���^
 */
static void usbuart_stdout(char* str){
	int len;

	len = tstrlen(str) + 1;

	while (!USBUART_bTxIsReady());
	USBUART_Write(str,len);

}

