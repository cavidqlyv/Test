#include <iostream>
using namespace std;

/*
typedef void(*ptr)(const char[10]);

void a(const char b[10])
{
	cout << "hello " << b << "\n";
}

int main()
{

	char d[10];

	cin >> d;
	ptr b = a;

	b(d);

	system("pause");
	return 0;
}
*/

/*
typedef int(*ptr)(int );

int  filter(int b)
{
	if (b % 2 == 0)
	{
		return b;
	}
	return 0;

}
int y = 0;
int *a(int *arr, ptr d)
{
	int h=0;
	for (int i = 0; i < 10; i++)
	{
		if (d(arr[i]) != 0)
		{
			h++;
		}
		
	}
	int * g = new int[h];
	
	for (int i = 0; i < 10; i++)
	{
		if (d(arr[i]) != 0)
		{
			g[y]= d(arr[i]);
			y++;
		}

	}
	return g;
}

int main()
{
	int arr[10] = { 1,2,3,4,5,6,7,8,9,10 };
	ptr d = filter;
	//a(arr , d );
	int* result = a(arr, d);
	for (int i = 0; i < y; i++)
	{
		cout << result[i] << "\n";
	}

	system("pause");
	return 0;
}

*/

/*
typedef int(*ptr)(int);

int  filter(int b)
{
	return b*2;
}
int a(int *arr, ptr d)
{
	int h = 0;
	for (int i = 0; i < 10; i++)
	{
			h = h + d(arr[i]);
	}
	return h;
}

int main()
{
	int arr[10] = { 1,2,3,4,5,6,7,8,9,10 };
	ptr d = filter;
	//a(arr , d );
	
	cout << a(arr, d) << "\n";
	
	system("pause");
	return 0;
}
*/


typedef int(*ptr)();
bool ab=false;
bool  filter()
{

}

int *a(int *arr, ptr d)
{
	int  n, c, e;
	int swap;

	for (c = 0; c < (n - 1); c++)
	{
		for (e = 0; e < n - c - 1; e++)
		{
			if (arr[e] > arr[e + 1] && )
			{
				swap = arr[e];
				arr[e] = arr[e + 1];
				arr[e + 1] = swap;
			}
		}
	}
	return arr;
}


int main()
{
	int arr[10] = { 1,2,3,4,5,6,7,8,9,10 };
	ptr d = filter;
	//a(arr , d );
	int* result = a(arr, d);
	for (int i = 0; i < 10; i++)
	{
		cout << result[i] << "\n";
	}
	for (int i = 0; i < 10; i++)
	{
		cout << result[i] << "\n";
	}

	system("pause");
	return 0;
}






