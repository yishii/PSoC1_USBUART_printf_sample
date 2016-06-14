#ifndef _TPRINTF_H_
#define _TPRINTF_H_

/*
  Tiny printf module
   for Embedded microcontrollers
*/

extern int ctprintf(const char* , ...);
extern void tprintf_SetCallBack(void (*)(char*));

#endif /* _TPRINTF_H_ */
