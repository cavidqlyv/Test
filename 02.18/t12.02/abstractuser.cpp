#include "userinterface.cpp"
#include <string>
class AbstractUser : public UserInterface
{
	std::string username;
	std::string password;
	
public:
	void setPassword(std::string pass)
	{
		password = pass;
	}
	void setUsername(std::string name)
	{
		username = name;
	}
	std::string& getPassword()
	{
		return password;
	}
	std::string& getUsername()
	{
		return username;
	}
};