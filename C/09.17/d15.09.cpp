#include <iostream>
using namespace std;


int main() {
/*
	int num[10];
	int num1[10];
	int a = 0;
	
	cout << "Birinci massivin qiymetlerini daxil edin \n";
	for (int i = 0; i < 10; i++)
	{
		cin >> num[i];
	}
	cout << "\n";
	for (int i = 0; i < 10; i++)
	{
		
		if (num[i] < 0)
		{
			num1[a] = num[i];
			a++;
		}
		


	}
	for (int i = 0; i < 10; i++)
	{

		if (num[i] >= 0)
		{
			
			num1[a] = num[i];
			a++;
		}



	}
	for (int i = 0; i < 10; i++)
	{
		cout <<  num1[i] << "\n";
	}

*/
	//int num[10] = {1,2,3,4,5,6,7,8,9,0};
	//int num1[10] = {11,22,3,44,5,66,77,8,9,10};
	//int num2[10];
	//int b = 0;
	//int d = 0;
	
	


	/*cout << "Birinci massivin qiymetlerini daxil edin \n";
	for (int i = 0; i < 10; i++)
	{
		cin >> num[i];
	}
	cout << "ikinci massivin qiymetlerini daxil edin \n";
	for (int i = 0; i < 10; i++)
	{
		cin >> num1[i];
	}*/
	/*for (int i = 0; i < 10; i++)
	{
		
		for (int a = 0; a < 10; a++)
		{
			d = 0;
			if (num[i] == num1[a])
			{
				d = 1;
			
			}
			
			
		
		
			if (d != 1)
			{
				num2[i] = num[i];
				b++;
			}
		}
		

	}

	for (int i = 0; i < b; i++)
	{
		cout << num2[i] <<  "  ";
	}

	*/
	/*
	int num[8];
	double b = 0;
	int a = 0;

	cout << "Birinci massivin qiymetlerini daxil edin \n";
	for (int i = 0; i < 8; i++)
	{
		cin >> num[i];
	}
	for (int i = 0; i < 8; i++)
	{
		if (num[i] > 0)
		{
			a = a + num[i];
			b++;
		}
	}
	cout << "Cem = " << a;
	cout << "Orta = " << a / b;
	*/


	
	
	int num[10];
	
	int a = 0, b = 10, c = 0;
	
	cout << "Birinci massivin qiymetlerini daxil edin \n";
	for (int i = 0; i < b; i++)
	{
		cin >> a;
		if (a >= 10 && a <= 100)
		{
			num[c] = a;
			b=b-1;
			c++;
		}
		else { cout << "Duzgun daxil et\n"; }
	}
	cout << "5 bolunen\n";
	for (int i = 0; i < 10; i++)
	{
		
		if (num[i] % 5 == 0)
		{
			cout << num[i];
		}
		
	
		
	}
	cout << "7 e bolunen ";
	for (int i = 0; i < 10; i++) 
	{
		if (num[i] % 7 != 0)
		{
			cout  << num[i];
		}
	}
	return 0;
	
}
