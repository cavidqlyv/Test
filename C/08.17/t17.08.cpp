#include <iostream>
using namespace std;

int main() {
	/*

	int num=0, cem=0,attempt,attempt1=0,a=0;
	cout << "Cehdlerin sayini daxil edin\n";
	cin >> attempt;
	while (attempt1 < attempt)
	{
		attempt1++;
		cout << "ededi daxil etn\n";
		cin >> num;
		a =num % 3 ;
		cem = cem + a;



	}

	cout << cem<< "\n";
	*/

	/*

	int num1=0,num=0;
	cout << "Reqem daxil edin\n";
	cin >> num1;
	while (num1 !=0)
	{
		num = num1;
		cout << "Reqem daxil edin\n";
		cin >> num1;

		if (num1 != 0 &&num1 < num) { cout << "Sehvdir\n";  }



		else if (num1 == 0) { cout << "Sona catdi\n"; break; }
	}

	*/


	/*

	int num, say=0, cem=0;
	cout << "Reqem daxil edin\n";
	cin >> num;
	while (num != 0)
	{
		say++;
		cem = cem + num;
		cout << "Reqem daxil edin\n";
		cin >> num;




	}

	cout << "Say " << say << "\n";
	cout << "Cem " << cem << "\n";

	*/

	/*

	int num=1;
	while (num < 100)
	{
		if (num % 10 != 0)
		{
			cout << num << "\n";

		}
		num++;
	}

	*/

	/*

	int num=0,menfi=0,musbet=0,num1=0;

	while (num1 < 10)
	{
		cout << "Reqem daxil edin\n";
		cin >> num;
		if (num < 0)
		{
			menfi=menfi+1;
		}
		else if (num > 0)
		{
			musbet=musbet+1;
		}
		num1++;

	}



	if (musbet == menfi) { cout << "Musbet ve menfi ededlerin sayi beraberdir\n"; }
	else if (musbet < menfi) { cout << "Menfi ededlerin sayi coxdur\n"; }
	else if (musbet > menfi) { cout << "Musbet ededlerin sayi coxdur\n"; }


	*/


	

	/*
	
	int balon;
	double litr=0,balon1=0  ;
	cout << "Balonun olcusunu daxil edin\n3,5 ve 7 litirlik balon gotur bilersiniz\n";
	cin >> balon;
	switch (balon)
	{
	case 3:
		balon1 = 3;
		while (balon1 <= balon)
		{

			cout << "Doldurmaq istediiyiniz miqdari daxil edin\n";
			cin >> litr;
			if (litr > balon1) { cout << litr - balon1 << " Qeder itki olacaq\n"; }
			else if (litr < balon1) { balon1 = balon1 - litr; cout << balon1 << " Qeder bos yer qaldi\n"; }
			else if (balon1 == litr) { cout << "Balon tam dolur\n"; break; }


		} break;
	case 5:
	
	balon1 = 5;
	while (balon1 <= balon)
	{

		cout << "Doldurmaq istediiyiniz miqdari daxil edin\n";
		cin >> litr;
		if (litr > balon1) { cout << litr - balon1 << " Qeder itki olacaq\n"; }
		else if (litr < balon1) { balon1 = balon1 - litr; cout << balon1 << " Qeder bos yer qaldi\n"; }
		else if (balon1 == litr) { cout << "Balon tam dolur\n"; break; }


	
	}break;
	case 7:
		balon1 = 7;
		while (balon1 <= balon)
		{

			cout << "Doldurmaq istediiyiniz miqdari daxil edin\n";
			cin >> litr;
			if (litr > balon1) { cout << litr - balon1 << " Qeder itki olacaq\n"; }
			else if (litr < balon1) { balon1 = balon1 - litr; cout << balon1 << " Qeder bos yer qaldi\n"; }
			else if (balon1 == litr) { cout << "Balon tam dolur\n"; break; }

			
		}break;
	default: cout << "Bele balon yoxdur\n";
	}
	
  */

    int num;
	cout << "Reqemi daxil et\n";
	cin >> num;
	while (num != 0)
	{
		cout << num / 10 << "\n";
		cout << "Reqemi daxil et\n";
		cin >> num;
	}














	return 0;
}