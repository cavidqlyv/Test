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
			current->next->task = task;
		}
		else
		{
			head[priority - 1] = new Node;
			head[priority - 1]->task = task;
		}
	}
	void printList()
	{
		Node *current;
		for (int i = 0; i < size; i++)
		{
			std::cout << "\n\nPriority " << i + 1 << " : \n\n";
			current = head[i];
			while (current)
			{
				std::cout << "Name : " << current->task->getName() << '\n';
				std::cout << "Deadline : " << current->task->getDeadline() << '\n';
				current = current->next;
			}
		}
	}
	Node * getNode(int index)
	{
		return head[index];
	}
};

//
//void printTask(App app)
//{
//	Node * tmp;
//	for (int i = 0; i < 3; i++)
//	{
//		tmp = app.getNode(i);
//		std::cout << "\n\nPriority " << i + 1 << " : \n\n";
//		while (tmp)
//		{
//			std::cout << "Name : " << tmp->task->getName() << '\n';
//			std::cout << "Deadline : " << tmp->task->getDeadline() << '\n';
//			tmp = tmp->next;
//		}
//	}
//}


int main()
{

	App app;
	int a;

	std::string tmp1;
	std::string tmp2;
	int tmp3;


	while (1)
	{
		std::cout << "Add task 1\n";
		std::cout << "Print List 2\n";
		std::cout << "Exit 0\n";
		std::cin >> a;
		if (a == 1)
		{
			std::cout << "Enter Task Name\n";
			std::cin >> tmp1;
			std::cout << "Enter Priority 1-3\n";
			std::cin >> tmp3;
			std::cout << "Enter Deadline\n";
			std::cin >> tmp2;
			app.addTask(tmp1, tmp3, tmp2);
		}
		if (a == 2)
		{
			app.printList();
		}
		if (a == 0)
			return 0;
	}

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