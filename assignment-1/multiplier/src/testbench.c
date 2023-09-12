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
	uint8_t a[52] = {194, 202, 240, 148, 199, 3, 155, 35, 187, 28, 177, 41, 182, 209, 126, 159, 117, 59, 249, 163, 75, 50, 4, 110, 99, 139, 228, 210, 250, 172, 215, 73, 221, 47, 20, 145, 14, 167, 92, 89, 18, 81, 64, 252, 102, 109, 35, 233, 231, 128, 130, 645};
	uint8_t b[52] = {170, 237, 246, 49, 45, 222, 19, 168, 0, 202, 33, 156, 74, 39, 142, 88, 197, 156, 241, 20, 112, 124, 63, 238, 188, 250, 250, 143, 96, 125, 54, 189, 9, 90, 89, 113, 27, 74, 53, 68, 204, 177, 10, 106, 217, 199, 224, 137, 162, 107, 215, 134};

	uint16_t c;
	int pass_tests = 0;
	int curr_testcase = 0;
	while (curr_testcase < 52)
	{
		c = shift_and_add_mul(a[curr_testcase], b[curr_testcase]);
		if (c == a[curr_testcase] * b[curr_testcase])
		{
			pass_tests += 1;
			fprintf(stdout, "PASS : mul(%d, %d) == %d\n", a[curr_testcase], b[curr_testcase], c);
		}
		else
		{
			fprintf(stdout, "ERROR : mul(%d, %d) != %d : Expected %d\n", a[curr_testcase], b[curr_testcase], c, a[curr_testcase] * b[curr_testcase]);
		}
		curr_testcase += 1;
	}

	fprintf(stdout, "%d testcases out of %d PASSED\n", pass_tests, 52);
	return (0);
}
