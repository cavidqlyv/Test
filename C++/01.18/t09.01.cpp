/*
Ev tapshiriqi:
1. Example 2-de qeyd olunan class-a bool changePassword(int old, int new)
method-u elave edin
2. Kohne shifre yeni shifreye uygun olmasa - method false qaytarmalidir,
eks halda ise true (yeni shifreni istifadechi daxil edir)
3. Shifre deyishib/deyishilmediyini istifadechiye bildirin
*/
#include <iostream>

class User
{
public:
	char* name = nullptr;//field of class
	int password;//field of class

				 //User() {}
	User(char* uName, int pwd)
	{
		std::cout << "Constructor User(char* uName, int pwd) called\n";
		name = uName;
		password = pwd;
	}

	User(int pwd)
	{
		std::cout << "Constructor User(int pwd) called\n";
		password = pwd;
	}

	~User()
	{
		std::cout << "Destructor called\n";
		if (name) {
			delete[] name;
		}
	}

	void showInfo()
	{
		if (name) {
			std::cout << "Name is: " << name << '\n';
		}
		std::cout << "Password is: " << password << '\n';
	}

	bool changePass(int old, int New_pass)
	{
		if (old == password && New_pass > 100000)
		{
			password = New_pass;
			return true;
		}
		return false;
	}
};

int main()
{
	User user1(new char[5]{ "Mike" }, 123456);
	user1.showInfo();
	int new_pass;
	int old_pass;

	while (1)
	{
		std::cout << "=================\n";
		std::cout << "Old pass : \n";
		std::cin >> old_pass;
		std::cout << "New pass :\n";
		std::cin >> new_pass;
		if (user1.changePass(old_pass, new_pass))
			std::cout << "\nChanged\n";
		else std::cout << "\nFailed\n";
		user1.showInfo();
	}
	system("pause");
	return 0;
}