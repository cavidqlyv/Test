#include <iostream>
#include <string>

/*
struct DivisionByOdd : std::exception
{
	DivisionByOdd(const char * reason) : std::exception(reason){}
};

class Number
{
	int a;

public:
	Number() = default;
	Number(int num1)
	{
		a = num1;
	}
	Number operator / (const Number& num) const
	{
		if (num.a == 0)
			throw std::exception("Division by zero condition!");
		if (num.a % 2 != 0)
			throw DivisionByOdd("Division By Odd!");


		return Number(a / num.a);
	}
	int GetNum()
	{
		return a;
	}
};


int main()
{
	Number a(5);
	Number b(1);

	try
	{
		Number c = a / b;
		std::cout <<c.GetNum() << '\n';
	}
	catch (std::exception& e)
	{
		std::cout << e.what() << '\n';
	}
	catch (DivisionByOdd& e)
	{
		std::cout << e.what() << '\n';
	}


	system("pause");
	return 0;
}
*/

template <typename T , typename T1>
class FixedArray 
{
	T** elements;
	T1 size;
	int count = 0;
public:
	FixedArray(T1 aSize)
	{
		size = aSize;
		elements = new T*[size];
	}
	~FixedArray()
	{
		for (int i = 0; i < count; i++)
			delete elements[i];
		delete[] elements;
	}
	void add(T num)
	{
		if (count  == size)
		throw std::out_of_range("Out of range");
		elements[count] = new T;
		*elements[count++] = num;
	}
	T &operator[](int index)
	{
		if (index >= count)
			throw std::out_of_range("Out of range");
		return *elements[index];
	}

};



int main()
{
	FixedArray<int, int> fixedArray(5);
	
	try
	{
		fixedArray.add(1);
		fixedArray.add(2);
		fixedArray.add(3);
		fixedArray.add(4);
		fixedArray.add(5);
		fixedArray.add(6);

	}
	catch (std::exception& e)
	{
		std::cout << e.what() << '\n';
	}
	
	//int * num1 = new int(1);


	/*
	
	try
	{
		fixedArray.add(1);
		fixedArray.add(2);
		fixedArray.add(3);
		std::cout << fixedArray[4] << '\n';
	}
	catch (std::exception& e)
	{
		std::cout << e.what() << '\n';
	}
	*/
	system("pause");
	return 0;
}