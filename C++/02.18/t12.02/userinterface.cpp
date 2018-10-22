#include <string>
#include "news.cpp"

struct UserInterface
{
	virtual void setPassword(std::string) = 0;
	virtual void setUsername(std::string) = 0;
	virtual std::string& getPassword() = 0;
	virtual std::string& getUsername() = 0;
};