#include <iostream>
#include"arr.cpp"

void print(Arr & arr)
{
	int * tmpBuf = arr.getBuf();
	int tmpIndex = arr.getIndex();
	for (int i = 0; i < tmpIndex; i++)
	{
		std::cout << tmpBuf[i] << "\n";
	}
}


int main()
{
	Arr arr(5);

	arr.push(10);
	arr.push(20);
	arr.push(30);
	arr.push(40);
	arr.push(50);
	arr.push(60);
	arr.push(70);
	arr.push(80);
	arr.push(90);

	arr.remove(1);

	std::cout << "arr[0] : " << arr[0] << '\n';
	std::cout << "arr :\n";
	print(arr);
	Arr arr1;
	arr1 = std::move(arr);
	std::cout << "\n\narr1 = std::move(arr):\n";

	print(arr1);

	Arr arr2 = std::move(arr1);
	std::cout << "\n\nArr arr2 = std::move(arr1) :\n";

	print(arr2);

	system("pause");
	return 0;
}