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
	std::string productName2 = "ccc";
	std::string productName3 = "bbb";
	std::string productName4 = "ddd";
	std::string productName5 = "eee";


	std::string productExpirationData1 = "15.12.15";
	std::string productExpirationData3 = "15.12.14";
	std::string productExpirationData5 = "15.12.16";

	stock->func(productName1, productExpirationData1);
	stock->func(productName2);
	stock->func(productName3, productExpirationData3);
	stock->func(productName4);
	stock->func(productName5, productExpirationData5);

	print(stock);
	Filter filter;
	Product* tmp1 = stock->filter(productName3, filter);
	std::cout << tmp1->getName() << '\n';
	std::cout << tmp1->getExpirationData() << '\n';

	SortDate data;
	SortName name;

	std::cout << "\n==================================\n\n";

	stock->sort(name);

	print(stock);

	stock->sort(data);
	std::cout << "\n==================================\n\n";

	print(stock);

	delete stock;

	system("pause");
	return 0;
}