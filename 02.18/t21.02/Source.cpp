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

	template <typename T, size_t Tsize>
	class FixedArray
	{
		T ** value;
		int count = 0;
		int size;
	public:
		FixedArray()
		{
			size = Tsize;
			value = new T*[Tsize];
		}
		~FixedArray()
		{
			for (int i = 0; i < Tsize; i++)
				delete value[i];
			delete[] value;
		}
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

			return *value[index];
		}
	};
}

int main()
{
	fArr::FixedArray<int, 2> fixedArray;

	fixedArray.add(5);
	fixedArray.add(5);

	for (int i = 0; i < 2; i++)
	{
		try
		{
			if (i == 0)
				std::cout << fixedArray[3] << '\n';
			if (i == 1)
				fixedArray.add(5);
		}
		catch (const std::exception& e)
		{
			std::cout << e.what() << '\n';
		}
	}

	system("pause");
	return 0;
}