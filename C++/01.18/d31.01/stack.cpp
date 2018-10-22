#include <iostream>

template<typename T>
class Stack
{
	T data[20];
	int count = -1;
public:
	Stack() = default;
	Stack(const T& sData)
	{
		data[++count] = sData;
	}
	Stack(T&& sData)
	{
		data[++count] = sData;
	}
	Stack(Stack&& sStack)
	{
		count = sStack.count;
		for (int i = 0; i < count; i++)
			data[i] = sStack.data[i];
	}
	Stack& operator = (Stack&& sStack)
	{
		count = sStack.count;
		for (int i = 0; i < count; i++)
			data[i] = sStack.data[i];
		return *this;
	}
	template<typename ...Args>
	void emplace(Args&&... args)
	{
		data[++count] = T(std::forward<Args>(args)...);
	}
	T& top()
	{
		return data[count];
	}
	void pop()
	{
		//delete T[count - 1];
		//T[count - 1] = nullptr;
		count--;
	}
	void swap(Stack & sStack)
	{
		std::swap(sStack, *this);
	}
	int size()
	{
		return count ;
	}
	//int getCount()
	//{
	//	return count;
	//}
	//T getData(int index)
	//{
	//	return data[index];
	//}
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
				if (data != sStack.data) return true;
			return false;
		}
		return true;
	}
	bool operator == (const Stack& sStack) const
	{
		if (count == sStack.count)
		{
			for (int i = 0; i < count; i++)
				if (data != sStack.data) return false;
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
			std::cout << data[i] << '\n';
	}

};