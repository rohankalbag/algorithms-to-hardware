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

#define ORDER 8

int main(int argc, char* argv[])
{
	uint8_t a,b,c;
	uint32_t I, J;

	init_mem(0, ORDER-1, 0, ORDER-1, 0);	
	fprintf(stderr, "Info: finished initializing memory\n");

	for (I = 0; I < ORDER; I++)
	{
		for(J = 0; J < ORDER; J++)
		{
			store (I, J, I+J);
		}
	}
	fprintf(stderr, "Info: finished stores\n");

	for (I = 0; I < ORDER; I++)
	{
		for(J = 0; J < ORDER; J++)
		{
			uint32_t t = load (I, J);
			if(t != I+J)
			{
				fprintf(stderr,"Error: [%d][%d] = %d, expected %d.\n", I,J,t, I+J);
			}
		}
	}
	fprintf(stderr, "Info: finished loads\n");


	uint32_t maxval = max_in_range (0, ORDER-1, 0, ORDER-1);
	fprintf(stderr,"maxval = %d\n", maxval);

	return(0);
}
