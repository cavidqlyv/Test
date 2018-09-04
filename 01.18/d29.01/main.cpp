#include <iostream>
#include "taskmanager.cpp"

void print(TaskManager * taskManager)
{
	int size = taskManager->getSize();
	for (int i = 0; i < size; i++)
	{
		Task * tmp = taskManager[i];
		std::cout << "Name : " << tmp->getName() << '\n';
		std::cout << "Priority" << tmp->getPriorty() << '\n';
	}
}

template<typename... T>
Task *  func(T&& ...arg)
{
	Task * tmp = new Task(std::forward<T>(arg...));
	return tmp;
}

int main()
{
	

	
	system("pause");
	return 0;
}
