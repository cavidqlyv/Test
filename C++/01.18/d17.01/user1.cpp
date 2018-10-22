#include "user.h"
#include <iostream>

char* User::getName()
{
	return name;
}
char * User::getEmail()
{
	return email;
}
void User::setName(char * uName)
{
	name = uName;
}
void User::setEmail(char * uEmail)
{
	email = uEmail;
}
void User::setStat(bool uStat)
{
	stat = uStat;
}
bool User::getStat()
{
	return stat;
}
void User::accept(News *news)
{
	if (stat)
		printNews(news);
}
void User::printNews(News *news)
{
	std::cout << "Title : " << news->getTitle() << "\n";
	std::cout << "Text : " << news->getText() << "\n";
}