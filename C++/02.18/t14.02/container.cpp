
template <typename T, typename T1>
class Container
{
public:
	class Value
	{
		T1 data;
		T key;
	public:
		Value() = default;
		template<typename ...Args>
		Value(T vKey, Args&&... args) : data(std::forward<Args>(args)...)
		{
			key = vKey;
		}
		Value(T vKey)
		{
			key = vKey;
		}
		T1& getData()
		{
			return data;
		}
		T getKey()
		{
			return key;
		}
	};
private:
	Value * value[10];
	int count = 0;
public:
	Container() = default;
	~Container()
	{
		for (int i = 0; i < count; i++)
		{
			delete value[i];
		}
	}
	template<typename ...Args>
	void add(T key, Args&&... args)
	{
		value[count++] = new Value(key, std::forward<Args>(args)...);
	}
	int size()
	{
		return count;
	}
	bool empty()
	{
		return count == 0;
	}
	T1 &operator[](T cKey)
	{
		for (int i = 0; i < count; i++)
			if (value[i]->getKey() == cKey)
				return value[i]->getData();
		value[count++] = new Value(cKey);
		return  value[count - 1]->getData();
	}
	int getCount()
	{
		return count;
	}
	T getKeyByIndex(int index)
	{
		if (index < count)
			return value[index]->getKey();
	}
	Value * getValue(int index)
	{
		if (index < count)
			return value[index];
	}
};