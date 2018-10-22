#include<iostream>
using namespace std;

void loop(int from, int to)
{

	if (from <= to)
	{
		cout << from<<"\n";
		loop(from + 1, to);
	}


		
}


int main()
{
	cin >> a;
	cin >> b;

	loop(a, b);

	return 0;
}