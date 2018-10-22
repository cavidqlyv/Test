#pragma once
#include "user.h"

class News
{
	char * title;
	char * text;
	User *user[3];
	int userCount = 0;
public:
	void addNews(char * nTitle, char * nText);
	~News();
	void setTitle(char * nTitle);
	void setText(char * nText);
	char * getTitle();
	char *getText();
	void changeUserStat(bool flag, int index);
	void addUser(char * uNane, char * uEmail);
};
