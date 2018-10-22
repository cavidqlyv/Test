#include <iostream>
using namespace std;
/*
template<typename t >
int test(t a, int c)
{
int * b = &a[c];

return (b - a)* sizeof(a[c]) + sizeof(a[c]);

}

int main()
{
const int c = 4;

int  * a = new int[c]{ 1,2,3,4 };

cout << test(a, c-1)  << "\n";
//cout << sizeof (int);
system("pause");
return 0;
}
*/

int d, h;
int h1 = h;

void a(int * a)
{
	int c = 0;
	int l = 0;
	int j;
	for (int i = 0; i < h; i++)
	{
		for ( j = 0; j < h; j++)
		{
			if (a[i] == a[j])
			{
				c++;
			}
		}
		if (c > 1)
		{
			a[j] = a[h - l ] ;
			l++;
			h -= 1;
			h1 -= 1;
			c = 0;

		}
		c = 0;
	}

}

int main()
{

	cout << "Birinci massivin sayini daxil edin\n";
	cin >> h;
	cout << "ikinci massivin sayini daxil edin\n";
	cin >> d;

	int g = 0;
	int * m = new int[h];
	int * n = new int[d];
	//cout << h << "\n";
	h1 = h;
	cout << "Birinci massivin elemetlerini daxil et\n";
	for (int i = 0; i < h; i++)
	{
		cin >> m[i];
	}
	cout << "Ikinci massivin elemetlerini daxil et\n";
	for (int i = 0; i < d; i++)

	{
		cin >> n[i];
	}
	a(m);
	for (int i = 0; i < h1; i++)
	{
		//cout << "1\n";
		for (int j = 0; j < d; j++)
		{
			if (m[i] == n[j])
			{
				m[i] = 0;
			}
		}
	}
	for (int i = 0; i < h1; i++)
	{
		//cout << "2\n";

		if (m[i] != 0)
		{
			g++;
		}
	}
	int * f = new int[g];
	int y = 0;
	for (int i = 0; i < h1; i++)
	{
		//cout << "3\n";

		if (m[i] != 0)
		{
			f[y++] = m[i];
		}

	}
	for (int i = 0; i < g; i++)
	{
		cout << f[i] << " ";
	}
	cout << "\n";
	system("pause");


	return 0;
}
