// Ackermann.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"			// pre-compiled headers
#include <iostream>			// cout
#include <conio.h>			// _getch
#include <time.h> 			// for timer

int depth = 0, maxDepth = 0, overflow = 0, underflow = 0, usedWins = 2;
int numWins = 0;

int ackermann(int x, int y) {
	depth++;
	if (depth > maxDepth)	maxDepth = depth;
	if (usedWins == numWins)	overflow++;
	else  usedWins++;

	int ret;

	if (x == 0) {
		ret =  y + 1;
	}
	else if (y == 0) {
		ret = ackermann(x - 1, 1);
	}
	else {
		ret = ackermann(x - 1, ackermann(x, y - 1));
	}

	depth--;
	if (usedWins == 2)	underflow++;
	else usedWins--;

	return ret;
}


int main()
{
	clock_t timeStart = clock();
	numWins = 6, depth = 0, maxDepth = 0, overflow = 0, underflow = 0, usedWins = 2;
	printf("numWins = %d, ret = %d, maxDepth = %d, underflow = %d, overflow = %d, usedwins = %d \n", numWins, ackermann(3, 6), maxDepth, underflow, overflow, usedWins);
	clock_t timeEnd = clock(); 
	printf("time = %g \n", (double)(timeEnd - timeStart) / CLOCKS_PER_SEC);
	numWins = 8, depth = 0, maxDepth = 0, overflow = 0, underflow = 0, usedWins = 2;
	timeStart = clock();
	printf("numWins = %d, ret = %d, maxDepth = %d, underflow = %d, overflow = %d, usedwins = %d \n", numWins, ackermann(3, 6), maxDepth, underflow, overflow, usedWins);
	timeEnd = clock();
	printf("time = %g \n", (double)(timeEnd - timeStart) / CLOCKS_PER_SEC);
	numWins = 16, depth = 0, maxDepth = 0, overflow = 0, underflow = 0, usedWins = 2;
	timeStart = clock();
	printf("numWins = %d, ret = %d, maxDepth = %d, underflow = %d, overflow = %d, usedwins = %d \n", numWins, ackermann(3, 6), maxDepth, underflow, overflow, usedWins);
	timeEnd = clock();
	printf("time = %g \n", (double)(timeEnd - timeStart) / CLOCKS_PER_SEC);
	return 0;
}
