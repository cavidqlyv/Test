#include "adminuser.cpp"
#include <iostream>
class User :public AbstractUser
{
	News* news[10];
	int count = 0;
public:
	void addNews(News *uNews)
	{
		news[count++] = uNews;
	}
	News * getNews(int index)
	{
		if (index < count)
			return news[index];
	}
	void showMenu()
	{
		std::cout << "Add news\n";
	}
};