
#include "stdafx.h"


#include <iostream>
#include <cstring>
#pragma warning(disable : 4996)
using namespace std;

/* Task 4

char * func(char * string1, char * string2, int num)
{
	int a1 = strlen(string1);
	int a2 = strlen(string1);


	//char * res = new char[50];

	if (num == 1)
	{
		char * res = new char[strlen(string1) + strlen(string2)];
		res[0] = '\0';

		strcat(res, string2);
		strcat(res, string1);
		res[strlen(string1) + strlen(string2)] = '\0';
		return res;

	}
	else if (num == 2)
	{
		char * res = new char[strlen(string1) + strlen(string2)];
		res[0] = '\0';

		strcat(res, string1);
		strcat(res, string2);
		res[strlen(string1) + strlen(string2)] = '\0';
		return res;

	}
	else if (num == 3)
	{
		char * res = new char[strlen(string1) + strlen(string2) + strlen(string2)];
		res[0] = '\0';

		strcat(res, string2);
		strcat(res, string1);
		strcat(res, string2);
		res[strlen(string1) + strlen(string2) + strlen(string2)] = '\0';
		return res;


	}
	return 0;
}


int main()
{

	cout << func("aaaa", "bbbb", 3) << "\n";


	system("pause");
	return 0;
}
*/


/* Task 5
char *func(char s , int num)
{
	char* res = new char[num+1];

	for (int i = 0; i < num; i++)
	{

		res[i] = s;
	}
	res[num] = '\0';
	return res;
}


int main()
{
	char a;
	int b;

	cout << "Simvolu daxil et\n";
	cin >> a;
	cout << "Sayi daxil et\n";
	cin >> b;

	cout << func(a, b) << "\n";

	system("pause");
	return 0;
}
*/