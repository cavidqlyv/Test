#include <iostream>

class User
{
public:
	char name[10];
	int pass;

	void setpass(int data)
	{
		pass = data;
	}
	void printuser()
	{
		std::cout << "Name " << name << "\n";
		std::cout << "Password " << pass << "\n";
	}
	int  getpass()
	{
		return pass;
	}
};

void GetUser(User& user)
{
	int data;
	std::cout << "Name:\n";
	std::cin >> user.name;
	std::cout << "Password:\n";
	std::cin >> data;
	user.setpass(data);
}


int main()
{

	User user;

	GetUser(user);
	user.getpass();
	user.printuser();
	system("pause");
	return 0;
}