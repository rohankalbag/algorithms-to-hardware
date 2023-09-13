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

int main(int argc, char *argv[])
{
	uint8_t a[52] = {48, 181, 113, 215, 102, 42, 156, 253, 55, 236, 234, 133, 27, 126, 174, 226, 62, 107, 250, 60, 166, 13, 95, 177, 29, 73, 91, 112, 201, 17, 36, 84, 186, 141, 78, 128, 86, 4, 191, 143, 229, 248, 9, 217, 130, 194, 162, 246, 33, 203, 153, 59};
	uint8_t b[52] = {117, 29, 111, 3, 233, 57, 227, 120, 49, 218, 184, 148, 130, 16, 38, 146, 1, 153, 19, 58, 250, 209, 138, 101, 210, 240, 90, 94, 4, 239, 120, 28, 100, 205, 72, 77, 192, 228, 190, 162, 253, 68, 80, 30, 163, 185, 173, 46, 86, 157, 179, 69, 247};

	uint16_t c;
	int pass_tests = 0;
	int curr_testcase = 0;
	while (curr_testcase < 52)
	{
		c = shift_and_subtract_div(a[curr_testcase], b[curr_testcase]);
		if (c == a[curr_testcase] / b[curr_testcase])
		{
			pass_tests += 1;
			fprintf(stdout, "PASS : div(%d, %d) == %d\n", a[curr_testcase], b[curr_testcase], c);
		}
		else
		{
			fprintf(stdout, "ERROR : div(%d, %d) != %d : Expected %d\n", a[curr_testcase], b[curr_testcase], c, a[curr_testcase] / b[curr_testcase]);
		}
		curr_testcase += 1;
	}

	fprintf(stdout, "%d testcases out of %d PASSED\n", pass_tests, 52);
	return (0);
}
