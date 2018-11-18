#include <iostream>
#include "container.cpp"

int main()
{
	int id = 0;
	Greater greater;
	Less less;

	Container<char, Greater> container('b');
	container.push('a', greater);
	container.push('c', greater);

	Container<int, Less> container1(6);

	container1.push(7, less);
	container1.push(8, less);
	container1.push(9, less);
	container1.push(5, less);
	container1.push(4, less);
	container1.push(3, less);
	container1.push(2, less);
	container1.push(1, less);
	container1.push(10, less);

	std::cout << "\n====================================================================\n\n";
	container1.print();

	std::cout << "\n====================================================================\n\n";

	container1[2] = 200;

	container.print();
	std::cout << "\n====================================================================\n\n";

	std::cout << "container1[2] = 200; \n";
	container1.print();
	std::cout << "\n====================================================================\n\n";

	std::cout << container.size() << " Byte\n";
	std::cout << container1.size() << " Byte\n";

	Container<int, Less> container2(6);
	Container<int, Less> container3(6);

	Container<char, Less> container4('b');
	Container<char, Less> container5('b');
	Container<char, Less> container6('b');

	std::cout << "Container<char> container('b');\t" << container.getId() << '\n';
	std::cout << "Container<int> container1(6);\t" << container1.getId() << '\n';
	std::cout << "Container<int> container2(6);\t" << container2.getId() << '\n';
	std::cout << "Container<int> container3(6);\t" << container3.getId() << '\n';
	std::cout << "Container<char> container4('b');\t" << container4.getId() << '\n';
	std::cout << "Container<char> container5('b');\t" << container5.getId() << '\n';
	std::cout << "Container<char> container6('b');\t" << container6.getId() << '\n';
	std::cout << "\n====================================================================\n\n";

	Container<Container<int, Less>, Greater> container7(container1);
	container7.push(container2, greater);
	container7.push(container3, greater);
	std::cout << "\n====================================================================\n\n";

	container7.print();

	system("pause");
	return 0;
}