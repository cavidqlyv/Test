#include <string>
#include<iostream>

class Task
{
	std::string name;
	int priorty;
	bool background;
public:
	Task(std::string tName, int tPriorty)
	{
		name = tName;
		priorty = tPriorty;
	}
	Task(std::string tName, int tPriorty , bool flag)
	{
		name = tName;
		priorty = tPriorty;
		run();
	}
	void setName(std::string tName)
	{
		name = tName;
	}
	std::string getName()
	{
		return name;
	}
	void setPriorty(int tPriorty)
	{
		priorty = tPriorty;
	}
	int getPriorty()
	{
		return priorty;
	}
	void setBackground(bool flag)
	{
		background = flag;
	}
	bool getBackground()
	{
		return background;
	}
	void run()
	{
		std::cout << "OK!\n";
	}
};