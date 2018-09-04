#include <iostream>
#include <string>
#include "container.cpp"

template <typename T, typename T1>
void print(Container<T, T1>& tmp)
{
	//typename Container<T, T1>::Value * tmp1 = nullptr;
	int count = 10;
	T key;

	for (int i = 0; i < count; i++)
	{
		List<T, T1>* tmp1 = tmp.getList(i);
		while (tmp1)
		{
			std::cout << "Key : " << tmp1->key << '\n';
			std::cout << "Value : " << tmp1->value << '\n';
			tmp1 = tmp1->next;
		}
	}
}


int main()
{

	Container<std::string, int> test;

	
	//int * a = new int(123);
	test.add("ccc", 111);
	test.add("ccc", 222);
	test.add("eee", 333);

	std::cout << test["aaa"] << '\n';

	print(test);

	system("pause");
	return 0;
}