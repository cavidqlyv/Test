#include <iostream>

template<typename T>
class Number;

template<>
class Number<int>
{
	int num;
public:
	Number(int n)
	{
		num = n;
	}
	int operator % (Number  nNum)
	{
		return num % nNum.num;
	}
};

template<>
class Number<double>
{
	double num;
public:
	Number(int n)
	{
		num = n;
	}
	int operator % (Number  nNum)
	{
		return std::fmod(num, nNum.num);
	}
};