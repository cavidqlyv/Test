#include"task.cpp"
#include <string>

class TaskManager
{
	Task * task[10];
	int count = 0;
public:
	void createTask(Task * tTask)
	{
		task[count++] = tTask;
		sort();
	}
	void exec(std::string name)
	{
		for (int i = 0; i < count; i++)
			if (name == task[i]->getName())
				task[i]->run();
	}
	void remove(std::string name)
	{
		int index;
		int a = 0;
		bool flag = true;
		for (int i = 0; i < count; i++)
		{
			if (name == task[i]->getName())
			{
				index = i;
				flag = true;
				break;
			}
			else flag = false;
		}
		if (!flag) return;
		for (int i = 0; i < count; i++)
		{
			if (i == index)
				continue;
			task[a++] = task[i];
		}
	}
	int getSize()
	{
		return count;
	}
	Task * operator[] (std::size_t i)
	{
		return task[i];
	}
	void sort()
	{
		for (int i = 0; i < count; i++)
			for (int j = 0; j < count; j++)
				if (task[i]->getPriorty() >task[j]->getPriorty())
					std::swap(task[i], task[j]);
	}
};


