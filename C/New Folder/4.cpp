#include <iostream>
using namespace std;

void main()
{
	char a;
	cin >> a;
	(a >= 33 && a <= 46) ? cout << "Punktuasiya Elementidir\n" : (a >= 58 && a <= 60) ? cout << "Punktuasiya Elementidir\n" : (a >= 62 && a <= 64) ? cout << "Punktuasiya Elementdir\n" : (a >= 123 && a <= 126) ? cout << "Punktuasiya Elementdir\n" : cout << "Punktuasiya Elementi Deyil\n";
}