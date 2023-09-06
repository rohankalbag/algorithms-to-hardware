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
	uint8_t a,b,c;

	c = gcd (19,12);
	fprintf(stdout, "gcd(19,12) = %d\n", c);

	c = gcd (16, 12);
	fprintf(stdout, "gcd(16,12) = %d\n", c);

	return(0);
}
