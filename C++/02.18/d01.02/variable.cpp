template <typename T>
class Variable
{
	T value;
	int priority;
public:
	Variable() = default;
	void setValue(T vValue)
	{
		value = vValue;
	}
	void setPriority(int vPriority)
	{
		priority = vPriority;
	}
	T getValue() const
	{
		return value;
	}
	int getPriority()
	{
		return priority;
	}
};