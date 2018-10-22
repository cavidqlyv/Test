
#include <iostream>
#include<conio.h>

#include <cstring>
#pragma warning(disable : 4996)
using namespace std;
/*
bool func(char * a)
{
	int  d = strlen(a);
	int b = 0;
	int c = 0;
	int f = 1;
	for (int i = 0; i < d / 2; i++)
	{
		if (a[c] == a[d - f])
		{
			b++;
		}
		f++;
		c++;
	}
	if (b == d / 2)
	{
		return true;
	}
	else
	{
		return false;
	}
}

int main()
{
	char a[] = "level";
	cout << func(a) << "\n";
	system("pause");
	return 0;
}
*/

/*
int main()
{
	char a[12] = "hello world";
	char b[12] = "hello world";
	char c;


	int v1 = rand() % 11;       // v1 in the range 0 to 99
	int v2 = rand() % 4;		// v2 in the range 1 to 100
	
	for (int i = 0; i < 12; i++)
	{
		if (i == v1 || i == v2)
		{
			b[i] = '*';
		}
	}

	cout << b<<'\n';
	

	int g = 0;
	int h = 0;
	while (g < 3)
	{
	
		
		if (h == 2)
		{
			cout << "\n\nTebrikler\n";
			break;
		}
		cout << "\n\nHerif daxil et\n";
		cout << 3 - g << " qeder cehd ede bilersiz\n\n";
		c = _getch();
		 if (c == a[v1] && b[v1] == '*')
		{
			b[v1] = a[v1];
			h++;
			cout << b << "\n";
		}
		else if (c == a[v2] && b[v2] == '*')
		{
			b[v2] = a[v2];
			h++;
			cout << b << "\n";

		}
		else g++;
		
	}
	
	system("pause");
	return 0;
}
*/
char * func(char *a)
{
	int b=0;
	int c=0;
	while (1)
	{
		if (a[b] == ' ') c++;
		else if (a[b] == '\0') break;
		b++;
	}
	
	char * res = new char[b - c+1];
	c = 0;
	for (int i = 0; i < b; i++)
	{
		if (a[i] != ' ')
		{
			res[c] = a[i];
			c++;
		}
	}
	res[c ] = '\0';
	return res;
}


int main()
{
	char a[] = { "hello world asdjhasjdha dhasjkhdask  asd ashd a dhs das das d ashd" };

	char *b = func(a);
	cout << b << '\n';
	delete[] b;

	system("pause");
	return 0;
}