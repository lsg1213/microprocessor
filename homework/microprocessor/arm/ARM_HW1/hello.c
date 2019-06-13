//*****************************************************************************
//
// hello.c - Simple hello world example.
//
// Copyright (c) 2011-2013 Texas Instruments Incorporated.  All rights reserved.
// Software License Agreement
//
// Texas Instruments (TI) is supplying this software for use solely and
// exclusively on TI's microcontroller products. The software is owned by
// TI and/or its suppliers, and is protected under applicable copyright
// laws. You may not combine this software with "viral" open-source
// software in order to form a larger program.
//
// THIS SOFTWARE IS PROVIDED "AS IS" AND WITH ALL FAULTS.
// NO WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT
// NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE. TI SHALL NOT, UNDER ANY
// CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR CONSEQUENTIAL
// DAMAGES, FOR ANY REASON WHATSOEVER.
//
// This is part of revision 1.1 of the DK-TM4C123G Firmware Package.
//
//*****************************************************************************

#include <stdint.h>
#include <stdbool.h>
#include "inc/hw_memmap.h"
#include "driverlib/fpu.h"
#include "driverlib/sysctl.h"
#include "driverlib/rom.h"
#include "driverlib/pin_map.h"
#include "driverlib/uart.h"
#include "grlib/grlib.h"
#include "drivers/cfal96x64x16.h"
#include "utils/uartstdio.h"
#include "driverlib/gpio.h"



extern unsigned int num_1();
extern unsigned int num_3();
extern unsigned int Switch_Input();
extern unsigned int Switch_Init();
//extern void ConfigureUART(void);
//*****************************************************************************
//
//! \addtogroup example_list
//! <h1>Hello World (hello)</h1>
//!
//! A very simple ``hello world'' example.  It simply displays ``Hello World!''
//! on the display and is a starting point for more complicated applications.
//! This example uses calls to the TivaWare Graphics Library graphics
//! primitives functions to update the display.  For a similar example using
//! widgets, please see ``hello_widget''.
//
//*****************************************************************************

//*****************************************************************************
//
// The error routine that is called if the driver library encounters an error.
//
//*****************************************************************************
#ifdef DEBUG
void
__error__(char *pcFilename, uint32_t ui32Line)
{
}
#endif

//*****************************************************************************
//
// Configure the UART and its pins.  This must be called before UARTprintf().
//
//*****************************************************************************
void
ConfigureUART(void)
{
    //
    // Enable the GPIO Peripheral used by the UART.
    //
    ROM_SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOA);

    //
    // Enable UART0
    //
    ROM_SysCtlPeripheralEnable(SYSCTL_PERIPH_UART0);

    //
    // Configure GPIO Pins for UART mode.
    //
    ROM_GPIOPinConfigure(GPIO_PA0_U0RX);
    ROM_GPIOPinConfigure(GPIO_PA1_U0TX);
    ROM_GPIOPinTypeUART(GPIO_PORTA_BASE, GPIO_PIN_0 | GPIO_PIN_1);

    //
    // Use the internal 16MHz oscillator as the UART clock source.
    //
    UARTClockSourceSet(UART0_BASE, UART_CLOCK_PIOSC);

    //
    // Initialize the UART for console I/O.
    //
    UARTStdioConfig(0, 115200, 16000000);
}



//*****************************************************************************
//
// Print "Hello World!" to the display.
//
//*****************************************************************************
int
main(void)
{
	//led();
    tContext sContext;
    ROM_FPULazyStackingEnable();
    ROM_SysCtlClockSet(SYSCTL_SYSDIV_4 | SYSCTL_USE_PLL | SYSCTL_XTAL_16MHZ |
                       SYSCTL_OSC_MAIN);
    ConfigureUART();

    UARTprintf("Hello, world!\n");

    CFAL96x64x16Init();

    GrContextInit(&sContext, &g_sCFAL96x64x16);

    GrContextForegroundSet(&sContext, ClrWhite);

    GrContextFontSet(&sContext, g_psFontCm12);

//*****************************************************************************************
//*****************************************************************************************

    	unsigned char n[4] = {'0', '0', '0', '0'};
    	unsigned char num[2] = {'0', '0'};

      tRectangle tRect1;
	  tRect1.i16XMin = 14;
	  tRect1.i16XMax = 95;
	  tRect1.i16YMin = 0;
	  tRect1.i16YMax = 10;
	  tRectangle tRect2;
	  tRect2.i16XMin = 14;
	  tRect2.i16XMax = 95;
	  tRect2.i16YMin = 12;
	  tRect2.i16YMax = 22;
	  tRectangle tRect3;
	  tRect3.i16XMin = 14;
	  tRect3.i16XMax = 95;
	  tRect3.i16YMin = 24;
	  tRect3.i16YMax = 34;
	  tRectangle tRect4;
	  tRect4.i16XMin = 14;
	  tRect4.i16XMax = 95;
	  tRect4.i16YMin = 36;
	  tRect4.i16YMax = 46;
	  tRectangle _tRect1 = tRect1;
	  tRectangle _tRect2 = tRect2;
	  tRectangle _tRect3 = tRect3;
	  tRectangle _tRect4 = tRect4;
        Switch_Init();
        int index = 0;
        int old = 0;
        int j;
        int clock = 0;
while(1){

	  int i = 0;

	  i = Switch_Input();

	  if (i != 0) {
		  if (old == 0) {
			  switch(i) {
			  case 1:
				  n[index]++;
				  if (n[index] > '9') {
					  n[index] = '0';
				  }
				  CFAL96x64x16Init();
				  old = i;
				  break;
			  case 2:
				  n[index]--;
				  if (n[index] < '0') {
					  n[index] = '9';
				  }
				  CFAL96x64x16Init();
				  old = i;
				  break;
			  case 3:
				  for (j = 0 ; j < 4 ; j++) n[j] = '0';
				  CFAL96x64x16Init();
				  old = i;
				  break;
			  case 4:
				  index--;
				  if (index < 0) index = 0;
				  CFAL96x64x16Init();
				  old = i;
				  break;
			  case 5:
				  index++;
				  if (index > 3) index = 3;
				  CFAL96x64x16Init();
				  old = i;
				  break;
			  }
		  }
	  } else {
		  old = 0;
	  }

	  GrRectDraw(&sContext, &tRect1);
	  GrRectDraw(&sContext, &tRect2);
	  GrRectDraw(&sContext, &tRect3);
	  GrRectDraw(&sContext, &tRect4);


	  _tRect1.i16XMax = 14 + 9 * (n[0]-'0');
	  GrRectFill(&sContext, &_tRect1);
	  _tRect2.i16XMax = 14 + 9 * (n[1]-'0');
	  GrRectFill(&sContext, &_tRect2);
	  _tRect3.i16XMax = 14 + 9 * (n[2]-'0');
	  GrRectFill(&sContext, &_tRect3);
	  _tRect4.i16XMax = 14 + 9 * (n[3]-'0');
	  GrRectFill(&sContext, &_tRect4);

	  clock++;
	  if (clock == 10000000) {
		  CFAL96x64x16Init();
		  clock = 0;
	  }

	  GrStringDrawCentered(&sContext, n, 4, GrContextDpyWidthGet(&sContext) / 2, 57, 0);
	  GrStringDrawCentered(&sContext, n, 4, GrContextDpyWidthGet(&sContext) / 2, 57, 0);



}	//end while
//*****************************************************************************************
//*****************************************************************************************
//    GrFlush(&sContext);


}		//end main


