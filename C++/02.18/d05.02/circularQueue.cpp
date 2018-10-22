#include <iostream>
#include <time.h>
#include <cstdlib>
template<typename T>
class CircularQueue
{
	T **data;
	int count = 0;
	int front = 0;
	int size;
public:
	CircularQueue(int cSize)
	{
		size = cSize;
		data = new T*[size];
	}
	~CircularQueue()
	{
		for (int i = 0; i < count; i++)
			delete data[i];
		delete data;
	}
	void add(T* cData)
	{
		if (count < size)
		{
			data[count] = new T;
			data[count++] = cData;
		}
		else
		{
			delete data[--count];
			data[count] = cData;
		}
	}
	T& top()
	{
		return*data[front];
	}
	void next()
	{
		front++;
		if (front == count)
			front = 0;
	}
	bool empty()
	{
		return count == 0;
	}
	void pop()
	{
		int tmp = 0;
		delete data[front];
		for (int i = 0; i < count; i++)
		{
			if (i == front) continue;
			data[tmp++] = data[i];
		}
		data[count - 1] = nullptr;
		count--;
	}
	void print()
	{
		for (int i = 0; i < count; i++)
			std::cout << *data[i] << '\n';
	}
	void resize(int qSize)
	{
		size = qSize;
		int tmp1 = 0;
		T** tmp = new T*[qSize];
		for (int i = 0; i < count; i++)
		{
			if (i < qSize)
				tmp[tmp1++] = data[i];
			else
				delete data[i];
		}
		count = tmp1;
		delete data;
		data = nullptr;
		data = tmp;
		front = 0;
	}
	void turn()
	{
		T** tmp = new T*[size];
		int tmp1 = 0;
		for (int i = count-1; i >= 0; i--)
			tmp[tmp1++] = data[i];
		delete data;
		data = nullptr;
		data = tmp;
	}
	void shake()
	{
		srand(time(NULL));
		T** tmp = new T*[size];
		int tmp1 = 0;
		bool flag = true;
		int *arr = new int[count];
		int tmp2 = 0;
		int tmp3;
		for (int i = 0; i < count; i++)
		{
			flag = true;
			tmp3 = (rand() % 5)-1;
			for (int j = 0; j < tmp2; j++)
			{
				if (tmp3 == arr[j])
				{
					i--;
					flag = false;
					break;
				}
			}
			if (flag)
			{
			arr[tmp2++]= tmp3;
			tmp[tmp1++] = data[tmp3];
			}
		}
		delete[] arr;
		delete data;
		data = nullptr;
		data = tmp;
	}
};