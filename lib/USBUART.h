//*****************************************************************************
//*****************************************************************************
//  FILENAME: USBUART.h
//   Version: 1.0, Updated on 2006/10/20 at 16:08:45
//  Generated by PSoC Designer ver 4.3  b1884 : 23 June, 2006
//
//  DESCRIPTION: USBUART User Module C Language interface file
//               for the CY8C24090 and CY7C64215 family of devices
//-----------------------------------------------------------------------------
//  Copyright (c) Cypress Semiconductor 2006. All Rights Reserved.
//*****************************************************************************
//*****************************************************************************
#include <m8c.h>

//-------------------------------------------------
// fastcall16 qualifiers for the  USBUART API.
//-------------------------------------------------
#pragma fastcall16 USBUART_Start
#pragma fastcall16 USBUART_Stop
#pragma fastcall16 USBUART_Init

#pragma fastcall16 USBUART_Write
#pragma fastcall16 USBUART_CWrite
#pragma fastcall16 USBUART_PutString
#pragma fastcall16 USBUART_CPutString
#pragma fastcall16 USBUART_PutChar
#pragma fastcall16 USBUART_PutCRLF
#pragma fastcall16 USBUART_PutSHexByte
#pragma fastcall16 USBUART_PutSHexInt

#pragma fastcall16 USBUART_bGetRxCount
#pragma fastcall16 USBUART_bTxIsReady

#pragma fastcall16 USBUART_Read
#pragma fastcall16 USBUART_ReadAll
#pragma fastcall16 USBUART_ReadChar

#pragma fastcall16 USBUART_bCheckUSBActivity

#pragma fastcall16 USBUART_dwGetDTERate
#pragma fastcall16 USBUART_bGetCharFormat
#pragma fastcall16 USBUART_bGetParityType
#pragma fastcall16 USBUART_bGetDataBits
#pragma fastcall16 USBUART_bGetLineControlBitmap
#pragma fastcall16 USBUART_SendStateNotify

//-------------------------------------------------
// Prototypes of the USBUART API.
//-------------------------------------------------
// high level API
extern void USBUART_Start(BYTE bMode);
extern void USBUART_Stop(void);
extern BOOL USBUART_Init(void);
extern void USBUART_Write(BYTE * pData, BYTE bLength);
extern void USBUART_CWrite(const BYTE * pData, BYTE bLength);
extern void USBUART_PutString(BYTE * pStr);
extern void USBUART_CPutString(const BYTE * pStr);
extern void USBUART_PutChar(BYTE bChar);
extern void USBUART_PutCRLF(void);
extern void USBUART_PutSHexByte(BYTE bValue);
extern void USBUART_PutSHexInt(INT iValue);
extern BYTE USBUART_bGetRxCount(void);
extern BYTE USBUART_bTxIsReady(void);
extern BYTE USBUART_Read(BYTE * pData, BYTE bLength);
extern void USBUART_ReadAll(BYTE * pData);
extern WORD USBUART_ReadChar(void);
extern BYTE USBUART_bCheckUSBActivity(void);
extern DWORD *USBUART_dwGetDTERate(DWORD * dwDTERate);
extern BYTE USBUART_bGetCharFormat(void);
extern BYTE USBUART_bGetParityType(void);
extern BYTE USBUART_bGetDataBits(void);
extern BYTE USBUART_bGetLineControlBitmap(void);
extern void USBUART_SendStateNotify(BYTE bState);

//-------------------------------------------------
// Constants for  USBUART API's.
//-------------------------------------------------

#define USBUART_3V_OPERATION         0x02
#define USBUART_5V_OPERATION         0x03

#define USBUART_1_STOPBIT            0x00  
#define USBUART_1_5_STOPBIT          0x01  
#define USBUART_2_STOPBIT            0x02  

#define USBUART_PARITY_NONE          0x00  
#define USBUART_PARITY_ODD           0x01  
#define USBUART_PARITY_EVEN          0x02  
#define USBUART_PARITY_MARK          0x03  
#define USBUART_PARITY_SPACE         0x04  

#define USBUART_DTR                  0x01  
#define USBUART_RTS                  0x02

#define USBUART_DCD                  0x01  
#define USBUART_DSR                  0x02  
#define USBUART_BREAK                0x04  
#define USBUART_RING                 0x08  
#define USBUART_FRAMING_ERR          0x10  
#define USBUART_PARITY_ERR           0x20  
#define USBUART_OVERRUN              0x40  

//--------------------------------------------------
// Constants for interrupt regs and masks
//--------------------------------------------------
#pragma ioport USBUART_INT_REG: 0x0DF
BYTE           USBUART_INT_REG;            
#define USBUART_INT_RESET_MASK 0x01
#define USBUART_INT_SOF_MASK   0x02
#define USBUART_INT_EP0_MASK   0x04
#define USBUART_INT_EP1_MASK   0x08
#define USBUART_INT_EP2_MASK   0x10
#define USBUART_INT_EP3_MASK   0x20
#define USBUART_INT_EP4_MASK   0x40
#define USBUART_INT_WAKEUP_MASK 0x80


// end of file USBUART.h

// end of file USBFS.h
