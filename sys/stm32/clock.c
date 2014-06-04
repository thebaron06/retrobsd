/*
 * Copyright (c) 1986 Regents of the University of California.
 * All rights reserved.  The Berkeley software License Agreement
 * specifies the terms and conditions for redistribution.
 */
#include "param.h"
#include "machine/stm32f4xx.h"

/*
 * Setup core timer for `hz' timer interrupts per second.
 */
void
clkstart()
{
	/* get current clock speed */
    RCC_ClocksTypeDef RCC_Clocks;
    RCC_GetClocksFreq(&RCC_Clocks);
    /* Clock tick every 5 ms */
    SysTick_Config(RCC_Clocks.HCLK_Frequency / HZ);
}
