#include <iostream>
using namespace std;


int main() {
	/*
	
	
	
	int num=0, ay=0,gun=0;
	cout << "Ayi daxil edin\n";
	enum {yanvar =1 , fevral ,  mart ,aprel , may , iyun ,iyul,avqust,sentyabr,oktyabr,noyabr,dekabr };
	cin >> num;
	cout << "Gun daxil edin\n";
	cin >> gun;
	switch (num) {
	case yanvar:;
	case dekabr:;
	case fevral:;
	case mart:if (gun < 22) { cout << "qis\n"; }
			  else { cout << "yaz\n"; }break;
	case aprel:;
	case may:
	case iyun:if (gun < 22) { cout << "yaz\n"; }
			  else { cout << "yay\n"; }break;
	case iyul:;
	case avqust:cout << "yay\n"; break;
	case sentyabr:;
	case oktyabr:;
	case noyabr:cout << "payiz\n"; break;
	default : cout << "duzgun daxil edin!\n";
	}

	*/





	/*
	
	int num, num1 = 10, cehd1 = 0, cehd = 0;
	cout << "Cehdlerin sayini daxil edin\n";
	cin >> cehd;
	cout << "Reqemi daxil et\n";
	cin >> num;
	
	

	
		
		while (num1 != num && cehd != 1)
		{
			cehd = cehd - 1;
			
			cout << "Qalan cehd " << cehd << "\n";



			cout << "Duzgun daxil et!\n";

			cin >> num;

		}







		if (num == num1) { cout << "Duzgundur\n"; }
	else { cout << "Sehvdir\n"; }

	*/





	/*
	int num=0, num1=0,num2=0,num3=0;
	cout << "birinci ededi daxil et\n";
	cin >> num;
	cout << "Ikinci ededi daxil edin\n";
	cin >> num1;
	if (num > num1) { cout << "Duzgun daxil edin\n"; }
	else
	{
		while (num1 > num)
		{
			num2 = num % 2;
			if (num2 == 1) { num3 = num3 + num; }
			num = num + 1;
		}
		cout << num3 << "\n";

	}

	*/


	/*
	
	int num=0,menfi=0,musbet=0;
	cout << "reqem daxil edin\n";
	cin >> num;
	while (num != 0)
	{
		
		if (num < 0) { menfi = menfi + 1; }
		else if (num > 0) { musbet = musbet + 1; }
		cout << "reqem daxil edin\n";
		cin >> num;
	}
	cout << "Musbet ededler - " << musbet << "\n";
	cout << "Menfi ededler - " << menfi << "\n";


	return 0;

	*/

int num = 1, num1 = 0, num2 = 0;
cout << "Reqemi daxil edin\n";
cin >> num1;

;

while (num < num1 )
{   
	num2 = num % 2;
	
	
	 if (num2 == 1) { cout << num << "\n"; }
	
	num = num + 1;
	
}
}