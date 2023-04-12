#include <stdio.h>
#include <inttypes.h>

long pointless(long n, long * p);

int main(){
	long value;
	printf("%ld\n", pointless(10,&value));
	printf("%ld\n", pointless(-10,&value));
	printf("%ld\n", pointless(134324320,&value));

	return 0;
}
