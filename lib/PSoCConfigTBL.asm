; Generated by PSoC Designer ver 4.3  b1884 : 23 June, 2006
;
include "m8c.inc"
;  Personalization tables 
export LoadConfigTBL_usb_uart_um
AREA psoc_config(rom, rel)
LoadConfigTBL_usb_uart_um:
;  Ordered Global Register values
	M8C_SetBank1
	mov	reg[00h], 00h		; Port_0_DriveMode_0 register (PRT0DM0)
	mov	reg[01h], ffh		; Port_0_DriveMode_1 register (PRT0DM1)
	M8C_SetBank0
	mov	reg[03h], ffh		; Port_0_DriveMode_2 register (PRT0DM2)
	mov	reg[02h], 00h		; Port_0_GlobalSelect register (PRT0GS)
	M8C_SetBank1
	mov	reg[02h], 00h		; Port_0_IntCtrl_0 register (PRT0IC0)
	mov	reg[03h], 00h		; Port_0_IntCtrl_1 register (PRT0IC1)
	M8C_SetBank0
	mov	reg[01h], 00h		; Port_0_IntEn register (PRT0IE)
	M8C_SetBank1
	mov	reg[04h], 00h		; Port_1_DriveMode_0 register (PRT1DM0)
	mov	reg[05h], ffh		; Port_1_DriveMode_1 register (PRT1DM1)
	M8C_SetBank0
	mov	reg[07h], ffh		; Port_1_DriveMode_2 register (PRT1DM2)
	mov	reg[06h], 00h		; Port_1_GlobalSelect register (PRT1GS)
	M8C_SetBank1
	mov	reg[06h], 00h		; Port_1_IntCtrl_0 register (PRT1IC0)
	mov	reg[07h], 00h		; Port_1_IntCtrl_1 register (PRT1IC1)
	M8C_SetBank0
	mov	reg[05h], 00h		; Port_1_IntEn register (PRT1IE)
	M8C_SetBank1
	mov	reg[08h], 00h		; Port_2_DriveMode_0 register (PRT2DM0)
	mov	reg[09h], ffh		; Port_2_DriveMode_1 register (PRT2DM1)
	M8C_SetBank0
	mov	reg[0bh], ffh		; Port_2_DriveMode_2 register (PRT2DM2)
	mov	reg[0ah], 00h		; Port_2_GlobalSelect register (PRT2GS)
	M8C_SetBank1
	mov	reg[0ah], 00h		; Port_2_IntCtrl_0 register (PRT2IC0)
	mov	reg[0bh], 00h		; Port_2_IntCtrl_1 register (PRT2IC1)
	M8C_SetBank0
	mov	reg[09h], 00h		; Port_2_IntEn register (PRT2IE)
	M8C_SetBank1
	mov	reg[0ch], 00h		; Port_3_DriveMode_0 register (PRT3DM0)
	mov	reg[0dh], ffh		; Port_3_DriveMode_1 register (PRT3DM1)
	M8C_SetBank0
	mov	reg[0fh], ffh		; Port_3_DriveMode_2 register (PRT3DM2)
	mov	reg[0eh], 00h		; Port_3_GlobalSelect register (PRT3GS)
	M8C_SetBank1
	mov	reg[0eh], 00h		; Port_3_IntCtrl_0 register (PRT3IC0)
	mov	reg[0fh], 00h		; Port_3_IntCtrl_1 register (PRT3IC1)
	M8C_SetBank0
	mov	reg[0dh], 00h		; Port_3_IntEn register (PRT3IE)
	M8C_SetBank1
	mov	reg[10h], 00h		; Port_4_DriveMode_0 register (PRT4DM0)
	mov	reg[11h], ffh		; Port_4_DriveMode_1 register (PRT4DM1)
	M8C_SetBank0
	mov	reg[13h], ffh		; Port_4_DriveMode_2 register (PRT4DM2)
	mov	reg[12h], 00h		; Port_4_GlobalSelect register (PRT4GS)
	M8C_SetBank1
	mov	reg[12h], 00h		; Port_4_IntCtrl_0 register (PRT4IC0)
	mov	reg[13h], 00h		; Port_4_IntCtrl_1 register (PRT4IC1)
	M8C_SetBank0
	mov	reg[11h], 00h		; Port_4_IntEn register (PRT4IE)
	M8C_SetBank1
	mov	reg[14h], 00h		; Port_5_DriveMode_0 register (PRT5DM0)
	mov	reg[15h], ffh		; Port_5_DriveMode_1 register (PRT5DM1)
	M8C_SetBank0
	mov	reg[17h], ffh		; Port_5_DriveMode_2 register (PRT5DM2)
	mov	reg[16h], 00h		; Port_5_GlobalSelect register (PRT5GS)
	M8C_SetBank1
	mov	reg[16h], 00h		; Port_5_IntCtrl_0 register (PRT5IC0)
	mov	reg[17h], 00h		; Port_5_IntCtrl_1 register (PRT5IC1)
	M8C_SetBank0
	mov	reg[15h], 00h		; Port_5_IntEn register (PRT5IE)
	M8C_SetBank1
	mov	reg[1ch], 00h		; Port_7_DriveMode_0 register (PRT7DM0)
	mov	reg[1dh], 81h		; Port_7_DriveMode_1 register (PRT7DM1)
	M8C_SetBank0
	mov	reg[1fh], 81h		; Port_7_DriveMode_2 register (PRT7DM2)
	mov	reg[1eh], 00h		; Port_7_GlobalSelect register (PRT7GS)
	M8C_SetBank1
	mov	reg[1eh], 00h		; Port_7_IntCtrl_0 register (PRT7IC0)
	mov	reg[1fh], 00h		; Port_7_IntCtrl_1 register (PRT7IC1)
	M8C_SetBank0
	mov	reg[1dh], 00h		; Port_7_IntEn register (PRT7IE)
	M8C_SetBank0
