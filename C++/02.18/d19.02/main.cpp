#include <iostream>
#include <string>

template<typename T>
class Value
{
	T * value;
	bool flag = true;
public:
	void setFlag(bool a)
	{
		flag = a;
	}
	template<typename ...Args>
	void setValue(Args&&... args)
	{
		value = new T(std::forward<Args>(args)...);
	}
	bool getFalg()
	{
		return flag;
	}
	T getValue()
	{
		return value;
	}
};

template <typename T>
class Container
{
	Value<T> * value[10];
	int count = 0;
	bool flag = true;
public:
	Container() = default;
	//{
	//	for (int i = 0; i < 10; i++)
	//		value[i] = nullptr;
	//}
	~Container()
	{
		
		for (int i = 0; i < count; i++)
		{
			delete value[i];
		}
	}
	template<typename ...Args>
	void add(Args&&... args)
	{
		value[count] = new Value<T>;
		value[count]->setFlag(flag);
		value[count++]->setValue(std::forward<Args>(args)...);
	}
	void modify(int index, T cValue)
	{
		if (!(index < count)) return;
		value[count] = new Value<T>;
		value[count]->setFlag(flag);
		value[count++]->setValue(cValue);
	}
	Container<T> &operator[](int index)
	{
		return value[index]->getValue();
	}
	int getCount()
	{
		return count;
	}
	void print()
	{
		for (int i = 0; i < count; i++)
		{
			std::cout << value[i] << '\n';
		}
	}
	Container<T>(const Container<T>& user)
	{
		int count = user.getCount();
		for (int i = 0; i < count; i++)
		{
			value[i] = user[i];
		}
		flag = false;
	}

	//copy assignment operator
	Container<T>& operator = (const Container<T>& user)
	{
		int count = user.getCount();
		for (int i = 0; i < count; i++)
		{
			value[i] = user[i];
		}
		flag = false;
		return *this;
	}
};


int main()
{
	Container<int> c1;
	Container<int> c2;

	c1.add(5);
	c1.add(6);


	c2 = c1;
	int* num1 = new int(8);

	c1.modify(1, 8);
	//c1.modify(0, 5);


	std::cout << "C1 : \n";
	c1.print();
	std::cout << "C2 : \n";
	c2.print();

	system("pause");
	return 0;
}