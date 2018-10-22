#include <iostream>
using namespace std;

//int i = 10;
/*
void loop(int from, int to) {
	//int a;
	//int b;
	int i = 10;

	//a = to;
	//b = from;
	if (from <= to)
	{


		cout << from << "\n";
		loop(from + 1, to);


	}
	if (to >= from)
	{
		cout << from << "\n";

	}
}



int main()
{
	
	loop(0, 10);
	
	system ("pause");
	return 0;
		
}
*/
//int d=0 ;
/*
int  b(int a)
{
	
	
	//if (d <= a)
//	{
	if 
		(a < 2) return 1;
	else 
		return ( a = a * b(a-1));
		//d++;
		
	
	//return a;
}

int main()
{
	int a;
	//int r=0;
	cin >> a;


	cout << b(a) << "\n";

	system("pause");
	return 0;
}
*/

int c = 1;
int d = 0;
int e = 0;
int f = 0;
void b(int a)
{
	if (f <= a)
	{
		
		
		e = c + d;
		d = c + e;
		c = d + e;
		
		
		if (e > c && e > d)
		{
			f = e;
		}
		else if (d > c && d > e)
		{
			f = d;
		}
		else if (c > d && c > e)
		{
			f = c;
		}
		
		
		b(a);
		if (f <= a)
			cout << e << "\n";
		if (f <= a)
			cout << d << "\n";
		if (f <= a)
			cout << c << "\n";
		
	
		
	}

		
		
}

int main()
{
	int a;
	//int c=0;
	cin >> a;

	  b(a);
	 system("pause");

	return 0;
}