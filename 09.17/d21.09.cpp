#include <iostream>
using namespace std;

int main() {


/*
	char name[10][50];
	char num[10][50];
	int a = 1, i = 0;



	while (a != 0)
	{
		cout << "Nomre daxil etmek ucun 1\n";
		cout << "Nomrelere baxmaq ucun 2\n";
		cout << "Baglamaq ucun 0\n";
		cin >> a;
		if (a == 1 && i < 10)
		{
			cout << "Adi daxil edin\n";
			cin >> name[i];
			cout << "Nomreni daxi edin\n";
			cin >> num[i];
			i++;
				
		}
		else if (a == 1 && i >= 10)
		{
			cout << "Artiq daxil ede bilmersiniz\n";
		}
		else if (a == 2)
		{
			for (int b = 0; b < i; b++)
			{
				cout << "Ad : "<< name[b] << "\tNomre : "<< num[b] << "\n";
			}
		}
	}
	*/

	char log[5][15];
	char pas[5][15];
	char b[15];
	int a = 1, i = 0, d = 0;
	
	cout << "Logini daxil edin\n";
	
	while (a != 0)
	{
		cout << "Qeydiyyat ucun 1\n";
		if (a == 1)
		{
			cin >> log[i];
			for (int j = 0; j < i; j++)
			{
				if (log[j] == log[i])
				{
					cout << "Bu login artiq var\n";
					cout << "Basqa login daxil edin\n";
					continue;
				}

			}
			cout << "Sifreni daxil edin\n";
			for (int j = 0; j < 15; j++)
			{
				cin >> b[j];
				if (b[j] == '0')
				{
					d++;
					break;
				}
				
			}
			if (d >= 6)
			{
				for (int j = 0; i < d; j++)
				{
					b[j] = pas[i][j];
				}
			}
			
		}

		
	}






}