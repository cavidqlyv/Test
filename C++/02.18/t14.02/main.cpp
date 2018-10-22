#include <iostream>
#include <string>
#include "container.cpp"

template <typename T, typename T1>
void print(Container<T, T1>& tmp)
{
	typename Container<T, T1>::Value * tmp1 = nullptr;
	int count = tmp.getCount();
	T key;

	for (int i = 0; i < count; i++)
	{
		tmp1 = tmp.getValue(i);
		std::cout << tmp1->getKey() << " : ";
		std::cout << tmp1->getData() << '\n';
	}
}


int main()
{

	Container<std::string, int> test;

	test.add("aaa", 123);
	test["aaa"] = 789;
	//int * a = new int(123);
	std::cout << test["aaa"] << '\n';

	print(test);

	system("pause");
	return 0;
}