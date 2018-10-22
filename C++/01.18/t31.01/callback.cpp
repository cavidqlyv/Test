#include "stock.cpp"
#include <string>

class Filter
{
public:
	bool operator () (std::string a, Product * product)
	{
		return a == product->getName();
	}
};

class SortName
{
public:
	bool operator () (Product* a, Product * b)
	{
		return  a->getName() <  b->getName();
	}
};

class SortDate
{
public:
	bool operator () (Product* a, Product * b)
	{
		return  a->getExpirationData() <  b->getExpirationData();
	}
};
