#include <iostream>
using namespace std;

int main() {

	int num[5][5];
	int num1[5];
	int a = 0, b = 0, c = 0, d = 0;

	for (int i = 0; i < 5; i++)
	{

		cout << i + 1 << " Massivin qiymetlerini daxil edin\n\n";
		for (int j = 0; j < 5; j++)
		{

			cin >> a;
			if (a >= -5 && a <= 5)
			{
				num[i][j] = a;

				if (a < 0)
				{
					b++;
				}
				else if (a == 0)
				{
					c++;
				}
				else if (a > 0)
				{
					d++;
				}

			}
			else
			{
				cout << "Qiymetler -5 ve 5 arasi olamalidir\n";
				j--;
			}
		}
	}


	cout << "Musbet " << d << "\n";
	cout << "Menfi  " << b << "\n";
	cout << "Sifir  " << c << "\n";



}