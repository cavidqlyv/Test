#include <string>
#include "car.cpp"

struct SearchByName
{
	bool operator () (AbstractClass* a, std::string b)
	{
		return a->getName() == b;
	}
};