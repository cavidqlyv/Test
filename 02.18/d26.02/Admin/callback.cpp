#include "message.cpp"

struct All
{
	bool operator () (int a, int b, int c)
	{
		return true;
	}
};

struct Sort
{
	bool operator () (int a, int b, int c)
	{
		if (a <= c && c <= b)
			return true;
		return false;
	}
};