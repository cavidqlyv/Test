#include <iostream>
#include <cstring>

#pragma warning(disable : 4996)
using namespace std;
/*
char * func(char *string)
{
	char * pch;
	bool  flag = false;
	int a = 0;
	char * res = new char[strlen(string) + 1];

	pch = strtok(string, " ");
	while (pch != NULL)
	{
		if (flag == false)
		{
			for (int i = 0; i < strlen(pch); i++)
			{
				res[a] = pch[i];
				a++;
			}
			flag = true;
		}
		else if (flag)
		{
			for (int i = strlen(pch) - 1; i >= 0; i--)
			{
				res[a] = pch[i];
				a++;
			}
			flag = false;
		}
		pch = strtok(NULL, " ");
	}
	cout << strlen(string) << "\n";
	res[a] = '\0';
	return res;
}



int main()
{

	char string[] = "abc abc abc abc abc abc";

	char* f = func(string);
	cout << f << "\n";
	delete[] f;

	system("pause");
	return 0;
}
*/



int main()
{

	

	system("pause");
	return 0;
}
