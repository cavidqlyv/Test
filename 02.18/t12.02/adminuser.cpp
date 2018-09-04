#include "abstractuser.cpp"
#include <string>

class AdminUser :public AbstractUser
{
public:
	void showMenu()
	{
		std::cout << "Add news\n";
		std::cout << "Add user\n";
	}
};