;  Global Register values
	mov	reg[60h], 09h		; AnalogColumnInputSelect register (AMX_IN)
	mov	reg[66h], 00h		; AnalogComparatorControl1 register (CMP_CR1)
	mov	reg[61h], 00h		; AnalogMuxBusConfig register (AMUXCFG)
	mov	reg[63h], 05h		; AnalogReferenceControl register (ARF_CR)
	mov	reg[65h], 00h		; AnalogSyncControl register (ASY_CR)
	mov	reg[fdh], 00h		; DAC_Data register (DAC_D)
	mov	reg[e6h], 00h		; DecimatorControl_0 register (DEC_CR0)
	mov	reg[e7h], 00h		; DecimatorControl_1 register (DEC_CR1)
	mov	reg[56h], 00h		; Endpoint0Control register (EP0_CR)
	mov	reg[57h], 00h		; Endpoint0Count register (EP0_CNT)
	mov	reg[58h], 00h		; Endpoint0Data0 register (EP0_DR0)
	mov	reg[59h], 00h		; Endpoint0Data1 register (EP0_DR1)
	mov	reg[5ah], 00h		; Endpoint0Data2 register (EP0_DR2)
	mov	reg[5bh], 00h		; Endpoint0Data3 register (EP0_DR3)
	mov	reg[5ch], 00h		; Endpoint0Data4 register (EP0_DR4)
	mov	reg[5dh], 00h		; Endpoint0Data5 register (EP0_DR5)
	mov	reg[5eh], 00h		; Endpoint0Data6 register (EP0_DR6)
	mov	reg[5fh], 00h		; Endpoint0Data7 register (EP0_DR7)
	mov	reg[4fh], 00h		; Endpoint1Count0 register (EP1_CNT)
	mov	reg[4eh], 00h		; Endpoint1Count1 register (EP1_CNT1)
	mov	reg[51h], 00h		; Endpoint2Count0 register (EP2_CNT)
	mov	reg[50h], 00h		; Endpoint2Count1 register (EP2_CNT1)
	mov	reg[53h], 00h		; Endpoint3Count0 register (EP3_CNT)
	mov	reg[52h], 00h		; Endpoint3Count1 register (EP3_CNT1)
	mov	reg[55h], 00h		; Endpoint4Count0 register (EP4_CNT)
	mov	reg[54h], 00h		; Endpoint4Count1 register (EP4_CNT1)
	mov	reg[d6h], 00h		; I2CConfig register (I2CCFG)
	mov	reg[b0h], 00h		; Row_0_InputMux register (RDI0RI)
	mov	reg[b1h], 00h		; Row_0_InputSync register (RDI0SYN)
	mov	reg[b2h], 00h		; Row_0_LogicInputAMux register (RDI0IS)
	mov	reg[b3h], 33h		; Row_0_LogicSelect_0 register (RDI0LT0)
	mov	reg[b4h], 33h		; Row_0_LogicSelect_1 register (RDI0LT1)
	mov	reg[b5h], 00h		; Row_0_OutputDrive_0 register (RDI0SRO0)
	mov	reg[b6h], 00h		; Row_0_OutputDrive_1 register (RDI0SRO1)
	mov	reg[4ah], 00h		; USBControl_0 register (USB_CR0)
	mov	reg[4bh], 00h		; USBIOControl_0 register (USBIO_CR0)
	mov	reg[4ch], 00h		; USBIOControl_1 register (USBIO_CR1)
