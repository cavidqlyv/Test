#include <iostream>
using namespace std;

int main() {




/*

for (; i < 10; i++)
{
cin >> num[i];
if (num[i] == '0')
{
break;
}
}

for (int i = 0; i < a; i++)
{
cout << num[i];
}
a--;
num[i] = '\0';
cout << num;
cout << "\n";
*/

	char t[5][10000];
	char x[5][10000];
	int s[5] = { 0,0,0,0,0 };
	int bl[5] = { 0,0,0,0,0 };


	//int num1[5];
	int a = 1, b = 0, c = 1, d = 0, e = 0;

	while (a != 0)
	{
		c = 1;
		cout << "Xeber daxil etmek ucun 1\n";
		cout << "Xeberler baxmaq ucun 2\n";
		cout << "Blok 3\n";
		cout << "Baglamaq ucun 0\n";
		cin >> a;
		if (a == 1 &&  b < 5)
		{
			cout << "Xeberin basliqini daxil edin\n";

			cin >>  t[b];
			a++;
			
			cout << "Xeberi daxil edin \n";
			cin >> x[b];
			b++;
		}
		else if (a==1 && b>=5)
		{
			cout << "Maksimum 5 xeber daxil ede bilersiniz\n";
		}
		else if (a == 2)
		{ 
			while (c != 0)
			{
				for (int i = 0; i <= b - 1; i++)
				{
					cout << i + 1 << " Xeberin basliqi : " << t[i] << "\n";
				}
				if (b == 0)
				{
					cout << "Xeber yoxdur\n";
					break;
				}
				cout << "Oxumaq istediyiniz xeberin nomresini daxil edin\n";
				cout << "Geri qayitmaq ucun 0\n";
				cin >> c;
				if (c - 1 < b)
				{
					cout << c  << " Xeber \n" << x[c - 1] << "\n";
					s[c-1]++;
					cout << "Baxis sayi :" << s[c-1] << "\n\n";
				}
				else
				{
					cout << "Duzgun daxil et\n";
				}
			}
		}
		else if (a == 3)
		{
			cout << "Bloklanmis xeberler\n";
			for (int i = 0; i < 5; i++)
			{
				e = 0;
				if (bl[i]==1)
				{
					cout << i << " Nomreli xeber bloklanib\n";
					e++;
					
				}
				
			}
			if (e == 0)
			{
				cout << "Hec bir xeber bloklanmiyb\n";
			}
			else if (e==0)

			cout << "Blok etmek ucun 1\n";
			cout << "Blokdan cixartmaq ucun 2\n";
			d = 0;
			cin >> d;
			if (d==1)
			{
				cout << "Blok etmek istediyiniz xeberin nomresini daxil edin\n";
				cin >> d;
				bl[d - 1] = 1;
			}
			if (d == 2)
			{
				e = 0;
				for (int i = 0; i < 5; i++)
				{
					if (bl[i] == 1)
					{
						e++;
					}
					
				}
				if (e != 0)
				{
					cout << "Siz hec bir xeberi blok etmemisin\n";
				}
				else if (e == 0)
				{
					cout << "Blokdan cixartmaq istediyiniz xeberin nomresini daxil edin\n";
					cin >> d;
					bl[d - 1] = 0;
				}

			}
			


		}
	}

	//cout << "Basliq "<<  t[0];
	//cout << "\nXeber " << x[0];
	
}