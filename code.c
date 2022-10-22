#include <stdio.h>

static int ARRAY1[10000];
static int ARRAY2[10000];

int main(int argc, char** argv) 
{
	int i, n1, n2;
	scanf("%d", &n1);
	for (i = 0; i < n1; ++i)
	{
		scanf("%d", ARRAY1 + i);
	}
	n2 = 0;
	for (i = 0; i < n1; ++i)
	{
		if (ARRAY1[i] > 0) 
		{
			ARRAY2[n2] = ARRAY1[i];
			++n2;
		}
	}
	for (i = 0; i < n2; ++i)
	{
		printf("%d ", ARRAY2[i]);
	}
	return 0;
}
