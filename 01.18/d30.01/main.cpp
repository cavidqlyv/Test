#include <iostream>
#include "callback.cpp"


void print(Stock * stock)
{
	int size = stock->getSize();
	for (int i = 0; i < size; i++)
	{
		Product * tmp = stock->getProduct(i);
		std::cout << "Name : " << tmp->getName() << '\n';
		std::cout << "ExpirationData : " << tmp->getExpirationData() << '\n';
	}
}

int main()
{

	Stock *stock = new Stock;

	std::string productName1 = "aaa";
	std::string productName2 = "bbb";
	std::string productName3 = "ccc";
	std::string productName4 = "ddd";
	std::string productName5 = "eee";


	std::string productExpirationData1 = "10.12.15";
	std::string productExpirationData3 = "13.12.15";
	std::string productExpirationData5 = "14.12.15";

	stock->func(productName1, productExpirationData1);
	stock->func(productName2);
	stock->func(productName3, productExpirationData3);
	stock->func(productName4);
	stock->func(productName5, productExpirationData5);

	print(stock);
	CallBack tmp;
	Product* tmp1 = stock->filter(productName3 , tmp);
	std::cout << tmp1->getName() << '\n';
	std::cout << tmp1->getExpirationData() << '\n';

	system("pause");
	return 0;
}