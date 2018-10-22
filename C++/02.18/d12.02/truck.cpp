#include "abstractclass.cpp"
#include <iostream>

class Truck : public AbstractClass
{
public:
	void run()
	{
		std::cout << "OK!\n";
	}
};