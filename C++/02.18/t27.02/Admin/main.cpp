#include <iostream>
#include <string>
#include <time.h>
#include "app.cpp"

void printTask(App &app)
{
	Node<Task> * tmp;
	"\n\n=========================== TASK ==========================\n\n\n";
	size_t size = app.getTaskCount();
	for (int i = 0; i < size; i++)
	{
		tmp = app.getTask(i);
		std::cout << "\n\nPriority " << i + 1 << " : \n\n";
		while (tmp)
		{
			std::cout << "Name : " << tmp->value->getName() << '\n';
			std::cout << "Deadline : " << tmp->value->getDeadline() << '\n';
			tmp = tmp->next;
		}
	}
}

template<typename T>
void printProduct(App & app, T callback, int a = 0, int b = 0)
{
	Node<Product> *tmp;
	size_t size = app.getProductCount();
	std::cout << "\n\n=========================== PRODUCT ==========================\n\n\n";
	for (int i = 0; i < size; i++)
	{
		tmp = app.getProduct(i);
		if (i == 0)
			std::cout << "\n\nPhone : \n\n";
		else if (i == 1)
			std::cout << "\n\TV : \n\n";
		while (tmp)
		{

			if (callback(a, b, tmp->value->getPrice()))
			{
				std::cout << "Name : " << tmp->value->getName() << '\n';
				std::cout << "Price : " << tmp->value->getPrice() << '\n';
				std::cout << "Count : " << tmp->value->getCount() << '\n';
			}
			tmp = tmp->next;
		}
	}
}

int main()
{

	App app;
	int a;

	All all;
	Sort sort;

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
		std::cout << "Search product 5\n";
		std::cout << "Add message 6\n";
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
			printTask(app);
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
			printProduct(app, all);
		}
		else if (a == 5)
		{
			std::cout << "Enter price\n";
			std::cin >> tmp3;
			std::cout << "Enter price\n";
			std::cin >> tmp4;
			printProduct(app, sort, tmp3, tmp4);
		}
		else if (a == 6)
		{
			std::cout << "Enter name\n";
			std::cin >> tmp1;
			std::cout << "Enter content\n";
			std::cin >> tmp2;
			app.addMessage(tmp1, tmp2);
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