#include "product.cpp"

class Stock
{
	Product * product[10];
	int count = 0;
public:
	Stock() = default;
	void addProduct(Product * sProduct)
	{
		product[count++] = sProduct;
	}
	Stock(std::initializer_list<Product*> data)
	{
		for (Product* tmp : data)
		{
			product[count++] = tmp;
		}
	}
	~Stock()
	{
		for (int i = 0; i < count; i++)
			delete[] product[i];
	}
	template<typename... T>
	void func(T&& ...arg)
	{
		Product * tmp = new Product(std::forward<T>(arg)...);
		product[count++]= tmp;
	}
	Product * getProduct(int index)
	{
		return product[index];
	}
	int getSize()
	{
		return count;
	}
	template<typename TCallback>
	Product* filter(std::string sName , TCallback callback)
	{
		for (int i = 0; i < count; i++)
			if (callback (sName , product[i]))
				return product[i];
	}
	
};