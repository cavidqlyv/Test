#include "stock.cpp"
#include <string>

class CallBack
{
public:
	bool operator () (std::string a, Product * product)
	{
		return a == product->getName();
	}
};