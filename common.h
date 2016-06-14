#ifndef _COMMON_H_
#define _COMMON_H_

#include "tprintf.h"
#include "tsprintf.h"
#include "tstring.h"

#ifdef NULL
#undef NULL
#endif

#define NULL	((void*)0)
#define CNULL	((const void*)0)

extern void disp_dump(const char* cmsg,char* ptr,int size);
extern void disp_hex(const char* cmsg,unsigned short value);

#define	ARRAY_LEN(x)		((sizeof(x))/(sizeof(x)[0]))

/* uITRONånÇÃå^êÈåæ */
typedef unsigned char		UB;
typedef	signed char			B;
typedef unsigned short		UH;
typedef signed short		H;
typedef unsigned long		UW;
typedef	signed long			W;

#endif /* _COMMON_H_ */
