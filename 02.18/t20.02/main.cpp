#include <iostream>
#include <string>

template <typename T>
class Container
{
	T * value[10];
	bool source[10];
	int count = 0;
	Container * copy = nullptr;
public:
	Container() = default;
	~Container()
	{
		for (int i = 0; i < count; i++)
		{
			if (source[i])
			{
				if (copy)
					copy->changeStat(i);
				delete value[i];
			}
		}
	}
	template<typename ...Args>
	void add(Args&&... args)
	{
		source[count] = true;
		value[count++] = new T (std::forward<Args>(args)...);
	}
	void modify(int index, T cValue)
	{
		if (!(index < count)) return;
		source[index] = true;
		value[index] = new T(cValue);
	}
	T &operator[](int index)
	{
		return *value[index];
	}
	int getCount()
	{
		return count;
	}
	void print()
	{
		for (int i = 0; i < count; i++)
		{
			std::cout << *value[i] << '\n';
		}
	}
	void changeStat(int index)
	{
		if (!source[index])
		{
			T * tmp = new T(*value[index]);
			value[index] = tmp;
			source[index] = true;
		}
	}
	Container<T>(Container<T>& container)
	{
		count = container.getCount();
		for (int i = 0; i < count; i++)
		{
			value[i] = &container[i];
			source[i] = false;
		}
		container.copy = this;
	}
	Container<T>& operator = (Container<T>& container)
	{
		count = container.getCount();
		for (int i = 0; i < count; i++)
		{
			value[i] = &container[i];
			source[i] = false;
		}
		container.copy = this;
		return *this;
	}
};

int main()
{
	Container<int> c1;

	c1.add(5);
	c1.add(6);

	Container<int> c2;
	c2 = c1;

	c1.modify(1, 8);
	c2.modify(1, 15);

	std::cout << "C1 : \n";
	c1.print();
	std::cout << "C2 : \n";
	c2.print();

	system("pause");
	return 0;
}