#include <iostream>
#include <string>
#include <time.h>
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

struct Node
{
	Node * next = nullptr;
	Task * task;
};

class App
{
	size_t size = 3;
	Node *head[3];
public:
	App()
	{
		for (int i = 0; i < size; i++)
			head[i] = nullptr;
	}
	~App()
	{
		for (int i = 0; i < size; i++)
		{
			Node * current;

			while (head[i])
			{
				current = head[i];
				head[i] = current->next;
				delete current->task;
				delete current;
				current = nullptr;
			}
		}
	}
	void addTask(std::string name, int priority, std::string deadline)
	{
		Task * task = new Task(name, priority, deadline);

		if (head[priority - 1])
		{
			Node  * current = head[priority - 1];
			while (current->next)
				current = current->next;
			current->next = new Node;
			current->task = task;
		}
		else
		{
			head[priority - 1] = new Node;
			head[priority - 1]->task = task;
		}
	}
	void printList()
	{
		for (int i = 0; i < size; i++)
		{
			std::cout << "Priority " << i + 1 << " : \n\n";
			Node *current = head[i];
			while (current)
			{
				std::cout << "Name : " << current->task->getName() << '\n';
				std::cout << "Deadline : " << current->task->getDeadline() << '\n';
				current = current->next;
			}
		}
	}
};



int main()
{

	App app;

	app.addTask("aaa", 1, "bbb");
	app.addTask("ccc", 2, "ddd");
	app.addTask("eee", 3, "fff");
	app.addTask("ggg", 1, "hhh");
	app.addTask("kkk", 2, "lll");



	app.printList();

	system("pause");
	return 0;
}

/*
time_t t = time(NULL);

tm* now = localtime(&t);
std::cout << (now->tm_year + 1900) << '-'
<< (now->tm_mon + 1) << '-'
<< now->tm_mday << ' '
<< now->tm_hour << ' '
<< now->tm_min << ' '
<< now->tm_sec;
*/