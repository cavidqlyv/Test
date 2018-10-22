#include <iostream>
using namespace std;

void main() {
	/*int number;
	cout << "Kanalin nomresini daxil edin\n";
	cin >> number;
	switch (number)
	{
	case 1: cout << "ATV\n"; break;
	case 2: cout << "AzTV\n"; break;
	case 3: cout << "Space\n"; break;
	case 4: cout << "ANS\n"; break;

	default:cout << "bele kanal yoxdur\n";
	}



	*/
	int login=0, pas=0, pas2=0, num=0, pin=0, user=0 , pas3; // pas3 - thlukesizlik sifresi
	cout << "Xos gelmisiniz\nSecimlerden Birini Secin\n1. Qeydiyyat Ucun 1 Basin\n2. Daxil olmaq ucun 2 basin\n3. Sirenin berpasi ucun 3 basin\n";
	cin >> num;
	switch (num)

	{
	case 1: cout << "Login daxil edin\nLogin 4 reqemnen az olmalidir\n";
		cin >> login;
		if (login < 1000 || login < 0) {
			cout << "Login 4 reqmnen uzun olmalidir!\n";
		}
		else {
			cout << "Sifreni daxil edin\nSifre 6 reqemnen az olmamalidi\n";
			cin >> pas;
			if (pas < 100000 || pas < 0) { cout << "Sifre 6 reqemnen az olmamalidir!"; }
			else {
				cout << "Sifreni tekrar daxil edin\n";
				cin >> pas2;
				if (pas2 != pas) { cout << "Daxil etdiyiniz sifreler eyni deyil\n"; }
				else { 
					cout << "PIN kod daxil edin\n";
				    cin >> pin; 
				    if (pin < 1000 || pin >9999) { cout << "Pin 4 reqem olmalidir\n"; }
				    else
				{
						cout << "Istfadecinin novunu daxil edin\nAdmin ucun 1 basin\nUser ucun 2 basin\n";
						cin >> user;
						if (user != 1 && user != 2) { cout << "Bele istifadeci novu yoxdur\n"; }
						else
						{
							cout << "Tehlukesizlik sifresini daxil edin\nTehlukesizlik sifresi - 1234\n";
							cin >> pas3;
							if (pas3 != 1234) { cout << "Sifreni duzgun daxil edin\n"; }
							else 
							{
								cout << "Login " << login << "\n";
								cout << "Password " << pas << "\n";
								cout << "Pin " << pin << "\n";
								switch (user)
								{
								case 1: cout << "Admin\n"; break;
								case 2: cout << "User\n"; break;
								}
							}


						}

				}
			 }


			}





		}
		break;
	case 2: cout << "Login daxil edin\n";
		cin >> login;
		
		if (login != 1234) { cout << "Login sehvdir\n"; }
		else {
			cout << "Sifreni daxil edin\n";
			cin >> pas;
			if (pas != 123456) { cout << "Sifre sehvdir\n"; }
			else {
				cout << "Salam " << login << "Sisteme son defe 25.05.2017 daxil olmusunuz\n";
			}
		}
		break;
	case 3: cout << "Logini daxil edin\n";
		cin >> login;
		if (login != 1234) { cout << "Login sehvdir\n"; }
		else 
		{
			cout << "PIN daxil edin\n";
			cin >> pin;
			if (pin != 1234) { cout << "PIN sehvdir\n"; }
			else 
			{
				cout << "Sifreni daxil edin\n";
				cin >> pas;
				if (pas != 123456) { cout << "Sifre sehvdir\n"; }
				else 
				{
					cout << "Sifreni tekrar daxil edin\n";
					cin >> pas2;
					if (pas != pas2) { cout << "Sifre sehvdir"; }
					else { cout << "Sifreniz deyisildi"; }

				}
			}
		}
		break;
	default:cout << "Duzgun daxil edin\n";

	}
}


