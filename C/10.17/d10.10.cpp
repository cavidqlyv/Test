#include<iostream>
using namespace std;

int money = 50;
int s[3][3];
int s1[3][3];



void pas() {

	int a;
	int b = 1234;

	cout << "Sifreni daxil edin\n";

	cin >> a;
	while (a != b)
	{
		cout << "Sehfdir tekrar daxil edin\n";
		cin >> a;
	}
}
void internet()
{
	int a=1;
	int b=1;
	int c[2];
	c[0] = 10;
	c[1] = 15;
	while (a != 0)
	{
		cout << "1. CityNet ucun 1 daxil et - 10 Manat\n";
		cout << "2. BakInternet ucun 2 daxil et - 15 Manat\n";
		cout << "Geri qayitmaq ucun 0 daxil et\n";
		cin >> a;
		if (a == 1)
		{ 
			while (b != 0)
			{
				cout << "Odenis ucun 1 daxil edin\n";

				cout << "Siyahiya elave etmek ucun 2 daxil edin\n";
				cout << "Geri qayitmaq ucun 0 daxil et\n";
				cin >> b;
				if (b == 2)
				{
					cout << "Siyahiya daxil etdiniz\n";
					s[0][a - 1] = 1;
				}
				else if (b == 1)
				{
					if (money => c[a - 1])
					{
						cout << "Siz odenis etdiniz\n";
						money = money - c[a - 1];
						s1[0][a - 1] = 1;

					}
					else
					{
						cout << "sizin pulunuz azdir\n";
					}
				}
			}
		}
		else
		{
			cout << "Duzgun daxil et\n";
		}

	}

}




int main()
{
	int a;
	pas;
	for (int i = 0; i < 3; i++)
	{
		for (int j = 0; j < 3; j++)
		{
			s[i][j] = 0;
			s1[i][j] = 0;
		}
	}
	cout << "\nSalam\n\n";
	while (a != 0)
	{
		cout << "Internet ucun 1 daxil et\n";
		cout << "Mobil xidmetler ucun 2 daxil et\n";
		cout << "TV ucun 3 daxil et\n";
		cout << "Siyahiya baxmaq ucun 4 daxil et\n";
		cout << "Baglamaq ucun 0 daxil et\n";
		cin >> a;
		if (a == 1)
		{
			internet;

		}
		else if (a == 2)
		{

		}
		else if (a == 3)
		{

		}
		else
		{
			if (a != 0)
			{
				cout << "Duzgun daxil et\n";
			}
		}


	}
	

 



	return 0;
}