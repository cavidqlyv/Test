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

template<typename T>
struct Node
{
	Node * next = nullptr;
	T * value;
};

class Product
{
	std::string name;
	int price;
	int count;
public:
	Product(std::string pName, int pPrice, int pCount)
	{
		name = pName;
		price = pPrice;
		count = pCount;
	}
	std::string getName()
	{
		return name;
	}
	int getCount()
	{
		return count;
	}
	int getPrice()
	{
		return price;
	}
	void setName(std::string pName)
	{
		name = pName;
	}
	void setPrice(int pPrice)
	{
		price = pPrice;
	}
	void setCount(int pCount)
	{
		count = pCount;
	}
};

class Stock
{
	size_t size = 3;
	Node<Product> * head[3];//Phone 0 , TV 1
public:
	Stock()
	{
		for (int i = 0; i < size; i++)
			head[i] = nullptr;
	}
	~Stock()
	{

	}
	void addProduct(std::string pName, int pPrice, int pCount, std::string category)
	{
		Product * product = new Product(pName, pPrice, pCount);
		int index;
		if (category == "Phone")
			index = 0;
		else if (category == "TV")
			index = 1;
		else
		{
			std::cout << "Error\n";
			return;
		}

		if (head[index])
		{
			Node<Product>  * current = head[index];
			while (current->next)
				current = current->next;
			current->next = new Node<Product>;
			current->next->value = product;
		}
		else
		{
			head[index] = new Node<Product>;
			head[index]->value = product;
		}
	}
	Node<Product>* getList(int index)
	{
		return head[index];
	}
};

class App
{
	size_t size = 3;
	Node<Task> *head[3];// priority
	Stock stock;
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
			Node<Task> * current;

			while (head[i])
			{
				current = head[i];
				head[i] = current->next;
				delete current->value;
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
			Node<Task>  * current = head[priority - 1];
			while (current->next)
				current = current->next;
			current->next = new Node<Task>;
			current->next->value = task;
		}
		else
		{
			head[priority - 1] = new Node<Task>;
			head[priority - 1]->value = task;
		}
	}
	void printList()
	{
		"\n\n=========================== TASK ==========================\n\n\n";
		Node<Task> *current;
		for (int i = 0; i < size; i++)
		{
			std::cout << "\n\nPriority " << i + 1 << " : \n\n";
			current = head[i];
			while (current)
			{
				std::cout << "Name : " << current->value->getName() << '\n';
				std::cout << "Deadline : " << current->value->getDeadline() << '\n';
				current = current->next;
			}
		}
	}
	Node<Task> * getNode(int index)
	{
		return head[index];
	}
	void addProduct(std::string pName, int pPrice, int pCount, std::string category)
	{
		stock.addProduct(pName, pPrice, pCount, category);
	}
	void printProductList()
	{
		std::cout << "\n\n=========================== PRODUCT ==========================\n\n\n";
		Node<Product> * tmp;
		for (int i = 0; i < 3; i++)
		{
			tmp = stock.getList(i);
			if (i == 0)
				std::cout << "\n\nPhone : \n\n";
			else if (i == 1)
				std::cout << "\n\TV : \n\n";
			while (tmp)
			{
				std::cout << "Name : " << tmp->value->getName() << '\n';
				std::cout << "Price : " << tmp->value->getPrice() << '\n';
				std::cout << "Count : " << tmp->value->getCount() << '\n';
				tmp = tmp->next;
			}
		}
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
	int tmp4;


	while (1)
	{
		std::cout << "\n\n=========================== MENU ==========================\n\n\n";

		std::cout << "Add task 1\n";
		std::cout << "Print task list 2\n";
		std::cout << "Add product 3\n";
		std::cout << "Print product list 4\n";
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
			system("cls");
		}
		else if (a == 2)
		{
			app.printList();
		}
		else if (a == 3)
		{
			std::cout << "Enter product name\n";
			std::cin >> tmp1;
			std::cout << "Enter Price\n";
			std::cin >> tmp3;
			std::cout << "Enter count\n";
			std::cin >> tmp4;
			std::cout << "Enter category\n";
			std::cin >> tmp2;
			app.addProduct(tmp1, tmp3, tmp4, tmp2);
			system("cls");
		}
		else if (a == 4)
		{
			app.printProductList();
		}
		else if (a == 0)
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