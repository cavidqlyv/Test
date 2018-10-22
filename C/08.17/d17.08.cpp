#include <iostream>
using namespace std;

int main() {

	/* task1
	int num[10];


	for (int i = 0; i < 10; i++)
	{
		cin >> num[i];

	}
	for (int i = 0; i < 10; i++)
	{
		cout << num[i]<<" ";
	}
	*/

	/*task2
	int num[] = { 15,16,48,47,49 };
	int num1[5];
	num1[0] = 15;
	num1[1] = 16;
	num1[2] = 48;
	num1[3] = 47;
	num1[4] = 49;
	*/
	/*task3
	char num[4] = { 'A','l','i','m' };

	
		cout << num[0];
		cout << num[1];
		cout << num[2];
		cout << num[3];
		cout << "\n";
	*/

	/*task4
		int num[5];
		for (int i = 0; i < 5; i++)
		{
		cin >> num[i];

		}
		for (int i = 4; i >= 0; i--)
		{
		cout << num[i]<<" ";
		}
	*/
		
	/*	task5
		int num[10];
		int a=0;
		for (int i = 0; i < 10; i++)
		{
		cin >> num[i];

		}
		for (int i = 0; i < 10; i++)
		{
			if (num[i] > 0)
			{
				a = a + num[i];
				
     		}
	
		}
		cout << a << "\n";
   */

	/*
	int num[10];
	int a = 0;
	int b = 0;


	for (int i = 0; i < 10; i++)
	{
		cin >> num[i];

	}
	for (int i = 0; i < 10; i++)
	{
		if (num[i] < 0 && b==0)
		{
			a = 0;
			b++;
		}
		if (num[i] > 0)
		{
			a = a + num[i];

		}

	}
	cout << a << "\n";
	*/

    /*
	int num[5];
	int a = 0;
	int b = 0;


	for (int i = 0; i < 5; i++)
	{
		cin >> num[i];

	}
	b = num[0];
	for (int i = 0; i < 5; i++)
	{
		if (num[i]>a)
		{
			a = num[i];
			
		}
		if (num[i] < b)
		{
			b = num[i];

		}

	}
	cout <<"En boyuk "<< a << "\n";
	cout <<"En kicik "<< b << "\n";
	*/
		





	return 0;
}