;  Instance name USBUART, User Module USBUART
	M8C_SetBank1
;  Global Register values
	mov	reg[61h], 00h		; AnalogClockSelect1 register (CLK_CR1)
	mov	reg[69h], 00h		; AnalogClockSelect2 register (CLK_CR2)
	mov	reg[60h], 00h		; AnalogColumnClockSelect register (CLK_CR0)
	mov	reg[62h], 00h		; AnalogIOControl_0 register (ABF_CR0)
	mov	reg[67h], 33h		; AnalogLUTControl0 register (ALT_CR0)
	mov	reg[68h], 00h		; AnalogLUTControl1 register (ALT_CR1)
	mov	reg[63h], 00h		; AnalogModulatorControl_0 register (AMD_CR0)
	mov	reg[66h], 00h		; AnalogModulatorControl_1 register (AMD_CR1)
	mov	reg[64h], 00h		; ComparatorGlobalOutEn register (CMP_GO_EN)
	mov	reg[64h], 00h		; ComparatorGlobalOutEn1 register (CMP_GO_EN1)
	mov	reg[fdh], 80h		; DAC_Control register (DAC_CR)
	mov	reg[c4h], 00h		; Endpoint1Control register (EP1_CR)
	mov	reg[c5h], 00h		; Endpoint2Control register (EP2_CR)
	mov	reg[c6h], 00h		; Endpoint3Control register (EP3_CR)
	mov	reg[c7h], 00h		; Endpoint4Control register (EP4_CR)
	mov	reg[d1h], 00h		; GlobalDigitalInterconnect_Drive_Even_Input register (GDI_E_IN)
	mov	reg[d3h], 00h		; GlobalDigitalInterconnect_Drive_Even_Output register (GDI_E_OU)
	mov	reg[d0h], 00h		; GlobalDigitalInterconnect_Drive_Odd_Input register (GDI_O_IN)
	mov	reg[d2h], 00h		; GlobalDigitalInterconnect_Drive_Odd_Output register (GDI_O_OU)
	mov	reg[e1h], ffh		; OscillatorControl_1 register (OSC_CR1)
	mov	reg[e2h], 00h		; OscillatorControl_2 register (OSC_CR2)
	mov	reg[dfh], ffh		; OscillatorControl_3 register (OSC_CR3)
	mov	reg[deh], 02h		; OscillatorControl_4 register (OSC_CR4)
	mov	reg[ddh], 00h		; OscillatorGlobalBusEnableControl register (OSC_GO_EN)
	mov	reg[d8h], 00h		; Port_0_MUXBusCtrl register (MUX_CR0)
	mov	reg[d9h], 00h		; Port_1_MUXBusCtrl register (MUX_CR1)
	mov	reg[dah], 00h		; Port_2_MUXBusCtrl register (MUX_CR2)
	mov	reg[dbh], 00h		; Port_3_MUXBusCtrl register (MUX_CR3)
	mov	reg[ech], 00h		; Port_4_MUXBusCtrl register (MUX_CR4)
	mov	reg[edh], 00h		; Port_5_MUXBusCtrl register (MUX_CR5)
	mov	reg[e7h], 00h		; Type2Decimator_Control register (DEC_CR2)
	mov	reg[c1h], 00h		; USBControl_1 register (USB_CR1)
;  Instance name USBUART, User Module USBUART
	M8C_SetBank0
	ret


; PSoC Configuration file trailer PsocConfig.asm
