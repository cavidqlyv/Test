#include "news.h"
#include <cstring>

void  News::addNews(char * nTitle, char * nText)
{
	setTitle(nTitle);
	setText(nText);
}
News::~News()
{
	for (int i = 0; i < userCount; i++)
		delete user[i];
}
void  News::setTitle(char * nTitle)
{
	title = nTitle;
}
void  News::setText(char * nText)
{
	text = nText;
}
char * News::getTitle()
{
	return title;
}
char * News::getText()
{
	return text;
}
void  News::changeUserStat(bool flag, int index)
{
	user[index]->setStat(flag);
}
void  News::addUser(char * uNane, char * uEmail)
{
	for (int i = 0; i < userCount; i++)
	{
		if (strcmp(user[i]->getEmail(), uEmail) == 0)
			return;
	}
	user[userCount] = new User;
	user[userCount]->setName(uNane);
	user[userCount++]->setEmail(uEmail);
}