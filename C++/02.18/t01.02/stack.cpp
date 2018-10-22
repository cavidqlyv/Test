#include <iostream>
#include "variable.cpp"

template<typename T>
class Stack
{
	Variable<T> variable[20];
	int count = -1;
public:
	Stack() = default;
	Stack(const T& sData)
	{
		variable[++count].setValue(sData);
	}
	Stack(T&& sData)
	{
		variable[++count].setValue(sData);
	}
	Stack(Stack&& sStack)
	{
		count = std::move(sStack.count);
	}
	Stack& operator = (Stack&& sStack)
	{
		count = sStack.count;
		for (int i = 0; i < count; i++)
			variable[i].setValue(sStack.variable[i].getValue());
		return *this;
	}
	template<typename ...Args>
	void emplace(Args&&... args)
	{
		variable[++count].setValue(T(std::forward<Args>(args)...));
	}
	T top()
	{
			return variable[count].getValue();
	}
	void pop()
	{
		variable[count].setExpired(false);
		count--;
	}
	void swap(Stack & sStack)
	{
		std::swap(sStack, *this);
	}
	int size()
	{
		return count;
	}
	bool empty()
	{
		if (count == 0) return true;
		return false;
	}
	bool operator != (const Stack& sStack) const
	{
		if (count == sStack.count)
		{
			for (int i = 0; i < count; i++)
				if (variable[i].getValue() != sStack.variable[i].getValue()) return true;
			return false;
		}
		return true;
	}
	bool operator == (const Stack& sStack) const
	{
		if (count == sStack.count)
		{
			for (int i = 0; i < count; i++)
				if (variable[i].getValue() != sStack.variable[i].getValue()) return false;
			return true;
		}
		return false;
	}
	operator bool() const
	{
		return count != 0;
	}
	void printTest()
	{
		for (int i = 0; i <= count; i++)
			std::cout << variable[i].getValue() << '\n';
	}
	void setExpired()
	{
		variable[count].setExpired(false);
	}
	bool getExpired()
	{
		return (variable[count]);
	}
};