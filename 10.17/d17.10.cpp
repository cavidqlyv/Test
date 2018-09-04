#include <iostream>
using namespace std;

/*

int main()
{

	int a ;
	int b ;

	int * a1;
	int * b1;

	cin >> a;
	cin >> b;

	a1 = &a;
	b1 = &b;

	if (*a1 > *b1)
	{
		cout << *a1 << "\n";
	}
	else if (*a1 < *b1)
	{
		cout << *b1 << "\n"; 
	}
	else
	{
		cout << "Beraberdir\n";
	}
	


	
	
	return 0;
}
*/

/*
int main()
{
	int a;
	int b;

	int * a1;
	int * b1;

	cin >> a;
	cin >> b;

	a1 = &a;
	b1 = &b;

	*a1 = *a1 + *b1;
	*b1 = *a1 - *b1;
	*a1 = *a1 - *b1;

	cout << "a :" << *a1 << "\n";
	cout << "b :" << *b1 << "\n";



	return 0;
}
*/
/*
const int h = 5;

void d(int *a, int * b, int * c)
{
	//*b = 0;
	//*c = 1;
	for (int i = 0; i < h; i++)
	{
		*b = *b + a[i];
		*c = *c * a[i];
	}


}

int main()
{
	int a[h] = { 1,2,3,4,5 };
	int a1 = 0;
	int b1 = 1;
	
	
	int *b = &a1 ;
	int *c = &b1;

	d(a, b, c );
	cout << *b << "\n";
	cout << *c << "\n";


	return 0;
}
*/

int d = 0, e = 0;
void a(int* num , int* num1 , int *num2 )
{
	int h = 0;
	int *a1 =&h;
	
	for (int i = 0; i < 5; i++)
	{
		*a1 = num[i];
		if (*a1 < 0)
		{
			num1[d] = *a1;
			d++;
		}
		else
		{
			num2[e] = *a1;
			e++;
		}
	}
}


int main()
{
	int num[5];
	int num1[5];
	int num2[5];

	for (int i = 0; i < 5; i++)
	{
		cin >> num[i];
	}

	a(num, num1, num2);
	cout << "\n\n";
	cout << &num1;
	cout << "\n\n";

	for (int i = 0; i < d; i++)
	{
		
		cout << num1[i] << "\n";
	}
	cout << "\n\n";
	cout << &num2;
	cout << "\n\n";

	for (int i = 0; i < e; i++)
	{

		cout << num2[i] << "\n";
	}
	


	return 0;
}