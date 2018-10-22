class Less
{
public:
	template<typename T>
	bool operator () (T a, T b) const
	{
		return a > b;
	}
};

class Greater
{
public:
	template<typename T>
	bool operator () (T a, T b) const
	{
		return a < b;
	}
};