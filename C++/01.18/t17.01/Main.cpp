#include <iostream>
#include "String.cpp"
#pragma warning(disable : 4996) 
int main()
{
	char tmp[10];
	String str;
	int key;
	String str1 = str;
	str1.print();
	
	while (1)
	{
		str.print();
		std::cout << "Press 1 for delete\nPress 2 for push back\n";
		std::cin >> key;
		if (key == 1)
			str.deleteString();
		else if (key == 2)
		{
			std::cin >> tmp;
			str.pushBack(tmp);
		}
	}
	system("pause");
	return 0;
}