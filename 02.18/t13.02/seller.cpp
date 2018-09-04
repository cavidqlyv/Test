#include "callback.cpp"
#include <string>
class Seller
{
	Car *car[10];
	Truck *truck[10];
	AbstractClass * cars[10];
	int carCount = 0;
	int truckCount = 0;
public:
	void addCar(std::string name, int year)
	{
		car[carCount] = new Car;
		car[carCount]->setName(name);
		car[carCount++]->setYear(year);
	}
	void addTruck(std::string name, int year)
	{
		truck[truckCount] = new Truck;
		truck[truckCount]->setName(name);
		truck[truckCount++]->setYear(year);
	}
	~Seller()
	{
		for (int i = 0; i < carCount; i++)
			delete car[i];
		for (int i = 0; i < truckCount; i++)
			delete truck[i];
	}
	template <typename T>
	AbstractClass * select(std::string name, T tmp)
	{
		for (int i = 0; i < carCount; i++)
		{
			if (tmp(car[i], name))
				return car[i];
		}
		for (int i = 0; i < truckCount; i++)
		{
			if (tmp(truck[i], name))
				return truck[i];
		}
		return nullptr;
	}
	void showList()
	{
		for (int i = 0; i < carCount; i++)
		{
			std::cout << "Car Name : " << car[i]->getName() << '\n';
			std::cout << "Car Year : " << car[i]->getYear() << '\n';
		}
		for (int i = 0; i < truckCount; i++)
		{
			std::cout << "Truck Name : " << truck[i]->getName() << '\n';
			std::cout << "Truck Year : " << truck[i]->getYear() << '\n';
		}
	}
};