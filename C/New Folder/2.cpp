#include <iostream>
using namespace std;

void main()
{
	int a;
	cin >> a;
	(a % 3 == 0 || a % 5 == 0) ? cout << "Bolunur\n" : (a % 7 == 0) ? cout << "Bolunur\n" : cout << "Bolunmur\n";
}