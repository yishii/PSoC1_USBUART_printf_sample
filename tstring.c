/*
	������R���g���[������ string.c
	Copyright(C)2002 Yasuhiro ISHII
	All rights reserved.
	Ver 0.04
	0.02            : tstrlen�ǉ�
	0.03            : SearchFirstPos�܂Ƃ��ɓ��삵�Ă��Ȃ������̂ŏC��
	0.04 2005/06/11 : �֐����̑��ύX

*/

#include "tstring.h"

void TrimStringLeft(unsigned char* );
void TrimStringRight(unsigned char* );
void tstrcpy(char* ,const char* );
void tstrncpy(char* ,const char* ,int );
char tstrcmp(const char* ,const char* );
int SearchFirstPos(const char* ,char );
int tstrlen(char* );

// ������̃g���~���O(������̎n�_��)
// ��(0x20)����菜��
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

// ������̃g���~���O(������̏I�_��)
// ��(0x20)����菜��
void TrimStringRight(unsigned char* buffer){
    unsigned char i;
	i=0;
    while(buffer[i++]);
    i-=2;
    while(buffer[i--] == 0x20);
    buffer[i+2]=0x00;
}

// strcpy�R���p�`�֐�
// �A���Ԃ�l�Ȃ�
void tstrcpy(char* dst,const char* src){
    while(*src){
		*dst++ = *src++;
    }
    *dst=*src;
}


// strncpy�R���p�`�֐�
// �A���Ԃ�l�Ȃ�
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
// �Ԃ�l�͕W����strcmp�Ə����قȂ�
// �Ԃ�l : string1��string2������ : 0
//          string1��string2�͈قȂ� : 1
char tstrcmp(const char* string1,const char* string2){
    while(*string1 | *string2){
		if (*string1++ != *string2++){
		    return 1;
		}
    }
    return(0);
}

// �ŏ��Ɉ���2�Ɏw�肵��char�^�f�[�^�������ꏊ��Ԃ�
// �Ԃ�l : ���������|�W�V����
//          �A���A������Ȃ������ꍇ�� -1 ��Ԃ�
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
	������̒����𒲂ׂ�
    ���� : ������
    �Ԓl : �����Ŏw�肵��������̕�����
*/
int tstrlen(char* ucpStr){
	int len = 0;

	while(*(ucpStr++)){
		len++;
	}

	return(len);
}
