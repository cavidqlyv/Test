#pragma once
#include "news.h"

class User
{
	char * name;
	char * email;
	bool stat = true;
public:
	char * getName();
	char * getEmail();
	void setName(char * uName);
	void setEmail(char * uEmail);
	void setStat(bool uStat);
	bool getStat();
	void accept(News *news);
	void printNews(News *news);
};