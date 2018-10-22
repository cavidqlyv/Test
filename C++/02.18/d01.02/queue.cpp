#include <iostream>
#include "variable.cpp"
template <typename T>
class Queue
{
	Variable<T> * variable[20];
	int count = 0;
public:
	T  front()
	{
		int tmp = variable[0]->getPriority();
		int tmpIndex = 0;
		for (int i = 0; i < count; i++)
		{
			if (tmp > variable[i]->getPriority())
			{
				tmp = variable[i]->getPriority();
				tmpIndex = i;
			}
		}
		return variable[tmpIndex]->getValue();
	}
	T back()
	{
		return variable[count - 1]->getValue();
	}
	~Queue()
	{
		for (int i = 0; i < count; i++)
			delete variable[i];
	}
	void push(T qData, int qPrioriy)
	{
		variable[count] = new Variable<T>;
		variable[count]->setValue(qData);
		variable[count++]->setPriority(qPrioriy);
	}
	bool empty()
	{
		return count == 0;
	}
	int size()
	{
		return count;
	}
	void pop()
	{
		int tmp = variable[0]->getPriority();
		int tmpIndex = 0;
		for (int i = 0; i < count; i++)
		{
			if (tmp > variable[i]->getPriority())
			{
				tmp = variable[i]->getPriority();
				tmpIndex = i;
			}
		}
		delete variable[tmpIndex];
		tmp = 0;
		for (int i = 0; i < count; i++)
		{
			if (i == tmpIndex)continue;
			variable[tmp++] = variable[i];
		}
		count--;
	}
	void printTest()
	{
		for (int i = 0; i < count; i++)
			std::cout << variable[i]->getValue() << '\t';
	}
};