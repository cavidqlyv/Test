#include <iostream>
#include "Staff.cpp"

class Cinema
{
	char * name;
	int year;
	int duration;
	int staffCount = 0;
	Staff* staff[5];
public:
	void addStaff(Staff * cStaff)
	{
		staff[staffCount++] = cStaff;
	}
	void setName(char *cName)
	{
		name = cName;
	}
	void setYear(int cYear)
	{
		year = cYear;
	}
	void setDuration(int cDuration)
	{
		duration = cDuration;
	}
	char * getName()
	{
		return name;
	}
	int getYear()
	{
		return year;
	}
	int getDuration()
	{
		return duration;
	}
	void print()
	{
		std::cout << "Name : " << getName() << "\n";
		std::cout << "Year : " << getYear() << "\n";
		std::cout << "Duration : " << getDuration() << "\n";
		for (int i = 0; i < staffCount; i++)
		{
			std::cout << "Staff Name : aa\t" << staff[i]->getName() << "\n";
			std::cout << "Staff job : aa\t" << staff[i]->getJob() << "\n";

		}
	}
};

