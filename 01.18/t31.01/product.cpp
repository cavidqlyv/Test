#include <string>

class Product
{
	std::string name;
	std::string expirationData;
public:
	Product(std::string pName, std::string pExpirationData)
	{
		name = pName;
		expirationData = pExpirationData;
	}
	Product(std::string pName)
	{
		name = pName;
	}
	Product(const Product& product)
	{
		name = product.name;
		expirationData = product.expirationData;
	}

	Product& operator = (const Product& product)
	{
		name = product.name;
		expirationData = product.expirationData;
		return *this;
	}
	Product(Product&& product)
	{
		name = product.name;
		expirationData = product.expirationData;
	}
	Product& operator = (Product&& product)
	{
		name = product.name;
		expirationData = product.expirationData;
		return *this;
	}
	void setExpirationData(std::string pExpirationData)
	{
		expirationData = pExpirationData;
	}
	void setName(std::string pName)
	{
		name = pName;
	}
	std::string getName()
	{
		return name;
	}
	std::string getExpirationData()
	{
		return expirationData;
	}
};