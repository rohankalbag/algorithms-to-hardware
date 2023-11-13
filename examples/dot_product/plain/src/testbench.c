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

#define ORDER 32
int main(int argc, char* argv[])
{
	uint16_t idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		storeA(idx, (float) idx);
		storeB(idx, (float) idx);
	}
	fprintf(stderr,"Stored A, B\n");
	
	float result = dot_product (ORDER);
	fprintf(stderr,"finished dot_product, result = %f\n", result);

	return(0);
}
