// T3.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include "pch.h"
#include <iostream>
#include <conio.h>			
#include <time.h> 		

// globals 
int depth;
int calls;
int maxDepth;
int underflows;
int overflows;
int numberWindows;
int usedWindows;


void setVariables(int registerSets){
depth = 0;
calls = 0;
maxDepth = 0;
underflows = 0;
overflows = 0;
usedWindows = 2;
numberWindows = registerSets; //variable depending on test 6,8 or 16 reg sets
}

int ackermann(int x, int y) {
	depth++;
	if (depth > maxDepth) {
		maxDepth = depth;
	}
	if (usedWindows == numberWindows) {
		overflows++;
	}
	else  usedWindows++;

	if (x == 0) {
		calls = y + 1;
	}
	else if (y == 0) {
		calls = ackermann(x - 1, 1);
	}
	else {
		calls = ackermann(x - 1, ackermann(x, y - 1));
	}

	depth--;
	if (usedWindows == 2) {
		underflows++;
	}
	else usedWindows--;

	return calls;
}


int main()
{
	clock_t start = clock();
	setVariables(6);
	int result = ackermann(3, 6);
	printf(" calls = %d, maxDepth = %d,overflows = %d, underflows = %d, usedWindows = %d ,numberWindows = %d \n", result, maxDepth, overflows, underflows, usedWindows, numberWindows);
	clock_t stop = clock();
	printf("time elapsed = %g \n", (double)(stop - start) / CLOCKS_PER_SEC);

	start = clock();
	setVariables(8);
	result = ackermann(3, 6);
	printf(" calls = %d, maxDepth = %d,overflows = %d, underflows = %d, usedWindows = %d ,numberWindows = %d \n", result, maxDepth, overflows, underflows, usedWindows, numberWindows);
    stop = clock();
	printf("time elapsed = %g \n", (double)(stop - start) / CLOCKS_PER_SEC);

	start = clock();
	setVariables(16);
	result = ackermann(3, 6);
	printf(" calls = %d, maxDepth = %d,overflows = %d, underflows = %d, usedWindows = %d ,numberWindows = %d \n", result, maxDepth, overflows, underflows, usedWindows, numberWindows);
	stop = clock();
	printf("time elapsed = %g \n", (double)(stop - start) / CLOCKS_PER_SEC);

	return 0;
}


