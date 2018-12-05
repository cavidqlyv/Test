#include <iostream>
using namespace std;

void main()
{
	int a, b, c, d;
	cin >> a;
	b = a % 3;
	c = a % 5;
	d = a % 7;
	(b + c + d == 0) ? cout << "3, 5 ve 7 qaliqsiz bolunur\n" : cout << "3, 5 7  qaliqsiz bolunmur\n";
}