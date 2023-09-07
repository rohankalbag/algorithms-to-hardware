#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <pthread.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#ifndef SW
#include "vhdlCStubs.h"
#endif

int main(int argc, char* argv[])
{
	uint8_t a,b;
	uint8_t c;
	a = 15;
	b = 15;
	c = shift_and_subtract_div (a,b);
	fprintf(stdout, "div(15, 15) = %d\n", c);

	a = 36;
	b = 12;
	c = shift_and_subtract_div (a, b);
	fprintf(stdout, "div(36, 12) = %d\n", c);

	a = 255;
	b = 8;
	c = shift_and_subtract_div (a, b);
	fprintf(stdout, "div(255, 8) = %d\n", c);
	return(0);
}
