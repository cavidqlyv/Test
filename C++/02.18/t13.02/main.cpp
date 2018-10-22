#include <iostream>
#include "seller.cpp"
#include <string>
int main()
{
	Seller seller;

	std::string carName1 = "aaaa";
	std::string carName2 = "bbbb";
	std::string carName3 = "cccc";
	std::string carName4 = "dddd";

	int carYear1 = 1997;
	int carYear2 = 1998;
	int carYear3 = 1999;
	int carYear4 = 2000;


	seller.addCar(carName1, carYear1);
	seller.addCar(carName2, carYear2);

	seller.addTruck(carName3, carYear3);
	seller.addTruck(carName4, carYear4);


	seller.showList();
	std::cout << "==========\n";
	SearchByName searchByName;
	AbstractClass * car = seller.select(carName1 , searchByName);

	std::cout << car->getName() << '\n';
	std::cout << car->getYear() << '\n';

	system("pause");
	return 0;
}