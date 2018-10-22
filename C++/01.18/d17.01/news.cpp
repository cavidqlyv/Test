//#include <iostream>
//#include "user.h"
//
//class News
//{
//	char * title;
//	char * text;
//	User *user[3];
//	int userCount = 0;
//public:
//	void addNews(char * nTitle, char * nText)
//	{
//		setTitle(nTitle);
//		setText(nText);
//	}
//	~News()
//	{
//		for (int i = 0; i < userCount; i++)
//			delete user[i];
//	}
//	void setTitle(char * nTitle)
//	{
//		title = nTitle;
//	}
//	void setText(char * nText)
//	{
//		text = nText;
//	}
//	char * getTitle()
//	{
//		return title;
//	}
//	char *getText()
//	{
//		return text;
//	}
//	void changeUserStat(bool flag, int index)
//	{
//		user[index]->setStat(flag);
//	}
//	void addUser(char * uNane, char * uEmail)
//	{
//		for (int i = 0; i < userCount; i++)
//		{
//			if (strcmp(user[i]->setEmail, uEmail) == 0)
//				return;
//		}
//		user[userCount] = new User;
//		user[userCount]->setName(uNane);
//		user[userCount++]->setEmail(uEmail);
//	}
//};