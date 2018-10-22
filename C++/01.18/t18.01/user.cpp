#include <iostream>
#include "news.cpp"

class User
{
	char * name;
	char * email;
	bool stat = true;
public:
	char * getName()
	{
		return name;
	}
	char * getEmail()
	{
		return email;
	}
	void setName(char * uName)
	{
		name = uName;
	}
	void setEmail(char * uEmail)
	{
		email = uEmail;
	}
	void setStat(bool uStat)
	{
		stat = uStat;
	}
	bool getStat()
	{
		return stat;
	}
	void accept(News *news)
	{
		if (stat)
			printNews(news);
	}
	void printNews(News *news)
	{
		std::cout << "New mail " << getName() << "\n";
		std::cout << "Title : " << news->getTitle() << "\n";
		std::cout << "Text : " << news->getText() << "\n";
	}
};