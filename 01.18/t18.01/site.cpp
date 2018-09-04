#include "user.cpp"
class Site
{
	User *user[3];
	News* news[3];
	int userCount = 0;
	int newsCount = 0;
public:
	void addUser(char * uNane, char * uEmail)
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
	~Site()
	{
		for (int i = 0; i < userCount; i++)
			delete user[i];
		
	}
	void addNews(News * sNews)
	{
		news[newsCount++] = sNews;
		for (int i = 0; i < userCount; i++)
		{
			user[i]->accept(news[newsCount - 1]);
		}
	}
	void changeUserStat(bool flag, int index)
	{
		user[index]->setStat(flag);
	}
};