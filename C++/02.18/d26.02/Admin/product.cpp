#include "node.cpp"

class Product
{
	std::string name;
	int price;
	int count;
public:
	Product(std::string pName, int pPrice, int pCount)
	{
		name = pName;
		price = pPrice;
		count = pCount;
	}
	std::string getName()
	{
		return name;
	}
	int getCount()
	{
		return count;
	}
	int getPrice()
	{
		return price;
	}
	void setName(std::string pName)
	{
		name = pName;
	}
	void setPrice(int pPrice)
	{
		price = pPrice;
	}
	void setCount(int pCount)
	{
		count = pCount;
	}
};