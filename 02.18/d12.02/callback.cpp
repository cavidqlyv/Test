#include <string>

struct SearchByName
{
	bool operator () (std::string a, std::string b)
	{
		return a == b;
	}
};