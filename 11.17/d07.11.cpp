// ConsoleApplication25.cpp : Defines the entry point for the console application.
//
//#define _CTR_SECURE_NO_WARNINGS

#include "stdafx.h"


#include <iostream>
#include <cstring>

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
/*
char *func(char a[])
{
int b = 0;
while (1)
{
if (a[b] == '\0')break;
b++;
}
char* c = new char[b];
c[0] = toupper(a[0]);
for (int i = 1; a[i]; i++)
{

c[i] = tolower(a[i]);

}
c[b] = '\0';
return c;
}


int main()
{


cout << func("ggfkfhglsdfsdfsdjhhAA") << "\n";
system("pause");
return 0;
}
*/
/*
int func(char string[], char sym)
{
for (int i = 0; string[i]; i++)
{

if (string[i] == sym)
return i;

}

return 0;
}

int main()
{
char a;
cout << "herifi daxil et\n";
cin >> a;

if (func("asdfgh", a) == 0)
{
cout << "Simvol yoxdur\n";
}
else
{
cout << func("asdfgh", a) +1 << "\n";
}

system("pause");
return 0;
}
*/
char * func(char * string1, char * string2, int num)
{

	char * res = new char[50];

	if (num == 1)
	{
		//char * res = new char[strlen(string1) + strlen(string2)];
		strcat(res, string2);
		strcat(res, string1);
		res[strlen(string1) + strlen(string2)] = '\0';
	}
	else if (num == 2)
	{
		char * res = new char[strlen(string1) + strlen(string2)];
		strcat(res, string1);
		strcat(res, string2);
		res[strlen(string1) + strlen(string2)] = '\0';
	}
	else if (num == 3)
	{
		char * res = new char[strlen(string1) + strlen(string2) + strlen(string2)];
		strcat(res, string2);
		strcat(res, string1);
		strcat(res, string2);
		res[strlen(string1) + strlen(string2) + strlen(string2)] = '\0';

	}
	return res;
}


int main()
{

	cout << func("aaaa", "bbbb", 1) << "\n";


	system("pause");
	return 0;
}


