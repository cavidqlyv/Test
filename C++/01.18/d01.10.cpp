#include <iostream>

class Home
{
	bool homeStat;
	int floor;
public:
	Home(bool hHomeStat, int hFloor)
	{
		setHomeStat(hHomeStat);
		setFloor(hFloor);
	}

	bool getHomeStat()
	{
		return homeStat;
	}
	void setHomeStat(bool flag)
	{
		homeStat = flag;
	}
	int getFloor()
	{
		return floor;
	}
	void setFloor(int hFloor)
	{
		floor = hFloor;
	}
};

class Building
{
	Home * home[10];
	static int buildingCount;
	int homeCount = 0;
public:
	void addHome(Home*bHome)
	{
		home[homeCount] = bHome;
	}
	int getFreeHomeCount()
	{
		int sum = 0;
		for (int i = 0; i < homeCount; i++)
		{
			//if (home[])
		}
		return sum;
	}
	int getHomeCount()
	{
		return homeCount;
	}
};
int Building::buildingCount = 0;

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


	system("pause");
	return 0;
}