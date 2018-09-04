#include <iostream>

class Home
{
	bool homeStat;
	int floor;
public:
	Home(bool hHomeStat, int hFloor)
	{
		setStat(hHomeStat);
		setFloor(hFloor);
	}
	bool getStat()
	{
		return homeStat;
	}
	int getFloor()
	{
		return floor;
	}
	void setStat(bool flag)
	{
		homeStat = flag;
	}
	void setFloor(int hFloor)
	{
		floor = hFloor;
	}
};

class Building
{
	Home * home[10];
	int homeCount = 0;
public:
	void addHome(Home*bHome)
	{
		home[getHomeCount()] = bHome;
		setHomeCount();
	}
	int getEmptyHomeCount()
	{
		int sum = 0;
		for (int i = 0; i < getHomeCount(); i++)
		{
			if (!home[i]->getStat())
				sum++;
		}
		return sum;
	}
	int getFullHomeCount()
	{
		int sum = 0;
		for (int i = 0; i < getHomeCount(); i++)
		{
			if (home[i]->getStat())
				sum++;
		}
		return sum;
	}
	~Building()
	{
		for (int i = 0; i < getHomeCount(); i++)
			delete home[i];
	}
	int getHomeCount()
	{
		return homeCount;
	}
	void setHomeCount()
	{
		homeCount++;
	}
	void printBuildInfo()
	{
		for (int i = 0; i < getHomeCount(); i++)
		{
			std::cout << "Home " << i + 1 << '\n';
			if (home[i]->getStat())
				std::cout << "Home is full\n";
			else
				std::cout << "Home is empty\n";
			std::cout << "Floor is " << home[i]->getFloor() << "\n";
			std::cout << "\n=================================================================\n\n";
		}
		std::cout << "Empty home : " << getEmptyHomeCount() << "\n";
		std::cout << "Full home : " << getFullHomeCount() << "\n";
		std::cout << "Home : " << getHomeCount() << "\n";
	}
};

int main()
{
	Building building;
	building.addHome(new Home(true, 1));
	building.addHome(new Home(false, 2));
	building.addHome(new Home(true, 3));
	building.addHome(new Home(false, 1));
	building.addHome(new Home(true, 2));
	building.addHome(new Home(false, 3));
	building.addHome(new Home(true, 1));

	building.printBuildInfo();
	system("pause");
	return 0;
}