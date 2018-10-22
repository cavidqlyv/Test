#include <iostream>
#include <string>
#include "container.cpp"

template <typename T, typename T1>
void print(Container<T, T1> tmp)
{
	int count = tmp.getCount();
	T key;

	for (int i = 0; i < count; i++)
	{
		key = tmp.getKeyByIndex(i);
		std::cout << key << " : " << tmp[key] << '\n';
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