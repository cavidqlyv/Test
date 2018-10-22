#include <iostream>
#include"arr.cpp"

int main()
{
	Arr arr(5);

	arr.push(10);
	arr.push(20);
	arr.push(30);

	arr.remove(0);

	std::cout << arr[0] << "\n";
	std::cout << arr[1] << "\n";
	std::cout << arr[2] << "\n";

	Arr arr1 = std::move(arr);

	system("pause");
	return 0;
}