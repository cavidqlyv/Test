//#include <string.h>
#include <iostream>

using namespace std;

/*
int func(char a[])
{
	int b = 0;
	int d = 0;
	int word = 0;
	while (1)
	{
		if (a[b] == '\0') break;
		b++;
	}
	for (int i = 0; i <= b; i++)
	{
		if (a[i] == '\0' || a[i] == ' ' || a[i] == '\t' || a[i] == '\n')
		{
			if (word == 1)
			{
				word = 0;
				d++;
			}
		}
		else word = 1;
	}
	return d;
}

int main()
{
	cout << func("") << "\n";


	system("pause");
	return 0;
}

*/
/*
int c = 0;
int d = 0;
void func1(char string[], char word[])
{
	if (string[d] == word[c])
	{
		d++;
		c++;
		func1(string, word);
	}
}

char * func(char string[], char word[])
{
	int a = 0;
	int b = 0;
	int h = 0;
	while (1)
	{
		if (string[a] == '\0') break;
		a++;
	}
	while (1)
	{
		if (word[b] == '\0') break;
		b++;
	}
	int k = 0;
	for (int i = 0; i < a; i++)
	{
		if (string[i] == word[0])
		{
			d = i;
			c = 0;
			func1(string, word);
			if (c == b)
			{
				h = i;
				k = c;
			}
		}
	}
	char *res = new char[a - b];
	int j = 0;
	for (int i = 0; i < a; i++)
	{
		if (i >= h && i < h + k)
		{

		}
		else {
			res[j] = string[i];
			j++;
		}
	}
	res[j] = '\0';

	return res;
}



int main()
{

cout << func("hello world aaaa", "hello") << "\n";

system("pause");
return 0;
}
*/






