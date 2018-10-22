#include <string>
#include <iostream>
#include "callback.cpp"
#pragma warning (disable : 4996)

class Task
{
	std::string name;
	int priority;
	std::string deadline;
	int stat;  // 1 In process , 2 Processed , 3 Expired
public:
	Task(std::string tName, int tPriority, std::string tDeadline)
	{
		name = tName;
		priority = tPriority;
		deadline = tDeadline;
		stat = 1;
	}
	void setName(std::string tName)
	{
		name = tName;
	}
	void setPriority(int tPriority)
	{
		priority = tPriority;
	}
	void setDeadline(std::string tDeadline)
	{
		deadline = tDeadline;
	}
	std::string getName()
	{
		return name;
	}
	int getPriority()
	{
		return priority;
	}
	std::string getDeadline()
	{
		return deadline;
	}
	void setStat(int n)
	{
		stat = n;
	}
	int getStat()
	{
		return stat;
	}
};