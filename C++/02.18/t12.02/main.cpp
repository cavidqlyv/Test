#include <iostream>
#include "site.cpp"

int main()
{
	std::string loginTmp;
	std::string passTmp;
	std::string tmpText;
	std::string tmpTitle;
	Site site;
	std::string adminLog = "aaa";
	std::string adminPass = "bbb";
	site.addAdminUser(adminLog, adminPass);
	int a;
	while (1)
	{
		std::cout << "Enter Login : ";
		std::cin >> loginTmp;
		std::cout << "Enter Password : ";
		std::cin >> passTmp;
		std::cout << "Admin 1 , User 2";
		std::cin >> a;
		if (a == 1 && site.checkAdmin(loginTmp, passTmp))
		{
			std::cout << "Add user 1\n";
			std::cout << "Add news 2\n";
			std::cin >> a;
			if (a == 1)
			{
				std::cout << "Enter Login : ";
				std::cin >> loginTmp;
				std::cout << "Enter Password : ";
				std::cin >> passTmp;
				site.addUser(loginTmp, passTmp);
			}
			else
			{
				std::cout << "Enter title\n";
				std::cin >> tmpTitle;
				std::cout << "Enter text\n";
				std::cin >> tmpText;
				site.addNews(tmpTitle, tmpText);
			}
		}
		else if (a == 2 && site.checkUser(loginTmp, passTmp))
		{
			std::cout << "Enter title\n";
			std::cin >> tmpTitle;
			std::cout << "Enter text\n";
			std::cin >> tmpText;
			site.addNews(tmpTitle, tmpText);
		}

		std::cout << "Users :\n";
		site.showUsers();
		std::cout << "News :\n";
		site.showNews();
	}

	system("pause");
	return 0;
}