#include <iostream>
using namespace std;


/*
int j = 0;
int h = 0;
int g = 0;


int main()
{

	cout << "Birinci massivin sayini daxil edin\n";
	cin >> j;
	cout << "ikinci massivin sayini daxil edin\n";
	cin >> h;


	int * m = new int[j];
	int * n = new int[h];
	int * e = new int[g];

	cout << "Birinci massivin elemetlerini daxil et\n";
	for (int i = 0; i < j; i++)
	{
		cin >> m[i];
	}
	cout << "Ikinci massivin elemetlerini daxil et\n";
	for (int i = 0; i < h; i++)

	{
		cin >> n[i];
	}

	for (int i = 0; i < j; i++)
	{
		e[i] = m[i];
		g++;
	}
	for (int i = 0; i < h + j; i++)
	{
		e[g++] = n[i];

	}
	for (int i = 0; i < h + j; i++)
	{
		cout << e[i] << "\n";
	}
	system("pause");
	return 0;

	
}

*/

/*
int func(int *a, int *b, int a1, int b1)
{
int d = 0;
for (int i = 0; i < a1; i++)
{
for (int j = 0; j < b1; j++)
{
if (b[j] == a[i])
{
d++;
}

}
}
if (d == 4)
{
return a[2];
}
return 0;
}


int main()
{
const int a1 = 8;
const int b1 = 4;

int a[a1];
int b[b1];
cout << "1 ci massiv\n";
for (int i = 0; i < a1; i++)
{
cin >> a[i];

}
cout << "2 ci massiv\n";
for (int i = 0; i < b1; i++)
{
cin >> b[i];
}

cout << func(a , b, a1, b1)<< "\n";

for (int i = 2; i < 8; i++)
{
cout << a[i] << ' ';
}

system("pause");

return 0;
}
*/



int main()
{
	int j;
	int h;
	int g = 0;

	cout << "Birinci massivin sayini daxil edin\n";
	cin >> j;
	cout << "ikinci massivin sayini daxil edin\n";
	cin >> h;
	
	int * m = new int[j];
	int * n = new int[h];

	cout << "Birinci massivin elemetlerini daxil et\n";
	for (int i = 0; i < j; i++)
	{
		cin >> m[i];

	}
	cout << "Ikinci massivin elemetlerini daxil et\n";
	for (int i = 0; i < h; i++)
	{
		cin >> n[i];
	}

	for (int i = 0; i < j ; i++)
	{
		for (int u = 0; u < h ; u++)
		{
			if (m[i] == n[h])
			{
				g++;
			}
		}
	}
	int * e = new int[g];
	int p = 0;
	int o = 0;
	for (int i = 0; i < j ; i++)
	{
		for (int u = 0; u < h ; h++)
		{
			if (m[i] == n[h])
			{
				p = 0;
				for (int l = 0; l < g; l++)
				{
					if (m[i] == e[l])
					{
						p++;
					}
				}
				if (p == 0)
				{
					e[o++] = m[i];
				}
			}
		}
	}
	for (int i = 0; i < g; i++)
	{
		cout << e[i] << ' ' << '\n';
	}
	system("pause");

	return 0;
}
