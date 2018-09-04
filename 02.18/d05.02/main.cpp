#include <iostream>
#include <string>
#include "circularQueue.cpp"
int main()
{
	CircularQueue<int> queue(6);

	int * num1 = new int(1);
	int * num2 = new int(2);
	int * num3 = new int(3);
	int * num4 = new int(4);
	int * num5 = new int(5);
	int * num6 = new int(6);
	int * num7 = new int(7);
	int * num8 = new int(8);
	int * num9 = new int(9);

	queue.add(num1);
	queue.add(num2);
	queue.add(num3);
	queue.add(num4);
	queue.add(num5);

	std::cout << "Top : " << queue.top() << "\n";

	//queue.next();

	std::cout << "Top : " << queue.top() << '\n';

	//queue.pop();

	queue.print();

	queue.resize(4);

	std::cout << "\n===================================================\n\n";

	//queue.add(num6);
	//queue.add(num7);



	for (int i = 0; i < 10; i++)
	{
		std::cout << queue.top() << '\n';
		queue.next();
	}

	queue.turn();

	std::cout << "\n===================================================\n\n";

	queue.print();

	queue.shake();

	std::cout << "\n===================================================\n\n";

	queue.print();


	system("pause");
	return 0;
}