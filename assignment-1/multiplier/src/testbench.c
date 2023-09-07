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
	uint16_t c;
	a = 15;
	b = 15;
	c = shift_and_add_mul (a,b);
	fprintf(stdout, "mul(15, 15) = %d\n", c);

	a = 3;
	b = 12;
	c = shift_and_add_mul (a, b);
	fprintf(stdout, "mul(3, 12) = %d\n", c);

	a = 255;
	b = 255;
	c = shift_and_add_mul (a, b);
	fprintf(stdout, "mul(255, 255) = %d\n", c);
	return(0);
}
