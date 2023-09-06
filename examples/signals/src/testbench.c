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
	uint32_t I,J;


	for (I = 0; I < 16; I++)
	{
		write_uint32 ("A", I);
		if(I > 0)
		{
			J = read_uint32("C");
			if(J != I)
			{
				fprintf(stderr,"Error: observed %d, expected %d.\n", J, I);
			}
			else
			{
				fprintf(stderr,"%d\n", J);
			}
		}
	}


	fprintf(stderr,"done.\n");
	return(0);
}
