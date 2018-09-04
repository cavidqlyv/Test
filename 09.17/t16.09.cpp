#include <iostream>
using namespace std;

int main() {

	int num[5][5];
	int num1[5];
	int a=0,b=0;
	for (int i = 0; i < 5; i++)
	{
		b = 0;
		cout << i + 1 << " Massivin qiymetlerini daxil edin\n\n";
		for (int j = 0; j < 5; j++)
		{
			
			cin >> a;
			if (a >= 0 && a <= 20)
			{
				num[i][j] = a;
				b = b + a;
				num1[i] = b;
			}
			else
			{
				cout << "Qiymetler 0 ve 20 arasi olamlidir\n";
				j--;
			}
		}
	}
	a = 0;
	for (int i = 0; i < 5; i++)
	{
		cout << i+1 << " Massivin cemi "<< num1[i] <<"\n";
		a = a + num1[i];
	}

	cout << "Cem " << a;


}