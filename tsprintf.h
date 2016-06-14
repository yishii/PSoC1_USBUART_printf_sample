/*
  Tiny sprintf module
   for Embedded microcontrollers

   (Ver 1.0)
*/

#ifndef _TSPRINTF_H_
#define _TSPRINTF_H_

typedef char* va_list;
#define va_start(ap, p)				(ap = (va_list)(&p))
#define va_arg(ap,type)				(*(type*)((ap-=sizeof(type))))
#define va_end(ap)

//#include <stdarg.h>

extern int cvtsprintf(char* buff,const char* fmt,va_list arg);

#endif /* _TSPRINTF_H_ */

