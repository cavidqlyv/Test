#include <iostream>
#include "number.cpp"

int main()
{
	Number<int> n1(5);
	Number<int> n2(2);

	Number<double> n3(2);
	Number<double> n4(2);

//	Number<char> n5;


	std::cout << n1 % n2 << "\n";
	std::cout << n1 % n2 << "\n";



	system("pause");
	return 0;
}