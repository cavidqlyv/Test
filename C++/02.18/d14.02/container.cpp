#include "list.cpp"


template <typename T, typename T1>
class Container
{
private:
	List<T, T1> * list[10];
	int count = 0;
public:
	Container()
	{
		for (int i = 0; i < 10; i++)
			list[i] = nullptr;
	}
	~Container()
	{
		for (int i = 0; i < count; i++)
		{
			if (list[i])
				delete list[i];
		}
	}
	template<typename ...Args>
	void add(T key, Args&&... args)
	{
		std::hash<T> hashFunction;
		int index = hashFunction(key) % 10;
		if (!list[index])
		{
			list[index] = new List<T, T1>(key, std::forward<Args>(args)...);
			count++;
		}
		else
		{
			List<T, T1> * current = list[index];
			while (current->next)
				current = current->next;
			current->next = new List<T, T1>(key, std::forward<Args>(args)...);
		}
	}
	bool empty()
	{
		return count == 0;
	}
	T1 &operator[](T cKey)
	{
		std::hash<T> hashFunction;
		int index = hashFunction(cKey) % 10;
		List<T, T1> * current = list[index];
		while (current)
		{
			if (current->key == cKey)
				return current->value;
			current = current->next;
		}
	}
	List<T, T1> * getList(int index)
	{
		return list[index];
	}
	//int getCount()
	//{
	//	return count;
	//}
};