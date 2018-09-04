#include <string>
#include "carinterface.cpp"

class AbstractClass
{
	std::string name;
	int year;
public:
	void setName(std::string cName)
	{
		name = cName;
	}
	void setYear(int cYear)
	{
		year = cYear;
	}
	std::string getName()
	{
		return name;
	}
	int getYear()
	{
		return year;
	}
};
