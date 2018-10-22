#include <iostream>
#include <string>

namespace fArr
{

	struct OutOfException : std::exception
	{
		OutOfException(const char * reason) : std::exception(reason) {}
	};
	struct LimitException : std::exception
	{
		LimitException(const char * reason) : std::exception(reason) {}
	};

	template <typename T>
	class FixedArray
	{
		T value[2];
		int count = 0;
		int size;
	public:
		void add(T aValue)
		{
			if (count == size)
				throw LimitException("Limit exception");

			value[count++] = new T(aValue);
		}
		T & operator [] (int index)
		{
			if (count == size)
				throw OutOfException("Out of exception");

			return value[index];
		}
	};
}

int main()
{
	fArr::FixedArray<int> fixedArray(2);

	template <typename T>;
	try
	{

	}
	catch (const )
	{

	}


	system("pause");
	return 0;
}