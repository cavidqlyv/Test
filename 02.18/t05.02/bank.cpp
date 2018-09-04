#include "queue.cpp"

class Bank
{
	Queue<User> * cash;
	Queue<User> * Operator;
public:
	void addCash(User & bUser , int priority)
	{
		cash->push(bUser , priority);
	}
	void addOperator(User &bUser , int priority)
	{
		Operator->push(bUser, priority);
	}
	void popCash()
	{
		cash->pop();
	}
	void popOperator()
	{
		Operator->pop();
	}
	void print()
	{
	//	Operator->printTest();
//		cash->printTest();
	}
};