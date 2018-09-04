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
/*
int d, h;
int h1 = h;

void a(int * a)
{
int c = 0;
int l = 0;
int j;
for (int i = 0; i < h; i++)
{
c = 0;
for (j = 0; j < h; j++)
{
if (a[i] == a[j])
{
c++;
}
}
if (c > 1)
{
a[i] = a[h-1];
l++;
h -= 1;
h1 -= 1;
c = 0;
i--;

}

}
int num = h1, temp;
for (int i = 0; i < num; i++)
{
for (j = 0; j < (num - i - 1); j++)
{
if (a[j] > a[j + 1])
{
temp = a[j];
a[j] = a[j + 1];
a[j + 1] = temp;
}
}
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
*/

int a, b, c=0;

char func(char * n , char *m)
{
	//c = a + b;

	int i = 0;
	int i1 = 0;
	for ( int y =0 ; y<a;y++ )
	{
		if (n[y] != '\0')
		{
			c++;
			i++;
		}
		else 
		{
			break;
		}
	}
	for (int y = 0; y<a; y++)
	{
		if (m[y] != '\0')
		{
			c++;
			i1++;
		}
		else
		{
			break;
		}
	}
	//cout << i << "\n";
	//cout << i1 << "\n";
	//cout << c << "\n";



	char * l = new char[c];
	for (int j = 0; j < i; j++)
	{
		l[j] = n[j];
	}
	int t = 0;
	for (int j = i; j < i+i1; j++)
	{
		l[j] = m[t++];

	}

	l[i + i1 ] = '\0';
	return l;
	cout <<  l << "\n";
}



int main()
{
	cout << "I Masivin olcusunu daxil et\n";
	cin >> a;
	cout << "II Masivin olcusunu daxil et\n";
	cin >> b;

	char * n = new char[a];
	char * m = new char[b];
	
	cout << "Birinci massivi doldurun\n";
	cin >> n;
	cout << "Ikinci massivi doldurun\n";
	cin >> m;

	//cout << n[0] << "\n";
	//cout << m << "\n";

	cout << func(n, m);
	system("pause");
	return 0;
}
