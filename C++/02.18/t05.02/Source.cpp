#include <iostream>
#include <string>

class User
{
	std::string name;
public:
	User() = default;
	User(std::string uName)
	{
		name = uName;
	}
	std::string getName() const
	{
		return name;
	}
};

template <typename T>
class Variable
{
	T value;
	int priority;
public:
	Variable() = default;
	void setValue(T vValue)
	{
		value = vValue;
	}
	void setPriority(int vPriority)
	{
		priority = vPriority;
	}
	T getValue() const
	{
		return value;
	}
	int getPriority()
	{
		return priority;
	}
};

std::ostream& operator << (std::ostream& os, const User& user)
{
	os << user.getName();
	return os;
}

template <typename T>
class Queue
{
	Variable<T>  variable[20];
	int count = 0;
public:
	Queue() = default;
	T  front()
	{
		int tmp = variable[0].getPriority();
		int tmpIndex = 0;
		for (int i = 0; i < count; i++)
		{
			if (tmp > variable[i].getPriority())
			{
				tmp = variable[i].getPriority();
				tmpIndex = i;
			}
		}
		return variable[tmpIndex].getValue();
	}
	T back()
	{
		return variable[count - 1].getValue();
	}
	//~Queue()
	//{
	//	for (int i = 0; i < count; i++)
	//		delete variable[i];
	//}
	void push(T& qData, int qPrioriy)
	{
		//variable[count] = new Variable<T>;
		variable[count].setValue(qData);
		variable[count++].setPriority(qPrioriy);
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
		int tmp = variable[0].getPriority();
		int tmpIndex = 0;
		for (int i = 0; i < count; i++)
		{
			if (tmp > variable[i].getPriority())
			{
				tmp = variable[i].getPriority();
				tmpIndex = i;
			}
		}
		//delete variable[tmpIndex];
		tmp = 0;
		for (int i = 0; i < count; i++)
		{
			if (i == tmpIndex) continue;
			variable[tmp++] = variable[i];
		}
		count--;
	}
	void printTest()
	{
		for (int i = 0; i < count; i++)
			std::cout << variable[i].getValue() << '\t';
	}
};

class Bank
{
	Queue<User>  cash;
	Queue<User>  Operator;
public:
	Bank() = default;
	void addCash(User & bUser, int priority)
	{
		cash.push(bUser, priority);
	}
	void addOperator(User &bUser, int priority)
	{
		Operator.push(bUser, priority);
	}
	void popCash()
	{
		cash.pop();
	}
	void popOperator()
	{
		Operator.pop();
	}
	void print()
	{
		Operator.printTest();
		cash.printTest();
	}
};

int main()
{
	std::string user1Name = "aaaa";
	std::string user2Name = "bbbb";
	std::string user3Name = "cccc";
	std::string user4Name = "dddd";
	std::string user5Name = "eeee";

	User user1(user1Name);
	User user2(user2Name);
	User user3(user3Name);
	User user4(user4Name);
	User user5(user5Name);

	Bank bank;

	bank.addCash(user1, 1);
	bank.addCash(user2, 1);
	bank.addCash(user3, 1);

	bank.print();

	system("pause");

	return 0;
}