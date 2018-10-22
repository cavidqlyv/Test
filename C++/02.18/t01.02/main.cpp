#include<iostream>
#include <iomanip>
#include "stack.cpp"

template <typename T>
void printStack(Stack<T> &stack)
{
	while (1)
	{
		if (stack.getExpired())
		std::cout << stack.top() << '\t';
		else std::cout << "Error!\n";
		if (stack.empty()) break;
		stack.pop();
	}
	std::cout << "\n";
}


int main()
{
	Stack<int> stack;

	int num1 = 1;
	int num2 = 2;
	int num3 = 3;
	int num4 = 4;
	int num5 = 5;
	int num6 = 6;
	int num7 = 7;

	stack.emplace(num1);
	stack.emplace(num2);
	stack.emplace(num3);
	stack.emplace(num4);
	stack.emplace(num5);

	std::cout << stack.top() << '\n';

	std::cout << "\n\n";

	std::cout << stack.size() << '\n';


	std::cout << "\n\n";
	std::cout << stack.size() << '\n';


	std::cout << std::boolalpha << stack.empty() << '\n';


	stack.printTest();

	Stack<int> stack1;

	stack1.emplace(num1);
	stack1.emplace(num2);
	stack1.emplace(num3);
	stack1.emplace(num4);
	stack1.emplace(num5);

	stack.pop();

	std::cout << "(stack1 == stack ) : " << (stack1 == stack) << '\n';
	std::cout << "(stack1 != stack ) : " << (stack1 != stack) << '\n';


	//stack.swap(stack1);


	std::cout << "\n\n";

	stack.printTest();
	std::cout << "\n\n";

	stack1.setExpired();

	std::cout << "--------------------------------------\n";

	stack1.printTest();
	std::cout << "--------------------------------------\n";

	printStack(stack1);

	system("pause");
	return 0;
}