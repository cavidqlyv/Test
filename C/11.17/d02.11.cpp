#include <iostream>
using namespace std;


int func1(char *a , int b)
{
	
	int c = 0;
	if (a[c] == ' ' || a[c] == '\t' && a[c])
		func1(a, b);
	a++

}



int func(char * a)
{
	int i = 0;
	int b=0;
	int d = 1;
	while ( a[i] != '\0')
	{
		i++;
		b++;
	}
	if (b == 0)
	{
		return 0;
	}
	else
	{
		if (a[0] == ' ' || a[0] == '\t')
			
		for (int i = 0; i < b; i++)
		{
			

		}
		return d;
	}


}


int main()
{
	int b=0;
	char * a = new char[250]{ "asgjldhas asjdhasjklhk;asdh" };

	for (int i = 0; i < 250; i++)
	{
		if (a[i] == '\0')
		{
			b++;
		}
	}
	char *c = new char[b];
	for (int i = 0; i < b + 1; i++)
	{
		c[i] = a[i];
	}
	c[b] = '\0';
	delete[] a;
	cout << func(c) << "\n";
	system("pause");
	return 0;
}