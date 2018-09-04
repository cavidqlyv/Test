#include <string>

class User
{
	std::string name;
public:
	User(std::string uName)
	{
		name = uName;
	}
	std::string getName() const
	{
		return name;
	}
};