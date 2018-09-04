#include "node.cpp"

template <typename T>
class MemoryPool
{
	Node<T>** reserv;
	int count = -1;
public:
	~MemoryPool()
	{
		 
		for (int i = count; i >= 0; i--)
			delete reserv[i];
		delete reserv;
	}
	void add(int mCount)
	{
		if (count == 0)
		{
			reserv = new Node<T>*[mCount];
			for (int i = 0; i < mCount; i++)
				reserv[i] = new Node<T>;
			count = mCount;
		}
	}
	Node<T> * getMemory()
	{
		return reserv[--count];
	}
	int getCount()
	{
		return count;
	}
};