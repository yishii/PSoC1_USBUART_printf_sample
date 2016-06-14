//----------------------------------------------------------------------------
// C main line
//----------------------------------------------------------------------------

#include <m8c.h>        // part specific constants and macros
#include "PSoCAPI.h"    // PSoC API definitions for all User Modules

BYTE Len;  
BYTE pData[32];

void main()
{
    M8C_EnableGInt;                        //Enable Global Interrupts    
    USBUART_Start(USBUART_3V_OPERATION);
	while(!USBUART_Init());
	
    while(1)  
    {  
        Len = USBUART_bGetRxCount();       //Get count of ready data  
        if (Len)    
        {   
            USBUART_ReadAll(pData);        //Read all data rom RX   
            while (!USBUART_bTxIsReady()); //If TX is ready  
            USBUART_Write(pData, Len);     //Echo  
        }  
    }   
}
