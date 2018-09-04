#include <string>

template <typename T , typename T1>
struct List
{
	T key;
	T1 value;
	List * next = nullptr;
	template<typename ...Args>
	List(T vKey, Args&&... args) : value(std::forward<Args>(args)...)
	{
		key = vKey;
	}
};