#include <string>

template <typename T>
class Variable
{
	T value;
	bool expired= true;
public:
	Variable() = default;
	void setValue(T vValue)
	{
		value = vValue;
	}
	void setExpired(bool vExpired)
	{
		expired = vExpired;
	}
	T getValue() const
	{
		return value;
	}
	bool getExpired()
	{
		return expired;
	}
	operator bool() const
	{
		return expired;
	}
};