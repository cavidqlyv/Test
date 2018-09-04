#include<iostream>
using namespace std;

void electric(int a[1], int alarm[1]) {

	
	if (a[0] == 0)
	{
		cout << "isiqlari yandirmaq ucun 1 daxil edin\n";
		cin >> a[0];
		while (a[0] != 1)
		{


			cout << "Duzgun daxil edin\n";
			cin >> a[0];

		}
		cout << "isiqlari yandirdiniz\n";
		if (alarm[0] == 1)
		{
			cout << "Temperatur coxdur\n";
		}
		
	
		
	}
	else if (a[0] == 1)
	{
		cout << "isiqlari sondurmek ucun 0 daxil edin\n";
		cin >> a[0];
		while (a[0] != 0)
		{
			cout << "Duzgun daxil edin\n";
			cin >> a[0];
		}
		cout << "isiqlari sondurdunuz\n";
		if (alarm[0] == 1)
		{
			cout << "Temperatur coxdur\n";
		}
		
		
	}
	


}


void door(int d[1] , int a[1]) {

	if (a[0] == 0)
	{
		cout << "\nEvvelce isiqlar\n\n";
		
	
	}
	else
	{
		if (d[0] == 0)
		{
			cout << "Qapilari acmaq ucun 1 daxil edin\n";
			cin >> d[0];
			while (d[0] != 1)
			{


				cout << "Duzgun daxil edin\n";
				cin >> d[0];

			}
			cout << "Qapilari acdiniz\n";
			if (alarm[0] == 1)
			{
				cout << "\n\nTemperatur coxdur\n\n";
			}



		}
		else if (d[0] == 1)
		{
			cout << "Qapilari baglamaq ucun 0 daxil edin\n";
			cin >> d[0];
			while (d[0] != 0)
			{
				cout << "Duzgun daxil edin\n";
				cin >> d[0];
			}
			cout << "Qapilari bagladiniz\n";
			if (alarm[0] == 1)
			{
				cout << "\n\nTemperatur coxdur\n\n";
			}


		}

	}

}

void wather(int w[1] , int s[1] , int a[1]) {

	if (a[0] == 0)
	{
		cout << "\nEvvelce isiqlar\n\n";
		if (alarm[0] == 1)
	
	}
	else
	{
		if (w[0] == 0)
		{
			cout << "Sulari acmaq  ucun 1 daxil edin\n";
			cin >> w[0];
			while (w[0] != 1)
			{


				cout << "Duzgun daxil edin\n";
				cin >> w[0];

			}
			cout << "Sulari acdiniz\n";
			if (alarm[0] == 1)
			{
				cout << "\n\nTemperatur coxdur\n\n";
			}



		}
		else if (w[0] == 1 && s[0] == 0)
		{
			cout << "Evvelce sualama sistemini sondurun\n";


		}
		else if (w[0] == 1 && s[0] == 1)
		{
			cout << "Sulari baglamaq ucun 0 daxil edin\n";
			cin >> w[0];
			while (w[0] != 0)
			{
				cout << "Duzgun daxil edin\n";
				cin >> w[0];
			}
			cout << "Sulari bagladiniz\n";
			if (alarm[0] == 1)
			{
				cout << "\n\nTemperatur coxdur\n\n";
			}


		}
	}


}


void wather1(int w[1] , int s[1] , int a[1]) {

	if (a[0] == 0)
	{
		cout << "\nEvvelce isiqlar\n\n";
		
	}
	else
	{

		if (w[0] == 1 && s[0] == 0)
		{
			cout << "Sulama sistemini acmaq  ucun 1 daxil edin\n";
			if (alarm[0] == 1)
			{
				cout << "\n\nTemperatur coxdur\n\n";
			}
			cin >> s[0];
			while (s[0] != 1)
			{


				cout << "Duzgun daxil edin\n";
				cin >> s[0];

			}
			cout << "Sulari acdiniz\n";
			if (alarm[0] == 1)
			{
				cout << "\n\nTemperatur coxdur\n\n";
			}



		}
		else if (w[0] == 1 && s[0] == 1)
		{
			cout << "Sulama sistemini baglamaq ucun 0 daxil edin\n";
			if (alarm[0] == 1)
			{
				cout << "\n\nTemperatur coxdur\n\n";
			}
			cin >> s[0];
			while (s[0] != 0)
			{
				cout << "Duzgun daxil edin\n";
				cin >> s[0];
			}
			cout << "Sulari bagladiniz sondurdunuz\n";
			if (alarm[0] == 1)
			{
				cout << "\n\nTemperatur coxdur\n\n";
			}


		}
		else if (w[0] == 0)
		{
			cout << "Evvelce sulari ac\n";
			if (alarm[0] == 1)
			{
				cout << "\n\nTemperatur coxdur\n\n";
			}
		}


	}
}

