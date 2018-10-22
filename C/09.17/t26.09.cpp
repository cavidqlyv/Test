#include <iostream>
using namespace std;

int main() {


	char log[5][15];
	
	char pas[5][15];
	char b[15];
	int a = 1, i = 0, d = 0, e = 0,f=0,o=0;

	

	while (a != 0)
	{
		cout << "Qeydiyyat ucun 1\n";
		e = 1;
		f = 0;
		cin >> a;
		if (a == 1)
		{
			while (e != 0)
			{
				cout << "Logini daxil edin\n";
				cin >> log[i];
				for (int g = 0; g < i + 1; g++)
				{
					for (int j = 0; j < 15; j++)
					{
						if (log[i][j] == log[g][j])
						{
							f++;
							cout << f;


						}

					}
				}
				o = ((i + 1) * 15) ;
				if (f >o )
				{
					cout << "Bu login artiq var\n";
					cout << "Basqa login daxil edin\n";
					f = 0;
				}
				else if (f < o)
				{
					e = 0;

				}
			}
			
			cout << "Sifreni daxil edin\n";
			cout << "Sifre 10 simvoldan uzun olmamalidir ve 0 yazdiqda sona catir\n";
			for (int j = 0; j < 10; j++)
			{
				cin >> b[j];
				d++;
				if (b[j] == '0'&&d>=6)
				{
					d--;
					for (int h = 0; h < d; h++)
					{
						pas[i][h] = b[h];
						
					}
					cout << "Siz ugurla qeydiyyatdan kecdiniz\n";
					i++;
					break;
				}
				else if (b[j] == '0'&&d < 6)
				{
					cout << "Sifre 6 reqemnen uzun olmalidir\n";
					j = 0;
					d--;
				}

			}
			
		
		}


	}






}