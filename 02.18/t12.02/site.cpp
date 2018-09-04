#include "user.cpp"
#include <string>
#include <iostream>
class Site
{
	User* user[3];
	AdminUser *adminUser;
	News* news[3];
	int userCount = 0;
	int newsCount = 0;
public:
	void addUser(std::string uName, std::string pass)
	{
		user[userCount] = new User;
		user[userCount]->setUsername(uName);
		user[userCount++]->setPassword(pass);
	}
	void addNews(std::string title, std::string text)
	{
		news[newsCount] = new News;
		news[newsCount]->setTitle(title);
		news[newsCount++]->setText(text);
	}
	~Site()
	{
		for (int i = 0; i < userCount; i++)
			delete user[i];
		for (int i = 0; i < newsCount; i++)
			delete news[i];
		delete adminUser;
	}
	void addAdminUser(std::string uName, std::string pass)
	{
		adminUser = new AdminUser;
		adminUser->setPassword(pass);
		adminUser->setUsername(uName);
	}
	bool checkAdmin(std::string uName, std::string pass)
	{
		if (uName == adminUser->getUsername() && pass == adminUser->getPassword())
			return true;
		return false;
	}
	bool checkUser(std::string uName, std::string pass)
	{
		for (int i = 0; i < userCount; i++)
			if (uName == user[i]->getUsername() && pass == user[i]->getPassword())
				return true;
		return false;
	}
	void showUsers()
	{
		for (int i = 0; i < userCount; i++)
		{
			std::cout << "Username : \n";
			std::cout << user[i]->getUsername() << '\n';
			std::cout << "Password : \n";
			std::cout << user[i]->getPassword() << '\n';
			std::cout << "\n========================================\n\n";
		}
	}
	void showNews()
	{
		for (int i = 0; i < newsCount; i++)
		{
			std::cout << "Title : \n";
			std::cout << news[i]->getTitle() << '\n';
			std::cout << "Text : \n";
			std::cout << news[i]->getText() << '\n';
			std::cout << "\n========================================\n\n";
		}
	}
	
};