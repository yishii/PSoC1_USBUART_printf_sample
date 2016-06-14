/*
  Tiny printf module
   for Embedded microcontrollers
   Copyright(C) 2005-2006 Yasuhiro ISHII
   File Version : 0.3

   (������tsprintf��uart_txs���g�p���܂�)

   0.3 : ���o�֐����R�[���o�b�N�ɕύX
   0.2 : vtsprintf���쐬���ēn���悤�ɂ���
   0.1 : First version
*/

//#include <stdarg.h>
#include "common.h"
#include "./tsprintf.h"

int ctprintf(const char* , ...);
void tprintf_SetCallBack(void (*)(char*));

static void (*uart_txs)(char*);

/** const������pTiny printf�֐�
 * @param fmt �����w�蕶����
 * @param [argument]... �ȗ��\�Ȉ���
 * @return ���������̕�����
 * @note fmt�Ɏw�肷�镶�����ROM���Ɋm�ۂ������̂��w�肵�Ă�������
 */
int ctprintf(const char* fmt, ...){
	char buf[80];
	va_list ap;
	int len;

	// �R�[���o�b�N���ݒ肳��Ă��Ȃ��ꍇ�̊m�F
	if (uart_txs == NULL){
		return(-1);
	}

	va_start(ap, fmt);
	
	len = cvtsprintf(buf, fmt, ap);

	va_end(ap);

	// �o�͗p�R�[���o�b�N�֐����R�[��
	(*uart_txs)(buf);
	
	return(len);
}

/** Type printf�W���o�͗p�֐����R�[���o�b�N�o�^����
 * @param func ASCIIZ��������o�͂ł���void func(char*)�^�֐��ւ̃|�C���^
 * @note NULL���w�肵�Ȃ�����
 */
void tprintf_SetCallBack(void (*func)(char*)){

	uart_txs = func;

}
