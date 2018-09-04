#include <string>

class CarInterface
{
	virtual void setName(std::string cName) = 0;
	virtual void setYear(int cYear) = 0;
	virtual std::string getName() = 0;
	virtual int getYear() = 0;
};
