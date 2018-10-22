#include <iostream>
#include <iomanip>
#include "list.cpp"

template<typename T>
void printNode(const Node<T> * node)
{
	std::cout << "\n============================\n\n";
	std::cout << "Value : " << node->value << '\n';
	std::cout << "Id : " << node->id << '\n';
	std::cout << "\n============================\n\n";
}

int main()
{
	int a;
	List<int> * list = new List<int>(1);

	while (true)
	{
		std::cout << "Evvele 1\n";
		std::cout << "Axira 2\n";
		std::cout << "Add by Id 3\n";
		std::cout << "Find by value 4\n";
		std::cout << "Find by ID 5\n";
		std::cout << "Delete by vaule 6\n";
		std::cout << "First 7\n";
		std::cout << "Last 8\n";
		std::cout << "Size 9\n";
		std::cout << "Empty 10 \n";
		std::cout << "Next 11\n";
		std::cout << "Prev 12\n";
		std::cout << "Current 13\n";
		std::cout << "Pop Front 14\n";
		std::cout << "Pop Back 15\n";
		std::cin >> a;

		if (a == 1)
		{
			std::cout << "Enter Value\n";
			std::cin >> a;
			list->pushFront(a);
		}
		else if (a == 2)
		{
			std::cout << "Enter Value\n";
			std::cin >> a;

			list->pushBack(a);
		}
		else if (a == 3)
		{
			int id;
			std::cout << "Enter id\n";
			std::cin >> id;
			std::cout << "Enter Value\n";
			std::cin >> a;
			list->insertAfter(id, a);
		}
		else if (a == 4)
		{
			std::cout << "Enter Value\n";
			std::cin >> a;
			printNode(list->findByValue(a));
		}
		else if (a == 5)
		{
			std::cout << "Enter id\n";
			std::cin >> a;
			printNode(list->findById(a));
		}
		else if (a == 6)
		{
			std::cout << "Enter Value\n";
			std::cin >> a;
			list->removeByVaule(a);
		}
		else if (a == 7)
			printNode(list->first());
		else if (a == 8)
			printNode(list->last());
		else if (a == 9)
			std::cout << "Size : " << list->size() << '\n';
		else if (a == 10)
			std::cout << std::boolalpha << list->empty() << '\n';
		else if (a == 11)
			list->next();
		else if (a == 12)
			list->prev();
		else if (a == 13)
			printNode(list->current());
		else if (a == 14)
			list->popFront();
		else if (a == 15)
			list->popBack();
		else if (a == 0) break;
		std::cout << "\n\n";
		list->printList();
	}
	delete list;
	system("pause");
	return 0;
}