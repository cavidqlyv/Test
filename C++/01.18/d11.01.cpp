#include <iostream>

class People
{
	char*name;
	int age;
	int salary;

public:
	People(char* pName, int pAge , int pSalary)
	{
		setPeopleName(pName);
		setPeopleAge(pAge);
		setPeopleSalary(pSalary);
	}
	~People()
	{
		delete[] name;
	}

	void setPeopleName(char*pName)
	{
		name = pName;
	}
	void setPeopleAge(int pAge)
	{
		age = pAge;
	}
	void setPeopleSalary(int pSalary)
	{
		salary = pSalary;
	}
	char * getPeopleName()
	{
		return name;
	}
	int getPeopleAge()
	{
		return age;
	}
	int getPeopleSalary()
	{
		return salary;
	}
};

class District
{
	char *districtName;
	int peopleCount = 0;
	People* people[5];
public:


	void addPeople(People*dpeople)
	{
		people[peopleCount] = dpeople;
		peopleCount++;
	}

	char * getDistrictName()
	{
		return districtName;
	}
	District(char *dDistrictName)
	{
		districtName = dDistrictName;
	}
	~District()
	{
		delete[] districtName;
		for (int i = 0; i < peopleCount; i++)
		{
			delete people[i];
		}
	}
	int getCount()
	{
		return peopleCount;
	}
	int getAvgSalary()
	{
		int sum = 0;
		for (int i = 0; i < peopleCount; i++)
		{
			sum += people[i]->getPeopleSalary();
		}
		return sum / peopleCount;
	}
	int getAvgAge()
	{
		int sum = 0;
		for (int i = 0; i < peopleCount; i++)
		{
			sum += people[i]->getPeopleAge();
		}
		return sum / peopleCount;
	}
	void printDistrictInfo()
	{
		std::cout << "\n=================================================================\n\n";
		for (int i = 0; i < peopleCount; i++)
		{
			std::cout << "Name : " << people[i]->getPeopleName() << '\n';
			std::cout << "Age : " << people[i]->getPeopleAge() << '\n';
			std::cout << "Salary : " << people[i]->getPeopleSalary() << '\n';
			std::cout << "\n=================================================================\n\n";
		}
	}
};

class City
{
	int countDistrict=0;
	char * cityName;
	District * district[10];

public:
	City(char * cCityName) 
	{
		setCityName(cCityName);
	}
	~City()
	{
		delete[] cityName;
		for (int i = 0; i < countDistrict; i++)
		{
			delete district[i];
		}
	}
	void addDistrict(District * cDistrict)
	{
		district[countDistrict] = cDistrict;
		countDistrict++;
	}

	void printCityInfo()
	{
		std::cout << getCityName() << '\n';
	
		std::cout << "Peoples : " << getCityPeopleCount() << "\n";
		for (int i = 0; i < countDistrict; i++)
		{
			std::cout <<"\n\n\nDistrict name : " <<  district[i]->getDistrictName() << "\n";
			std::cout << "Average salary : " << district[i]->getAvgSalary() << "\n";
			std::cout << "Average age : " << district[i]->getAvgAge() << '\n';
			district[i]->printDistrictInfo();
		}
	}
	int getCityPeopleCount()
	{
		int sum = 0;
		for (int i = 0; i < countDistrict; i++)
		{
			sum +=district[i]->getCount();
		}
		return sum;
	}
	void setCityName(char *cCityName)
	{
		cityName = cCityName;
	}
	char * getCityName()
	{
		return cityName;
	}
};

int main()
{
	City city(new char[5]{ "Baki" });

	District * yasamal = new District(new char[10]{ "Yasamal" });

	yasamal->addPeople(new People(new char[10]{ "aaaaaa" }, 15, 500));
	yasamal->addPeople(new People(new char[10]{ "bbbbbb" }, 16, 600));
	yasamal->addPeople(new People(new char[10]{ "cccccc" }, 17, 700));
	yasamal->addPeople(new People(new char[10]{ "dddddd" }, 18, 800));

	District * bineqedi = new District(new char[15]{ "Bineqedi" });
	bineqedi->addPeople(new People(new char[10]{ "eeeeee" }, 19, 900));
	bineqedi->addPeople(new People(new char[10]{ "ffffff" }, 20, 1000));
	bineqedi->addPeople(new People(new char[10]{ "gggggg" }, 21, 1100));
	bineqedi->addPeople(new People(new char[10]{ "hhhhhh" }, 22, 1200));

	city.addDistrict(yasamal);
	city.addDistrict(bineqedi);

	city.printCityInfo();
	system("pause");
	return 0;
}