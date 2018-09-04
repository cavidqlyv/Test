#include "cash.cpp"
#include <iostream>

class Cashier
{
	char *name;
public:
	void setName(char * cName)
	{
		name = cName;
	}
	char * getName()
	{
		return name;
	}
};