void cam(int c[1] , int a[1] ,int d[1],int s[1]) {

	int i = 1;

	if (a[0] == 0)
	{
		cout << "\nEvvelce isiqlar\n\n";
	}
	else
	{

		if (c[0] == 0)
		{
			
				cout << "Kameralari yandirmaq ucun 1 daxil edin\n";
				cout << "kameralardan baxmaq ucun 2 daxil edin\n";
				cin >> i;
				if (i == 1)
				{
					c[0] = 1 ;
					while (c[0] != 1)
					
					cout << "Kameralari yandirdiniz\n";
					if (alarm[0] == 1)
					{
						cout << "\n\nTemperatur coxdur\n\n";
					}
				}
				else if (i == 2)
				{
					cout << "Evvelce kameralari yandirin\n";
				}
			


		}
		else if (c[0] == 1)
		{
			cout << "Kameralari sondurmek ucun 0 daxil edin\n";
			cout << "kameralardan baxmaq ucun 2 daxil edin\n";
			cin >> i;

			if (i == 1)
			{
				c[0] = 0;
			}
			else if (i == 2)
			{
				if (d[0] == 1)
				{
					cout << "Qapilar aciqdir\n";
				
				}
				else if (d[0] == 0)
				{
					cout << "qapilar baglidir\n";
				}
				if (s[0] == 1)
				{
					cout << "Sulama sistemi aciqdir\n\n";
				}
				else if (s[0] == 0)
				{
					cout << "Sulama sistemi baglidir\n\n";
				}
			}

		}


	}
}

void status(int a[1], int c[1], int d[1], int w[1] , int s[1]) {
	
	if (a[0] == 0)
	{
		cout << "\nSistem sonludur\n\n";
	}
	else
	{

		if (a[0] == 1)
		{
			cout << "\nIsiqlar yanlidi\n";
		}
		else if (a[0] == 0)
		{
			cout << "\nIsiqlar sonludur\n";
		}
		if (c[0] == 1)
		{
			cout << "Kameralar yanlidir\n";
		}
		else if (c[0] == 0)
		{
			cout << "Kameralar sonludur\n";
		}
		if (d[0] == 1)
		{
			cout << "Qapilar aciqdir\n";
		}
		else if (d[0] == 0)
		{
			cout << "qapilar baglidir\n";
		}
		if (w[0] == 1)
		{
			cout << "Sular aciqdir\n";
		}
		else if (w[0] == 0)
		{
			cout << "Sular baglidir\n";
		}
		if (s[0] == 1)
		{
			cout << "Sulama sistemi aciqdir\n\n";
		}
		else if (s[0] == 0)
		{
			cout << "Sulama sistemi baglidir\n\n";
		}
		if (alarm[0] == 1)
		{
			cout << "\n\nTemperatur coxdur\n\n";
		}
	}
}

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

void temp(int t[1], int alarm[1] , int a[1]) {
	
	int i , j=0;
	
	if (a[0] == 0)
	{
		cout << "\nEvvelce isiqlar\n\n";
	}
	else
	{
		cout << "\n\nFesli secin\n";
		cout << "Yay ucun 1\n";
		cout << "Qis ucun 2\n";
		cout << "Geri qayitmaq ucun 0 daxil edin\n\n\n";

		cin >> i;

		if (i == 1)
		{
			cout << "5 - 25 arasi temperatur daxil edin\n";
			cin >> j;

			if (j < 5)
			{
				cout << "Temperatur cox azdir\n";
			}
			else if (j >= 5 && j < 25)
			{
				alarm[0] = 0;
				cout << "Istilik sistemi isleyir\n";
			}
			else if (j >= 25)
			{
				alarm[0] = 1;
				cout << "Istilik sitemi isleyir amma temperatur coxdur\n";
			}
		}
		else if (i == 2)
		{
			cout << "20 - 35 arasi temperatur daxil edin\n";
			cin >> j;

			if (j < 20)
			{
				cout << "Temperatur cox azdir\n";
			}
			else if (j >= 20 && j < 35)
			{
				alarm[0] = 0;
				cout << "Istilik sistemi isleyir\n";
			}
			else if (j >= 35)
			{
				alarm[0] = 1;
				cout << "Istilik sitemi isleyir amma temperatur coxdur\n";
			}
		}

	}


}


int main() {

	int a[1],c[1],d[1],w[1],s[1], b = 1;
	int alarm[1];
	alarm[0] = 0;
	a[0]=0;
	c[0] = 0;
	d[0] = 0;
	w[0] = 0;
	s[0] = 0;
	pas();

	while (b != 0)
	{
		cout << "\n\n------------------------------------------------------------------------------------------------------------------------\n\n";
		cout << "Isiqlar 1 daxil et\n";
		cout << "Kameralar ucun 2 daxil et\n";
		cout << "Evin statusuna baxmaq ucun 3 daxil et\n";
		cout << "Qapilar ucun 4 basin\n";
		cout << "Sular ucun 5 basin\n";
		cout << "Sulama sistemi ucun 6 daxl edin\n";
		cout << "Istilik sistemi ucun 7 daxil edin\n";
		cout << "Baglamaq ucun 0 daxil et\n";
		if (alarm[0] == 1)
		{
			cout << "\n\nTemperatur coxdur\n\n";
		}
		
		cout << "\n\n------------------------------------------------------------------------------------------------------------------------\n\n";
		
		cin >> b;
		if (b == 1)
		{
			electric(a);
		}
		else if (b == 2)
		{
			cam(c,a,d,s);
		}
		else if (b == 3)
		{
			status(a, c, d, w , s);
		}
		else if (b == 4)
		{
			door(d,a);
		}
		else if (b == 5)
		{
			wather(w , s,a);
		}
		else if (b == 6)
		{
			wather1(w, s,a);
		}
		else if (b == 7);
		{

		}
	}
}