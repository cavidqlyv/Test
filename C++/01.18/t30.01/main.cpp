#include <iostream>
#include "taskmanager.cpp"

void print(TaskManager * taskManager)
{
	int size = taskManager->getSize();
	std::cout << "\n==============================================================\n\n";
	for (int i = 0; i < size; i++)
	{
		Task * tmp = (*taskManager)[i];
		std::cout << "Name : " << tmp->getName() << '\n';
		std::cout << "Priority : " << tmp->getPriorty() << '\n';
		if (tmp->getBackground()) std::cout << "Running\n";
		else std::cout << "Stoped\n";
		std::cout << "\n==============================================================\n\n";

	}
}

template<typename... T>
Task *  func(T&& ...arg)
{
	Task * tmp = new Task(std::forward<T>(arg)...);
	return tmp;
}

int main()
{
	std::string taskname1 = "aaaa";
	std::string taskname2 = "bbbb";
	std::string taskname3 = "cccc";
	std::string taskname4 = "dddd";
	std::string taskname5 = "eeee";


	int priorty1 = 2;
	int priorty2 = 3;
	int priorty3 = 3;
	int priorty4 = 3;
	int priorty5 = 3;



	Task* task1 = func(taskname1, priorty1);
	Task* task2 = func(taskname2, priorty2 , true);
	Task* task3 = func(taskname3, priorty3);
	Task* task4 = func(taskname4, priorty4 , true);
	Task* task5 = func(taskname5, priorty5);



	TaskManager *taskManager  = new TaskManager;
	taskManager->createTask(task1);
	taskManager->createTask(task2);
	taskManager->createTask(task3);
	taskManager->createTask(task4);
	taskManager->createTask(task5);

	print(taskManager);


	delete task1;
	delete task2;
	delete task3;
	delete task4;
	delete task5;

	delete taskManager;
	
	system("pause");
	return 0;
}
