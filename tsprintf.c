/*
  Tiny sprintf module
   for Embedded microcontrollers
   Copyright(C) 2005 Yasuhiro ISHII
   
   File Version : 1.3
   Copyright(C) 2005-2007 Yasuhiro ISHII

   �y�o�[�W�����A�b�v�����z
   0.1 : �Ƃ肠�����Ȃ񂩓�������
   0.2 : decimal��0�\���Ή�   20050313
   0.3 : hexa decimal��0�\���Ή� 20050313
   0.4 : �\�[�X���̕ςȃR�[�h(^M)���폜���� 20050503
   0.5 : tsprintf�֐��̕ϐ� size������������悤�ɂ��� 20050503
   0.6 : %d�̕����Ή�,%x��unsigned������ 20050522
   0.7 : %d,%x�̌����w��(%[n]d)/0�⊮�w��(%0[n]d)�Ή� 20050522
   0.8 : va_list�œn��vtsprintf���쐬���Avsprintf��vtsprintf�̐e�֐��ɂ��� 20050522
   0.9 : hex�ŁA�l��0�̎��Ɍ���1�ɂȂ��Ă��܂��o�O�C�� 20050526
   1.0 : dec�ŁA�l��0�̎��Ɍ���1�ɂȂ��Ă��܂��o�O�C�� 20050629
   1.1 : �n�[�o�[�h�E�A�[�L�e�N�`���Ή������const�łƂ��Ē�` 20061224
   1.2 : �m�ۂ��Ă��Ȃ�RAM���󂷃o�O���C��(10�i�A16�i�\������)
   1.3 : PSoC��p�ɏ�������

   printf�̏����ݒ���ȈՓI�Ȃ��̂ɂ��Ď������Ă���̂Ŏg�p���ɂ�
   ���������m�F���ĉ������B

*/
#include "common.h"
#include "./tsprintf.h"
#include "PSoCAPI.h"    // PSoC API definitions for all User Modules

int ctsprintf(char* ,const char* ,...);
int cvtsprintf(char* buff,const char* fmt,va_list arg);

static int tsprintf_string(char* ,char* );
static int tsprintf_cstring(const char* str,char* buff);
static int tsprintf_char(int ,char* );
static int tsprintf_decimal(signed long,char* ,int ,int );
static int tsprintf_hexadecimal(unsigned long ,char* ,int ,int ,int );

/** Tiny sprintf(const�����w�蕶����)�֐�
 * @param buff ����������������i�[����ׂ̃o�b�t�@�ւ̃|�C���^
 * @param fmt �����w�蕶����
 * @param [argument]... �ȗ��\�Ȉ���
 * @return ���������̕�����
 * @note fmt�Ɏw�肷�镶�����ROM���Ɋm�ۂ������̂��w�肵�Ă�������
 */
int ctsprintf(char* buff,const char* fmt, ...){
	va_list arg;
	int result;

	va_start(arg, fmt);

	result = cvtsprintf(buff,fmt,arg);
	
	va_end(arg);

	return(result);
}

/** Tiny vsprintf(const�����w�蕶����)�֐�
 * @param buff ����������������i�[����ׂ̃o�b�t�@�ւ̃|�C���^
 * @param fmt �����w�蕶����
 * @param arg ����
 * @return ���������̕�����
 * @note fmt�Ɏw�肷�镶�����ROM���Ɋm�ۂ������̂��w�肵�Ă�������
 */
int cvtsprintf(char* buff,const char* fmt,va_list arg){
	int len;
	int size;
	int zeroflag,width;
	int prev_sizeofarg;

	prev_sizeofarg = 0;

	size = 0;
	len = 0;

	while(*fmt){
		if(*fmt=='%'){		/* % �Ɋւ��鏈�� */
			zeroflag = width = 0;
			fmt++;

			if (*fmt == '0'){
				fmt++;
				zeroflag = 1;
			}
			if ((*fmt >= '0') && (*fmt <= '9')){
				width = *(fmt++) - '0';
			}

			switch(*fmt){
			case 'd':		/* 16�r�b�g 10�i�� */
				size = tsprintf_decimal(va_arg(arg,H),buff,zeroflag,width);
				break;
			case 'x':		/* 16�r�b�g 16�i�� 0-f */
//				size = tsprintf_hexadecimal(va_arg(arg,unsigned long),buff,0,zeroflag,width);
				size = tsprintf_hexadecimal(va_arg(arg,UH),buff,0,zeroflag,width);
				break;
			case 'X':		/* 16�r�b�g 16�i�� 0-F */
//				size = tsprintf_hexadecimal(va_arg(arg,unsigned long),buff,1,zeroflag,width);
				size = tsprintf_hexadecimal(va_arg(arg,UH),buff,1,zeroflag,width);
				break;
			case 'c':		/* �L�����N�^�[ */
				size = tsprintf_char(va_arg(arg,H),buff);
				break;
			case 's':		/* ASCIIZ������ */
				size = tsprintf_string(va_arg(arg,char*),buff);
				break;
			case 'S':		/* const ASCIIZ������ */
				size = tsprintf_cstring(va_arg(arg,const char*),buff);
				break;
			default:		/* �R���g���[���R�[�h�ȊO�̕��� */
				/* %%(%�ɑΉ�)�͂����őΉ������ */
				len++;
				*(buff++) = *fmt;
				break;
			}
			len += size;
			buff += size;
			fmt++;
		} else {
			*(buff++) = *(fmt++);
			len++;
		}
	}

	*buff = '\0';		/* �I�[������ */

	va_end(arg);
	return (len);
}

/** ���l => 10�i������ϊ�
 * @param val �ϊ�������������f�[�^
 * @param buff �ϊ�����������f�[�^���i�[����o�b�t�@�ւ̃|�C���^
 * @param zf 1:������f�[�^�擪������0�𖄂ߍ���
 * @param wd �����񂷂�ꍇ�̌����w��(0�`9)
 * @return ���������̕�����
 */
static int tsprintf_decimal(signed long val,char* buff,int zf,int wd){
	int i;
	char tmp[10];
	char* ptmp = tmp + 9;
	int len = 0;
	int minus = 0;
				
	if (!val){		/* �w��l��0�̏ꍇ */
		*(ptmp--) = '0';
		len++;
	} else {
		/* �}�C�i�X�̒l�̏ꍇ�ɂ�2�̕␔����� */
		if (val < 0){
			val = ~val;
			val++;
			minus = 1;
		}
		while (val){

			/* �o�b�t�@�A���_�[�t���[�΍� */
			if (len >= 8){
				break;
			}
	
			*ptmp = (val % 10) + '0';

			val /= 10;
			ptmp--;
			len++;
		}

	}

	/* �����A�����킹�Ɋւ��鏈�� */
	if (zf){
		if (minus){
			wd--;
		}
		while (len < wd){
			*(ptmp--) =  '0';
			len++;
		}
		if (minus){
			*(ptmp--) = '-';
			len++;
		}
	} else {
		if (minus){
			*(ptmp--) = '-';
			len++;
		}
		while (len < wd){
			*(ptmp--) =  ' ';
			len++;
		}
	}

	/* ����������̃o�b�t�@�R�s�[ */
	for (i=0;i<len;i++){
		*(buff++) = *(++ptmp);
	}

	return (len);
}

/** ���l => 16�i������ϊ�
 * @param val �ϊ�������������f�[�^
 * @param buff �ϊ�����������f�[�^���i�[����o�b�t�@�ւ̃|�C���^
 * @param capital 1 : 16�i��a�`f��'A'�`'F'�ɂ���
 * @param zf 1:������f�[�^�擪������0�𖄂ߍ���
 * @param wd �����񂷂�ꍇ�̌����w��(0�`9)
 * @return ���������̕�����
 */
static int tsprintf_hexadecimal(unsigned long val,char* buff,
								int capital,int zf,int wd){
	int i;
	char tmp[10];
	char* ptmp = tmp + 9;
	int len = 0;
	char str_a;

	/* A�`F��啶���ɂ��邩�������ɂ��邩�؂�ւ��� */
	if (capital){
		str_a = 'A';
	} else {
		str_a = 'a';
	}
	
	if (!val){		/* �w��l��0�̏ꍇ */
		*(ptmp--) = '0';
		len++;
	} else {
		while (val){
			/* �o�b�t�@�A���_�[�t���[�΍� */
			if (len >= 8){
				break;
			}

			*ptmp = (val % 16);
			if (*ptmp > 9){
				*ptmp += str_a - 10;
			} else {
				*ptmp += '0';
			}
		
			val >>= 4;		/* 16�Ŋ��� */
			ptmp--;
			len++;
		}
	}
	while (len < wd){
		*(ptmp--) =  zf ? '0' : ' ';
		len++;
	}
		
	for (i=0;i<len;i++){
		*(buff++) = *(++ptmp);
	}

	return(len);
}

/** 1�L�����N�^�\��
 * @param ch �����f�[�^�̃R�[�h�l
 * @param buff �ϊ�����������f�[�^���i�[����o�b�t�@�ւ̃|�C���^
 * @return ���������̕�����
 */
static int tsprintf_char(int ch,char* buff){
	*buff = (char)ch;
	return(1);
}

/** ASCIIZ������\��(�������RAM���Ɋm�ۂ��邱��)
 * @param str ASCIIZ������f�[�^�ւ̃|�C���^
 * @param buff �ϊ�����������f�[�^���i�[����o�b�t�@�ւ̃|�C���^
 * @return ���������̕�����
 */
static int tsprintf_string(char* str,char* buff){
	int count = 0;
	while(*str){
		*(buff++) = *str;
		str++;
		count++;
	}
	return(count);
}

/** Const ASCIIZ������\��(�������ROM���Ɋm�ۂ��邱��)
 * @param str ASCIIZ������f�[�^�ւ̃|�C���^
 * @param buff �ϊ�����������f�[�^���i�[����o�b�t�@�ւ̃|�C���^
 * @return ���������̕�����
 */
static int tsprintf_cstring(const char* str,char* buff){
	int count = 0;
	while(*str){
		*(buff++) = *str;
		str++;
		count++;
	}
	return(count);
}
